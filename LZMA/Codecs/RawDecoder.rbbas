#tag Class
Protected Class RawDecoder
Inherits LZMA.Codecs.LZMAEngine
Implements LZMA.Decompressor
	#tag Method, Flags = &h0
		Sub Constructor()
		  ' Constructs a decoder for raw LZMA
		  
		  Super.Constructor()
		  Dim filters As New MemoryBlock(1024)
		  Dim p As Ptr = filters
		  p.lzma_filter.ID = LZMA_FILTER_LZMA1
		  p = Ptr(Integer(p) + lzma_filter.Size)
		  p.lzma_filter.ID = LZMA_VLI_UNKNOWN
		  mLastError = lzma_raw_decoder(mStream, filters)
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
