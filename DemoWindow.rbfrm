#tag Window
Begin Window DemoWindow
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   1.58e+2
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   ""
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   2
   Resizeable      =   False
   Title           =   "liblzma Demo"
   Visible         =   True
   Width           =   2.66e+2
   Begin Timer CompletionTimer
      Height          =   32
      Index           =   -2147483648
      Left            =   -48
      LockedInPosition=   False
      Mode            =   0
      Period          =   1
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   -14
      Width           =   32
   End
   Begin TabPanel TabPanel1
      AutoDeactivate  =   True
      Bold            =   ""
      Enabled         =   True
      Height          =   138
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   1
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Panels          =   ""
      Scope           =   0
      SmallTabs       =   ""
      TabDefinition   =   "Compress\rDecompress"
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   0
      Underline       =   ""
      Value           =   0
      Visible         =   True
      Width           =   265
      Begin Slider CompressionLevel
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   18
         HelpTag         =   "Compression level (0-9)"
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Left            =   17
         LineStep        =   1
         LiveScroll      =   True
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Maximum         =   9
         Minimum         =   0
         PageStep        =   20
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         TickStyle       =   2
         Top             =   112
         Value           =   6
         Visible         =   True
         Width           =   136
      End
      Begin Label CompressionLevelTxt
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   155
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   1
         Text            =   6
         TextAlign       =   1
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   108
         Transparent     =   True
         Underline       =   ""
         Visible         =   True
         Width           =   26
      End
      Begin PushButton CompressFileBtn
         AutoDeactivate  =   True
         Bold            =   ""
         ButtonStyle     =   0
         Cancel          =   ""
         Caption         =   "Compress"
         Default         =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   78
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   47
         Underline       =   ""
         Visible         =   True
         Width           =   97
      End
      Begin PopupMenu CheckTypeList
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         InitialValue    =   "CRC32\r\nCRC64\r\nSHA256\r\nNone"
         Italic          =   ""
         Left            =   128
         ListIndex       =   0
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   76
         Underline       =   ""
         Visible         =   True
         Width           =   80
      End
      Begin PopupMenu EncoderList
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         InitialValue    =   "XZ\r\nLZMA2\r\nLZMA1"
         Italic          =   ""
         Left            =   45
         ListIndex       =   0
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   76
         Underline       =   ""
         Visible         =   True
         Width           =   80
      End
      Begin PushButton DecompressFileBtn
         AutoDeactivate  =   True
         Bold            =   ""
         ButtonStyle     =   0
         Cancel          =   ""
         Caption         =   "Decompress"
         Default         =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   80
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   30
         Underline       =   ""
         Visible         =   True
         Width           =   97
      End
      Begin Label Label1
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   33
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   2
         Text            =   "Memory Limit(MB):"
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   63
         Transparent     =   True
         Underline       =   ""
         Visible         =   True
         Width           =   113
      End
      Begin TextField MemoryLimitTxt
         AcceptTabs      =   ""
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &hFFFFFF
         Bold            =   ""
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   152
         LimitText       =   0
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Mask            =   ""
         Password        =   ""
         ReadOnly        =   ""
         Scope           =   0
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   0
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   62
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   71
      End
      Begin CheckBox LZMAFlag_IgnoreCheck
         AutoDeactivate  =   True
         Bold            =   ""
         Caption         =   "Ignore check"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   33
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   88
         Underline       =   ""
         Value           =   False
         Visible         =   True
         Width           =   100
      End
      Begin CheckBox LZMAFlag_Concatenate
         AutoDeactivate  =   True
         Bold            =   ""
         Caption         =   "Concatenated"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   137
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   88
         Underline       =   ""
         Value           =   False
         Visible         =   True
         Width           =   100
      End
      Begin CheckBox ExtremeFlagChkBx
         AutoDeactivate  =   True
         Bold            =   ""
         Caption         =   "+Extreme"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   179
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   108
         Underline       =   ""
         Value           =   False
         Visible         =   True
         Width           =   79
      End
   End
   Begin ProgressBar ProgressBar1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   4
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Maximum         =   100
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   138
      Value           =   0
      Visible         =   True
      Width           =   258
   End
   Begin Timer ProgressTimer
      Height          =   32
      Index           =   -2147483648
      Left            =   -48
      LockedInPosition=   False
      Mode            =   0
      Period          =   100
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   32
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  #pragma Unused appQuitting
		  If mWorker <> Nil And mWorker.State <> Thread.NotRunning Then
		    If MsgBox("Would you like to cancel the current operation?", 4 + 32, "Operation incomplete") <> 6 Then Return True
		    mWorker.Kill
		    mWorker = Nil
		  End If
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub RunCompress(Sender As Thread)
		  #pragma Unused Sender
		  
		  Dim encoder As LZMA.Compressor
		  Select Case mCodec
		  Case LZMA.Codec.XZ
		    encoder = New LZMA.Codecs.XZEncoder(mLevel, Nil, mCheckType)
		  Case LZMA.Codec.lzma2
		    encoder = New LZMA.Codecs.LZMAEncoder(mLevel, Nil)
		  Case LZMA.Codec.lzma1
		    encoder = New LZMA.Codecs.RawEncoder(New LZMA.FilterList(mLevel, LZMA.LZMA_FILTER_LZMA1))
		  Else
		    encoder = New LZMA.Codecs.BasicEncoder(mLevel, mCheckType)
		  End Select
		  
		  Dim stream As BinaryStream = BinaryStream.Create(mDestination, True)
		  Dim compressor As New LZMA.LZMAStream(encoder, stream)
		  Dim input As BinaryStream = BinaryStream.Open(mSource)
		  Do Until input.EOF
		    compressor.Write(input.Read(1024 * 64))
		    mProgress = input.Length:input.Position
		  Loop
		  input.Close
		  compressor.Close
		  mResult = LZMA.ErrorCodes.OK
		  CompletionTimer.Mode = Timer.ModeSingle
		  
		Exception err As LZMA.LZMAException
		  mResult = LZMA.ErrorCodes(err.ErrorNumber)
		  CompletionTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDecompress(Sender As Thread)
		  #pragma Unused Sender
		  
		  Dim decoder As LZMA.Decompressor
		  Select Case mCodec
		  Case LZMA.Codec.XZ
		    decoder = New LZMA.Codecs.XZDecoder(0, 0)
		  Case LZMA.Codec.lzma2
		    decoder = New LZMA.Codecs.LZMADecoder()
		  Case LZMA.Codec.lzma1
		    decoder = New LZMA.Codecs.RawDecoder(New LZMA.FilterList(mLevel, LZMA.LZMA_FILTER_LZMA1), Nil)
		  Else
		    decoder = New LZMA.Codecs.BasicDecoder(0, 0)
		  End Select
		  
		  Dim stream As BinaryStream = BinaryStream.Open(mSource)
		  Dim decompressor As New LZMA.LZMAStream(decoder, stream)
		  Dim output As BinaryStream = BinaryStream.Create(mDestination)
		  Do Until decompressor.EOF
		    output.Write(decompressor.Read(1024 * 64))
		    mProgress = stream.Length:stream.Position
		  Loop
		  output.Close
		  decompressor.Close
		  mResult = LZMA.ErrorCodes.OK
		  CompletionTimer.Mode = Timer.ModeSingle
		  
		Exception err As LZMA.LZMAException
		  mResult = LZMA.ErrorCodes(err.ErrorNumber)
		  CompletionTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToggleLockUI()
		  CheckTypeList.Enabled = Not CheckTypeList.Enabled
		  CompressFileBtn.Enabled = Not CompressFileBtn.Enabled
		  CompressionLevel.Enabled = Not CompressionLevel.Enabled
		  CompressionLevelTxt.Enabled = Not CompressionLevelTxt.Enabled
		  DecompressFileBtn.Enabled = Not DecompressFileBtn.Enabled
		  EncoderList.Enabled = Not EncoderList.Enabled
		  ExtremeFlagChkBx.Enabled = (Not ExtremeFlagChkBx.Enabled And EncoderList.Text <> "LZMA1")
		  Label1.Enabled = Not Label1.Enabled
		  LZMAFlag_Concatenate.Enabled = Not LZMAFlag_Concatenate.Enabled
		  LZMAFlag_IgnoreCheck.Enabled = Not LZMAFlag_IgnoreCheck.Enabled
		  MemoryLimitTxt.Enabled = Not MemoryLimitTxt.Enabled
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCheckType As LZMA.ChecksumType
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCodec As LZMA.Codec
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDecoderFlags As UInt32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestination As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLockUI As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMemoryLimit As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As Pair
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResult As LZMA.ErrorCodes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorker As Thread
	#tag EndProperty


