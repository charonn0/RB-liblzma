#tag Class
Protected Class IndexEncoder
Inherits LZMA.LZMAEngine
Implements Compressor
	#tag Method, Flags = &h1000
		Sub Constructor(Index As LZMA.Indices.LZMAIndex)
		  // Calling the overridden superclass constructor.
		  Super.Constructor()
		  mLastError = lzma_index_encoder(mStream, Index)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIndex As LZMAIndex
	#tag EndProperty


End Class
#tag EndClass
