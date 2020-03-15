#tag Class
Protected Class FilterList
	#tag Method, Flags = &h0
		Sub Append(FilterID As UInt64, Options As MemoryBlock)
		  If Count >= 4 Then Raise New LZMAException(ErrorCodes.ProgError)
		  Dim filter As lzma_filter
		  filter.ID = FilterID
		  If Options <> Nil Then filter.Options = Options
		  mFilters.Append(filter)
		  mOptRefs.Append(Options)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return UBound(mFilters) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilterID(Index As Integer) As UInt64
		  Return mFilters(Index).ID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FilterID(Index As Integer, Assigns NewFilter As UInt64)
		  mFilters(Index).ID = NewFilter
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, FilterID As UInt64, Options As MemoryBlock)
		  If Count >= 3 Or Index > Count - 1 Then Raise New LZMAException(ErrorCodes.ProgError)
		  Dim filter As lzma_filter
		  filter.ID = FilterID
		  filter.Options = Options
		  mFilters.Insert(Index, filter)
		  mOptRefs.Insert(Index, Options)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Ptr
		  Dim count As Integer = UBound(mFilters)
		  If count > 4 Then Raise New LZMAException(ErrorCodes.ProgError)
		  If count < 1 Then
		    Dim mb As New MemoryBlock(lzma_filter.Size)
		    mb.UInt64Value(0) = LZMA_VLI_UNKNOWN
		    Return mb
		  End If
		  
		  Dim lst As New MemoryBlock((mFilters.Ubound + 2) * lzma_filter.Size)
		  Dim index As Integer
		  For index = 0 To UBound(mFilters)
		    lst.UInt64Value(index * lzma_filter.Size) = mFilters(index).ID
		    lst.Ptr((index * lzma_filter.Size) + 8) = mFilters(index).Options
		  Next
		  
		  lst.UInt64Value(index * lzma_filter.Size) = LZMA_VLI_UNKNOWN
		  
		  Return lst
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Options(Index As Integer) As MemoryBlock
		  Return mFilters(Index).Options
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Options(Index As Integer, Assigns NewOpts As MemoryBlock)
		  mFilters(Index).Options = NewOpts
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  mFilters.Remove(Index)
		  mOptRefs.Remove(Index)
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If LZMA.IsAvailable Then Return lzma_raw_decoder_memusage(Me)
			End Get
		#tag EndGetter
		MemoryUse As UInt64
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mFilters() As lzma_filter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOptRefs() As MemoryBlock
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
