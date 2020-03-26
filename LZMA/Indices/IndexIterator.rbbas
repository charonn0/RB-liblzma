#tag Class
Protected Class IndexIterator
	#tag Method, Flags = &h0
		Sub Constructor(Index As LZMA.Indices.LZMAIndex)
		  mLastError = lzma_index_iter_init(mIterator, Index)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext(Mode As LZMA.Indices.IterationMode) As Boolean
		  Return Not lzma_index_iter_next(mIterator, Mode)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Rewind()
		  mLastError = lzma_index_iter_rewind(mIterator)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SeekToUncompressedOffest(Offset As UInt64) As Boolean
		  Return lzma_index_iter_locate(mIterator, Offset)
		End Function
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
		Private mIterator As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastError As LZMA.ErrorCodes
	#tag EndProperty


End Class
#tag EndClass
