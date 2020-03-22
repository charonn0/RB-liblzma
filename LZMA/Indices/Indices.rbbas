#tag Module
Protected Module Indices
	#tag Method, Flags = &h1
		Protected Function DecodeIndex(XZFile As FolderItem, MemoryLimit As UInt64 = 0) As LZMA.Indices.LZMAIndex
		  If MemoryLimit = 0 Then MemoryLimit = UINT64_MAX
		  Dim engine As IndexDecoder
		  Dim rawstream As BinaryStream
		  Try
		    rawstream = BinaryStream.Open(XZFile)
		    'rawstream.LittleEndian = True
		    Dim size As UInt32
		    If LocateIndex(rawstream, size) Then
		      engine = New IndexDecoder(MemoryLimit)
		      Call engine.Perform(rawstream, Nil, EncodeAction.Run, size)
		    End If
		  Finally
		    If rawstream <> Nil Then rawstream.Close
		  End Try
		  If engine <> Nil Then Return engine.Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DecodeIndex(Index As MemoryBlock, MemoryLimit As UInt64 = 0) As LZMA.Indices.LZMAIndex
		  If MemoryLimit = 0 Then MemoryLimit = UINT64_MAX
		  Dim buffer As Ptr
		  Dim pos As UInt32
		  Dim err As ErrorCodes = lzma_index_buffer_decode(buffer, MemoryLimit, Nil, Index, pos, Index.Size)
		  If err = ErrorCodes.OK Then Return New LZMAIndex(buffer)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncodeIndex(Index As LZMA.Indices.LZMAIndex) As MemoryBlock
		  Dim buffer As New MemoryBlock(Index.Size)
		  Dim out As UInt32
		  Dim err As ErrorCodes = lzma_index_buffer_encode(Index, buffer, out, buffer.Size)
		  If err = ErrorCodes.OK Then Return buffer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LocateIndex(RawStream As BinaryStream, ByRef IndexSize As UInt32) As Boolean
		  RawStream.LittleEndian = True
		  Dim old As UInt64 = RawStream.Position
		  RawStream.Position = RawStream.Length - 12
		  Dim crc As UInt32 = RawStream.ReadUInt32()
		  Dim check As MemoryBlock = RawStream.Read(6)
		  IndexSize = (check.UInt32Value(0) + 1 ) * 4
		  Dim flags As UInt16
		  flags = check.UInt16Value(4)
		  Dim magic As String = RawStream.Read(2)
		  
		  If magic = "YZ" And CRC32(check) = crc Then
		    RawStream.Position = RawStream.Length - 12 - IndexSize
		    Return True
		  Else
		    RawStream.Position = old
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_append Lib LIB_LZMA (Index As Ptr, Allocator As Ptr, UnpaddedSize As UInt64, UncompressedSize As UInt64) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_block_count Lib LIB_LZMA (Index As Ptr) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_buffer_decode Lib LIB_LZMA (ByRef Index As Ptr, MemoryLimit As UInt64, Allocator As Ptr, Input As Ptr, ByRef InputPosition As UInt32, InputSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_buffer_encode Lib LIB_LZMA (Index As Ptr, Output As Ptr, ByRef OutputPosition As UInt32, OutputSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_cat Lib LIB_LZMA (Source As Ptr, Destination As Ptr, Allocator As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_checks Lib LIB_LZMA (Index As Ptr) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_decoder Lib LIB_LZMA (ByRef Stream As lzma_stream, ByRef Index As Ptr, MemoryLimit As UInt64) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_dup Lib LIB_LZMA (Index As Ptr, Allocator As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_encoder Lib LIB_LZMA (ByRef Stream As lzma_stream, Index As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub lzma_index_end Lib LIB_LZMA (Index As Ptr, Allocator As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_file_size Lib LIB_LZMA (Index As Ptr) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_hash_append Lib LIB_LZMA (Hash As Ptr, UnpaddedSize As UInt64, UncompressedSize As UInt64) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_hash_decode Lib LIB_LZMA (Hash As Ptr, Buffer As Ptr, ByRef BufferPosition As UInt32, BufferSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub lzma_index_hash_end Lib LIB_LZMA (Hash As Ptr, Allocator As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_hash_init Lib LIB_LZMA (Hash As Ptr, Allocator As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_hash_size Lib LIB_LZMA (Hash As Ptr) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_init Lib LIB_LZMA (Allocator As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_iter_init Lib LIB_LZMA (ByRef Iterator As Ptr, Index As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_iter_locate Lib LIB_LZMA (Iterator As Ptr, Target As UInt64) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_iter_next Lib LIB_LZMA (Iterator As Ptr, Mode As IterationMode) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_iter_rewind Lib LIB_LZMA (Iterator As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_size Lib LIB_LZMA (Index As Ptr) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_stream_count Lib LIB_LZMA (Index As Ptr) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_stream_flags Lib LIB_LZMA (Index As Ptr, Flags As lzma_stream_flags) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_stream_padding Lib LIB_LZMA (Index As Ptr, Padding As UInt64) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_stream_size Lib LIB_LZMA (Index As Ptr) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_total_size Lib LIB_LZMA (Index As Ptr) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_index_uncompressed_size Lib LIB_LZMA (Index As Ptr) As UInt64
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
