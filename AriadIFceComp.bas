Attribute VB_Name = "basAriadIFceComp"

'-------------------------------'
' Ariad Development Library 2.0 '
'-------------------------------'
'    Ariad Interface Components '
'                   Version 1.0 '
'-------------------------------'
'          Core Routines Module '
'-------------------------------'
'Copyright © 1998-9 by Ariad Software. All Rights Reserved

'Date Created:
'Last Updated:

Option Explicit
DefInt A-Z

'PlaySoundA Constants
Public Const SND_ASYNC = &H1             '  play asynchronously
Public Const SND_NODEFAULT = &H2         '  silence not default, if sound not found
Public Const SND_MEMORY = &H4            '  lpszSoundName points to a memory file

Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public Declare Function ClientToScreen Lib "user32" (ByVal hWnd As Long, lpPoint As POINTAPI) As Long
Public Declare Function GetActiveWindow Lib "user32" () As Long
Public Declare Function GetDC Lib "user32" (ByVal hWnd As Long) As Long
Public Declare Function GetDesktopWindow Lib "user32" () As Long
Public Declare Function GetDeviceCaps Lib "gdi32" (ByVal hDC As Long, ByVal nIndex As Long) As Long
Public Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Public Declare Function GetKeyState Lib "user32" (ByVal nVirtKey As Long) As Integer
Public Declare Function GetWindowRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long
Public Declare Function PlaySoundData Lib "WINMM.DLL" Alias "PlaySoundA" (lpData As Any, ByVal hModule As Long, ByVal dwFlags As Long) As Long
Public Declare Function ReleaseCapture& Lib "user32" ()
Public Declare Function ReleaseDC Lib "user32" (ByVal hWnd As Long, ByVal hDC As Long) As Long
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Function SetCapture& Lib "user32" (ByVal hWnd As Long)
Public Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Public Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Public Declare Function ShowWindow Lib "user32" (ByVal hWnd As Long, ByVal nCmdShow As Long) As Long
Public Declare Function WindowFromPoint Lib "user32" (ByVal xPoint As Long, ByVal yPoint As Long) As Long

Public Const SW_SHOWNOACTIVATE = 4

Private Const HWND_TOP& = 0
Private Const SWP_NOMOVE& = &H2
Private Const SWP_NOACTIVATE& = &H10
Private Const SWP_NOSIZE& = &H1
Private Const SWP_SHOWWINDOW& = &H40

Public PE As ascPaintEffects

Public CtlCount As Long

Public Const ASMAIL$ = "support@ariad.globalnet.co.uk"
Public Const ASURL$ = "http://www.users.globalnet.co.uk/~ariad/"
Public Const ASURL2$ = "http://www.ariad.tsx.org/"

Public Const INTERR$ = "An unexpected application error has occured!"
Public Const ERRTEXT$ = "If this problem continues, please contact Ariad technical support, at " + ASMAIL$ + ", quoting the above information."

'-------------------------------
'Name        : ShowPopupMenu
'Created     : 27/08/1999 14:39
'-------------------------------
'Author      : Richard Moss
'Organisation: Ariad Software
'-------------------------------
'Returns     : Nothing
'
'-------------------------------
'Updates     :
'
'-------------------------------
'---------AS-PROCBUILD 1.00.0024
Public Sub ShowPopupMenu(hWndClient As Long, PopupMenu As Menu, PopupParent As Form)
 Dim WinRect As RECT
 Dim WinPoint As POINTAPI
 Dim X As Single, Y As Single
 Dim ScaleMode As ScaleModeConstants
 ClientToScreen PopupParent.hWnd, WinPoint
 GetWindowRect hWndClient, WinRect
 If TypeOf PopupParent Is MDIForm Then
  ScaleMode = vbTwips
 Else
  ScaleMode = PopupParent.ScaleMode
 End If
 X = PopupParent.ScaleX(WinRect.Left - WinPoint.X, vbPixels, ScaleMode)
 Y = PopupParent.ScaleY(WinRect.Bottom - WinPoint.Y, vbPixels, ScaleMode)
 PopupParent.PopupMenu PopupMenu, , X, Y
End Sub '(Public) Sub ShowPopupMenu ()

'----------------------------------------------------------------------
'Name        : Highlight
'Created     : 21/08/1999 23:07
'Modified    :
'Modified By :
'----------------------------------------------------------------------
'Author      : Richard James Moss
'Organisation: Ariad Software
'----------------------------------------------------------------------
Public Sub Highlight(C As Control)
 With C
  .SelStart = 0
  .SelLength = Len(.Text)
 End With
End Sub '(Public) Sub Highlight ()

'----------------------------------------------------------------------
'Name        : InitPaintEffects
'Created     : 12/07/1999 14:51
'Modified    :
'Modified By :
'----------------------------------------------------------------------
'Author      : Richard James Moss
'Organisation: Ariad Software
'----------------------------------------------------------------------
Public Sub InitPaintEffects()
 If PE Is Nothing Then
  Set PE = New ascPaintEffects
 End If
End Sub '(Public) Sub InitPaintEffects ()


'----------------------------------------------------------------------
'Name        : Main
'Created     : 12/07/1999 14:40
'Modified    :
'Modified By :
'----------------------------------------------------------------------
'Author      : Richard James Moss
'Organisation: Ariad Software
'----------------------------------------------------------------------
Public Sub Main()
 Set PE = New ascPaintEffects
End Sub '(Public) Sub Main ()

