#tag Class
Protected Class LZMAOptions
	#tag Method, Flags = &h0
		Sub Constructor(Preset As UInt32)
		  If Not LZMA.IsAvailable Then Raise New PlatformNotSupportedException
		  mOptions = New MemoryBlock(lzma_options_lzma.Size)
		  If lzma_lzma_preset(mOptions, Preset) Then ' returns true if the preset is *not* supported
		    Raise New LZMAException(ErrorCodes.ProgError)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Ptr
		  Return mOptions
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mOptions <> Nil Then Return Operator_Convert.lzma_options_lzma.Depth
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mOptions <> Nil Then Operator_Convert.lzma_options_lzma.Depth = value
			End Set
		#tag EndSetter
		Depth As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mOptions <> Nil Then Return Operator_Convert.lzma_options_lzma.DictionarySize
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mOptions <> Nil Then Operator_Convert.lzma_options_lzma.DictionarySize = value
			End Set
		#tag EndSetter
		DictionarySize As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mOptions <> Nil Then Return Operator_Convert.lzma_options_lzma.LiteralContextBitCount
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mOptions <> Nil Then Operator_Convert.lzma_options_lzma.LiteralContextBitCount = value
			End Set
		#tag EndSetter
		LiteralContextBitCount As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mOptions <> Nil Then Return Operator_Convert.lzma_options_lzma.LiteralPositionBitCount
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mOptions <> Nil Then Operator_Convert.lzma_options_lzma.LiteralPositionBitCount = value
			End Set
		#tag EndSetter
		LiteralPositionBitCount As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mOptions <> Nil Then Return Operator_Convert.lzma_options_lzma.MatchFinder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mOptions <> Nil Then Operator_Convert.lzma_options_lzma.MatchFinder = value
			End Set
		#tag EndSetter
		MatchFinder As LZMA.MatchFinder
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mOptions <> Nil Then Return Operator_Convert.lzma_options_lzma.Mode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mOptions <> Nil Then Operator_Convert.lzma_options_lzma.Mode = value
			End Set
		#tag EndSetter
		Mode As LZMA.LZMAMode
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mOptions As MemoryBlock
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mOptions <> Nil Then Return Operator_Convert.lzma_options_lzma.NiceLength
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mOptions <> Nil Then Operator_Convert.lzma_options_lzma.NiceLength = value
			End Set
		#tag EndSetter
		NiceLength As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mOptions <> Nil Then Return Operator_Convert.lzma_options_lzma.PositionBitCount
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mOptions <> Nil Then Operator_Convert.lzma_options_lzma.PositionBitCount = value
			End Set
		#tag EndSetter
		PositionBitCount As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mOptions <> Nil Then Return Operator_Convert.lzma_options_lzma.PresetDictionary
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mOptions <> Nil Then Operator_Convert.lzma_options_lzma.PresetDictionary = value
			End Set
		#tag EndSetter
		PresetDictionary As Ptr
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mOptions <> Nil Then Return Operator_Convert.lzma_options_lzma.PresetDictionarySize
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mOptions <> Nil Then Operator_Convert.lzma_options_lzma.PresetDictionarySize = value
			End Set
		#tag EndSetter
		PresetDictionarySize As UInt32
	#tag EndComputedProperty


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
