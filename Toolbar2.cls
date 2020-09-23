VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsBSButton"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

'-----------------------------------------------'
'                 Ariad Development Library 2.0 '
'-----------------------------------------------'
'                       Generic Button Template '
'                                   Version 1.0 '
'-----------------------------------------------'
' For use with Toolbar, ToolBox and ButtonStrip '
'-----------------------------------------------'
'Copyright © 1998-9 by Ariad Software. All Rights Reserved

'Date Created:
'Last Updated:  12/07/99

'21/04/99
'           - GroupID property added
'12/07/99
'           - Pictures modified to use private array
'             access via APicture property

Option Explicit
DefInt A-Z

Public Caption$, Tag$, ToolTipText$
Public Enabled As Boolean, Visible As Boolean
Public UseMaskColor As Boolean
Public Checked As Boolean
Public MaskColor As OLE_COLOR
Public ClientLeft As Single, ClientHeight As Single
Public ClientWidth As Single, ClientTop As Single
Public TextClientLeft As Single, TextClientHeight As Single
Public TextClientWidth As Single, TextClientTop As Single
Public Key$, Description$
Public Style As IFCTBButtonStyles
Public PlaceholderSize As Single
Public AlwaysShowCaption As Boolean
Public GroupID

Public TemporaryPicture As StdPicture

Dim m_Picture(2) As StdPicture
'----------------------------------------------------------------------
'Name        : APicture
'Created     : 12/07/1999 14:30
'Modified    :
'Modified By :
'----------------------------------------------------------------------
'Author      : Richard James Moss
'Organisation: Ariad Software
'----------------------------------------------------------------------
Public Property Get APicture(WhichPicture As IFCWhatPictures) As StdPicture
 Set APicture = m_Picture(WhichPicture)
End Property '(Public) Property Get APicture () As StdPicture

Property Set APicture(WhichPicture As IFCWhatPictures, ByVal APicture As StdPicture)
 Set m_Picture(WhichPicture) = APicture
End Property ' Property Set APicture

Private Sub Class_Terminate()
 Dim I
 For I = 0 To 2
  Set m_Picture(I) = Nothing
 Next
 Set TemporaryPicture = Nothing
End Sub


