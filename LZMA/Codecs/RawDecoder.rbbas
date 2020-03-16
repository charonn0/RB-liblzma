#tag Class
Protected Class RawDecoder
Inherits LZMA.LZMAEngine
Implements LZMA.Decompressor
	#tag Method, Flags = &h0
		Sub Constructor(Filters As LZMA.FilterList, Header As MemoryBlock)
		  ' Constructs a decoder for raw LZMA
		  
		  Super.Constructor()

		  If Header <> Nil And Header.Size > 0 Then
		    Filters(1).DictionarySize = _
		    (Header.UInt8Value(5) And &hFF) Or _
		    (ShiftLeft(Header.UInt8Value(6) And &hFF, 8)) Or _
		    (ShiftLeft(Header.UInt8Value(7) And &hFF, 16)) Or _
		    (ShiftLeft(Header.UInt8Value(8) And &hFF, 24))
		    
		    Dim props As New MemoryBlock(1)
		    props.UInt8Value(0) = Header.UInt8Value(4)
		    
		    mLastError = lzma_properties_decode(Filters, Nil, props, 4)
		    If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		  End If
		  
		  mLastError = lzma_raw_decoder(mStream, Filters)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		  mFilters = Filters
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MemoryUse_() As UInt64
		  If IsOpen Then Return lzma_raw_decoder_memusage(mFilters)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFilters As FilterList
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
