#tag Class
Protected Class Compressor
Inherits LZMAEngine
	#tag Method, Flags = &h0
		Sub Constructor(Preset As Integer, Checksum As LZMA.ChecksumType, Extreme As Boolean = False)
		  Super.Constructor()
		  If Preset < 0 Then Preset = 6
		  mLevel = Preset
		  mExtreme = Extreme
		  If Extreme Then Preset = Preset Or LZMA_PRESET_EXTREME
		  mLastError = lzma_easy_encoder(mStream, Preset, Checksum)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mExtreme
			End Get
		#tag EndGetter
		Extreme As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mLevel
			End Get
		#tag EndGetter
		Level As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mExtreme As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLevel As Integer = 6
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
