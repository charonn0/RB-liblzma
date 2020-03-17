#tag Class
Protected Class LZMAEncoder
Inherits LZMA.LZMAEngine
Implements LZMA.Compressor
	#tag Method, Flags = &h0
		Sub Constructor(Preset As UInt32, Options As LZMA.LZMAOptions)
		  ' Constructs an encoder for the original LZMA1 algorithm.
		  
		  Super.Constructor()
		  If Options = Nil Then Options = New LZMAOptions(Preset)
		  mOptions = Options
		  mLastError = lzma_alone_encoder(mStream, mOptions)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mOptions As MemoryBlock
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
