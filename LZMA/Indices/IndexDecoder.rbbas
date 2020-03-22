#tag Class
Protected Class IndexDecoder
Inherits LZMA.LZMAEngine
Implements Decompressor
	#tag Method, Flags = &h1000
		Sub Constructor(MemoryLimit As UInt64)
		  // Calling the overridden superclass constructor.
		  Super.Constructor()
		  If MemoryLimit = 0 Then MemoryLimit = UINT64_MAX
		  mLastError = lzma_index_decoder(mStream, mIndex, MemoryLimit)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIndex As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResult As LZMAIndex
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mResult <> Nil Then
			    Return New LZMAIndex(mResult)
			  ElseIf mIndex <> Nil Then
			    mResult = New LZMAIndex(mIndex)
			    Return mResult
			  End If
			End Get
		#tag EndGetter
		Result As LZMAIndex
	#tag EndComputedProperty


End Class
#tag EndClass
