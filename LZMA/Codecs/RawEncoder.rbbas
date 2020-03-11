#tag Class
Protected Class RawEncoder
Inherits LZMA.Codecs.LZMAEngine
Implements LZMA.Compressor
	#tag Method, Flags = &h0
		Sub Constructor(Filters As LZMA.FilterList)
		  Super.Constructor()
		  mLastError = lzma_raw_encoder(mStream, filters)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mOptions As lzma_options_lzma
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Extreme"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="LZMA.Compressor"
		#tag EndViewProperty
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
			Name="Level"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="LZMA.Compressor"
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
