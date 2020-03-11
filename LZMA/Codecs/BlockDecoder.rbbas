#tag Class
Protected Class BlockDecoder
Inherits LZMA.Codecs.LZMAEngine
Implements LZMA.Decompressor
	#tag Method, Flags = &h0
		Sub Constructor(ChecksumType As LZMA.ChecksumType, CompressedSize As UInt64)
		  ' Constructs a block decoder.
		  ' Checksum is the type of Checksum used
		  ' CompressedSize is the actual compressed size of the data
		  
		  Super.Constructor()
		  mBlock.Version = 1
		  mBlock.HeaderSize = LZMA_BLOCK_HEADER_SIZE_MIN
		  mBlock.Check = ChecksumType
		  mBlock.CompressedSize = CompressedSize
		  mLastError = lzma_block_decoder(mStream, mBlock)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mBlock As lzma_block
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
