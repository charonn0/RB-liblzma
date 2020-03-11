#tag Interface
Protected Interface Compressor
	#tag Method, Flags = &h0
		Function IsOpen() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastError() As LZMA.ErrorCodes
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Perform(ReadFrom As Readable, WriteTo As Writeable, Action As LZMA.EncodeAction, ReadCount As Int64) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalIn() As UInt64
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalOut() As UInt64
		  
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
End Interface
#tag EndInterface
