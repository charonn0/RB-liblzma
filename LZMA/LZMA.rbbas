#tag Module
Protected Module LZMA
	#tag Method, Flags = &h21
		Private Function ConvertFilterList(Filters() As LZMA.lzma_filter) As MemoryBlock
		  Dim count As Integer = UBound(Filters)
		  If count > 4 Or count < 0 Then Raise New LZMAException(ErrorCodes.ProgError)
		  
		  Dim lst As New MemoryBlock((Filters.Ubound + 2) * lzma_filter.Size)
		  Dim index As Integer
		  For index = 0 To UBound(Filters)
		    lst.UInt64Value(index * lzma_filter.Size) = Filters(index).ID
		    lst.Ptr((index * lzma_filter.Size) + 8) = Filters(index).Options
		  Next
		  
		  lst.UInt64Value(index * lzma_filter.Size) = LZMA_VLI_UNKNOWN
		  
		  Return lst
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CRC32(Data As MemoryBlock, LastCRC As UInt32 = 0, DataSize As Integer = - 1) As UInt32
		  ' Calculate the CRC32 checksum for the Data. Pass back the returned value
		  ' to continue processing.
		  '    Dim crc As UInt32
		  '    Do
		  '      crc = CRC32(NextData, crc)
		  '    Loop
		  ' If Data.Size is not known (-1) then specify the size as DataSize
		  
		  Static avail As Boolean
		  If Not avail Then avail = IsAvailable()
		  If Not avail Or Data = Nil Then Return 0
		  
		  If DataSize = -1 Then DataSize = Data.Size
		  Return lzma_crc32(Data, DataSize, LastCRC)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CRC64(Data As MemoryBlock, LastCRC As UInt64 = 0, DataSize As Integer = - 1) As UInt64
		  ' Calculate the CRC64 checksum for the Data. Pass back the returned value
		  ' to continue processing.
		  '    Dim crc As UInt64
		  '    Do
		  '      crc = CRC64(NextData, crc)
		  '    Loop
		  ' If Data.Size is not known (-1) then specify the size as DataSize
		  
		  Static avail As Boolean
		  If Not avail Then avail = IsAvailable()
		  If Not avail Or Data = Nil Then Return 0
		  
		  If DataSize = -1 Then DataSize = Data.Size
		  Return lzma_crc64(Data, DataSize, LastCRC)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCompressor(Codec As LZMA.Codec, Preset As UInt32, Checksum As LZMA.ChecksumType, Optional Filters As LZMA.FilterList) As LZMA.Compressor
		  Select Case Codec
		  Case LZMA.Codec.XZ
		    Return New LZMA.Codecs.XZEncoder(Filters, Checksum)
		  Case LZMA.Codec.lzma1
		    Return New LZMA.Codecs.LZMAEncoder()
		  Case LZMA.Codec.Raw
		    Return New LZMA.Codecs.RawEncoder(Preset)
		  Else
		    Return New LZMA.Codecs.BasicEncoder(Preset, Checksum)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetDecompressor(Codec As LZMA.Codec, MemoryLimit As UInt64, Flags As UInt32) As LZMA.Decompressor
		  Select Case Codec
		  Case LZMA.Codec.XZ
		    Return New LZMA.Codecs.XZDecoder(MemoryLimit, Flags)
		  Case LZMA.Codec.lzma1
		    Return New LZMA.Codecs.LZMADecoder(MemoryLimit)
		  Case LZMA.Codec.Raw
		    Return New LZMA.Codecs.RawDecoder()
		  Else
		    Return New LZMA.Codecs.BasicDecoder(MemoryLimit, Flags)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsAvailable() As Boolean
		  Static avail As Boolean
		  If Not avail Then avail = System.IsFunctionAvailable("lzma_easy_encoder", "liblzma")
		  Return avail
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsChecksumTypeAvailable(Type As LZMA.ChecksumType) As Boolean
		  If Not IsAvailable Then Return False
		  Return lzma_check_is_supported(Type)
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_alone_decoder Lib LIB_LZMA (ByRef Stream As lzma_stream, MemLimit As UInt64) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_alone_encoder Lib LIB_LZMA (ByRef Stream As lzma_stream, Options As lzma_options_lzma) As ErrorCodes
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
		Private Soft Declare Function lzma_check_is_supported Lib LIB_LZMA (CheckType As ChecksumType) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_code Lib LIB_LZMA (ByRef Stream As lzma_stream, Action As EncodeAction) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_crc32 Lib LIB_LZMA (Buffer As Ptr, BufferSize As UInt32, LastCRC As UInt32) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_crc64 Lib LIB_LZMA (Buffer As Ptr, BufferSize As UInt32, LastCRC As UInt64) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_easy_encoder Lib LIB_LZMA (ByRef Stream As lzma_stream, Preset As UInt32, Check As ChecksumType) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_end Lib LIB_LZMA (ByRef Stream As lzma_stream) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_filters_update Lib LIB_LZMA (ByRef Stream As lzma_stream, Filters As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_filter_decoder_is_supported Lib LIB_LZMA (FilterID As UInt64) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_filter_encoder_is_supported Lib LIB_LZMA (FilterID As UInt64) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_lzma_preset Lib LIB_LZMA (Options As Ptr, Preset As UInt32) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_memlimit_get Lib LIB_LZMA (ByRef Stream As lzma_stream) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_memlimit_set Lib LIB_LZMA (ByRef Stream As lzma_stream, MemLimit As UInt64) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_memusage Lib LIB_LZMA (ByRef Stream As lzma_stream) As UInt64
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

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_version_number Lib LIB_LZMA () As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_version_string Lib LIB_LZMA () As CString
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function VersionNumber() As UInt32
		  If IsAvailable Then Return lzma_version_number()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function VersionString() As String
		  If IsAvailable Then Return lzma_version_string()
		End Function
	#tag EndMethod


	#tag Constant, Name = CHUNK_SIZE, Type = Double, Dynamic = False, Default = \"16384", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LIB_LZMA, Type = String, Dynamic = False, Default = \"liblzma", Scope = Private
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"liblzma.dll"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"liblzma.so.5"
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"liblzma.5.dylib"
	#tag EndConstant

	#tag Constant, Name = LZMA_BLOCK_HEADER_SIZE_MAX, Type = Double, Dynamic = False, Default = \"1024", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_BLOCK_HEADER_SIZE_MIN, Type = Double, Dynamic = False, Default = \"8", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_CONCATENATED, Type = Double, Dynamic = False, Default = \"&h08", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_DICT_SIZE_DEFAULT, Type = Double, Dynamic = False, Default = \"&h00800000", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_DICT_SIZE_MIN, Type = Double, Dynamic = False, Default = \"4096", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_FILTER_ARM, Type = Double, Dynamic = False, Default = \"&h07", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_FILTER_ARMTHUMB, Type = Double, Dynamic = False, Default = \"&h08", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_FILTER_IA64, Type = Double, Dynamic = False, Default = \"&h06", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_FILTER_LZMA1, Type = Double, Dynamic = False, Default = \"&h4000000000000001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_FILTER_LZMA2, Type = Double, Dynamic = False, Default = \"&h21", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_FILTER_POWERPC, Type = Double, Dynamic = False, Default = \"&h05", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_FILTER_SPARC, Type = Double, Dynamic = False, Default = \"&h09", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_FILTER_X86, Type = Double, Dynamic = False, Default = \"&h04", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_IGNORE_CHECK, Type = Double, Dynamic = False, Default = \"&h10", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_LCLP_MAX, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_LCLP_MIN, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_LC_DEFAULT, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_PRESET_EXTREME, Type = Double, Dynamic = False, Default = \"&h80000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_TELL_ANY_CHECK, Type = Double, Dynamic = False, Default = \"&h04", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_TELL_NO_CHECK, Type = Double, Dynamic = False, Default = \"&h01", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_TELL_UNSUPPORTED_CHECK, Type = Double, Dynamic = False, Default = \"&h02", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_VLI_UNKNOWN, Type = Double, Dynamic = False, Default = \"UINT64_MAX", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UINT64_MAX, Type = Double, Dynamic = False, Default = \"&hFFFFFFFFFFFFFFFF", Scope = Private
	#tag EndConstant


	#tag Structure, Name = lzma_block, Flags = &h21, Attributes = \"StructureAlignment \x3D 8"
		Version As UInt32
		  HeaderSize As UInt32
		  Check As ChecksumType
		  CompressedSize As UInt64
		  UncompressedSize As UInt64
		  Filters As lzma_filter
		  Checksum As String*64
		  Reserved1 As Ptr
		  Reserved2 As Ptr
		  Reserved3 As Ptr
		  Reserved4 As UInt32
		  Reserved5 As UInt32
		  Reserved6 As UInt64
		  Reserved7 As UInt64
		  Reserved8 As UInt64
		  Reserved9 As UInt64
		  Reserved10 As UInt64
		  Reserved11 As UInt64
		  Reserved12 As UInt32
		  Reserved13 As UInt32
		  Reserved14 As UInt32
		Reserved15 As UInt32
	#tag EndStructure

	#tag Structure, Name = lzma_filter, Flags = &h1, Attributes = \"StructureAlignment \x3D 8"
		ID As UInt64
		Options As Ptr
	#tag EndStructure

	#tag Structure, Name = lzma_options_lzma, Flags = &h21, Attributes = \"StructureAlignment \x3D 8"
		DictionarySize As UInt32
		  PresetDictionary As Ptr
		  PresetDictionarySize As UInt32
		  LiteralContextBitCount As UInt32
		  LiteralPositionBitCount As UInt32
		  PositionBitCount As UInt32
		  Mode As LZMAMode
		  NiceLength As UInt32
		  MatchFinder As LZMAMatchFinder
		  Depth As UInt32
		  Reserved1 As UInt32
		  Reserved2 As UInt32
		  Reserved3 As UInt32
		  Reserved4 As UInt32
		  Reserved5 As UInt32
		  Reserved6 As UInt32
		  Reserved7 As UInt32
		  Reserved8 As UInt32
		  Reserved9 As UInt32
		  Reserved10 As UInt32
		  Reserved11 As UInt32
		  Reserved12 As UInt32
		  Reserved13 As Ptr
		Reserved14 As Ptr
	#tag EndStructure

	#tag Structure, Name = lzma_stream, Flags = &h21, Attributes = \"StructureAlignment \x3D 8"
		NextIn As Ptr
		  AvailIn As UInt32
		  TotalIn As UInt64
		  NextOut As Ptr
		  AvailOut As UInt32
		  TotalOut As UInt64
		  Allocator As Ptr
		  InternalState As Int32
		  Reserved1 As Ptr
		  Reserved2 As Ptr
		  Reserved3 As Ptr
		  Reserved4 As Ptr
		  Reserved5 As UInt64
		  Reserved6 As UInt64
		  Reserved7 As Integer
		  Reserved8 As Integer
		  Reserved9 As Integer
		Reserved10 As Integer
	#tag EndStructure


	#tag Enum, Name = ChecksumType, Type = Integer, Flags = &h1
		None=0
		  CRC32=1
		  CRC64=4
		SHA256=10
	#tag EndEnum

	#tag Enum, Name = Codec, Type = Integer, Flags = &h1
		XZ
		  lzma1
		  Raw
		  Block
		Detect
	#tag EndEnum

	#tag Enum, Name = EncodeAction, Flags = &h1
		Run=0
		  SyncFlush=1
		  FullFlush=2
		  Finish=3
		FullBarrier=4
	#tag EndEnum

	#tag Enum, Name = ErrorCodes, Type = Integer, Flags = &h1
		OK=0
		  StreamEnd=1
		  NoCheck=2
		  UnsupportedCheck=3
		  GetCheck=4
		  MemError=5
		  MemLimitError=6
		  FormatError=7
		  OptionsError=8
		  DataError=9
		  BuffError=10
		ProgError=11
	#tag EndEnum

	#tag Enum, Name = LZMAMatchFinder, Type = Integer, Flags = &h1
		MF_HC3 = &h03
		  MF_HC4=&h04
		  MF_BT2=&h12
		  MF_BT3=&h13
		MF_BT4=&h14
	#tag EndEnum

	#tag Enum, Name = LZMAMode, Type = Integer, Flags = &h1
		Fast=1
		Normal=2
	#tag EndEnum


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
