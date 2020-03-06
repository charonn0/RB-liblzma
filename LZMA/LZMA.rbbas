#tag Module
Protected Module LZMA
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
		Private Soft Declare Function lzma_check_is_supported Lib "liblzma" (CheckType As ChecksumType) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_code Lib "liblzma" (ByRef Stream As lzma_stream, Action As EncoderActions) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_crc32 Lib "liblzma" (Buffer As Ptr, BufferSize As UInt32, LastCRC As UInt32) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_crc64 Lib "liblzma" (Buffer As Ptr, BufferSize As UInt32, LastCRC As UInt64) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_easy_encoder Lib "liblzma" (ByRef Stream As lzma_stream, Preset As UInt32, Check As ChecksumType) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_end Lib "liblzma" (ByRef Stream As lzma_stream) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_stream_decoder Lib "liblzma" (ByRef Stream As lzma_stream, MemLimit As UInt64, Flags As UInt32) As ErrorCodes
	#tag EndExternalMethod


	#tag Constant, Name = CHUNK_SIZE, Type = Double, Dynamic = False, Default = \"16384", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_CONCATENATED, Type = Double, Dynamic = False, Default = \"&h08", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_IGNORE_CHECK, Type = Double, Dynamic = False, Default = \"&h10", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_PRESET_EXTREME, Type = Double, Dynamic = False, Default = \"&h80000000", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_TELL_ANY_CHECK, Type = Double, Dynamic = False, Default = \"&h04", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_TELL_NO_CHECK, Type = Double, Dynamic = False, Default = \"&h01", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_TELL_UNSUPPORTED_CHECK, Type = Double, Dynamic = False, Default = \"&h02", Scope = Private
	#tag EndConstant


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

	#tag Enum, Name = EncoderActions, Type = Integer, Flags = &h1
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
