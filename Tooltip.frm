VERSION 5.00
Begin VB.Form frmTooltip 
   BackColor       =   &H80000018&
   BorderStyle     =   0  'None
   ClientHeight    =   360
   ClientLeft      =   2955
   ClientTop       =   3195
   ClientWidth     =   1560
   ControlBox      =   0   'False
   Icon            =   "Tooltip.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   360
   ScaleWidth      =   1560
   ShowInTaskbar   =   0   'False
   Begin VB.Timer tmrTip 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   720
      Top             =   -45
   End
   Begin VB.Label lblTip 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000018&
      Caption         =   "TipLabel "
      ForeColor       =   &H80000017&
      Height          =   195
      Left            =   45
      TabIndex        =   0
      Top             =   30
      Width           =   660
   End
End
Attribute VB_Name = "frmTooltip"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

'-------------------------------'
' Ariad Development Library 2.0 '
'-------------------------------'
'    Ariad Interface Components '
'                   Version 1.0 '
'-------------------------------'
'                  ToolTip Form '
'-------------------------------'
'Copyright © 1998-9 by Ariad Software. All Rights Reserved

'Date Created:
'Last Updated:

Option Explicit
DefInt A-Z

Public CtlHWnd As Long

Private Sub Form_Load()
 AutoRedraw = -1
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 Unload Me
End Sub


Private Sub Form_Resize()
 Cls
 ScaleMode = 3
 Line (0, 0)-(ScaleWidth, 0), vb3DLight
 Line (0, 0)-(0, ScaleHeight), vb3DLight
 Line (ScaleWidth - 1, 0)-(ScaleWidth - 1, ScaleHeight), vb3DDKShadow
 Line (0, ScaleHeight - 1)-(ScaleWidth, ScaleHeight - 1), vb3DDKShadow
 ScaleMode = 1
End Sub


Private Sub Form_Unload(Cancel As Integer)
 tmrTip.Enabled = 0
End Sub

Private Sub lblTip_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 Unload Me
End Sub


Private Sub tmrTip_Timer()
 If GetActiveWindow() <> CtlHWnd Then Unload Me
End Sub


