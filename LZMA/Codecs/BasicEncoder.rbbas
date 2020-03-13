#tag Class
Protected Class BasicEncoder
Inherits LZMA.LZMAEngine
Implements LZMA.Compressor
	#tag Method, Flags = &h0
		Sub Constructor(Preset As UInt32, Checksum As LZMA.ChecksumType, Extreme As Boolean = False)
		  ' Constructs an encoder that uses the XZ file format.
		  ' Preset is the compression level (1-9)
		  ' Checksum is the type of Checksum to use
		  ' If Extreme=True then slower techniques are used to maximize compression
		  
		  Super.Constructor()
		  If Preset < 0 Then Preset = 6
		  mPreset = Preset
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

	#tag Property, Flags = &h21
		Private mExtreme As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPreset As UInt32 = 6
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mPreset
			End Get
		#tag EndGetter
		Preset As UInt32
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Extreme"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
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
			InheritedFrom="LZMA.Codecs.LZMAEngine"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Level"
			Group="Behavior"
			Type="Integer"
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
