Attribute VB_Name = "basChooseColor"

'-------------------------------'
' Ariad Development Library 2.0 '
'-------------------------------'
'      API Colour Common Dialog '
'                   Version 1.0 '
'-------------------------------'
'Copyright © 1998-9 by Ariad Software. All Rights Reserved

'Date Created:
'Last Updated:

Option Explicit
DefInt A-Z

Private Type TCHOOSECOLOR
 lStructSize        As Long
 hWndOwner          As Long
 hInstance          As Long
 rgbResult          As Long
 lpCustColors       As Long
 Flags              As Long
 lCustData          As Long
 lpfnHook           As Long
 lpTemplateName     As Long
End Type

Private Declare Function ChooseColor Lib "COMDLG32.DLL" Alias "ChooseColorA" (Color As TCHOOSECOLOR) As Long

Public CustomColors(0 To 15) As Long

Public Function SelectColor(hWndParent As Long, DefColor As Long, Optional ShowExpDlg As Boolean = 0, Optional InitCustomColours As Boolean = -1) As Long
 Dim I
 Dim C As Long
 Dim CC As TCHOOSECOLOR
 Dim CT$
 'Initialise Custom Colours
 If InitCustomColours Then
  For I = 0 To 15
   CT$ = GetSetting$("Ariad Non-ADL User Settings", "CustomColours", CStr(I))
   CustomColors(I) = IIf(Len(CT$), Val(CT$), QBColor(15))
  Next
 End If
 'Show Dialog
 With CC
  .rgbResult = DefColor
  .hWndOwner = hWndParent
  .lpCustColors = VarPtr(CustomColors(0))
  .Flags = &H101
  If ShowExpDlg Then .Flags = .Flags Or &H2
  .lStructSize = Len(CC)
  C = ChooseColor(CC)
  If C Then
   SelectColor = .rgbResult
  Else
   SelectColor = -1
  End If
 End With
End Function
