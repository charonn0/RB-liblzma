#tag Class
Protected Class LZMADecoder
Inherits LZMA.LZMAEngine
Implements LZMA.Decompressor
	#tag Method, Flags = &h0
		Sub Constructor(MemoryLimit As UInt64 = 0)
		  ' Constructs a decoder for the original LZMA1 algorithm.
		  ' MemoryLimit defines the maximum memory use; specify zero to disable memory limiting.
		  
		  Super.Constructor()
		  If MemoryLimit = 0 Then MemoryLimit = UINT64_MAX
		  mLastError = lzma_alone_decoder(mStream, MemoryLimit)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsOpen"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="LZMA.Codecs.LZMAEngine"
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
