#tag Module
Protected Module Codecs
	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_alone_decoder Lib LIB_LZMA (ByRef Stream As lzma_stream, MemLimit As UInt64) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_alone_encoder Lib LIB_LZMA (ByRef Stream As lzma_stream, Options As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_auto_decoder Lib LIB_LZMA (ByRef Stream As lzma_stream, MemLimit As UInt64, Flags As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_block_decoder Lib LIB_LZMA (ByRef Stream As lzma_stream, ByRef Block As lzma_block) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_block_encoder Lib LIB_LZMA (ByRef Stream As lzma_stream, ByRef Block As lzma_block) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_easy_encoder Lib LIB_LZMA (ByRef Stream As lzma_stream, Preset As UInt32, Check As ChecksumType) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_properties_decode Lib LIB_LZMA (Filter As Ptr, Allocator As Ptr, Props As Ptr, PropsSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_properties_encode Lib LIB_LZMA (Filter As Ptr, ByRef Props As UInt8) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_properties_size Lib LIB_LZMA (ByRef Size As UInt32, Filter As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_raw_decoder Lib LIB_LZMA (ByRef Stream As lzma_stream, Filters As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_raw_encoder Lib LIB_LZMA (ByRef Stream As lzma_stream, Filters As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_stream_decoder Lib LIB_LZMA (ByRef Stream As lzma_stream, MemoryLimit As UInt64, Flags As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_stream_encoder Lib LIB_LZMA (ByRef Stream As lzma_stream, Filters As Ptr, Check As ChecksumType) As ErrorCodes
	#tag EndExternalMethod


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
