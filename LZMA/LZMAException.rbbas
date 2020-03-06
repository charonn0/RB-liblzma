#tag Class
Protected Class LZMAException
Inherits RuntimeException
	#tag Method, Flags = &h1000
		Sub Constructor(Error As ErrorCodes)
		  Me.ErrorNumber = Integer(Error)
		  Select Case Error
		  Case ErrorCodes.StreamEnd
		    Me.Message = "End of stream was reached"
		    
		  Case ErrorCodes.NoCheck
		    Me.Message = "Input stream has no integrity check"
		    
		  Case ErrorCodes.UnsupportedCheck
		    Me.Message = "Cannot calculate the integrity check"
		    
		  Case ErrorCodes.GetCheck
		    Me.Message = "Integrity check type is now available"
		    
		  Case ErrorCodes.MemError
		    Me.Message = "Cannot allocate memory"
		    
		  Case ErrorCodes.MemLimitError
		    Me.Message = "Memory usage limit was reached"
		    
		  Case ErrorCodes.FormatError
		    Me.Message = "File format not recognized"
		    
		  Case ErrorCodes.OptionsError
		    Me.Message = "Invalid or unsupported options"
		    
		  Case ErrorCodes.DataError
		    Me.Message = "Data is corrupt"
		    
		  Case ErrorCodes.BuffError
		    Me.Message = "No progress is possible"
		    
		  Case ErrorCodes.ProgError
		    Me.Message = "Programming error"
		  End Select
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="ErrorNumber"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="RuntimeException"
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
			Name="Message"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="RuntimeException"
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
