#tag Module
Protected Module LZMA
	#tag Method, Flags = &h1
		Protected Function ChecksumLength(Type As LZMA.ChecksumType) As UInt32
		  If Not IsAvailable Then Return 0
		  Return lzma_check_size(Type)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CompressAsRaw(Filters As LZMA.FilterList, InputBuffer As MemoryBlock, ByRef OutputBuffer As MemoryBlock) As LZMA.ErrorCodes
		  If Not LZMA.IsAvailable Then Raise New PlatformNotSupportedException
		  If OutputBuffer = Nil Then OutputBuffer = New MemoryBlock(CompressBound(InputBuffer.Size))
		  Dim pos As UInt32
		  Dim err As ErrorCodes = lzma_raw_buffer_encode(Filters, Nil, InputBuffer, InputBuffer.Size, OutputBuffer, pos, OutputBuffer.Size)
		  If err = ErrorCodes.OK Then OutputBuffer.Size = pos
		  Return err
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CompressAsXZ(Filters As LZMA.FilterList, InputBuffer As MemoryBlock, ByRef OutputBuffer As MemoryBlock, Checksum As LZMA.ChecksumType) As LZMA.ErrorCodes
		  If Not LZMA.IsAvailable Then Raise New PlatformNotSupportedException
		  If OutputBuffer = Nil Then OutputBuffer = New MemoryBlock(CompressBound(InputBuffer.Size))
		  Dim pos As UInt32
		  Dim err As ErrorCodes = lzma_stream_buffer_encode(Filters, Checksum, Nil, InputBuffer, InputBuffer.Size, OutputBuffer, pos, OutputBuffer.Size)
		  If err = ErrorCodes.OK Then OutputBuffer.Size = pos
		  Return err
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CompressAsXZ(Preset As UInt32, InputBuffer As MemoryBlock, ByRef OutputBuffer As MemoryBlock, Checksum As LZMA.ChecksumType) As LZMA.ErrorCodes
		  If Not LZMA.IsAvailable Then Raise New PlatformNotSupportedException
		  If OutputBuffer = Nil Then OutputBuffer = New MemoryBlock(CompressBound(InputBuffer.Size))
		  Dim pos As UInt32
		  Dim err As ErrorCodes = lzma_easy_buffer_encode(Preset, Checksum, Nil, InputBuffer, InputBuffer.Size, OutputBuffer, pos, OutputBuffer.Size)
		  If err = ErrorCodes.OK Then OutputBuffer.Size = pos
		  Return err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CompressBound(UncompressedSize As UInt32) As UInt32
		  If IsAvailable Then Return lzma_stream_buffer_bound(UncompressedSize)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CRC32(Data As MemoryBlock, LastCRC As UInt32 = 0, DataSize As UInt32 = 0) As UInt32
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
		  
		  If DataSize = 0 Then DataSize = Data.Size
		  Return lzma_crc32(Data, DataSize, LastCRC)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CRC64(Data As MemoryBlock, LastCRC As UInt64 = 0, DataSize As UInt32 = 0) As UInt64
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
		  
		  If DataSize = 0 Then DataSize = Data.Size
		  Return lzma_crc64(Data, DataSize, LastCRC)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DecoderMemoryUse(Preset As UInt32) As UInt64
		  If Not IsAvailable Then Return 0
		  Return lzma_easy_decoder_memusage(Preset)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DecodeUInt64(EncodedForm As MemoryBlock) As UInt64
		  If Not LZMA.IsAvailable Then Raise New PlatformNotSupportedException
		  Dim VLIPosition, BufferPosition As UInt32
		  Dim VLI As UInt64
		  Dim err As ErrorCodes = lzma_vli_decode(VLI, VLIPosition, EncodedForm, BufferPosition, EncodedForm.Size)
		  If err <> ErrorCodes.StreamEnd Then Raise New LZMAException(err)
		  Return VLI
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Decompress(Filters As LZMA.FilterList, InputBuffer As MemoryBlock, OutputBuffer As MemoryBlock) As LZMA.ErrorCodes
		  Return Decompress(Filters, InputBuffer, OutputBuffer, 0, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Decompress(Filters As LZMA.FilterList, InputBuffer As MemoryBlock, OutputBuffer As MemoryBlock, Flags As UInt32, MemoryLimit As UInt64) As LZMA.ErrorCodes
		  If Not LZMA.IsAvailable Then Raise New PlatformNotSupportedException
		  Dim inpos, outpos As UInt32
		  Dim err As ErrorCodes
		  If Filters <> Nil Then
		    err = lzma_raw_buffer_decode(Filters, Nil, InputBuffer, inpos, InputBuffer.Size, OutputBuffer, outpos, OutputBuffer.Size)
		  Else
		    If MemoryLimit = 0 Then MemoryLimit = UINT64_MAX
		    err = lzma_stream_buffer_decode(MemoryLimit, Flags, Nil, InputBuffer, inpos, InputBuffer.Size, OutputBuffer, outpos, OutputBuffer.Size)
		  End If
		  If err = ErrorCodes.OK Then OutputBuffer.Size = outpos
		  Return err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Decompress(InputBuffer As MemoryBlock, OutputBuffer As MemoryBlock, Optional Flags As UInt32, Optional MemoryLimit As UInt64) As LZMA.ErrorCodes
		  Return Decompress(Nil, InputBuffer, OutputBuffer, Flags, MemoryLimit)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncoderMemoryUse(Preset As UInt32) As UInt64
		  If Not IsAvailable Then Return 0
		  Return lzma_easy_encoder_memusage(Preset)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncodeUInt64(VLI As UInt64) As MemoryBlock
		  If Not LZMA.IsAvailable Then Raise New PlatformNotSupportedException
		  Dim sz As UInt32 = lzma_vli_size(VLI)
		  If sz < 1 Then Raise New LZMAException(ErrorCodes.ProgError)
		  Dim VLIPosition, BufferPosition As UInt32
		  Dim buffer As New MemoryBlock(sz)
		  Dim err As ErrorCodes = lzma_vli_encode(VLI, VLIPosition, Buffer, BufferPosition, Buffer.Size)
		  If err <> ErrorCodes.StreamEnd Then Raise New LZMAException(err)
		  Return buffer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCompressor(Codec As LZMA.Codec, Preset As UInt32, Checksum As LZMA.ChecksumType) As LZMA.Compressor
		  Select Case Codec
		  Case LZMA.Codec.XZ
		    Return New LZMA.Codecs.XZEncoder(Preset, Nil, Checksum)
		  Case LZMA.Codec.lzma1
		    Return New LZMA.Codecs.LZMAEncoder(Preset, Nil)
		  Else
		    If Preset > 9 Then Preset = 9 Or LZMA_PRESET_EXTREME
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

	#tag Method, Flags = &h21
		Private Function IsXZCompressed(Extends Target As BinaryStream) As Boolean
		  //Checks the XZ magic number. Returns True if the Target is likely a XZ stream
		  
		  Dim IsXZ As Boolean
		  Dim pos As UInt64 = Target.Position
		  If Target.ReadUInt8 = &hFD And Target.ReadUInt8 = &h37 And _
		    Target.ReadUInt8 = &h7A And Target.ReadUInt8 = &h58 And _
		    Target.ReadUInt8 = &h5A And Target.ReadUInt8 = &h00 Then IsXZ = True 'maybe
		    Target.Position = pos
		    Return IsXZ
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsXZCompressed(Extends TargetFile As FolderItem) As Boolean
		  //Checks the XZ magic number. Returns True if the TargetFile is likely a XZ stream
		  
		  If Not TargetFile.Exists Then Return False
		  If TargetFile.Directory Then Return False
		  Dim bs As BinaryStream
		  Dim IsXZ As Boolean
		  Try
		    bs = BinaryStream.Open(TargetFile)
		    IsXZ = bs.IsXZCompressed()
		  Catch
		    IsXZ = False
		  Finally
		    If bs <> Nil Then bs.Close
		  End Try
		  Return IsXZ
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsXZCompressed(Extends Target As MemoryBlock) As Boolean
		  //Checks the XZ magic number. Returns True if the Target is likely a XZ stream
		  
		  If Target.Size = -1 Then Return False
		  Dim bs As BinaryStream
		  Dim IsXZ As Boolean
		  Try
		    bs = New BinaryStream(Target)
		    IsXZ = bs.IsXZCompressed()
		  Catch
		    IsXZ = False
		  Finally
		    If bs <> Nil Then bs.Close
		  End Try
		  Return IsXZ
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_block_buffer_bound Lib LIB_LZMA (UncompressedSize As UInt32) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_block_buffer_decode Lib LIB_LZMA (ByRef Block As lzma_block, Allocator As Ptr, Input As Ptr, ByRef InputPosition As UInt32, InputSize As UInt32, Output As Ptr, ByRef OutputPosition As UInt32, OutputSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_block_buffer_encode Lib LIB_LZMA (ByRef Block As lzma_block, Allocator As Ptr, Input As Ptr, InputSize As UInt32, Output As Ptr, ByRef OutputPosition As UInt32, OutputSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_block_compressed_size Lib LIB_LZMA (ByRef Block As lzma_block, UnpaddedSize As UInt64) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_block_header_decode Lib LIB_LZMA (ByRef Block As lzma_block, Allocator As Ptr, Input As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_block_header_encode Lib LIB_LZMA (Block As lzma_block, Output As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_block_header_size Lib LIB_LZMA (ByRef Block As lzma_block) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_block_total_size Lib LIB_LZMA (Block As lzma_block) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_block_uncomp_encode Lib LIB_LZMA (ByRef Block As lzma_block, Input As Ptr, InputSize As UInt32, Output As Ptr, ByRef OutputPosition As UInt32, OutputSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_block_unpadded_size Lib LIB_LZMA (Block As lzma_block) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_check_is_supported Lib LIB_LZMA (CheckType As ChecksumType) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_check_size Lib LIB_LZMA (CheckType As ChecksumType) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_code Lib LIB_LZMA (ByRef Stream As lzma_stream, Action As EncodeAction) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_cputhreads Lib LIB_LZMA () As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_crc32 Lib LIB_LZMA (Buffer As Ptr, BufferSize As UInt32, LastCRC As UInt32) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_crc64 Lib LIB_LZMA (Buffer As Ptr, BufferSize As UInt32, LastCRC As UInt64) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_easy_buffer_encode Lib LIB_LZMA (Preset As UInt32, Check As ChecksumType, Allocator As Ptr, Input As Ptr, InputSize As UInt32, Output As Ptr, ByRef OutputPosition As UInt32, OutputSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_easy_decoder_memusage Lib LIB_LZMA (Preset As UInt32) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_easy_encoder_memusage Lib LIB_LZMA (Preset As UInt32) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_end Lib LIB_LZMA (ByRef Stream As lzma_stream) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_filters_copy Lib LIB_LZMA (Source As Ptr, Destination As Ptr, Allocator As Ptr) As ErrorCodes
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
		Private Soft Declare Function lzma_filter_flags_decode Lib LIB_LZMA (Filters As Ptr, Allocator As Ptr, Input As Ptr, ByRef InputPosition As UInt32, InputSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_filter_flags_encode Lib LIB_LZMA (Filters As Ptr, Output As Ptr, ByRef OutputPosition As UInt32, OutputSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_filter_flags_size Lib LIB_LZMA (ByRef Size As UInt32, Filters As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_get_check Lib LIB_LZMA (ByRef Stream As lzma_stream) As ChecksumType
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
		Private Soft Declare Function lzma_physmem Lib LIB_LZMA () As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_raw_buffer_decode Lib LIB_LZMA (FilterList As Ptr, Allocator As Ptr, Input As Ptr, ByRef InputPosition As UInt32, InputSize As UInt32, Output As Ptr, ByRef OutputPosition As UInt32, OutputSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_raw_buffer_encode Lib LIB_LZMA (FilterList As Ptr, Allocator As Ptr, Input As Ptr, InputSize As UInt32, Output As Ptr, ByRef OutputPosition As UInt32, OutputSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_raw_decoder_memusage Lib LIB_LZMA (Filters As Ptr) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_raw_encoder_memusage Lib LIB_LZMA (Filters As Ptr) As UInt64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_stream_buffer_bound Lib LIB_LZMA (UncompressedSize As UInt32) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_stream_buffer_decode Lib LIB_LZMA (ByRef MemoryLimit As UInt64, Flags As UInt32, Allocator As Ptr, Input As Ptr, ByRef InputPosition As UInt32, InputSize As UInt32, Output As Ptr, ByRef OutputPosition As UInt32, OutputSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_stream_buffer_encode Lib LIB_LZMA (FilterList As Ptr, Check As ChecksumType, Allocator As Ptr, Input As Ptr, InputSize As UInt32, Output As Ptr, ByRef OutputPosition As UInt32, OutputSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_stream_flags_compare Lib LIB_LZMA (LValue As lzma_stream_flags, RValue As lzma_stream_flags) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_stream_footer_decode Lib LIB_LZMA (ByRef Options As lzma_stream_flags, Input As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_stream_footer_encode Lib LIB_LZMA (Options As lzma_stream_flags, Output As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_stream_header_decode Lib LIB_LZMA (ByRef Options As lzma_stream_flags, Input As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_stream_header_encode Lib LIB_LZMA (Options As lzma_stream_flags, Output As Ptr) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_version_number Lib LIB_LZMA () As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_version_string Lib LIB_LZMA () As CString
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_vli_decode Lib LIB_LZMA (Byref VLI As UInt64, ByRef VLIPosition As UInt32, Buffer As Ptr, ByRef BufferPosition As UInt32, BufferSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_vli_encode Lib LIB_LZMA (VLI As UInt64, ByRef VLIPosition As UInt32, Buffer As Ptr, ByRef BufferPosition As UInt32, BufferSize As UInt32) As ErrorCodes
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function lzma_vli_size Lib LIB_LZMA (VLI As UInt64) As UInt32
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


	#tag Note, Name = Copying
		RB-lzma (https://github.com/charonn0/RB-lzma)
		
		Copyright (c)2020 Andrew Lambert, all rights reserved.
		
		 Permission to use, copy, modify, and distribute this software for any purpose
		 with or without fee is hereby granted, provided that the above copyright
		 notice and this permission notice appear in all copies.
		 
		    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS. IN
		    NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
		    DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
		    OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
		    OR OTHER DEALINGS IN THE SOFTWARE.
		 
		 Except as contained in this notice, the name of a copyright holder shall not
		 be used in advertising or otherwise to promote the sale, use or other dealings
		 in this Software without prior written authorization of the copyright holder.
	#tag EndNote


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If IsAvailable Then Return lzma_cputhreads()
			End Get
		#tag EndGetter
		Protected CPUCount As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If IsAvailable Then Return lzma_physmem()
			End Get
		#tag EndGetter
		Protected TotalPhysicalMemory As UInt64
	#tag EndComputedProperty


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

	#tag Constant, Name = LZMA_CONCATENATED, Type = Double, Dynamic = False, Default = \"&h08", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_DICT_SIZE_DEFAULT, Type = Double, Dynamic = False, Default = \"&h00800000", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_DICT_SIZE_MIN, Type = Double, Dynamic = False, Default = \"4096", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_FILTER_ARM, Type = Double, Dynamic = False, Default = \"&h07", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_FILTER_ARMTHUMB, Type = Double, Dynamic = False, Default = \"&h08", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_FILTER_DELTA, Type = Double, Dynamic = False, Default = \"&h03", Scope = Protected
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

	#tag Constant, Name = LZMA_IGNORE_CHECK, Type = Double, Dynamic = False, Default = \"&h10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_LCLP_MAX, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_LCLP_MIN, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_LC_DEFAULT, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_PRESET_EXTREME, Type = Double, Dynamic = False, Default = \"&h80000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_STREAM_HEADER_SIZE, Type = Double, Dynamic = False, Default = \"12", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LZMA_TELL_ANY_CHECK, Type = Double, Dynamic = False, Default = \"&h04", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_TELL_NO_CHECK, Type = Double, Dynamic = False, Default = \"&h01", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LZMA_TELL_UNSUPPORTED_CHECK, Type = Double, Dynamic = False, Default = \"&h02", Scope = Protected
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
		  Filters As Ptr
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

	#tag Structure, Name = lzma_filter, Flags = &h21, Attributes = \"StructureAlignment \x3D 8"
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
		  MatchFinder As MatchFinder
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

	#tag Structure, Name = lzma_stream_flags, Flags = &h21, Attributes = \"StructureAlignment \x3D 8"
		Version As UInt32
		  BackwardSize As UInt64
		  Check As ChecksumType
		  Reserved1 As UInt32
		  Reserved2 As UInt32
		  Reserved3 As UInt32
		  Reserved4 As UInt32
		  Reserved5 As Boolean
		  Reserved6 As Boolean
		  Reserved7 As Boolean
		  Reserved8 As Boolean
		  Reserved9 As Boolean
		  Reserved10 As Boolean
		  Reserved11 As Boolean
		  Reserved12 As Boolean
		  Reserved13 As UInt32
		Reserved14 As UInt32
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
		  Detect
		lzma2=Codec.XZ
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

	#tag Enum, Name = LZMAMode, Type = Integer, Flags = &h1
		Fast=1
		Normal=2
	#tag EndEnum

	#tag Enum, Name = MatchFinder, Flags = &h1
		MF_HC3 = &h03
		  MF_HC4=&h04
		  MF_BT2=&h12
		  MF_BT3=&h13
		MF_BT4=&h14
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
