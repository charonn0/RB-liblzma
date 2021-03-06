#tag Class
Protected Class FilterList
	#tag Method, Flags = &h0
		Sub Append(FilterID As UInt64, Options As LZMA.LZMAOptions)
		  ' Appends the FilterID and Options to the list. 
		  
		  If Count >= 4 Then Raise New LZMAException(ErrorCodes.ProgError)
		  Dim filter As lzma_filter
		  filter.ID = FilterID
		  If Options <> Nil Then
		    filter.Options = Options
		  End If
		  mFilters.Append(filter)
		  mOptRefs.Append(Options)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(CopyFrom As LZMA.FilterList)
		  ' Constructs a filter list by copying the CopyFrom parameter.
		  
		  Dim copyto As New MemoryBlock((CopyFrom.mFilters.Ubound + 2) * lzma_filter.Size)
		  Dim err As ErrorCodes = lzma_filters_copy(CopyFrom, copyto, Nil)
		  If err <> ErrorCodes.OK Then Raise New LZMAException(err)
		  
		  Dim count As Integer = copyto.Size / lzma_filter.Size
		  Dim index As Integer
		  For index = 0 To count - 2
		    Dim id As UInt64 = copyto.UInt64Value(index * lzma_filter.Size)
		    Dim options As MemoryBlock = copyto.Ptr(index * lzma_filter.Size + 8)
		    Dim opt As LZMAOptions
		    If options <> Nil Then opt = New LZMAOptions(options)
		    Me.Append(id, opt)
		  Next
		  mRef = copyto
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Preset As UInt32 = 0, FilterID As UInt64 = LZMA.LZMA_FILTER_LZMA2)
		  ' Constructs a basic filter list. If Preset is specified then the list is
		  ' prepopulated for LZMA1 or LZMA2, as indicated by the FilterID parameter.
		  
		  If Preset > 0 Then
		    #If TargetX86 Then
		      Me.Append(LZMA_FILTER_X86, Nil)
		    #ElseIf Target64Bit
		      Me.Append(LZMA_FILTER_IA64, Nil)
		    #Else
		      Raise New PlatformNotSupportedException
		    #endif
		    Me.Append(FilterID, New LZMAOptions(Preset))
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  ' Returns the number of filters in the list
		  
		  Return UBound(mFilters) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilterID(Index As Integer) As UInt64
		  ' Update the FilterID for the filter at Index
		  
		  Return mFilters(Index).ID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FilterID(Index As Integer, Assigns NewFilter As UInt64)
		  ' Get the FilterID for the filter at Index
		  
		  mFilters(Index).ID = NewFilter
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, FilterID As UInt64, Options As LZMA.LZMAOptions)
		  ' Inserts the FilterID and Options to the list at the specified index.
		  ' Existing filters are shifted down the list unless there is no more room
		  ' in the list, in which case an exception will be raised.
		  
		  If Count >= 3 Or Index > Count - 1 Then Raise New LZMAException(ErrorCodes.ProgError)
		  Dim filter As lzma_filter
		  filter.ID = FilterID
		  filter.Options = Options
		  mFilters.Insert(Index, filter)
		  mOptRefs.Insert(Index, Options)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function IsDecoderSupported(FilterID As UInt64) As Boolean
		  ' Returns True if the installed version of liblzma supports decoding the specified FilterID.
		  
		  Return LZMA.IsAvailable And lzma_filter_decoder_is_supported(FilterID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function IsEncoderSupported(FilterID As UInt64) As Boolean
		  ' Returns True if the installed version of liblzma supports encoding the specified FilterID.
		  
		  Return LZMA.IsAvailable And lzma_filter_encoder_is_supported(FilterID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Ptr
		  ' Returns a Ptr to a MemoryBlock generated from the list of filters.
		  
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
		Function Operator_Subscript(Index As Integer) As lzma_options_lzma
		  ' Returns the lzma_options_lzma structure at Index. Can only be called
		  ' from within the LZMA module.
		  
		  Dim p As Ptr = Me.Options(Index)
		  Return p.lzma_options_lzma
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Options(Index As Integer) As LZMA.LZMAOptions
		  ' Returns an LZMAOptions object corresponding to the options for the filter at Index.
		  
		  Return mOptRefs(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Options(Index As Integer, Assigns NewOpts As LZMA.LZMAOptions)
		  ' Updates the options for the filter at Index.
		  
		  mFilters(Index).Options = NewOpts
		  mOptRefs(Index) = NewOpts
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  ' Removes the filter at Index.
		  
		  mFilters.Remove(Index)
		  mOptRefs.Remove(Index)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFilters() As lzma_filter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOptRefs() As LZMAOptions
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRef As MemoryBlock
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
