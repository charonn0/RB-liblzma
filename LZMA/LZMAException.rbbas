#tag Class
Protected Class LZMAException
Inherits RuntimeException
	#tag Method, Flags = &h1000
		Sub Constructor(Error As ErrorCodes)
		  Me.ErrorNumber = Integer(Error)
		  Select Case Error
		  Case ErrorCodes.StreamEnd
		    mErrorName = "StreamEnd"
		    Me.Message = "End-of-Stream was reached."
		    
		  Case ErrorCodes.NoCheck
		    mErrorName = "NoCheck"
		    Me.Message = "The input stream has no integrity check."
		    
		  Case ErrorCodes.UnsupportedCheck
		    mErrorName = "UnsupportedCheck"
		    Me.Message = "The integrity check type is not supported."
		    
		  Case ErrorCodes.GetCheck
		    mErrorName = "GetCheck"
		    Me.Message = "The integrity check type is now available."
		    
		  Case ErrorCodes.MemError
		    mErrorName = "MemError"
		    Me.Message = "Out of memory."
		    
		  Case ErrorCodes.MemLimitError
		    mErrorName = "MemLimitError"
		    Me.Message = "The memory usage limit was reached."
		    
		  Case ErrorCodes.FormatError
		    mErrorName = "FormatError"
		    Me.Message = "The file format is not recognized."
		    
		  Case ErrorCodes.OptionsError
		    mErrorName = "OptionsError"
		    Me.Message = "The specified options are invalid or unsupported."
		    
		  Case ErrorCodes.DataError
		    mErrorName = "DataError"
		    Me.Message = "The input data are corrupt."
		    
		  Case ErrorCodes.BuffError
		    mErrorName = "BuffError"
		    Me.Message = "No progress is possible because the output buffer is full."
		    
		  Case ErrorCodes.ProgError
		    mErrorName = "ProgError"
		    Me.Message = "Programming error."
		  End Select
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mErrorName
			End Get
		#tag EndGetter
		ErrorName As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mErrorName As String
	#tag EndProperty


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
