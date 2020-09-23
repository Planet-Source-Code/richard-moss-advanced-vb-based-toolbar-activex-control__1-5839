Attribute VB_Name = "basGDI"
Option Explicit
DefInt A-Z

Type RECT
 Left       As Long
 Top        As Long
 Right      As Long
 Bottom     As Long
End Type

Type POINTAPI
 X As Long
 Y As Long
End Type

Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Declare Function CreatePen& Lib "gdi32" (ByVal nPenStyle As Long, ByVal nWidth As Long, ByVal crColor As Long)
Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long
Declare Function DeleteObject& Lib "gdi32" (ByVal hObject As Long)
Declare Function DrawEdge Lib "user32" (ByVal hDC As Long, qrc As RECT, ByVal edge As Long, ByVal grfFlags As Long) As Boolean
Declare Function DrawFocusRect& Lib "user32" (ByVal hDC As Long, lpRect As RECT)
Declare Function DrawFrameControl Lib "user32" (ByVal hDC&, lpRect As RECT, ByVal un1 As Long, ByVal un2 As Long) As Boolean
Declare Function DrawText& Lib "user32" Alias "DrawTextA" (ByVal hDC As Long, ByVal lpStr As String, ByVal nCount As Long, lpRect As RECT, ByVal wFormat As Long)
Declare Function FillRect& Lib "user32" (ByVal hDC As Long, lpRect As RECT, ByVal hBrush As Long)
Declare Function GetBkColor& Lib "gdi32" (ByVal hDC As Long)
Declare Function GetDeviceCaps Lib "gdi32" (ByVal hDC As Long, ByVal nIndex As Long) As Long
Declare Function GetTextColor& Lib "gdi32" (ByVal hDC As Long)
Declare Function LineTo& Lib "gdi32" (ByVal hDC As Long, ByVal X As Long, ByVal Y As Long)
Declare Function MoveToEx& Lib "gdi32" (ByVal hDC As Long, ByVal X As Long, ByVal Y As Long, lpPoint As POINTAPI)
Declare Function MulDiv Lib "kernel32" (ByVal nNumber As Long, ByVal nNumerator As Long, ByVal nDenominator As Long) As Long
Declare Function OleTranslateColor Lib "oleaut32.dll" (ByVal lOleColor As Long, ByVal lHPalette As Long, lColorRef As Long) As Long
Declare Function SelectObject& Lib "gdi32" (ByVal hDC As Long, ByVal hObject As Long)
Declare Function SetTextColor& Lib "gdi32" (ByVal hDC As Long, ByVal crColor As Long)
Declare Function SetTextJustification Lib "gdi32" (ByVal hDC As Long, ByVal nBreakExtra As Long, ByVal nBreakCount As Long) As Long
Declare Function TextOut Lib "gdi32" Alias "TextOutA" (ByVal hDC As Long, ByVal X As Long, ByVal Y As Long, ByVal lpString As String, ByVal nCount As Long) As Long
Declare Function UpdateWindow& Lib "user32" (ByVal hWnd As Long)

'  flags for DrawFrameControl
Public Const DFC_CAPTION = 1 'Title bar
Public Const DFC_MENU = 2   'Menu
Public Const DFC_SCROLL = 3 'Scroll bar
Public Const DFC_BUTTON = 4 'Standard button

Public Const DFCS_CAPTIONCLOSE = &H0    'Close button
Public Const DFCS_CAPTIONMIN = &H1 'Minimize button
Public Const DFCS_CAPTIONMAX = &H2 'Maximize button
Public Const DFCS_CAPTIONRESTORE = &H3  'Restore button
Public Const DFCS_CAPTIONHELP = &H4     'Windows 95 only: Help button

Public Const DFCS_MENUARROW = &H0 'Submenu arrow
Public Const DFCS_MENUCHECK = &H1 'Check mark
Public Const DFCS_MENUBULLET = &H2 'Bullet
Public Const DFCS_MENUARROWRIGHT = &H4

Public Const DFCS_SCROLLUP = &H0   'Up arrow of scroll bar
Public Const DFCS_SCROLLDOWN = &H1 'Down arrow of scroll bar
Public Const DFCS_SCROLLLEFT = &H2 'Left arrow of scroll bar
Public Const DFCS_SCROLLRIGHT = &H3 'Right arrow of scroll bar

Public Const DFCS_SCROLLCOMBOBOX = &H5   'Combo box scroll bar
Public Const DFCS_SCROLLSIZEGRIP = &H8   'Size grip
Public Const DFCS_SCROLLSIZEGRIPRIGHT = &H10   'Size grip in bottom-right corner of window

