#tag Class
Protected Class IndexHash
	#tag Method, Flags = &h0
		Sub Append(UnpaddedSize As UInt64, UncompressedSize As UInt64)
		  mLastError = lzma_index_hash_append(mHash, UnpaddedSize, UncompressedSize)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  If Not LZMA.IsAvailable Then Raise New PlatformNotSupportedException
		  mHash = lzma_index_hash_init(mHash, Nil)
		  If mHash = Nil Then Raise New LZMAException(ErrorCodes.ProgError)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Decode(ReadFrom As Readable) As Boolean
		  Do Until ReadFrom.EOF
		    Dim mb As MemoryBlock = ReadFrom.Read(CHUNK_SIZE)
		    Dim pos As UInt32
		    mLastError = lzma_index_hash_decode(mHash, mb, pos, mb.Size)
		  Loop Until mLastError <> ErrorCodes.OK
		  Return mLastError = ErrorCodes.StreamEnd
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If mHash <> Nil Then lzma_index_hash_end(mHash, Nil)
		  mHash = Nil
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mLastError
			End Get
		#tag EndGetter
		LastError As LZMA.ErrorCodes
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mHash As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastError As LZMA.ErrorCodes
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mHash <> Nil Then Return lzma_index_hash_size(mHash)
			End Get
		#tag EndGetter
		Size As UInt64
	#tag EndComputedProperty


End Class
#tag EndClass
