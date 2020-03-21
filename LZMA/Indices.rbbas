#tag Module
Protected Module Indices
	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_properties_decode Lib LIB_LZMA (Filter As Ptr, Allocator As Ptr, Props As Ptr, PropsSize As UInt32) As ErrorCodes
	#tag EndExternalMethod


	#tag Structure, Name = lzma_index_iter, Flags = &h21, Attributes = \"StructureAlignment \x3D 8"
		Reserved1 As Ptr
		  Reserved2 As UInt32
		Reserved3 As UInt64
	#tag EndStructure

	#tag Structure, Name = xz_block, Flags = &h21, Attributes = \"StructureAlignment \x3D 8"
		NumberInFile As UInt64
		  CompressedFileOffset As UInt64
		  UncompressedFileOffset As UInt64
		  NumberInStream As UInt64
		  CompressedStreamOffset As UInt64
		  UncompressedStreamOffset As UInt64
		  UncompressedSize As UInt64
		  UnpaddedSize As UInt64
		  TotalSize As UInt64
		  Reserved1 As UInt64
		  Reserved2 As UInt64
		  Reserved3 As UInt64
		  Reserved4 As UInt64
		  Reserved5 As Ptr
		  Reserved6 As Ptr
		  Reserved7 As Ptr
		Reserved8 As Ptr
	#tag EndStructure

	#tag Structure, Name = xz_stream, Flags = &h21, Attributes = \"StructureAlignment \x3D 8"
		Flags As lzma_stream_flags
		  Reserved1 As Ptr
		  Reserved2 As Ptr
		  Reserved3 As Ptr
		  Number As UInt64
		  BlockCount As UInt64
		  CompressedOffset As UInt64
		  UncompressedOffset As UInt64
		  CompressedSize As UInt64
		  UncompressedSize As UInt64
		  Padding As UInt64
		  Reserved4 As UInt64
		  Reserved5 As UInt64
		  Reserved6 As UInt64
		Reserved7 As UInt64
	#tag EndStructure


	#tag Enum, Name = IterationMode, Type = Integer, Flags = &h1
		Any=0
		  Stream=1
		  Block=2
		NonemptyBlock=3
	#tag EndEnum


End Module
#tag EndModule
