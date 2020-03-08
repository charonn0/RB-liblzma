#tag Class
Protected Class LZMAStream
Implements Readable,Writeable
	#tag Method, Flags = &h0
		Sub Close()
		  ' End the stream. If the stream is being written/compressed then all pending output is flushed.
		  ' If the stream is being read/decompressed then all pending output is discarded; check EOF to
		  ' determine whether there is pending output. After this method returns all calls to Read/Write
		  ' will raise an exception.
		  
		  If mCompressor <> Nil Then
		    Try
		      Me.Flush(EncodeAction.Finish)
		    Catch
		    End Try
		  End If
		  mSource = Nil
		  mDestination = Nil
		  mCompressor = Nil
		  mDecompressor = Nil
		  mSourceMB = Nil
		  mReadBuffer = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As BinaryStream, CompressionLevel As Integer = -1, Optional Checksum As LZMA.ChecksumType)
		  ' Constructs a LZMAStream from the Source BinaryStream. If the Source's current position is equal
		  ' to its length then compressed output will be appended, otherwise the Source will be used as
		  ' input to be decompressed.
		  
		  If Source.Length = Source.Position Then 'compress into Source
		    If Checksum = ChecksumType.None Then Checksum = ChecksumType.CRC32
		    Me.Constructor(New Compressor(CompressionLevel, Checksum), Source)
		  Else ' decompress from Source
		    Me.Constructor(New Decompressor(), Source)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Engine As LZMA.Compressor, Destination As Writeable)
		  ' Construct a compression stream using the Engine and Destination parameters
		  mCompressor = Engine
		  mDestination = Destination
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Engine As LZMA.Decompressor, Source As Readable)
		  ' Construct a decompression stream using the Engine and Source parameters
		  mDecompressor = Engine
		  mSource = Source
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As MemoryBlock, CompressionLevel As Integer = -1, Optional Checksum As LZMA.ChecksumType)
		  ' Constructs a LZMAStream from the Source MemoryBlock. If the Source's size is zero then
		  ' compressed output will be appended, otherwise the Source will be used as input
		  ' to be decompressed.
		  
		  If Source.Size >= 0 Then
		    If Checksum = ChecksumType.None Then Checksum = ChecksumType.CRC32
		    Me.Constructor(New BinaryStream(Source), CompressionLevel, Checksum)
		  Else
		    Raise New LZMAException(ErrorCodes.ProgError) ' can't use memoryblocks of unknown size!!
		  End If
		  mSourceMB = Source
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(OutputStream As FolderItem, CompressionLevel As Integer = -1, Overwrite As Boolean = False, Optional Checksum As LZMA.ChecksumType, Extreme As Boolean = False) As LZMA.LZMAStream
		  ' Create a compression stream where compressed output is written to the OutputStream file.
		  
		  Return Create(BinaryStream.Create(OutputStream, Overwrite), CompressionLevel, Checksum, Extreme)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(OutputStream As Writeable, CompressionLevel As Integer = -1, Optional Checksum As LZMA.ChecksumType, Extreme As Boolean = False) As LZMA.LZMAStream
		  ' Create a compression stream where compressed output is written to the OutputStream object.
		  
		  Return New LZMAStream(New Compressor(CompressionLevel, Checksum, Extreme), OutputStream)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Me.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EndOfFile() As Boolean
		  // Part of the Readable interface as of 2019r2
		  Return Me.EOF()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EOF() As Boolean
		  // Part of the Readable interface.
		  ' Returns True if there is no more output to read (decompression only)
		  If mSource <> Nil And mSource.EOF And mDecompressor <> Nil And mDecompressor.AvailIn = 0 And mReadBuffer = "" Then
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Flush() Implements Writeable.Flush
		  // Part of the Writeable interface.
		  ' All pending output is flushed to the output buffer and the output is aligned on a byte boundary.
		  ' Flushing may degrade compression so it should be used only when necessary.
		  
		  Me.Flush(EncodeAction.SyncFlush)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Flush(Flushing As LZMA.EncodeAction)
		  ' Flushing may be:
		  '   EncodeAction.SyncFlush:   all pending output is flushed to the output buffer and the output is aligned on a byte boundary.
		  '   EncodeAction.FullFlush:   like SyncFlush, and the compression state is reset so that decompression can restart from this point.
		  '   EncodeAction.Finish:      processing is finished and flushed; equivalent to calling LZMAStream.Close()
		  
		  If mCompressor = Nil Then Raise New IOException
		  Select Case Flushing
		  Case EncodeAction.Finish, EncodeAction.FullFlush, EncodeAction.SyncFlush
		    If Not mCompressor.Perform(Nil, mDestination, Flushing, -1) Then Raise New LZMAException(mCompressor.LastError)
		  Else
		    Raise New LZMAException(ErrorCodes.ProgError)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookahead(encoding As TextEncoding = Nil) As String
		  ' Returns the contents of the read buffer if BufferedReading is True (the default)
		  ' If there are fewer than two bytes remaining in the buffer then a new chunk is
		  ' read into the buffer.
		  
		  If Me.BufferedReading = False Then Return ""
		  If mReadBuffer.LenB < 2 Then
		    mBufferedReading = False
		    mReadBuffer = mReadBuffer + Me.Read(CHUNK_SIZE, encoding)
		    mBufferedReading = True
		  End If
		  Return DefineEncoding(mReadBuffer, encoding)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Open(InputStream As FolderItem, Flags As UInt32, MemoryLimit As UInt64 = 0) As LZMA.LZMAStream
		  ' Create a decompression stream where the compressed input is read from the Source file.
		  
		  Return Open(BinaryStream.Open(InputStream), Flags, MemoryLimit)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Open(InputStream As Readable, Flags As UInt32 = 0, MemoryLimit As UInt64 = 0) As LZMA.LZMAStream
		  ' Create a decompression stream where the compressed input is read from the InputStream object.
		  
		  Return New LZMAStream(New Decompressor(MemoryLimit, Flags), InputStream)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Count As Integer, encoding As TextEncoding = Nil) As String
		  // Part of the Readable interface.
		  ' This method reads from the compressed stream.
		  ' If BufferedReading is True (the default) then this method will read as many compressed bytes
		  ' as are necessary to produce exactly Count decompressed bytes (or until EOF if there are fewer
		  ' than Count decompressed bytes remaining in the stream).
		  ' If BufferedReading is False then exactly Count compressed bytes are read and fed into the
		  ' decompressor. Any decompressed output is returned: depending on the size of the read request
		  ' and the state of the decompressor this method might return zero bytes. A zero-length return
		  ' value does not indicate an error or the end of the stream; continue to Read from the stream
		  ' until EOF=True.
		  
		  If mDecompressor = Nil Then Raise New IOException
		  Dim data As New MemoryBlock(0)
		  Dim ret As New BinaryStream(data)
		  Dim readsz As Integer = Count
		  If BufferedReading Then
		    If Count <= mReadBuffer.LenB Then
		      ' the buffer has enough bytes already
		      ret.Write(LeftB(mReadBuffer, Count))
		      Dim sz As Integer = mReadBuffer.LenB - Count
		      mReadBuffer = RightB(mReadBuffer, sz)
		      ret.Close
		      readsz = 0
		    Else
		      ' not enough bytes in the buffer
		      If mReadBuffer.LenB > 0 Then
		        ret.Write(mReadBuffer)
		        mReadBuffer = ""
		      End If
		      readsz = Max(Count, CHUNK_SIZE) ' read this many more compressed bytes
		    End If
		  End If
		  If readsz > 0 Then
		    If Not mDecompressor.Perform(mSource, ret, EncodeAction.Run, readsz) Then Raise New LZMAException(mDecompressor.LastError)
		    ret.Close
		    If BufferedReading Then
		      If data.Size >= Count Then
		        ' buffer any leftovers
		        mReadBuffer = RightB(data, data.Size - Count)
		        data = LeftB(data, Count)
		      ElseIf Not Me.EOF Then
		        ' still need even more bytes!
		        mReadBuffer = data
		        Return Me.Read(Count, encoding)
		      End If
		    End If
		  End If
		  
		  If data <> Nil Then Return DefineEncoding(data, encoding)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadError() As Boolean
		  // Part of the Readable interface.
		  If mSource <> Nil Then Return mSource.ReadError Or (mDecompressor <> Nil And mDecompressor.LastError <> ErrorCodes.OK)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(Data As String)
		  // Part of the Writeable interface.
		  ' Write Data to the compressed stream.
		  ' NOTE: the Data may not be immediately written to the output; the compressor will write
		  ' to the output at times dictated by the compression parameters. Use the Flush method to
		  ' forcibly write pending output.
		  
		  If mCompressor = Nil Then Raise New IOException
		  Dim tmp As New BinaryStream(Data)
		  If Not mCompressor.Perform(tmp, mDestination, EncodeAction.Run, -1) Then Raise New LZMAException(mCompressor.LastError)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WriteError() As Boolean
		  // Part of the Writeable interface.
		  If mDestination <> Nil Then Return mDestination.WriteError Or (mCompressor <> Nil And mCompressor.LastError <> ErrorCodes.OK)
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mBufferedReading
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Not value Then mReadBuffer = ""
			  mBufferedReading = value
			End Set
		#tag EndSetter
		BufferedReading As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mCompressor
			End Get
		#tag EndGetter
		Compressor As LZMA.Compressor
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mDecompressor
			End Get
		#tag EndGetter
		Decompressor As LZMA.Decompressor
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns True if the stream is in decompression mode
			  Return mDecompressor <> Nil
			End Get
		#tag EndGetter
		IsReadable As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns True if the stream is in compression mode
			  Return mCompressor <> Nil
			End Get
		#tag EndGetter
		IsWriteable As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mDecompressor <> Nil Then
			    Return mDecompressor.LastError
			  ElseIf mCompressor <> Nil Then
			    Return mCompressor.LastError
			  End IF
			End Get
		#tag EndGetter
		LastError As LZMA.ErrorCodes
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mCompressor <> Nil Then Return mCompressor.Level
			End Get
		#tag EndGetter
		Level As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBufferedReading As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCompressor As LZMA.Compressor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDecompressor As LZMA.Decompressor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestination As Writeable
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReadBuffer As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As Readable
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSourceMB As MemoryBlock
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mCompressor <> Nil Then
			    Return mCompressor.TotalIn
			  ElseIf mDecompressor <> Nil Then
			    Return mDecompressor.TotalIn
			  End If
			End Get
		#tag EndGetter
		TotalIn As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mCompressor <> Nil Then
			    Return mCompressor.TotalOut
			  ElseIf mDecompressor <> Nil Then
			    Return mDecompressor.TotalOut
			  End If
			End Get
		#tag EndGetter
		TotalOut As UInt32
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="BufferedReading"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Encoding"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsReadable"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsWriteable"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Level"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Ratio"
			Group="Behavior"
			Type="Single"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Strategy"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
