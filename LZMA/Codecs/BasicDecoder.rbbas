#tag Class
Protected Class BasicDecoder
Inherits LZMA.LZMAEngine
Implements LZMA.Decompressor
	#tag Method, Flags = &h0
		Sub Constructor(MemoryLimit As UInt64, Flags As UInt32)
		  ' Constructs a decoder that detects the file format
		  ' MemoryLimit defines the maximum memory use; specify zero to disable memory limiting.
		  ' Flags may be zero or more of the following flags:
		  ' LZMA_TELL_NO_CHECK
		  ' LZMA_TELL_UNSUPPORTED_CHECK
		  ' LZMA_TELL_ANY_CHECK
		  ' LZMA_IGNORE_CHECK
		  ' LZMA_CONCATENATED
		  
		  Super.Constructor()
		  If MemoryLimit = 0 Then MemoryLimit = UINT64_MAX
		  mLastError = lzma_auto_decoder(mStream, MemoryLimit, Flags)
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
