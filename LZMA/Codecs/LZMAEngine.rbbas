#tag Class
Protected Class LZMAEngine
	#tag Method, Flags = &h0
		Function AvailIn() As UInt32
		  return mStream.AvailIn
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  If Not LZMA.IsAvailable() Then Raise New PlatformNotSupportedException
		  mStream.InternalState = 0
		  mStream.AvailIn = 0
		  mStream.AvailOut = 0
		  mStream.NextIn = Nil
		  mStream.NextOut = Nil
		  mStream.Reserved1 = Nil
		  mStream.Reserved2 = Nil
		  mStream.Reserved3 = Nil
		  mStream.Reserved4 = Nil
		  mStream.Reserved5 = 0
		  mStream.Reserved6 = 0
		  mStream.Reserved7 = 0
		  mStream.Reserved8 = 0
		  mStream.Reserved9 = 0
		  mStream.Reserved10 = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If mStream.InternalState <> 0 Then mLastError = lzma_end(mStream)
		  mStream.InternalState = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastError() As LZMA.ErrorCodes
		  return mLastError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Perform(ReadFrom As Readable, WriteTo As Writeable, Action As LZMA.EncodeAction, ReadCount As Int64) As Boolean
		  ' Performs encoding/decoding
		  ' ReadFrom is a Readable object from which input bytes are read.
		  ' WriteTo is a Writeable object to which output bytes are written.
		  ' Action is the encoder action to perform on the input bytes
		  ' ReadCount is the number of input bytes to read. Specify -1 to continue reading until ReadFrom.EOF
		  ' Returns True if the operation succeeded and the codec is ready for more input.
		  
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
		  return mStream.TotalIn
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalOut() As UInt64
		  return mStream.TotalOut
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mStream.AvailOut
			End Get
		#tag EndGetter
		AvailOut As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mStream.InternalState <> 0
			End Get
		#tag EndGetter
		IsOpen As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		LastError As ErrorCodes
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If IsOpen Then Return lzma_memlimit_get(mStream)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If IsOpen Then mLastError = lzma_memlimit_set(mStream, value)
			End Set
		#tag EndSetter
		MemoryLimit As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If IsOpen Then Return lzma_memusage(mStream)
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