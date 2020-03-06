#tag Class
Protected Class Compressor
Inherits LZMAEngine
	#tag Method, Flags = &h0
		Function Compress(ReadFrom As Readable, WriteTo As Writeable, Action As LZMA.EncoderActions, ReadCount As Int64 = -1) As Boolean
		  Return Super.Perform(ReadFrom, WriteTo, Action, ReadCount)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Preset As Integer, Checksum As LZMA.ChecksumType, Extreme As Boolean = False)
		  Super.Constructor()
		  If Extreme Then Preset = Preset Or LZMA_PRESET_EXTREME
		  mLastError = lzma_easy_encoder(mStream, Preset, Checksum)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		End Sub
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