#tag Class
Protected Class XZEncoder
Inherits LZMA.LZMAEngine
Implements LZMA.Compressor
	#tag Method, Flags = &h0
		Sub Constructor(Preset As UInt32, Filters As LZMA.FilterList, Checksum As LZMA.ChecksumType)
		  ' Constructs an encoder that encodes the XZ format. Filters is an
		  ' optional list of filters to use; specify Nil to use the default
		  ' filter list. Checksum specifies what kind of checksum to use.
		  
		  If Filters = Nil Then
		    ' use default xz Filters
		    mOptions = New LZMAOptions(Preset)
		    Filters = New FilterList
		    Filters.Append(LZMA_FILTER_X86, Nil)
		    Filters.Append(LZMA_FILTER_LZMA2, mOptions)
		  End If
		  
		  ' compress using the specified filters
		  Super.Constructor()
		  mLastError = lzma_stream_encoder(mStream, Filters, Checksum)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		  mFilters = Filters
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFilters As FilterList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOptions As LZMAOptions
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
