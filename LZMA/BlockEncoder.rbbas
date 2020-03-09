#tag Class
Protected Class BlockEncoder
Inherits LZMA.Compressor
	#tag Method, Flags = &h0
		Sub Constructor(ChecksumType As LZMA.ChecksumType)
		  Super.Constructor()
		  mBlock.Version = 1
		  mBlock.Check = ChecksumType
		  mLastError = lzma_block_encoder(mStream, mBlock)
		  If mLastError <> ErrorCodes.OK Then Raise New LZMAException(mLastError)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Perform(ReadFrom As Readable, WriteTo As Writeable, Action As LZMA.EncodeAction, ReadCount As Int64) As Boolean
		  Return Super.Perform(ReadFrom, WriteTo, Action, ReadCount)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mBlock As lzma_block
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Extreme"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="LZMA.Compressor"
		#tag EndViewProperty
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
			Name="Level"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="LZMA.Compressor"
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