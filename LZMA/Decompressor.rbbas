#tag Class
Protected Class Decompressor
Inherits LZMAEngine
	#tag Method, Flags = &h0
		Sub Constructor(MemoryLimit As UInt64 = 0, Flags As UInt32 = 0)
		  Super.Constructor()
		  Const UINT64_MAX = &hffffffffffffffff
		  If MemoryLimit = 0 Then MemoryLimit = UINT64_MAX
		  If Flags = 0 Then Flags = LZMA_CONCATENATED
		  mLastError = lzma_auto_decoder(mStream, MemoryLimit, Flags)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Decompress(ReadFrom As Readable, WriteTo As Writeable, ReadCount As Int64 = -1) As Boolean
		  Return Super.Perform(ReadFrom, WriteTo, EncodeAction.Run, ReadCount)
		End Function
	#tag EndMethod


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
End Class
#tag EndClass
