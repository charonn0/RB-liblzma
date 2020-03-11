#tag Class
Protected Class FilterList
	#tag Method, Flags = &h0
		Sub AppendFilter(FilterID As UInt64, Options As MemoryBlock)
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
		Function GetFilterID(Index As Integer) As UInt64
		  Return mFilters(Index).ID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFilterOptions(Index As Integer) As MemoryBlock
		  Return mFilters(Index).Options
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function GetPresetOptions(Preset As UInt32) As MemoryBlock
		  If Not LZMA.IsAvailable Then Return Nil
		  Dim opts As New MemoryBlock(lzma_options_lzma.Size)
		  If Not lzma_lzma_preset(opts, Preset) Then Break
		  Return opts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertFilter(Index As Integer, FilterID As UInt64, Options As MemoryBlock)
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
		  If count > 4 Or count < 0 Then Raise New LZMAException(ErrorCodes.ProgError)
		  
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
		Sub RemoveFilter(Index As Integer)
		  mFilters.Remove(Index)
		  mOptRefs.Remove(Index)
		End Sub
	#tag EndMethod


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