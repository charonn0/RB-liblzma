## Introduction
[liblzma](https://tukaani.org/xz/) is a free general purpose data compression library for the [LZMA](https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Markov_chain_algorithm) compression algorithm. LZMA is the basis for the XZ compressed file format.

**RB-liblzma** is a liblzma [binding](http://en.wikipedia.org/wiki/Language_binding) for Realbasic and Xojo projects.

The minimum supported liblzma version is 5.2.4. The minimum supported Xojo version is RS2009R3.

## Hilights
* Read and write compressed file or memory streams using a simple [BinaryStream work-alike](https://github.com/charonn0/RB-liblzma/wiki/LZMA.LZMAStream).
* Supports LZMA2, LZMA1, and XZ compressed streams

## Getting started
The recommended way to compress or decompress data is with the [`LZMAStream`](https://github.com/charonn0/RB-liblzma/wiki/LZMA.LZMAStream) class. The `LZMAStream` is a `BinaryStream` work-alike, and implements both the `Readable` and `Writeable` interfaces. Anything [written](https://github.com/charonn0/RB-liblzma/wiki/LZMA.LZMAStream.Write) to a `LZMAStream` is compressed and emitted to the output stream (another `Writeable`); [reading](https://github.com/charonn0/RB-liblzma/wiki/LZMA.LZMAStream.Read) from a `LZMAStream` decompresses data from the input stream (another `Readable`).

Instances of `LZMAStream` can be created from MemoryBlocks, FolderItems, and objects that implement the `Readable` and/or `Writeable` interfaces. For example, creating an in-memory compression stream from a zero-length MemoryBlock and writing a string to it:

```realbasic
  Dim output As New MemoryBlock(0)
  Dim lz As New LZMA.LZMAStream(output) ' zero-length creates a compressor
  lz.Write("Hello, world!")
  lz.Close
```
The string will be processed through the compressor and written to the `output` MemoryBlock. To create a decompressor pass a MemoryBlock whose size is > 0 (continuing from above):

```realbasic
  lz = New LZMA.LZMAStream(output) ' output contains the compressed string
  MsgBox(lz.Read(256)) ' read the decompressed string
```

### Encoder and Decoder classes
The other way to use LZMA is through the Encoder and Decoder classes found in the Codecs submodule. These classes provide a low-level wrapper to the LZMA API. All compression and decompression done using the `LZMAStream` class is ultimately carried out by an instance of an Encoder and Decoder class, respectively. You can construct instances directly, or use the [GetCompressor](https://github.com/charonn0/RB-liblzma/wiki/LZMA.GetCompressor) and [GetDecompressor](https://github.com/charonn0/RB-liblzma/wiki/LZMA.GetDecompressor) helper methods.

```realbasic
  ' compress
  Dim encoder As New LZMA.Codecs.BasicEncoder(6, LZMA.ChecksumType.CRC32)
  Dim src As MemoryBlock = "Hello, world!"
  Dim inputstream As New BinaryStream(src)
  Dim dst As New MemoryBlock(0)
  Dim outputstream As New BinaryStream(dst)
  
  Do Until inputstream.EOF
    Call encoder.Perform(inputstream, outputstream, LZMA.EncodeAction.Run, -1)
  Loop
  Call encoder.Perform(Nil, outputstream, LZMA.EncodeAction.Finish, -1)
  inputstream.Close
  outputstream.Close
  
  ' decompress
  Dim decoder As New LZMA.Codecs.BasicDecoder(0, 0)
  Dim result As New MemoryBlock(0)
  inputstream = New BinaryStream(dst)
  outputstream = New BinaryStream(result)
  
  Do Until inputstream.EOF
    Call decoder.Perform(inputstream, outputstream, LZMA.EncodeAction.Run, -1)
  Loop
  
  inputstream.Close
  outputstream.Close
  MsgBox(result)
```

## How to incorporate LZMA into your Realbasic/Xojo project
### Import the `LZMA` module
1. Download the RB-liblzma project either in [ZIP archive format](https://github.com/charonn0/RB-liblzma/archive/master.zip) or by cloning the repository with your Git client.
2. Open the RB-liblzma project in REALstudio or Xojo. Open your project in a separate window.
3. Copy the `LZMA` module into your project and save.

### Ensure the LZMA shared library is installed
LZMA is installed by default on some Unix-like operating systems, but may need to be installed separately.

Windows does not have it installed by default, you will need to ship the DLL with your application. You can download pre-built binaries from the [XZ project page](https://tukaani.org/xz/), or you can build them yourself from source (ibid.)

RB-liblzma will raise a PlatformNotSupportedException when used if all required DLLs/SOs/DyLibs are not available at runtime. 