#tag EndWindowCode

#tag Events CompletionTimer
	#tag Event
		Sub Action()
		  If mResult <> LZMA.ErrorCodes.OK Then Call MsgBox("Error number " + Str(mResult), 16, "Error") Else MsgBox("Success!")
		  mWorker = Nil
		  mDestination = Nil
		  mSource = Nil
		  Self.Title = "liblzma Demo"
		  ProgressTimer.Mode = Timer.ModeOff
		  ToggleLockUI()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CompressionLevel
	#tag Event
		Sub ValueChanged()
		  CompressionLevelTxt.Text = Str(CompressionLevel.Value)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CompressFileBtn
	#tag Event
		Sub Action()
		  If mWorker <> Nil Then Return
		  mSource = GetOpenFolderItem("")
		  If mSource = Nil Then Return
		  mCodec = EncoderList.RowTag(EncoderList.ListIndex)
		  Select Case mCodec
		  Case LZMA.Codec.XZ
		    mDestination = GetSaveFolderItem(FileTypes1.XZCompressedFile, mSource.Name + ".xz")
		  Case LZMA.Codec.lzma2
		    mDestination = GetSaveFolderItem(FileTypes1.LZMA2CompressedFile, mSource.Name + ".lzma")
		  Case LZMA.Codec.lzma1
		    mDestination = GetSaveFolderItem(FileTypes1.LZMA1CompressedFile, mSource.Name + ".lzma1")
		  End Select
		  If mDestination = Nil Then Return
		  mLevel = CompressionLevel.Value
		  If ExtremeFlagChkBx.Value Then mLevel = mLevel Or LZMA.LZMA_PRESET_EXTREME
		  mCodec = EncoderList.RowTag(EncoderList.ListIndex)
		  mProgress = 0:0
		  ToggleLockUI()
		  mCheckType = CheckTypeList.RowTag(CheckTypeList.ListIndex)
		  Self.Title = "Compressing..."
		  ProgressTimer.Mode = Timer.ModeMultiple
		  mWorker = New Thread
		  AddHandler mWorker.Run, WeakAddressOf RunCompress
		  mWorker.Run
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckTypeList
	#tag Event
		Sub Open()
		  Me.DeleteAllRows
		  Me.AddRow("CRC32")
		  Me.RowTag(0) = LZMA.ChecksumType.CRC32
		  Me.AddRow("CRC64")
		  Me.RowTag(1) = LZMA.ChecksumType.CRC64
		  Me.AddRow("SHA256")
		  Me.RowTag(2) = LZMA.ChecksumType.SHA256
		  Me.AddRow("None")
		  Me.RowTag(3) = LZMA.ChecksumType.None
		  Me.ListIndex = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  If Me.Text <> "CRC32" And EncoderList.Text = "LZMA1" Then
		    Call MsgBox("The LZMA1 format supports only CRC32.", 48, "Invalid checksum type")
		    Me.ListIndex = 0
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EncoderList
	#tag Event
		Sub Open()
		  Me.DeleteAllRows
		  Me.AddRow("XZ")
		  Me.RowTag(0) = LZMA.Codec.XZ
		  Me.AddRow("LZMA1")
		  Me.RowTag(1) = LZMA.Codec.lzma1
		  Me.AddRow("LZMA2")
		  Me.RowTag(2) = LZMA.Codec.lzma2
		  Me.ListIndex = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  If Me.Text = "LZMA1" Then
		    If CheckTypeList.Text <> "CRC32" Then
		      Call MsgBox("The LZMA1 format supports only CRC32.", 48, "Checksum type updated")
		      CheckTypeList.ListIndex = 0
		    End If
		    If ExtremeFlagChkBx.Value Then
		      Call MsgBox("The LZMA1 format does not support the +Extreme option.", 48, "+Extreme flag updated")
		      ExtremeFlagChkBx.Value = False
		    End If
		    If CompressionLevel.Value = 0 Then
		      Call MsgBox("The LZMA1 format does not support a compression level of zero.", 48, "Compression level updated")
		      CompressionLevel.Value = 1
		    End If
		    CompressionLevel.Minimum = 1
		    CompressionLevel.HelpTag = "Compression level (1-9)"
		  Else
		    CompressionLevel.Minimum = 0
		    CompressionLevel.HelpTag = "Compression level (0-9)"
		  End If
		  
		  ExtremeFlagChkBx.Enabled = (Me.Text <> "LZMA1")
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DecompressFileBtn
	#tag Event
		Sub Action()
		  If mWorker <> Nil Then Return
		  mSource = GetOpenFolderItem(FileTypes1.All)
		  If mSource = Nil Then Return
		  Dim name As String = mSource.Name
		  Dim ext As String = NthField(name, ".", CountFields(name, "."))
		  name = Replace(name, "." + ext, "")
		  mDestination = GetSaveFolderItem("", name)
		  If mDestination = Nil Then Return
		  mDecoderFlags = 0
		  mProgress = 0:0
		  If LZMAFlag_Concatenate.Value Then mDecoderFlags = mDecoderFlags Or LZMA.LZMA_CONCATENATED
		  If LZMAFlag_IgnoreCheck.Value Then mDecoderFlags = mDecoderFlags Or LZMA.LZMA_IGNORE_CHECK
		  Select Case ext
		  Case FileTypes1.XZCompressedFile.Extensions
		    mCodec = LZMA.Codec.XZ
		  Case FileTypes1.LZMA1CompressedFile.Extensions
		    mCodec = LZMA.Codec.lzma1
		  Case FileTypes1.LZMA2CompressedFile.Extensions
		    mCodec = LZMA.Codec.lzma2
		  Else
		    mCodec = LZMA.Codec.Detect
		  End Select
		  
		  If Val(MemoryLimitTxt.Text) > 0 Then
		    mMemoryLimit = Val(MemoryLimitTxt.Text) * 1024 * 1024
		  Else
		    mMemoryLimit = 0
		  End If
		  ToggleLockUI()
		  
		  Self.Title = "Decompressing..."
		  ProgressTimer.Mode = Timer.ModeMultiple
		  mWorker = New Thread
		  AddHandler mWorker.Run, WeakAddressOf RunDecompress
		  mWorker.Run
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ProgressTimer
	#tag Event
		Sub Action()
		  Dim total, now As UInt64
		  total = mProgress.Left
		  now = mProgress.Right
		  ProgressBar1.Value = now * 100 / total
		End Sub
	#tag EndEvent
#tag EndEvents
