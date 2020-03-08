#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  Dim errors As Dictionary = Testing.RuntTests()
		  If errors <> Nil And errors.Count > 0 Then
		    Dim s As String
		    For Each file As String In errors.Keys
		      Dim p As Pair = errors.Value(file)
		      s = s + file + " failed. Expected: " + Str(p.Left) +", got: " + Str(p.Right) + EndOfLine
		    Next
		    MsgBox(s)
		  Else
		    MsgBox("Tests completed with no errors.")
		  End If
		  
		End Sub
	#tag EndEvent


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