Public Const DFCS_BUTTONCHECK = &H0 'Check box
Public Const DFCS_BUTTONRADIO = &H4 'Radio button
Public Const DFCS_BUTTON3STATE = &H8 'Three-state button
Public Const DFCS_BUTTONPUSH = &H10 'Push button
Public Const DFCS_INACTIVE = &H100 'Button is inactive (grayed)
Public Const DFCS_PUSHED = &H200  'Button is pushed
Public Const DFCS_CHECKED = &H400 'Button is checked
Public Const DFCS_ADJUSTRECT = &H2000   'Bounding rectangle is adjusted to exclude the surrounding edge of the push button
Public Const DFCS_FLAT = &H4000   'Button has a flat border
Public Const DFCS_MONO = &H8000   'Button has a monochrome border

Public Const BDR_RAISEDOUTER = &H1
Public Const BDR_SUNKENOUTER = &H2
Public Const BDR_RAISEDINNER = &H4
Public Const BDR_SUNKENINNER = &H8
Public Const BDR_OUTER = &H3
Public Const BDR_INNER = &HC
Public Const BDR_RAISED = &H5
Public Const BDR_SUNKEN = &HA

Public Const EDGE_RAISED = (BDR_RAISEDOUTER Or BDR_RAISEDINNER)
Public Const EDGE_SUNKEN = (BDR_SUNKENOUTER Or BDR_SUNKENINNER)
Public Const EDGE_ETCHED = (BDR_SUNKENOUTER Or BDR_RAISEDINNER)
Public Const EDGE_BUMP = (BDR_RAISEDOUTER Or BDR_SUNKENINNER)

Public Const BF_LEFT = &H1
Public Const BF_TOP = &H2
Public Const BF_RIGHT = &H4
Public Const BF_BOTTOM = &H8
Public Const BF_TOPLEFT = (BF_TOP Or BF_LEFT)
Public Const BF_TOPRIGHT = (BF_TOP Or BF_RIGHT)
Public Const BF_BOTTOMLEFT = (BF_BOTTOM Or BF_LEFT)
Public Const BF_BOTTOMRIGHT = (BF_BOTTOM Or BF_RIGHT)
Public Const BF_RECT = (BF_LEFT Or BF_TOP Or BF_RIGHT Or BF_BOTTOM)
Public Const BF_DIAGONAL = &H10

' For diagonal lines, the BF_RECT flags specify the end point of
' the vector bounded by the rectangle parameter.
Public Const BF_DIAGONAL_ENDTOPRIGHT = (BF_DIAGONAL Or BF_TOP Or BF_RIGHT)
Public Const BF_DIAGONAL_ENDTOPLEFT = (BF_DIAGONAL Or BF_TOP Or BF_LEFT)
Public Const BF_DIAGONAL_ENDBOTTOMLEFT = (BF_DIAGONAL Or BF_BOTTOM Or BF_LEFT)
Public Const BF_DIAGONAL_ENDBOTTOMRIGHT = (BF_DIAGONAL Or BF_BOTTOM Or BF_RIGHT)

Public Const BF_MIDDLE = &H800    ' Fill in the middle.
Public Const BF_SOFT = &H1000     ' Use for softer buttons.
Public Const BF_ADJUST = &H2000   ' Calculate the space left over.
Public Const BF_FLAT = &H4000     ' For flat rather than 3-D borders.
Public Const BF_MONO = &H8000     ' For monochrome borders.

'DrawText Constants
Public Const DT_BOTTOM = &H8
Public Const DT_CALCRECT = &H400
Public Const DT_CENTER = &H1
Public Const DT_LEFT = &H0
Public Const DT_NOCLIP = &H100
Public Const DT_NOPREFIX = &H800
Public Const DT_RIGHT = &H2
Public Const DT_SINGLELINE = &H20
Public Const DT_TOP = &H0
Public Const DT_VCENTER = &H4
Public Const DT_WORDBREAK = &H10

Public PT As POINTAPI
Public Sub DrawCtlEdge(hDC As Long, X As Single, Y As Single, W As Single, H As Single, Optional Style As Long = EDGE_RAISED, Optional Flags As Long = BF_RECT)
 Dim R As RECT
 With R
  .Left = X
  .Top = Y
  .Right = X + W
  .Bottom = Y + H
 End With
 DrawEdge hDC, R, Style, Flags
End Sub

Public Function DrawControl(ByVal hDC As Long, ByVal X As Single, ByVal Y As Single, ByVal W As Single, ByVal H As Single, ByVal CtlType As Long, ByVal Flags As Long)
 Dim R As RECT
 With R
  .Left = X
  .Top = Y
  .Right = X + W
  .Bottom = Y + H
 End With
 DrawControl = DrawFrameControl(hDC, R, CtlType, Flags)
