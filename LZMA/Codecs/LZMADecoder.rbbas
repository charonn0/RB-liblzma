#tag Class
Protected Class LZMADecoder
Inherits LZMA.Codecs.LZMAEngine
Implements LZMA.Decompressor
	#tag Method, Flags = &h0
		Sub Constructor(MemoryLimit As UInt64 = 0)
		  Super.Constructor()
		  If MemoryLimit = 0 Then MemoryLimit = UINT64_MAX
		  mLastError = lzma_alone_decoder(mStream, MemoryLimit)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		  mMemoryLimit = MemoryLimit
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mMemoryLimit As UInt64
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
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
