VERSION 5.00
Object = "*\AToolbar2.vbp"
Begin VB.Form frmToolbarDemonstration 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Toolbar Demonstration"
   ClientHeight    =   4650
   ClientLeft      =   1485
   ClientTop       =   1455
   ClientWidth     =   6870
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   310
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   458
   ShowInTaskbar   =   0   'False
   Begin VB.CheckBox chkBorderTop 
      Caption         =   "Border&Top"
      Height          =   285
      Left            =   2700
      TabIndex        =   19
      Top             =   630
      Value           =   1  'Checked
      Width           =   1965
   End
   Begin VB.CheckBox chkBorderLeft 
      Caption         =   "Border&Left"
      Height          =   285
      Left            =   2700
      TabIndex        =   18
      Top             =   945
      Value           =   1  'Checked
      Width           =   1965
   End
   Begin VB.CheckBox chkBorderRight 
      Caption         =   "Border&Right"
      Height          =   285
      Left            =   2700
      TabIndex        =   17
      Top             =   1260
      Value           =   1  'Checked
      Width           =   1965
   End
   Begin VB.CheckBox chkBorderBottom 
      Caption         =   "Border&Bottom"
      Height          =   285
      Left            =   2700
      TabIndex        =   16
      Top             =   1575
      Value           =   1  'Checked
      Width           =   1965
   End
   Begin VB.ComboBox cboBorderStyle 
      Height          =   315
      ItemData        =   "Test.frx":0000
      Left            =   630
      List            =   "Test.frx":0016
      Style           =   2  'Dropdown List
      TabIndex        =   15
      Top             =   1530
      Width           =   1725
   End
   Begin VB.CheckBox chkDoubleTopBorder 
      Caption         =   "Dou&bleTopBorder"
      Height          =   285
      Left            =   4770
      TabIndex        =   14
      Top             =   630
      Width           =   1965
   End
   Begin VB.CheckBox chkDoubleBottomBorder 
      Caption         =   "DoubleBotto&mBorder"
      Height          =   285
      Left            =   4770
      TabIndex        =   13
      Top             =   945
      Width           =   1965
   End
   Begin VB.ComboBox cboAppearance 
      Height          =   315
      ItemData        =   "Test.frx":006F
      Left            =   630
      List            =   "Test.frx":0079
      Style           =   2  'Dropdown List
      TabIndex        =   12
      Top             =   855
      Width           =   1725
   End
   Begin VB.ComboBox cboCaption 
      Height          =   315
      ItemData        =   "Test.frx":0097
      Left            =   630
      List            =   "Test.frx":00A4
      Style           =   2  'Dropdown List
      TabIndex        =   11
      Top             =   2205
      Width           =   1725
   End
   Begin VB.CheckBox chkBold 
      Caption         =   "BoldOn&Checked"
      Height          =   285
      Left            =   2700
      TabIndex        =   10
      Top             =   2025
      Value           =   1  'Checked
      Width           =   1965
   End
   Begin VB.CheckBox chkShowSeparators 
      Caption         =   "Sho&wSeparators"
      Height          =   285
      Left            =   2700
      TabIndex        =   9
      Top             =   2340
      Value           =   1  'Checked
      Width           =   1965
   End
   Begin VB.TextBox txtField 
      Height          =   285
      Left            =   630
      TabIndex        =   8
      Top             =   3555
      Width           =   600
   End
   Begin VB.ComboBox cboAlignment 
      Height          =   315
      ItemData        =   "Test.frx":00DD
      Left            =   630
      List            =   "Test.frx":00ED
      Style           =   2  'Dropdown List
      TabIndex        =   7
      Top             =   2880
      Width           =   1725
   End
   Begin VB.CheckBox chkAutoSize 
      Caption         =   "AutoSi&ze"
      Enabled         =   0   'False
      Height          =   285
      Left            =   2700
      TabIndex        =   6
      Top             =   3105
      Width           =   1965
   End
   Begin VB.CheckBox chkDisabled 
      Caption         =   "DisabledText&3D"
      Height          =   285
      Left            =   2700
      TabIndex        =   5
      Top             =   3510
      Width           =   1965
   End
   Begin VB.CheckBox chkEnabled 
      Caption         =   "&Enabled"
      Height          =   285
      Left            =   2700
      TabIndex        =   4
      Top             =   3960
      Value           =   1  'Checked
      Width           =   1965
   End
   Begin VB.ComboBox cboStyle 
      Height          =   315
      ItemData        =   "Test.frx":0143
      Left            =   630
      List            =   "Test.frx":014D
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   4230
      Width           =   1725
   End
   Begin VB.CheckBox chkSolidChecked 
      Caption         =   "SolidChec&ked"
      Height          =   285
      Left            =   2700
      TabIndex        =   2
      Top             =   2655
      Width           =   1965
   End
   Begin VB.CheckBox chkShowToolTips 
      Caption         =   "Show&ToolTips"
      Height          =   240
      Left            =   4770
      TabIndex        =   1
      Top             =   2340
      Value           =   1  'Checked
      Width           =   1635
   End
   Begin VB.CheckBox chkSounds 
      Caption         =   "Play&Sounds"
      Height          =   240
      Left            =   4770
      TabIndex        =   0
      Top             =   2025
      Value           =   1  'Checked
      Width           =   1635
   End
   Begin AIFCmp1.asxToolbar tbrFontDemo 
      Height          =   465
      Left            =   5355
      Top             =   4050
      Width           =   1410
      _ExtentX        =   2487
      _ExtentY        =   820
      BeginProperty ToolTipFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ButtonGap       =   6
      BorderStyle     =   3
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ButtonCount     =   3
      SolidChecked    =   -1  'True
      ShowSeparators  =   -1  'True
      ButtonChecked1  =   -1  'True
      ButtonKey1      =   "Left"
      ButtonPicture1  =   "Test.frx":016C
      ButtonToolTipText1=   "Left"
      ButtonGroupID1  =   1
      ButtonKey2      =   "Center"
      ButtonPicture2  =   "Test.frx":04BE
      ButtonToolTipText2=   "Center"
      ButtonGroupID2  =   1
      ButtonKey3      =   "Right"
      ButtonPicture3  =   "Test.frx":0810
      ButtonToolTipText3=   "Right"
      ButtonGroupID3  =   1
   End
   Begin AIFCmp1.asxToolbar tbrDemo 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      Top             =   0
      Width           =   6870
      _ExtentX        =   12118
      _ExtentY        =   900
      FixedSize       =   32
      BeginProperty ToolTipFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ButtonCount     =   15
      CaptionOptions  =   2
      ButtonCaption1  =   "Back"
      ButtonDescription1=   "Display previous page from History"
      ButtonPicture1  =   "Test.frx":0B62
      ButtonPictureOver1=   "Test.frx":1064
      ButtonToolTipText1=   "Back"
      ButtonCaption2  =   "Next"
      ButtonDescription2=   "Display next page from history"
      ButtonPicture2  =   "Test.frx":1566
      ButtonPictureOver2=   "Test.frx":1A68
      ButtonToolTipText2=   "Next"
      ButtonDescription3=   "Stop loading a page"
      ButtonPicture3  =   "Test.frx":1F6A
      ButtonPictureOver3=   "Test.frx":246C
      ButtonToolTipText3=   "Stop"
      ButtonCaption4  =   "Refresh"
      ButtonDescription4=   "Refresh the current page"
      ButtonPicture4  =   "Test.frx":296E
      ButtonPictureOver4=   "Test.frx":2E70
      ButtonToolTipText4=   "Refresh"
      ButtonAlwaysShowCaption4=   -1  'True
      ButtonDescription5=   "Displays your home page"
      ButtonPicture5  =   "Test.frx":3372
      ButtonPictureOver5=   "Test.frx":3874
      ButtonToolTipText5=   "Home"
      ButtonStyle6    =   2
      ButtonDescription7=   "Displays a search engine"
      ButtonKey7      =   "Search"
      ButtonPicture7  =   "Test.frx":3D76
      ButtonPictureOver7=   "Test.frx":4278
      ButtonToolTipText7=   "Search"
      ButtonDescription8=   "Displays your favourites menu"
      ButtonKey8      =   "Fav"
      ButtonPicture8  =   "Test.frx":477A
      ButtonPictureOver8=   "Test.frx":4C7C
      ButtonToolTipText8=   "Favourites"
      ButtonDescription9=   "Displays your history list"
      ButtonKey9      =   "History"
      ButtonPicture9  =   "Test.frx":517E
      ButtonPictureOver9=   "Test.frx":5680
      ButtonToolTipText9=   "History"
      ButtonStyle10   =   2
      ButtonDescription11=   "Allows you to set options"
      ButtonPicture11 =   "Test.frx":5B82
      ButtonPictureOver11=   "Test.frx":6084
      ButtonPictureDown11=   "Test.frx":6586
      ButtonToolTipText11=   "Options"
      ButtonStyle12   =   2
      ButtonDescription13=   "Displays the page full screen"
      ButtonPicture13 =   "Test.frx":6A88
      ButtonPictureOver13=   "Test.frx":6F8A
      ButtonToolTipText13=   "Full Screen"
      ButtonDescription14=   "Allows the page to be edited"
      ButtonPicture14 =   "Test.frx":748C
      ButtonPictureOver14=   "Test.frx":79DE
      ButtonToolTipText14=   "Edit"
      ButtonStyle15   =   2
   End
   Begin AIFCmp1.asxToolbar tbrHeader 
      Align           =   3  'Align Left
      Height          =   4140
      Left            =   0
      Top             =   510
      Width           =   510
      _ExtentX        =   900
      _ExtentY        =   7303
      BeginProperty ToolTipFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TextColor       =   12582912
      TextDisabledColor=   8421504
      ButtonGap       =   6
      BorderStyle     =   0
      BackColor       =   255
      HighlightColor  =   12632319
      ShadowColor     =   192
      HighlightDarkColor=   8421631
      ShadowDarkColor =   128
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ButtonCount     =   3
      ShowSeparators  =   -1  'True
      ButtonCaption1  =   "Code"
      ButtonKey1      =   "Code"
      ButtonPicture1  =   "Test.frx":7F30
      ButtonToolTipText1=   "Display Code Module"
      ButtonGroupID1  =   1
      ButtonCaption2  =   "Notes"
      ButtonKey2      =   "Notes"
      ButtonPicture2  =   "Test.frx":8282
      ButtonToolTipText2=   "Display Code Description"
      ButtonGroupID2  =   1
      ButtonKey3      =   "Example"
      ButtonPicture3  =   "Test.frx":85D4
      ButtonToolTipText3=   "Display examples on using the code"
      ButtonGroupID3  =   1
   End
   Begin VB.Label lblHdr 
      AutoSize        =   -1  'True
      Caption         =   "Border&Style:"
      Height          =   195
      Index           =   0
      Left            =   630
      TabIndex        =   25
      Top             =   1305
      Width           =   855
   End
   Begin VB.Label lblHdr 
      AutoSize        =   -1  'True
      Caption         =   "&Appearance:"
      Height          =   195
      Index           =   1
      Left            =   630
      TabIndex        =   24
      Top             =   630
      Width           =   915
   End
   Begin VB.Label lblHdr 
      AutoSize        =   -1  'True
      Caption         =   "Caption&Options:"
      Height          =   195
      Index           =   2
      Left            =   630
      TabIndex        =   23
      Top             =   1980
      Width           =   1125
   End
   Begin VB.Label lblHdr 
      AutoSize        =   -1  'True
      Caption         =   "Button&Gap:"
      Height          =   195
      Index           =   3
      Left            =   630
      TabIndex        =   22
      Top             =   3330
      Width           =   810
   End
   Begin VB.Label lblHdr 
      AutoSize        =   -1  'True
      Caption         =   "CaptionAlignm&ent:"
      Height          =   195
      Index           =   4
      Left            =   630
      TabIndex        =   21
      Top             =   2655
      Width           =   1275
   End
   Begin VB.Label lblHdr 
      AutoSize        =   -1  'True
      Caption         =   "St&yle:"
      Height          =   195
      Index           =   5
      Left            =   630
      TabIndex        =   20
      Top             =   4005
      Width           =   390
   End
