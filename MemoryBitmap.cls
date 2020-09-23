VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ascMemoryBitmap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

'-----------------------------------------'
'           Ariad Development Library 2.1 '
'-----------------------------------------'
'                     Memory Bitmap Class '
'                             Version 1.0 '
'-----------------------------------------'
' Based on original code by Steve McMahon '
'-----------------------------------------'
'Copyright © 1999 by Ariad Software. All Rights Reserved

'Date Created:
'Last Updated: 21/05/1999

Option Explicit
DefInt A-Z

Private Type BITMAP '14 bytes
 bmType         As Long
 bmWidth        As Long
 bmHeight       As Long
 bmWidthBytes   As Long
 bmPlanes       As Integer
 bmBitsPixel    As Integer
 bmBits         As Long
End Type

Private Type PicBmp
 Size       As Long
 tType      As Long
 hBmp       As Long
 hPal       As Long
 Reserved   As Long
End Type

Private Type GUID
 Data1      As Long
 Data2      As Integer
 Data3      As Integer
 Data4(7)   As Byte
End Type

Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hDC As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hDC As Long) As Long
Private Declare Function CreateDCAsNull Lib "gdi32" Alias "CreateDCA" (ByVal lpDriverName As String, lpDeviceName As Any, lpOutput As Any, lpInitData As Any) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hDC As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function GetDC Lib "user32" (ByVal hWnd As Long) As Long
Private Declare Function GetDeviceCaps Lib "gdi32" (ByVal hDC As Long, ByVal nIndex As Long) As Long
Private Declare Function GetObjectAPI Lib "gdi32" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, lpObject As Any) As Long
Private Declare Function OleCreatePictureIndirect Lib "olepro32.dll" (PicDesc As PicBmp, RefIID As GUID, ByVal fPictureOwnsHandle As Long, IPic As IPicture) As Long
Private Declare Function ReleaseDC Lib "user32" (ByVal hWnd As Long, ByVal hDC As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hDC As Long, ByVal hObject As Long) As Long

Const BITSPIXEL = 12
Const LOGPIXELSX = 88    '  Logical pixels/inch in X
Const LOGPIXELSY = 90    '  Logical pixels/inch in Y

Dim m_hDC As Long
Dim m_hBmp As Long
Dim m_hBmpOld As Long
Dim m_lWidth As Long
Dim m_lHeight As Long
'----------------------------------------------------------------------
'Name        : Picture
'Created     : 28/06/1999 14:14
'Modified    :
'----------------------------------------------------------------------
'Author      : Richard Moss
'Organisation: Ariad Software
'----------------------------------------------------------------------
Public Property Get Picture() As IPicture
 Dim pic As PicBmp
 Dim IPic As IPicture
 Dim IID_IDispatch As GUID
 If m_hBmp Then
  ' Fill in with IDispatch Interface ID.
  With IID_IDispatch
   .Data1 = &H20400
   .Data4(0) = &HC0
   .Data4(7) = &H46
  End With
  ' Fill Pic with necessary parts.
  With pic
   .Size = Len(pic) ' Length of structure.
   .tType = vbPicTypeBitmap ' Type of Picture (bitmap).
   .hBmp = m_hBmp ' Handle to bitmap.
  End With
  ' Create Picture object.
  Call OleCreatePictureIndirect(pic, IID_IDispatch, 1, IPic)
  ' Return the new Picture object.
  Set Picture = IPic
 End If
End Property
Public Property Get hBmp() As Long
 hBmp = m_hBmp
End Property
Public Property Get Width() As Long
 Width = m_lWidth
End Property

Public Property Get Height() As Long
 Height = m_lHeight
End Property

Sub ClearUp()
 If m_hBmpOld <> 0 Then
  SelectObject m_hDC, m_hBmpOld
  m_hBmpOld = 0
 End If
 If m_hBmp <> 0 Then
  DeleteObject m_hBmp
  m_hBmp = 0
 End If
 If m_hDC <> 0 Then
  DeleteDC m_hDC
  m_hDC = 0
 End If
End Sub

Private Sub Class_Terminate()
 ClearUp
End Sub

Private Function LoadBitmapIntoMemory(P As StdPicture) As Boolean
 Dim tBM As BITMAP
 Dim hBmp As Long, hBmpOld As Long
 Dim hDCDesk As Long, hdcTemp As Long
 On Error GoTo ProcErr
  ClearUp
  hBmp = P.handle
  GetObjectAPI hBmp, Len(tBM), tBM
  hDCDesk = CreateDCAsNull("DISPLAY", ByVal 0&, ByVal 0&, ByVal 0&)
  If (hDCDesk <> 0) Then
   hdcTemp = CreateCompatibleDC(hDCDesk)
   If (hdcTemp <> 0) Then
    hBmpOld = SelectObject(hdcTemp, hBmp)
    If (hBmpOld <> 0) Then
     m_hDC = CreateCompatibleDC(hDCDesk)
     If (m_hDC <> 0) Then
      m_hBmp = CreateCompatibleBitmap(hDCDesk, tBM.bmWidth, tBM.bmHeight)
      If (m_hBmp <> 0) Then
       m_hBmpOld = SelectObject(m_hDC, m_hBmp)
       If m_hBmpOld <> 0 Then
        m_lWidth = tBM.bmWidth
        m_lHeight = tBM.bmHeight
        BitBlt m_hDC, 0, 0, m_lWidth, m_lHeight, hdcTemp, 0, 0, vbSrcCopy
        LoadBitmapIntoMemory = True
       Else
        ClearUp
       End If
      Else
       ClearUp
      End If
     Else
      ClearUp
     End If
     SelectObject hdcTemp, hBmpOld
    End If
    DeleteDC hdcTemp
   End If
   DeleteDC hDCDesk
  End If
 On Error GoTo 0
