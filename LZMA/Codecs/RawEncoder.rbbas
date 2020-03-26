#tag Class
Protected Class RawEncoder
Inherits LZMA.LZMAEngine
Implements LZMA.Compressor
	#tag Method, Flags = &h0
		Sub Constructor(Filters As LZMA.FilterList)
		  Super.Constructor()
		  Dim propsz As UInt32
		  mLastError = lzma_properties_size(propsz, Filters)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		  
		  If propsz > 0 Then
		    Dim prop As UInt8
		    mLastError = lzma_properties_encode(Filters, prop)
		    If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		    mHeader = New MemoryBlock(9)
		    mHeader.UInt8Value(0) = &h13
		    mHeader.UInt8Value(1) = 0
		    mHeader.UInt8Value(2) = 5
		    mHeader.UInt8Value(3) = 0
		    mHeader.UInt8Value(4) = prop
		    For i As Integer = 0 To Filters.Count - 1
		      If Filters.Options(i) <> Nil Then
		        mHeader.UInt32Value(5) = Filters(i).DictionarySize
		        Exit For
		      End If
		    Next
		  End If
		  
		  mLastError = lzma_raw_encoder(mStream, filters)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		  mFilters = Filters
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MemoryUse_() As UInt64
		  If IsOpen Then Return lzma_raw_encoder_memusage(mFilters)
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mHeader
			End Get
		#tag EndGetter
		Header As MemoryBlock
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mFilters As FilterList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHeader As MemoryBlock
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