End
Attribute VB_Name = "frmToolbarDemonstration"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z


Private Sub cboAlignment_Click()
 tbrDemo.CaptionAlignment = cboAlignment.ListIndex
End Sub


Private Sub cboAppearance_Click()
 tbrDemo.Appearance = cboAppearance.ListIndex
 tbrFontDemo.Appearance = cboAppearance.ListIndex
 tbrHeader.Appearance = cboAppearance.ListIndex
End Sub


Private Sub cboBorderStyle_Click()
 tbrDemo.BorderStyle = cboBorderStyle.ListIndex
End Sub

Private Sub cboCaption_Click()
 tbrDemo.CaptionOptions = cboCaption.ListIndex
End Sub


Private Sub cboStyle_Click()
 tbrDemo.Style = cboStyle.ListIndex
End Sub


Private Sub chkBold_Click()
 tbrHeader.BoldOnChecked = chkBold
End Sub

Private Sub chkBorderBottom_Click()
 tbrDemo.Borderbottom = chkBorderBottom
End Sub

Private Sub chkBorderLeft_Click()
 tbrDemo.Borderleft = chkBorderLeft
End Sub

Private Sub chkBorderRight_Click()
 tbrDemo.Borderright = chkBorderRight
End Sub


Private Sub chkBorderTop_Click()
 tbrDemo.BorderTop = chkBorderTop