Exit Function

ProcErr:
 RaiseError "LoadBitmapIntoMemory"
Exit Function
End Function


Public Property Get hDC() As Long
 '##BD Returns a handle provided by the Microsoft Windows operating environment to the device context of the memory bitmap
 hDC = m_hDC
End Property


Public Function CreateByFile(ByVal FileName$) As Boolean
 Dim P As StdPicture
 On Error GoTo ProcErr
  Set P = LoadPicture(FileName$)
  If Not P Is Nothing Then
   CreateByFile = LoadBitmapIntoMemory(P)
  End If
 On Error GoTo 0
Exit Function

ProcErr:
 RaiseError "CreateByFile"
Exit Function
End Function

Public Function CreateByPicture(ByVal Picture As StdPicture) As Boolean
 On Error GoTo ProcErr
  If Not Picture Is Nothing Then
   If Picture.Type = vbPicTypeBitmap Then
    CreateByPicture = LoadBitmapIntoMemory(Picture)
   Else
    RaiseErrorEx "CreateByPicture", 481, "Picture property must be of type Bitmap"
   End If
  End If
 On Error GoTo 0
Exit Function

ProcErr:
 RaiseError "CreateByPicture"
Exit Function
End Function

Public Function CreateByResource(ByVal ResourceID As Variant) As Boolean
 Dim P As StdPicture
 On Error GoTo ProcErr
  Set P = LoadResPicture(ResourceID, vbResBitmap)
  If Not P Is Nothing Then
   CreateByResource = LoadBitmapIntoMemory(P)
  End If
 On Error GoTo 0
Exit Function

ProcErr:
 RaiseError "CreateByResource"
Exit Function
End Function

'----------------------------------------------------------------------
'Name        : RaiseError
'Created     : 14/07/1999 19:12
'Modified    :
'Modified By :
'----------------------------------------------------------------------
'Author      : Richard James Moss
'Organisation: Ariad Software
'----------------------------------------------------------------------
'Description : Raises a standard Visual Basic error
'            : When in Design Mode, a simple message box is displayed instead
'----------------------------------------------------------------------
'Updates     : 16/09/99 - Added support for procedure names
'
'----------------------------------------------------------------------
'------------------------------Ariad Procedure Builder Add-In 1.00.0026
Private Sub RaiseError(ByVal ProcName$)
' If Ambient.UserMode Then
  '"Runtime" - raise error
  Err.Raise Err, App.EXEName & "." & TypeName(Me) & ":" & ProcName$
' Else
'  '"Design time" - display error
'  VBA.MsgBox INTERR$ & vbCr & vbCr & Err.Description & " (" & Err & ")" & vbCr & vbCr & ERRTEXT$, vbCritical, App.EXEName & "." & TypeName(Me) & ":" & ProcName$
' End If
End Sub

'----------------------------------------------------------------------
'Name        : RaiseErrorEx
'Created     : 29/08/1999 16:11
'----------------------------------------------------------------------
'Author      : Richard James Moss
'Organisation: Ariad Software
'----------------------------------------------------------------------
'Description : Raises an extended error.
'
'              If the error occurs in design time, and not run time, a
'              simple error message is displayed instead of raising an error.
'----------------------------------------------------------------------
'Updates     : 16/09/99 - Added support for procedure names
'
'----------------------------------------------------------------------
'------------------------------Ariad Procedure Builder Add-In 1.00.0026
Private Sub RaiseErrorEx(ByVal ProcName$, ByVal ErrNum As Long, Optional ByVal ErrMsg$ = "")
' If Ambient.UserMode Then
  '"Runtime" - raise error
  If Len(ErrMsg$) Then
   Err.Raise ErrNum, App.EXEName & "." & TypeName(Me) & ":" & ProcName$, ErrMsg$
  Else
   Err.Raise ErrNum, App.EXEName & "." & TypeName(Me) & ":" & ProcName$
  End If
' Else
'  '"Design time" - display error
'  If Len(ErrMsg$) = 0 Then
'   On Error Resume Next
'    Error ErrNum
'    ErrMsg$ = Err.Description
'   On Error GoTo 0
'  End If
'  VBA.MsgBox INTERR$ & vbCr & vbCr & ErrMsg$ & " (" & ErrNum & ")" & vbCr & vbCr & ERRTEXT$, vbCritical, App.EXEName & "." & TypeName(Me)
' End If
End Sub

