#tag Class
Protected Class BlockEncoder
Inherits LZMA.LZMAEngine
Implements LZMA.Compressor
	#tag Method, Flags = &h0
		Sub Constructor(Filters As LZMA.FilterList, ChecksumType As LZMA.ChecksumType)
		  ' Constructs a block encoder.
		  ' Checksum is the type of Checksum to use
		  
		  Super.Constructor()
		  mBlock.Version = 1
		  mBlock.Check = ChecksumType
		  mFilterPtr = Filters
		  mBlock.Filters = mFilterPtr
		  mLastError = lzma_block_encoder(mStream, mBlock)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		  mFilters = Filters
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlock As lzma_block
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFilterPtr As MemoryBlock
	#tag EndProperty

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