Function StartDocError$(R As Long)
 Dim M$
 If R >= 0 Then
  Select Case R
   Case 0: M$ = "System was out of memory or executable file was corrupt."
   Case 2: M$ = "The file was not found."
   Case 3: M$ = "The path was not found."
   Case 5: M$ = "Attempt was made to link to a task dynamically, or there was a sharing or network-protection error."
   Case 6: M$ = "Library required separate data segments for each task."
   Case 8: M$ = "There was insufficient memory to start the application."
   Case 10: M$ = "The Windows version was incorrect."
   Case 11: M$ = "The executable file was invalid. Either it was not a Windows-based application or there was an error in the .EXE image."
   Case 12: M$ = "Application was designed for a different operating system."
   Case 13: M$ = "Application was designed for MS-DOS version 4.0."
   Case 14: M$ = "Type of executable file was unknown."
   Case 15: M$ = "Attempt was made to load a real-mode application that was developed for an earlier version of Windows."
   Case 16: M$ = "Attempt was made to load a second instance of an executable file containing multiple data segments not marked read-only."
   Case 19: M$ = "Attempt was made to load a compressed executable file. The file must be decompressed before it can be loaded."
   Case 20: M$ = "Dynamic-link library (DLL) file was invalid. One of the DLLs required to run this application was corrupt."
   Case 21: M$ = "Application requires Microsoft Windows 32-bit extensions."
   Case 31: M$ = "No application has been associated for use with specified document."
   Case Else: M$ = "Unknown Error."
  End Select
 Else
  M$ = "Unknown error."
 End If
 StartDocError$ = M$ + Chr$(10) + Chr$(10) + "(Error Code: " + CStr(R) + ")"
End Function

Function IsUsingLargeFonts() As Boolean
 Dim hWndDesk As Long, hDCDesk As Long, logPix As Long, R As Long
 hWndDesk = GetDesktopWindow()
 hDCDesk = GetDC(hWndDesk)
 logPix = GetDeviceCaps(hDCDesk, 88)
 R = ReleaseDC(hWndDesk, hDCDesk)
 If logPix > 96 Then IsUsingLargeFonts = -1
End Function

Function DegreeToRad(Deg As Integer) As Single
 DegreeToRad = Deg / 57.295779513
End Function

Public Function RemoveExtension$(F$)
 Dim R$(), E$
 Dim I
 If InStr(F$, ".") Then
  R$ = Split(F$, ".")
  For I = 0 To UBound(R$) - 1
   E$ = E$ + R$(I) + "."
  Next
  RemoveExtension$ = Left$(E$, Len(E$) - 1)
 Else
  RemoveExtension$ = F$
 End If
End Function

Function IsInControl(ByVal hWnd As Long) As Boolean
 Dim P As POINTAPI
 GetCursorPos P
 If hWnd = WindowFromPoint(P.X, P.Y) Then IsInControl = -1
End Function

Public Function GetFile$(FP$)
 Dim R$()
 If Len(FP$) Then
  R$() = Split(FP$, "\")
  GetFile$ = R$(UBound(R$))
 End If
End Function

Sub PlaySnd(SndName$, m_PlaySounds As Boolean)
 Dim bySound() As Byte
 On Error Resume Next
  If m_PlaySounds Then
   bySound = LoadResData(SndName$, 100)
   If Err = 0 And UBound(bySound) > 0 Then
    PlaySoundData bySound(0), 0, SND_MEMORY + SND_ASYNC + SND_NODEFAULT
   End If
  End If
 On Error GoTo 0
End Sub

Public Function ShowTip(ByVal Tip$, ByVal hWnd As Long, Optional ByVal Font As StdFont) As Boolean
 Const DX = -2   ' Offset from the mouse position.
 Const DY = 18
 Dim X As Long, Y As Long
 Dim PT As POINTAPI
 On Error Resume Next
  GetCursorPos PT
  X = PT.X
  Y = PT.Y
  HideTip
  With frmTooltip
   If Not Font Is Nothing Then
    Set .lblTip.Font = Font
    Set .Font = Font
   End If
   .lblTip.Width = .TextWidth(Tip$)
   .lblTip.Caption = Tip$
   .lblTip.Refresh
   .CtlHWnd = hWnd
   .Move (X + DX) * Screen.TwipsPerPixelX, (Y + DY) * Screen.TwipsPerPixelY, .lblTip.Width + (8 * Screen.TwipsPerPixelX), .lblTip.Height + (5 * Screen.TwipsPerPixelY)
   .tmrTip.Enabled = 0
   .tmrTip.Enabled = -1
   If .Left + .Width > Screen.Width Then .Left = Screen.Width - .Width
   If .Top + .Height > Screen.Height Then .Top = Screen.Height - .Height
   SetWindowPos .hWnd, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE Or SWP_NOMOVE Or SWP_NOSIZE Or SWP_SHOWWINDOW
  End With
  ShowTip = -1
 On Error GoTo 0
End Function

Function DefineAccessKey$(Caption$)
 Dim P, N
 Dim C$
 N = 1
 Do
  P = InStr(N, Caption$, "&")
  If P Then
   C$ = Mid$(Caption$, P + 1, 1)
   If C$ <> "&" Then DefineAccessKey$ = DefineAccessKey$ + C$
   N = P + 1
  End If
 Loop Until P = 0
End Function


Public Sub HideTip()
 On Error Resume Next
  Unload frmTooltip
 On Error GoTo 0
End Sub


Public Sub Pointer(V)
 Screen.MousePointer = V
End Sub



Public Function UltimateParent(Ctl As Object) As Object
 Dim O As Object, T As Object
 On Error Resume Next
  Set T = Ctl.Parent
  Set UltimateParent = T
  Do
   Set O = T.Parent
   If Not O Is Nothing Then
    Set T = O
    Set UltimateParent = O
   End If
  Loop Until O Is Nothing
 On Error GoTo 0
End Function