End Sub


Private Sub chkDisabled_Click()
 tbrDemo.DisabledText3D = chkDisabled
End Sub

Private Sub chkDoubleBottomBorder_Click()
 tbrDemo.DoubleBottomBorder = chkDoubleBottomBorder
End Sub

Private Sub chkDoubleTopBorder_Click()
 tbrDemo.DoubleTopBorder = chkDoubleTopBorder
End Sub


Private Sub chkEnabled_Click()
 tbrDemo.Enabled = chkEnabled
 tbrFontDemo.Enabled = chkEnabled
 tbrHeader.Enabled = chkEnabled
End Sub


Private Sub chkShowSeparators_Click()
 tbrHeader.ShowSeparators = chkShowSeparators
End Sub

Private Sub chkShowToolTips_Click()
 tbrDemo.ShowToolTips = chkShowToolTips
End Sub

Private Sub chkSolidChecked_Click()
 tbrHeader.SolidChecked = chkSolidChecked
End Sub


Private Sub chkSounds_Click()
 tbrDemo.PlaySounds = chkSounds
End Sub

Private Sub Form_Load()
 cboAppearance.ListIndex = ifcaStandard
 cboBorderStyle.ListIndex = tbbsRaised
 cboCaption.ListIndex = iftoSelectedLabels
 cboAlignment.ListIndex = ifcaCaptionOnRight
 cboStyle.ListIndex = tbtsVariable
 txtField = tbrDemo.ButtonGap
End Sub


Private Sub tbrDemo_ButtonClick(ByVal ButtonIndex As Integer, ByVal ButtonKey As String)
 If ButtonKey = "Search" Or ButtonKey = "Fav" Or ButtonKey = "History" Then
  tbrDemo.ButtonChecked(ButtonIndex) = Not tbrDemo.ButtonChecked(ButtonIndex)
 End If
End Sub


Private Sub txtField_Change()
 tbrDemo.ButtonGap = Val(txtField)
End Sub