End Function

Function TranslateColor(ByVal clr As OLE_COLOR, Optional hPal As Long = 0) As Long
 If OleTranslateColor(clr, hPal, TranslateColor) Then TranslateColor = -1
End Function
Public Function LineDC(ByVal hDC As Long, ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long, Optional Color As OLE_COLOR = -1) As Long
 Dim hPen As Long, hPenOld As Long
 Dim R
 hPen = CreatePen(0, 1, IIf(Color = -1, GetTextColor(hDC), TranslateColor(Color)))
 hPenOld = SelectObject(hDC, hPen)
 MoveToEx hDC, X1, Y1, PT
 LineDC = LineTo(hDC, X2, Y2)
 SelectObject hDC, hPenOld
 DeleteObject hPen
 DeleteObject hPenOld
End Function

Public Sub Box3DDC(ByVal hDC As Long, ByVal X As Long, ByVal Y As Long, ByVal W As Long, ByVal H As Long, Optional Highlight As OLE_COLOR = vb3DHighlight, Optional Shadow As OLE_COLOR = vb3DShadow, Optional Fill As OLE_COLOR = -1)
 Dim hPen As Long, hPenOld As Long
 'Fill
 If Fill <> -1 Then BoxSolidDC hDC, X, Y, W, H, Fill
 'Highlight
 hPen = CreatePen(0, 1, TranslateColor(Highlight))
 hPenOld = SelectObject(hDC, hPen)
 MoveToEx hDC, X + W - 1, Y, PT
 LineTo hDC, X, Y
 LineTo hDC, X, Y + H - 1
 SelectObject hDC, hPenOld
 DeleteObject hPen
 DeleteObject hPenOld
 'Shadow
 hPen = CreatePen(0, 1, TranslateColor(Shadow))
 hPenOld = SelectObject(hDC, hPen)
 LineTo hDC, X + W - 1, Y + H - 1
 LineTo hDC, X + W - 1, Y
 SelectObject hDC, hPenOld
 DeleteObject hPen
 DeleteObject hPenOld
End Sub
Public Sub BoxDC(ByVal hDC As Long, ByVal X As Long, ByVal Y As Long, ByVal W As Long, ByVal H As Long, Optional Color As OLE_COLOR = vbButtonFace, Optional Fill As OLE_COLOR = -1)
 Dim hPen As Long, hPenOld As Long
 'Fill
 If Fill <> -1 Then BoxSolidDC hDC, X, Y, W, H, Fill
 'Box
 hPen = CreatePen(0, 1, TranslateColor(Color))
 hPenOld = SelectObject(hDC, hPen)
 MoveToEx hDC, X + W - 1, Y, PT
 LineTo hDC, X, Y
 LineTo hDC, X, Y + H - 1
 LineTo hDC, X + W - 1, Y + H - 1
 LineTo hDC, X + W - 1, Y
 SelectObject hDC, hPenOld
 DeleteObject hPen
 DeleteObject hPenOld
End Sub

Public Function BoxSolidDC(ByVal hDC As Long, ByVal X As Long, ByVal Y As Long, ByVal W As Long, ByVal H As Long, Optional ByVal Fill As OLE_COLOR = vbButtonFace)
 Dim hBrush As Long
 Dim R As RECT
 hBrush = CreateSolidBrush(TranslateColor(Fill))
 With R
  .Left = X
  .Top = Y
  .Right = X + W - 1
  .Bottom = Y + H - 1
 End With
 FillRect hDC, R, hBrush
 DeleteObject hBrush
End Function

Public Sub BoxRect3DDC(ByVal hDC As Long, R As RECT, Optional Highlight As OLE_COLOR = vb3DHighlight, Optional Shadow As OLE_COLOR = vb3DShadow, Optional Fill As OLE_COLOR = -1)
 Box3DDC hDC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, Highlight, Shadow, Fill
End Sub

Public Sub PaintText(ByVal hDC As Long, ByVal Text$, ByVal X As Single, ByVal Y As Single, ByVal W As Single, ByVal H As Single, Optional ByVal Flags As Long = DT_LEFT)
 Dim R As RECT
 With R
  .Left = X
  .Top = Y
  .Right = X + W
  .Bottom = Y + H
 End With
 DrawText hDC, Text$, -1, R, Flags
End Sub


Public Sub DrawFocus(ByVal hDC As Long, ByVal X As Long, ByVal Y As Long, ByVal W As Long, ByVal H As Long)
 Dim R As RECT
 With R
  .Left = X
  .Top = Y
  .Right = X + W
  .Bottom = Y + H
 End With
 DrawFocusRect hDC, R
End Sub

