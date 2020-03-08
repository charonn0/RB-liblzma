#tag Module
Protected Module Testing
	#tag Method, Flags = &h1
		Protected Function RuntTests() As Dictionary
		  Dim testdir As FolderItem = GetFolderItem("Test Files")
		  Dim errs As New Dictionary
		  For i As Integer = 1 To testdir.Count
		    Dim item As FolderItem = testdir.Item(i)
		    If Right(item.Name, 2) <> "xz" Then Continue
		    Dim actual, expected As LZMA.ErrorCodes
		    Select Case item.Name
		    Case "bad-0-backward_size.xz", "bad-0-footer_magic.xz", "bad-0-nonempty_index.xz", "bad-1-block_header-1.xz", _
		      "bad-1-block_header-2.xz", "bad-1-block_header-3.xz", "bad-1-block_header-4.xz", "bad-1-block_header-5.xz", _
		      "bad-1-block_header-6.xz", "bad-1-check-crc32.xz", "bad-1-check-crc64.xz", "bad-1-check-sha256.xz", "bad-1-lzma2-1.xz", _
		      "bad-1-lzma2-2.xz", "bad-1-lzma2-3.xz", "bad-1-lzma2-4.xz", "bad-1-lzma2-5.xz", "bad-1-lzma2-6.xz", "bad-1-lzma2-7.xz", _
		      "bad-1-lzma2-8.xz", "bad-1-stream_flags-1.xz", "bad-1-stream_flags-2.xz", "bad-1-stream_flags-3.xz", "bad-1-vli-1.xz", _
		      "bad-1-vli-2.xz", "bad-2-compressed_data_padding.xz", "bad-2-index-1.xz", "bad-2-index-2.xz", "bad-2-index-3.xz", _
		      "bad-2-index-4.xz", "bad-2-index-5.xz"
		      expected = LZMA.ErrorCodes.DataError
		      
		    Case "bad-0cat-alone.xz", "bad-0cat-header_magic.xz", "bad-0catpad-empty.xz", "good-0-empty.xz", "good-0cat-empty.xz", _
		      "good-0catpad-empty.xz", "good-0pad-empty.xz", "good-1-3delta-lzma2.xz", "good-1-block_header-1.xz", "good-1-block_header-2.xz", _
		      "good-1-block_header-3.xz", "good-1-check-crc32.xz", "good-1-check-crc64.xz", "good-1-check-none.xz", "good-1-check-sha256.xz", _
		      "good-1-lzma2-1.xz", "good-1-lzma2-2.xz", "good-1-lzma2-3.xz", "good-1-lzma2-4.xz", "good-1-lzma2-5.xz","good-1-sparc-lzma2.xz", _
		      "good-1-x86-lzma2.xz", "good-2-lzma2.xz", "bad-0pad-empty.xz", "unsupported-check.xz"
		      expected = LZMA.ErrorCodes.StreamEnd
		      
		    Case "good-1-delta-lzma2.tiff.xz", "bad-0-empty-truncated.xz"
		      expected = LZMA.ErrorCodes.OK
		      
		    Case "unsupported-block_header.xz", "unsupported-filter_flags-1.xz", "unsupported-filter_flags-2.xz", "unsupported-filter_flags-3.xz"
		      expected = LZMA.ErrorCodes.OptionsError
		      
		    Case "bad-0-header_magic.xz"
		      expected = LZMA.ErrorCodes.FormatError
		      
		    End Select
		    
		    Dim bs As BinaryStream
		    Dim stream As LZMA.LZMAStream
		    Try
		      bs = BinaryStream.Open(item)
		      stream = LZMA.LZMAStream.Open(bs)
		      Call stream.Read(1024)
		      actual = stream.LastError
		    Catch err As LZMA.LZMAException
		      actual = LZMA.ErrorCodes(err.ErrorNumber)
		    Finally
		      If stream <> Nil Then stream.Close
		      If bs <> Nil Then bs.Close
		    End Try
		    
		    If actual <> expected Then errs.Value(item.Name) = expected:actual
		  Next
		  
		  Return errs
		End Function
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
End Module
#tag EndModule
