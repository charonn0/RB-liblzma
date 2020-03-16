#tag Class
Protected Class RawEncoder
Inherits LZMA.LZMAEngine
Implements LZMA.Compressor
	#tag Method, Flags = &h0
		Sub Constructor(Filters As LZMA.FilterList)
		  Super.Constructor()
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		  
		  mLastError = lzma_raw_encoder(mStream, filters)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		  mFilters = Filters
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MemoryUse() As UInt64
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
