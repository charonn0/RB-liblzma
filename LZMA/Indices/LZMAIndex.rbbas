#tag Class
Protected Class LZMAIndex
	#tag Method, Flags = &h0
		Sub AppendBlock(UnpaddedSize As UInt64, UncompressedSize As UInt64)
		  If mIndex = Nil Then Raise New LZMAException(ErrorCodes.ProgError)
		  mLastError = lzma_index_append(mIndex, Nil, UnpaddedSize, UncompressedSize)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Concatenate(Destination As LZMA.Indices.LZMAIndex)
		  mLastError = lzma_index_cat(mIndex, Destination.mIndex, Nil)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		  mIndex = Nil ' self is no longer valid
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  If Not LZMA.IsAvailable Then Raise New PlatformNotSupportedException
		  mIndex = lzma_index_init(Nil)
		  If mIndex = Nil Then Raise New LZMAException(ErrorCodes.ProgError)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(DuplicateFrom As LZMA.Indices.LZMAIndex)
		  mIndex = lzma_index_dup(DuplicateFrom, Nil)
		  If mIndex = Nil Then Raise New LZMAException(ErrorCodes.ProgError)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Internal As Ptr)
		  mIndex = Internal
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function DecodeIndex(XZFile As FolderItem, MemoryLimit As UInt64 = 0) As LZMA.Indices.LZMAIndex
		  If MemoryLimit = 0 Then MemoryLimit = UINT64_MAX
		  Dim engine As IndexDecoder
		  Dim rawstream As BinaryStream
		  Try
		    rawstream = BinaryStream.Open(XZFile)
		    'rawstream.LittleEndian = True
		    Dim size As UInt32
		    If LocateIndex(rawstream, size) Then
		      engine = New IndexDecoder(MemoryLimit)
		      Call engine.Perform(rawstream, Nil, EncodeAction.Run, size)
		    End If
		  Finally
		    If rawstream <> Nil Then rawstream.Close
		  End Try
		  If engine <> Nil Then Return engine.Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function DecodeIndex(Index As MemoryBlock, MemoryLimit As UInt64 = 0) As LZMA.Indices.LZMAIndex
		  If MemoryLimit = 0 Then MemoryLimit = UINT64_MAX
		  Dim buffer As Ptr
		  Dim pos As UInt32
		  Dim err As ErrorCodes = lzma_index_buffer_decode(buffer, MemoryLimit, Nil, Index, pos, Index.Size)
		  If err = ErrorCodes.OK Then Return New LZMAIndex(buffer)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If mIndex <> Nil Then lzma_index_end(mIndex, Nil)
		  mIndex = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function EncodeIndex(Index As LZMA.Indices.LZMAIndex) As MemoryBlock
		  Dim buffer As New MemoryBlock(Index.Size)
		  Dim out As UInt32
		  Dim err As ErrorCodes = lzma_index_buffer_encode(Index, buffer, out, buffer.Size)
		  If err = ErrorCodes.OK Then Return buffer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function LocateIndex(RawStream As BinaryStream, ByRef IndexSize As UInt32) As Boolean
		  RawStream.LittleEndian = True
		  Dim old As UInt64 = RawStream.Position
		  RawStream.Position = RawStream.Length - 12
		  Dim crc As UInt32 = RawStream.ReadUInt32()
		  Dim check As MemoryBlock = RawStream.Read(6)
		  IndexSize = (check.UInt32Value(0) + 1 ) * 4
		  Dim flags As UInt16
		  flags = check.UInt16Value(4)
		  Dim magic As String = RawStream.Read(2)
		  
		  If magic = "YZ" And CRC32(check) = crc Then
		    RawStream.Position = RawStream.Length - 12 - IndexSize
		    Return True
		  Else
		    RawStream.Position = old
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Ptr
		  Return mIndex
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mIndex <> Nil Then Return lzma_index_block_count(mIndex)
			End Get
		#tag EndGetter
		BlockCount As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mIndex <> Nil Then
			    Dim mask As UInt32 = lzma_index_checks(mIndex)
			    Select Case True
			    Case mask = 0
			      Return LZMA.ChecksumType.None
			    Case mask = ShiftLeft(1, 1)
			      Return LZMA.ChecksumType.CRC32
			    Case mask = ShiftLeft(1, 4)
			      Return LZMA.ChecksumType.CRC64
			    Case mask = ShiftLeft(1, 10)
			      Return LZMA.ChecksumType.SHA256
			    End Select
			  End If
			End Get
		#tag EndGetter
		ChecksumType As LZMA.ChecksumType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mIndex <> Nil Then Return lzma_index_file_size(mIndex)
			End Get
		#tag EndGetter
		FileSize As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mLastError
			End Get
		#tag EndGetter
		LastError As LZMA.ErrorCodes
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mIndex As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastError As LZMA.ErrorCodes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPadding As UInt64
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mPadding
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mIndex <> Nil Then
			    mLastError = lzma_index_stream_padding(mIndex, value)
			    If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
			    mPadding = value
			  End If
			End Set
		#tag EndSetter
		Padding As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mIndex <> Nil Then Return lzma_index_size(mIndex)
			End Get
		#tag EndGetter
		Size As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mIndex <> Nil Then Return lzma_index_stream_count(mIndex)
			End Get
		#tag EndGetter
		StreamCount As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mIndex <> Nil Then Return lzma_index_stream_size(mIndex)
			End Get
		#tag EndGetter
		StreamSize As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mIndex <> Nil Then Return lzma_index_total_size(mIndex)
			End Get
		#tag EndGetter
		TotalSize As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mIndex <> Nil Then Return lzma_index_uncompressed_size(mIndex)
			End Get
		#tag EndGetter
		UncompressedSize As UInt64
	#tag EndComputedProperty


End Class
#tag EndClass
