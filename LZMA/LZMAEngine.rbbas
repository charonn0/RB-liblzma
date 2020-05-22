#tag Class
Protected Class LZMAEngine
	#tag Method, Flags = &h0
		Function AvailIn() As UInt32
		  // Part of the Decompressor interface.
		  ' Returns the number of unused bytes in the input buffer.
		  
		  return mStream.AvailIn
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AvailOut() As UInt32
		  ' Returns the number of unused bytes in the output buffer.
		  
		  return mStream.AvailOut
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  ' Subclasses must make sure to call this method from their Constructors.
		  
		  If Not LZMA.IsAvailable() Then Raise New PlatformNotSupportedException
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  ' Frees all resources. 
		  
		  If mStream.InternalState <> 0 Then mLastError = lzma_end(mStream)
		  mStream.InternalState = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetChecksumType() As ChecksumType
		  ' Used by subclasses if liblzma returns ErrorCodes.GetCheck
		  
		  Return lzma_get_check(mStream)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastError() As LZMA.ErrorCodes
		  // Part of the Compressor interface.
		  // Part of the Decompressor interface.
		  ' Returns the most recent error code encountered by the LZMAEngine.
		  
		  return mLastError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MemoryUse_() As UInt64
		  ' This method can be overridden by subclasses that need to call a different
		  ' function than lzma_memusage. The LZMAEngine.MemoryUse property uses this
		  ' method or its override.
		  
		  If IsOpen Then Return lzma_memusage(mStream)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Perform(ReadFrom As Readable, WriteTo As Writeable, Action As LZMA.EncodeAction, ReadCount As Int64) As Boolean
		  // Part of the Compressor interface.
		  // Part of the Decompressor interface.
		  ' Performs encoding and decoding. ReadFrom is a Readable object from which 
		  ' input bytes are read. WriteTo is a Writeable object to which output bytes
		  ' are written. Action is the encoder/decoder action to perform on the input. 
		  ' Not all actions are valid for all subclasses; for example, the SyncFlush
		  ' action is invalid if the engine is a Decompressor. ReadCount is the number
		  ' of input bytes to read. Specify -1 to continue reading until ReadFrom.EOF
		  ' This method returns True if the operation succeeded and the engine is 
		  ' ready for more input (unless Action=Finish.)
		  
		  If Not IsOpen Then Return False
		  Dim outbuff As New MemoryBlock(CHUNK_SIZE)
		  Dim count As Integer
		  Do
		    Dim chunk As MemoryBlock
		    Dim sz As Integer
		    If ReadCount > -1 Then sz = Min(ReadCount - count, CHUNK_SIZE) Else sz = CHUNK_SIZE
		    If ReadFrom <> Nil And sz > 0 Then chunk = ReadFrom.Read(sz) Else chunk = ""
		    
		    mStream.AvailIn = chunk.Size
		    mStream.NextIn = chunk
		    count = count + chunk.Size
		    
		    Do
		      If outbuff.Size <> CHUNK_SIZE Then outbuff.Size = CHUNK_SIZE
		      mStream.NextOut = outbuff
		      mStream.AvailOut = outbuff.Size
		      mLastError = lzma_code(mStream, Action)
		      Dim have As UInt32 = CHUNK_SIZE - mStream.AvailOut
		      If have > 0 Then
		        If have <> outbuff.Size Then outbuff.Size = have
		        WriteTo.Write(outbuff)
		      End If
		    Loop Until mLastError <> ErrorCodes.OK Or mStream.AvailOut <> 0
		    
		  Loop Until (ReadCount > -1 And count >= ReadCount) Or ReadFrom = Nil Or ReadFrom.EOF
		  
		  If Action = EncodeAction.Finish And mLastError <> ErrorCodes.StreamEnd Then Raise New LZMAException(mLastError)
		  Return mStream.AvailIn = 0 And (mLastError = ErrorCodes.OK Or mLastError = ErrorCodes.StreamEnd)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalIn() As UInt64
		  // Part of the Compressor interface.
		  // Part of the Decompressor interface.
		  ' Returns the number of bytes read so far.
		  
		  return mStream.TotalIn
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalOut() As UInt64
		  // Part of the Compressor interface.
		  // Part of the Decompressor interface.
		  ' Returns the number of bytes written so far.
		  
		  return mStream.TotalOut
		End Function
	#tag EndMethod


	#tag Note, Name = About this class
		This abstract class is the common ancestor for all the encoder and decoder classes. It supplies the 
		concrete methods for the Compressor and Decompressor interfaces implemented by its subclasses, but 
		does not implement either interface itself. The subclasses usually only implement their own Constructor
		methods and nothing else.
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns True if the LZMAEngine is ready for processing.
			  
			  Return mStream.InternalState <> 0
			End Get
		#tag EndGetter
		IsOpen As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the memory limit for the engine (decompression).
			  
			  If IsOpen Then Return lzma_memlimit_get(mStream)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the memory limit for the engine (decompression).
			  
			  If IsOpen Then mLastError = lzma_memlimit_set(mStream, value)
			End Set
		#tag EndSetter
		MemoryLimit As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the memory usage for the engine (decompression).
			  
			  return Me.MemoryUse_()
			End Get
		#tag EndGetter
		MemoryUse As UInt64
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mLastError As ErrorCodes
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mStream As lzma_stream
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
