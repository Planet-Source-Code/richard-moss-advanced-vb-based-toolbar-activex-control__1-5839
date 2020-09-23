VERSION 5.00
Begin VB.UserControl asxToolbar 
   Alignable       =   -1  'True
   CanGetFocus     =   0   'False
   ClientHeight    =   390
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4440
   ControlContainer=   -1  'True
   PropertyPages   =   "Toolbar2.ctx":0000
   ScaleHeight     =   26
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   296
   ToolboxBitmap   =   "Toolbar2.ctx":005E
   Begin VB.Timer tmrTip 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   315
      Top             =   0
   End
   Begin VB.Timer tmrCheck 
      Enabled         =   0   'False
      Interval        =   10
      Left            =   945
      Top             =   0
   End
End
Attribute VB_Name = "asxToolbar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_HelpID = 2889
Attribute VB_Description = "The <b>asxToolbar</b> is a powerful toolbar control "
Attribute VB_Ext_KEY = "PropPageWizardRun" ,"Yes"


'-------------------------------'
' Ariad Development Library 2.0 '
'-------------------------------'
'                       Toolbar '
'                   Version 2.0 '
'-------------------------------'
'Copyright © 1998-9 by Ariad Software. All Rights Reserved
'
'Date Created:
'Date Completed: 23/03/99
'Last Updated:   24/08/99
'
'25/03/99
'           - MousePointer, MouseIcon properties added
'16/04/99
'           - CaptionOptions, ButtonAlwaysShowCaption() properties added
'           - Depending on settings of the above properties, the toolbar can now
'             selectivly display captions, similar to IE5's behaviour.
'           - BUGFIX: Seperators on vertical toolbars drawn incorrectly
'           - BUGFIX: FontStrikethru property fixed
'           - BUGFIX: MouseUp event not raised when clicking button
'           - BUGFIX: Click event raised after ButtonClick event fired
'21/04/99
'           - New ForceClick event added
'           - New GroupID properties added, for creating pushed group buttons
'           - New CurrentGroupID property added
'           - New ButtonGap property added
'           - New SolidChecked property added - checked buttons in Flat toolbar mode
'             displayed as Standard
'           - New ShowSeparators property add - allows automatic seperators displayed
'             between buttons in Flat toolbar mode and ButtonGap is greater than 3
'           - BUGFIX: Vertical Separators 1 pixel too small
'22/04/99
'           - BUGFIX: Horizontal Separators 1 pixel too small
'           - Vertical Captions finally supported!!!
'23/04/99
'           - New HotTracking* properties added
'24/04/99
'           - BUGFIX: Group button update not executed before click
'           - New RightClick event
'02/05/99
'           - New CaptionAlignment property added
'03/05/99
'           - New AutoSize property added
'06/05/99
'           - New ToolTipFont property added
'           - BUGFIX: ToolTips crash on modal forms
'           - New Style property added
'           - New FixedSize property added
'12/05/99
'           - Error handling replaced with new private centralised system
'13/05/99
'           - BUGFIX: AddButton or AddButtonEx resets Redraw flag
'           - New DisabledText3D property
'           - BUGFIX: Non-standard font size cause infinite refresh loop
'14/05/99
'           - New BackStyle property added
'20/05/99
'           - BUGFIX: Invisible buttons drawn when properties set
'           - BUGFIX: RefreshButton method will draw invisible buttons
'           - Button size for vertical buttons with captions increased by 3 pixels
'22/05/99
'           - BUGFIX: Borders not drawn on checked buttons when button not highlighted
'           - When mouse over checked button, dither no longer drawn (Office 97 behaviour)
'           - BUGFIX: Error raised when AutoSize set to False with Align set
'27/05/99
'           - Custom tooltips now work correctly on modal forms!
'18/06/99
'           - Borders now drawn at all times when in Design Mode
'06/07/99
'           - Documentation added via Document! VB
'12/07/99
'           - Multiple PaintEffects classes replaced with single instance
'           - Button template modifications
'           - Tile picture routine replaced with fast API version
'20/08/99
'           - MoveButton function renamed to SwapButton
'           - BUGFIX: Property page would reset the first object on Apply changes
'24/08/99
'           - Event declaration parmeters modified !BREAKS COMPATIBILITY WITH USER APPLICATIONS!
'           - Two new border styles available (tbbsInsetButton, tbbsRaisedButton)

'##CD The <b>asxToolbar</b> is a powerful toolbar control

'Custom Errors (vbObjectError + ...)
'1          - AutoSize property cannot be set to True when Align property is set.

Option Explicit
DefInt A-Z

Public Event ButtonClick(ByVal ButtonIndex As Integer, ByVal ButtonKey$)
Attribute ButtonClick.VB_HelpID = 4297
Public Event ButtonRightClick(ByVal ButtonIndex As Integer, ByVal ButtonKey$, CancelBeep As Boolean)
Attribute ButtonRightClick.VB_HelpID = 4298
Public Event ButtonMouseOver(ByVal ButtonIndex As Integer, ByVal ButtonKey$)
Attribute ButtonMouseOver.VB_HelpID = 4299
Public Event BeforeButtonClick(ByVal ButtonIndex As Integer, ByVal ButtonKey$, Cancel As Boolean)
Attribute BeforeButtonClick.VB_HelpID = 4300
Public Event Click()
Attribute Click.VB_Description = "Occurs when the user presses and then releases a mouse button over a Toolbar control "
Attribute Click.VB_HelpID = 2894
'##ED Occurs when the user presses and then releases a mouse button over a Toolbar control
Public Event DblClick()
Attribute DblClick.VB_Description = "Occurs when the user presses and releases a mouse button and then presses and releases it again over a Toolbar control "
Attribute DblClick.VB_HelpID = 2895
'##ED Occurs when the user presses and releases a mouse button and then presses and releases it again over a Toolbar control
Public Event MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
Attribute MouseUp.VB_Description = "Occurs when the user presses (MouseDown) or releases (MouseUp) a mouse button "
Attribute MouseUp.VB_HelpID = 2896
'##ED Occurs when the user presses (MouseDown) or releases (MouseUp) a mouse button
Public Event MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
Attribute MouseDown.VB_Description = "Occurs when the user presses (MouseDown) or releases (MouseUp) a mouse button "
Attribute MouseDown.VB_HelpID = 2897
'##ED Occurs when the user presses (MouseDown) or releases (MouseUp) a mouse button
Public Event MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Attribute MouseMove.VB_Description = "Occurs when the user moves the mouse. "
Attribute MouseMove.VB_HelpID = 2898
'##ED Occurs when the user moves the mouse.
Public Event Resize(ByVal NewWidth As Single, ByVal NewHeight As Single)
Attribute Resize.VB_Description = "Occurs when Toolbar control window size is changed "
Attribute Resize.VB_HelpID = 2899
'##ED Occurs when Toolbar control window size is changed
Public Event RightClick()
Attribute RightClick.VB_HelpID = 2900

Dim BrdrVis(3) As Boolean, MseDwn As Boolean
Dim NoBorder As Boolean, DoClick As Boolean
Dim LastButton, BtnDown, CurrentButton

Dim m_ShowToolTips As Boolean
Dim m_Appearance As IFCAppearances
Dim m_BackColor As OLE_COLOR
Dim m_HighlightColor As OLE_COLOR, m_ShadowColor As OLE_COLOR
Dim m_HighlightDarkColor As OLE_COLOR, m_ShadowDarkColor As OLE_COLOR
Dim m_TextColor As OLE_COLOR, m_TextDisabledColor As OLE_COLOR
Dim m_HotTrackingColor As OLE_COLOR
Dim m_BorderStyle As IFCTBBorderStyles
Dim m_DoubleTopBorder As Boolean, m_DoubleBottomBorder As Boolean
Dim m_ButtonCount, m_ButtonGap
Dim m_Buttons() As New clsBSButton
Dim m_PlaySounds As Boolean, m_HotTracking As Boolean
Dim m_CaptionOptions As IFCCaptionOptions
Dim m_SolidChecked As Boolean, m_ShowSeparators As Boolean
Dim m_BoldOnChecked As Boolean, m_AutoSize As Boolean
Dim m_CaptionAlignment As IFCCaptionAlignments
Dim m_ToolTipFont As StdFont
Dim m_Style As IFCTBStyle
Dim m_FixedSize As Single
Dim m_DisabledText3D As Boolean
Dim m_BackStyle As IFCBackStyles

Public Redraw As Boolean
Attribute Redraw.VB_VarMemberFlags = "400"
Attribute Redraw.VB_VarProcData = ";Behavior"
Attribute Redraw.VB_VarHelpID = 2903
Attribute Redraw.VB_VarDescription = "When this property is set to False, calls to any Refresh methods, either internal or external, will be ignored. "
'##VD Redraw When this property is set to False, calls to any Refresh methods, either internal or external, will be ignored.

Dim MB As New ascMemoryBitmap
Dim LF As New clsLogFont

Dim MX As Single, MY As Single
Dim NoClk As Boolean

Dim RanOnce As Boolean
Public Property Get ToolTipFont() As StdFont
Attribute ToolTipFont.VB_Description = "Returns or sets the font used for displaying popup tooltips. "
Attribute ToolTipFont.VB_HelpID = 2904
 '##BD Returns or sets the font used for displaying popup tooltips.
 Set ToolTipFont = m_ToolTipFont
End Property

Public Property Set ToolTipFont(ByVal ToolTipFont As StdFont)
 If ToolTipFont Is Nothing Then
  RaiseErrorEx "ToolTipFont", 424
 Else
  Set m_ToolTipFont = ToolTipFont
  PropertyChanged "ToolTipFont"
 End If
End Property

Public Property Get MousePointer() As MousePointerConstants
Attribute MousePointer.VB_Description = "Returns or sets a value indicating the type of mouse pointer displayed when the mouse is over a Toolbar control. "
Attribute MousePointer.VB_HelpID = 2905
Attribute MousePointer.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets a value indicating the type of mouse pointer displayed when the mouse is over a Toolbar control.
 MousePointer = UserControl.MousePointer
End Property

Public Property Let MousePointer(ByVal MousePointer As MousePointerConstants)
 UserControl.MousePointer = MousePointer
 PropertyChanged "MousePointer"
End Property

Public Property Get MouseIcon() As StdPicture
Attribute MouseIcon.VB_Description = "Returns or sets a custom mouse icon. "
Attribute MouseIcon.VB_HelpID = 2906
Attribute MouseIcon.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets a custom mouse icon.
 Set MouseIcon = UserControl.MouseIcon
End Property

Public Property Set MouseIcon(ByVal MouseIcon As StdPicture)
 Set UserControl.MouseIcon = MouseIcon
 PropertyChanged "MouseIcon"
End Property

Public Property Get hWnd() As Long
Attribute hWnd.VB_Description = "Returns a handle to a Toolbar control "
Attribute hWnd.VB_HelpID = 2907
Attribute hWnd.VB_MemberFlags = "400"
 '##BD Returns a handle to a Toolbar control
 hWnd = UserControl.hWnd
End Property
Public Property Get hDC() As Long
Attribute hDC.VB_Description = "Returns a handle provided by the Microsoft Windows operating environment to the device context of a Toolbar control. "
Attribute hDC.VB_HelpID = 2908
Attribute hDC.VB_MemberFlags = "400"
 '##BD Returns a handle provided by the Microsoft Windows operating environment to the device context of a Toolbar control.
 hDC = UserControl.hDC
End Property

Private Sub ResetTip()
Attribute ResetTip.VB_HelpID = 2909
 On Error Resume Next
  tmrTip.Enabled = 0
  HideTip
  tmrCheck.Enabled = -1
  Extender.ToolTipText = ""
 On Error GoTo 0
End Sub

Public Property Get PlaySounds() As Boolean
Attribute PlaySounds.VB_Description = "Returns or sets if sounds are played when buttons in a Toolbar control are clicked "
Attribute PlaySounds.VB_HelpID = 2911
Attribute PlaySounds.VB_ProcData.VB_Invoke_Property = ";Behavior"
 '##BD Returns or sets if sounds are played when buttons in a Toolbar control are clicked
 PlaySounds = m_PlaySounds
End Property

Public Property Let PlaySounds(ByVal State As Boolean)
 m_PlaySounds = State
 PropertyChanged "PlaySounds"
End Property

Public Function KeyToIndex(ByVal Index As Variant) As Integer
Attribute KeyToIndex.VB_Description = "Returns the integer index value of a button identified by either it's Key property or index. "
Attribute KeyToIndex.VB_HelpID = 2912
 '##BD Returns the integer index value of a button identified by either it's Key property or index.
 Dim I
 If Val(Index) = 0 Then
  For I = 1 To m_ButtonCount
   If UCase$(m_Buttons(I).Key) = UCase$(Index) Then
    KeyToIndex = I
    Exit Function
   End If
  Next
 Else
  KeyToIndex = Val(Index)
 End If
 If KeyToIndex = 0 And Index <> 0 Then
  RaiseErrorEx "KeyToIndex", 35601, "Element not found. Key is missing or illegal."
 End If
End Function


Private Sub tmrCheck_Timer()
Attribute tmrCheck_Timer.VB_HelpID = 2913
 If IsInControl(hWnd) = 0 Then
  MX = 0
  MY = 0
  ResetButton LastButton
  LastButton = 0
  tmrCheck.Enabled = 0
  tmrTip.Enabled = 0
 End If
End Sub

Private Sub tmrTip_Timer()
Attribute tmrTip_Timer.VB_HelpID = 2914
 On Error Resume Next
  ResetTip
  If IsInControl(hWnd) Then
   If ShowTip(tmrTip.Tag, GetActiveWindow(), m_ToolTipFont) = 0 Then
    Extender.ToolTipText = tmrTip.Tag
   End If
  End If
 On Error GoTo 0
End Sub

Private Sub UserControl_Click()
Attribute UserControl_Click.VB_HelpID = 2915
 If NoClk = 0 Then RaiseEvent Click
 NoClk = 0
End Sub

Private Sub UserControl_DblClick()
Attribute UserControl_DblClick.VB_HelpID = 2916
 RaiseEvent DblClick
End Sub





Public Property Get BorderStyle() As IFCTBBorderStyles
Attribute BorderStyle.VB_Description = "Returns or sets the border style of a Toolbar control "
Attribute BorderStyle.VB_HelpID = 2917
Attribute BorderStyle.VB_ProcData.VB_Invoke_Property = ";Appearance"
Attribute BorderStyle.VB_MemberFlags = "200"
 '##BD Returns or sets the border style of a Toolbar control
 BorderStyle = m_BorderStyle
End Property

Public Property Let BorderStyle(ByVal NewStyle As IFCTBBorderStyles)
 Dim I
 If BorderStyle < tbbsNone Or BorderStyle > tbbsRaisedButton Then
  RaiseErrorEx "BorderStyle", 380
 Else
  m_BorderStyle = NewStyle
  If m_BorderStyle = 3 Then
   DoubleTopBorder = 0
   DoubleBottomBorder = 0
   BorderBottom = -1
   BorderTop = -1
   BorderLeft = -1
   BorderRight = -1
  End If
  Refresh
 End If
 PropertyChanged "BorderStyle"
End Property

Private Sub UserControl_Initialize()
 CtlCount = CtlCount + 1
 Redraw = 0
 AutoRedraw = -1
 MB.CreateByResource "DITHER"
 LF.Rotation = 90
End Sub

Private Sub UserControl_InitProperties()
Attribute UserControl_InitProperties.VB_HelpID = 2919
 Dim I
 For I = 0 To 3
  BrdrVis(I) = -1
 Next
 m_BackStyle = ifbsOpaque
 m_DisabledText3D = -1
 m_CaptionOptions = iftoShowLabels
 m_BorderStyle = tbbsRaised
 m_BackColor = vbButtonFace
 m_HighlightColor = vb3DHighlight
 m_ShadowColor = vb3DShadow
 m_HighlightDarkColor = vb3DLight
 m_ShadowDarkColor = vb3DDKShadow
 m_TextColor = vbWindowText
 m_TextDisabledColor = vbGrayText
 m_HotTrackingColor = vbHighlight
 m_PlaySounds = -1
 m_ShowToolTips = -1
 m_CaptionAlignment = ifcaCaptionOnRight
 Set UserControl.Font = Ambient.Font
 Set m_ToolTipFont = Ambient.Font
 Redraw = -1
 Refresh
End Sub

Private Sub UserControl_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
Attribute UserControl_MouseDown.VB_HelpID = 2920
 MseDwn = -1
 BtnDown = LastButton
 LastButton = 0
 ResetTip
 UserControl_MouseMove Button, Shift, X, Y
 RaiseEvent MouseDown(Button, Shift, X, Y)
End Sub

Private Sub UserControl_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Attribute UserControl_MouseMove.VB_HelpID = 2921
 Dim I
 MX = X
 MY = Y
 I = IsWithinButton(X, Y)
 CurrentButton = I
 If IsInControl(hWnd) = 0 Then CurrentButton = 0
 If I Then
  'Button is Highlighted
  If I <> LastButton Then
   If m_Buttons(I).Style = tbbsButton Then
    ShowCtlTip m_Buttons(I).ToolTipText
   Else
    tmrTip.Enabled = 0
    HideTip
    Extender.ToolTipText = ""
   End If
   ResetButton LastButton
   If m_Buttons(I).Enabled Then
    If m_Buttons(I).Style = tbbsButton Then
     RefreshButton I, MseDwn
     tmrCheck.Enabled = -1
     RaiseEvent ButtonMouseOver(I, m_Buttons(I).Key)
    End If
   Else
    RaiseEvent ButtonMouseOver(I, m_Buttons(I).Key)
   End If
   LastButton = I
  End If
 Else
  'Clear Last Button
  If LastButton Then
   ResetButton LastButton
   LastButton = 0
   tmrCheck.Enabled = 0
  End If
  tmrTip.Enabled = 0
  HideTip
  Extender.ToolTipText = ""
  RaiseEvent MouseMove(Button, Shift, X, Y)
 End If
End Sub

Private Sub ShowCtlTip(Tip$)
Attribute ShowCtlTip.VB_HelpID = 2922
 On Error Resume Next
  If Tip$ = "" Or m_ShowToolTips = 0 Then
   HideTip
   tmrTip.Enabled = 0
   Extender.ToolTipText = ""
  Else
   tmrTip.Enabled = Ambient.UserMode
   tmrTip.Tag = Tip$
  End If
 On Error GoTo 0
End Sub

Private Sub UserControl_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
Attribute UserControl_MouseUp.VB_HelpID = 2923
 Dim I
 Dim CancelBeep As Boolean, Cancel As Boolean
 MseDwn = 0
 LastButton = BtnDown
 ResetTip
 RaiseEvent MouseUp(Button, Shift, X, Y)
 If Button Then
  I = IsWithinButton(X, Y)
  If I Then
   RefreshButton I
   If m_Buttons(I).Style = tbbsButton And m_Buttons(I).Enabled Then
    If Button = 1 Then
     RaiseEvent BeforeButtonClick(I, m_Buttons(I).Key, Cancel)
     If Cancel = 0 Then
      PlaySnd "BUTTON_CLICK", m_PlaySounds
      NoClk = -1
      UpdateGroups I
      RaiseEvent ButtonClick(I, m_Buttons(I).Key)
     End If
    Else
     RaiseEvent ButtonRightClick(I, m_Buttons(I).Key, CancelBeep)
     If CancelBeep = 0 Then Beep
    End If
   Else
    ResetButton I
   End If
  Else
   ResetButton I
   If Button = 2 Then RaiseEvent RightClick
  End If
 Else
  ResetButton I
 End If
 ResetTip
End Sub


Private Sub Outline(ByVal X, ByVal Y, ByVal W, ByVal H, C1 As OLE_COLOR, C2 As OLE_COLOR)
Attribute Outline.VB_HelpID = 2924
 Line (X, Y)-(X + W + 1, Y), C1
 Line (X + W, Y)-(X + W, Y + H + 1), C2
 Line (X, Y + H)-(X + W + 1, Y + H), C2
 Line (X, Y)-(X, Y + H), C1
End Sub

Public Property Get ScaleWidth() As Single
Attribute ScaleWidth.VB_Description = "Returns the width, in pixels, of the control. "
Attribute ScaleWidth.VB_HelpID = 2925
Attribute ScaleWidth.VB_ProcData.VB_Invoke_Property = ";Data"
 '##BD Returns the width, in pixels, of the control.
 ScaleWidth = UserControl.ScaleWidth
End Property
Public Property Get ScaleHeight() As Single
Attribute ScaleHeight.VB_Description = "Returns the height, in pixels, of the control. "
Attribute ScaleHeight.VB_HelpID = 2926
Attribute ScaleHeight.VB_ProcData.VB_Invoke_Property = ";Data"
 '##BD Returns the height, in pixels, of the control.
 ScaleHeight = UserControl.ScaleHeight
End Property
Public Property Get BorderTop() As Boolean
Attribute BorderTop.VB_Description = "Returns or sets if the top border is drawn "
Attribute BorderTop.VB_HelpID = 2927
Attribute BorderTop.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets if the top border is drawn
 BorderTop = BrdrVis(1)
End Property
Public Property Let BorderTop(ByVal Vis As Boolean)
 BrdrVis(1) = Vis
 If m_BorderStyle = 3 Then BrdrVis(1) = -1
 Refresh
 PropertyChanged "BorderTop"
End Property
Public Property Get BorderLeft() As Boolean
Attribute BorderLeft.VB_Description = "Returns or sets if the left border is drawn "
Attribute BorderLeft.VB_HelpID = 2928
Attribute BorderLeft.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets if the left border is drawn
 BorderLeft = BrdrVis(0)
End Property
Public Property Let BorderLeft(ByVal Vis As Boolean)
 BrdrVis(0) = Vis
 If m_BorderStyle = 3 Then BrdrVis(0) = -1
 Refresh
 PropertyChanged "BorderLeft"
End Property
Public Property Get BorderRight() As Boolean
Attribute BorderRight.VB_Description = "Returns or sets if the right border is drawn "
Attribute BorderRight.VB_HelpID = 2929
Attribute BorderRight.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets if the right border is drawn
 BorderRight = BrdrVis(2)
End Property
Public Property Let BorderRight(ByVal Vis As Boolean)
 BrdrVis(2) = Vis
 If m_BorderStyle = 3 Then BrdrVis(2) = -1
 Refresh
 PropertyChanged "BorderRight"
End Property
Public Property Get BorderBottom() As Boolean
Attribute BorderBottom.VB_Description = "Returns or sets if the bottom border is drawn "
Attribute BorderBottom.VB_HelpID = 2930
Attribute BorderBottom.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets if the bottom border is drawn
 BorderBottom = BrdrVis(3)
End Property
Public Property Let BorderBottom(ByVal Vis As Boolean)
 BrdrVis(3) = Vis
 If m_BorderStyle = 3 Then BrdrVis(3) = -1
 Refresh
 PropertyChanged "BorderBottom"
End Property



Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
Attribute UserControl_ReadProperties.VB_HelpID = 2931
 Dim I
 Redraw = 0
  With PropBag
   m_DisabledText3D = .ReadProperty("DisabledText3D", -1)
   m_FixedSize = .ReadProperty("FixedSize", 0)
   m_Style = .ReadProperty("Style", tbtsVariable)
   Set m_ToolTipFont = .ReadProperty("ToolTipFont", Ambient.Font)
   m_TextColor = .ReadProperty("TextColor", vbWindowText)
   m_TextDisabledColor = .ReadProperty("TextDisabledColor", vbGrayText)
   m_SolidChecked = .ReadProperty("SolidChecked", 0)
   m_ButtonGap = .ReadProperty("ButtonGap", 0)
   m_BorderStyle = .ReadProperty("BorderStyle", tbbsRaised)
   BrdrVis(0) = .ReadProperty("BorderLeft", -1)
   BrdrVis(1) = .ReadProperty("BorderTop", -1)
   BrdrVis(2) = .ReadProperty("BorderRight", -1)
   BrdrVis(3) = .ReadProperty("BorderBottom", -1)
   m_DoubleTopBorder = .ReadProperty("DoubleTopBorder", 0)
   m_DoubleBottomBorder = .ReadProperty("DoubleBottomBorder", 0)
   m_BackColor = .ReadProperty("BackColor", vbButtonFace)
   m_HighlightColor = .ReadProperty("HighlightColor", vb3DHighlight)
   m_ShadowColor = .ReadProperty("ShadowColor", vb3DShadow)
   m_HighlightDarkColor = .ReadProperty("HighlightDarkColor", vb3DLight)
   m_ShadowDarkColor = .ReadProperty("ShadowDarkColor", vb3DDKShadow)
   m_PlaySounds = .ReadProperty("PlaySounds", -1)
   Set UserControl.Font = .ReadProperty("Font", Ambient.Font)
   m_Appearance = .ReadProperty("Appearance", ifcaStandard)
   m_ButtonCount = .ReadProperty("ButtonCount", 0)
   m_ShowToolTips = .ReadProperty("ShowToolTips", -1)
   UserControl.MousePointer = .ReadProperty("MousePointer", vbDefault)
   Set UserControl.MouseIcon = .ReadProperty("MouseIcon", Nothing)
   ReDim m_Buttons(m_ButtonCount) As New clsBSButton
   Enabled = .ReadProperty("Enabled", -1)
   m_CaptionOptions = .ReadProperty("CaptionOptions", iftoShowLabels)
   m_ShowSeparators = .ReadProperty("ShowSeparators", 0)
   m_HotTracking = .ReadProperty("HotTracking", 0)
   m_HotTrackingColor = .ReadProperty("HotTrackingColor", vbHighlight)
   m_BoldOnChecked = .ReadProperty("BoldOnChecked", 0)
   m_CaptionAlignment = .ReadProperty("CaptionAlignment", ifcaCaptionOnRight)
   m_AutoSize = .ReadProperty("AutoSize", 0)
   If Extender.Align Then m_AutoSize = 0
   m_BackStyle = .ReadProperty("BackStyle", ifbsOpaque)
   For I = 1 To m_ButtonCount
    'Load Buttons
    With m_Buttons(I)
     .Enabled = PropBag.ReadProperty("ButtonEnabled" & I, -1)
     .Checked = PropBag.ReadProperty("ButtonChecked" & I, 0)
     .Caption = PropBag.ReadProperty("ButtonCaption" & I, "")
     .Description = PropBag.ReadProperty("ButtonDescription" & I, "")
     .Key = PropBag.ReadProperty("ButtonKey" & I, "")
     .UseMaskColor = PropBag.ReadProperty("ButtonUseMaskColor" & I, -1)
     .MaskColor = PropBag.ReadProperty("ButtonMaskColor" & I, QBColor(13))
     Set .APicture(ifwpPicNormal) = PropBag.ReadProperty("ButtonPicture" & I, Nothing)
     Set .APicture(ifwpPicOver) = PropBag.ReadProperty("ButtonPictureOver" & I, Nothing)
     Set .APicture(ifwpPicDown) = PropBag.ReadProperty("ButtonPictureDown" & I, Nothing)
     .PlaceholderSize = PropBag.ReadProperty("ButtonWidth" & I, 0)
     .Style = PropBag.ReadProperty("ButtonStyle" & I, tbbsButton)
     .ToolTipText = PropBag.ReadProperty("ButtonToolTipText" & I, "")
     .Visible = PropBag.ReadProperty("ButtonVisible" & I, -1)
     .AlwaysShowCaption = PropBag.ReadProperty("ButtonAlwaysShowCaption" & I, 0)
     .GroupID = PropBag.ReadProperty("ButtonGroupID" & I, 0)
    End With
   Next
  End With
 Redraw = -1
 UserControl.BackStyle = m_BackStyle
 Refresh
End Sub
Private Sub UserControl_Resize()
Attribute UserControl_Resize.VB_HelpID = 2932
 Refresh
 RaiseEvent Resize(ScaleWidth, ScaleHeight)
End Sub


Private Sub UserControl_Terminate()
 Dim I
 Set LF.LogFont = Nothing
 CtlCount = CtlCount - 1
 If CtlCount = 0 Then Set PE = Nothing
 MB.ClearUp
 Set MB = Nothing
 Set LF = Nothing
 Redraw = 0
 On Error Resume Next
  tmrCheck.Enabled = 0
  For I = 1 To m_ButtonCount
   Set m_Buttons(I) = Nothing
  Next
  Erase m_Buttons()
 On Error GoTo 0
 HideTip
End Sub

Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
Attribute UserControl_WriteProperties.VB_HelpID = 2934
 Dim I
 With PropBag
  .WriteProperty "DisabledText3D", m_DisabledText3D, -1
  .WriteProperty "FixedSize", m_FixedSize, 0
  .WriteProperty "Style", m_Style, tbtsVariable
  .WriteProperty "ToolTipFont", m_ToolTipFont, Ambient.Font
  .WriteProperty "TextColor", m_TextColor, vbWindowText
  .WriteProperty "TextDisabledColor", m_TextDisabledColor, vbGrayText
  .WriteProperty "ButtonGap", m_ButtonGap, 0
  .WriteProperty "BorderStyle", m_BorderStyle, tbbsRaised
  .WriteProperty "BorderLeft", BrdrVis(0), -1
  .WriteProperty "BorderTop", BrdrVis(1), -1
  .WriteProperty "BorderRight", BrdrVis(2), -1
  .WriteProperty "BorderBottom", BrdrVis(3), -1
  .WriteProperty "DoubleTopBorder", m_DoubleTopBorder, 0
  .WriteProperty "DoubleBottomBorder", m_DoubleBottomBorder, 0
  .WriteProperty "BackColor", m_BackColor, vbButtonFace
  .WriteProperty "HighlightColor", m_HighlightColor, vb3DHighlight
  .WriteProperty "ShadowColor", m_ShadowColor, vb3DShadow
  .WriteProperty "HighlightDarkColor", m_HighlightDarkColor, vb3DLight
  .WriteProperty "ShadowDarkColor", m_ShadowDarkColor, vb3DDKShadow
  .WriteProperty "Font", Font, Ambient.Font
  .WriteProperty "Appearance", m_Appearance, ifcaStandard
  .WriteProperty "Enabled", Enabled, -1
  .WriteProperty "ButtonCount", m_ButtonCount
  .WriteProperty "PlaySounds", m_PlaySounds, -1
  .WriteProperty "ShowToolTips", m_ShowToolTips, -1
  .WriteProperty "MousePointer", MousePointer, vbDefault
  .WriteProperty "MouseIcon", MouseIcon, Nothing
  .WriteProperty "CaptionOptions", m_CaptionOptions, iftoShowLabels
  .WriteProperty "SolidChecked", m_SolidChecked, 0
  .WriteProperty "ShowSeparators", m_ShowSeparators, 0
  .WriteProperty "HotTracking", m_HotTracking, 0
  .WriteProperty "HotTrackingColor", m_HotTrackingColor, vbHighlight
  .WriteProperty "BoldOnChecked", m_BoldOnChecked, 0
  .WriteProperty "CaptionAlignment", m_CaptionAlignment, ifcaCaptionOnRight
  .WriteProperty "AutoSize", m_AutoSize, 0
  .WriteProperty "BackStyle", m_BackStyle, ifbsOpaque
  For I = 1 To m_ButtonCount
   With m_Buttons(I)
    PropBag.WriteProperty "ButtonEnabled" & I, .Enabled, -1
    PropBag.WriteProperty "ButtonChecked" & I, .Checked, 0
    PropBag.WriteProperty "ButtonCaption" & I, .Caption, ""
    PropBag.WriteProperty "ButtonDescription" & I, .Description, ""
    PropBag.WriteProperty "ButtonKey" & I, .Key, ""
    PropBag.WriteProperty "ButtonUseMaskColor" & I, .UseMaskColor, -1
    PropBag.WriteProperty "ButtonMaskColor" & I, .MaskColor, QBColor(13)
    PropBag.WriteProperty "ButtonPicture" & I, .APicture(ifwpPicNormal), Nothing
    PropBag.WriteProperty "ButtonPictureOver" & I, .APicture(ifwpPicOver), Nothing
    PropBag.WriteProperty "ButtonPictureDown" & I, .APicture(ifwpPicDown), Nothing
    PropBag.WriteProperty "ButtonWidth" & I, .PlaceholderSize, 0
    PropBag.WriteProperty "ButtonStyle" & I, .Style, tbbsButton
    PropBag.WriteProperty "ButtonToolTipText" & I, .ToolTipText, ""
    PropBag.WriteProperty "ButtonVisible" & I, .Visible, -1
    PropBag.WriteProperty "ButtonAlwaysShowCaption" & I, .AlwaysShowCaption, 0
    PropBag.WriteProperty "ButtonGroupID" & I, .GroupID, 0
   End With
  Next
 End With
End Sub
Public Sub Refresh()
Attribute Refresh.VB_Description = "Forces a complete repaint of a Toolbar control "
Attribute Refresh.VB_HelpID = 2935
 '##BD Forces a complete repaint of a Toolbar control
 Dim I, G
 Dim O As IFCOrientations
 Dim X As Single, Y As Single, W As Single, H As Single, Z As Single
 Dim B As Boolean
 Dim Size As Single, CurrentSize As Single
 On Error GoTo ProcErr
  InitPaintEffects
  If Redraw Then
   UserControl.BackColor = m_BackColor
   Line (-1, -1)-(ScaleWidth + 1, ScaleHeight + 1), m_BackColor, BF
   HideTip
   Extender.ToolTipText = ""
   tmrTip.Enabled = 0
   DrawBorders
   X = BorderOffset(0)
   Y = BorderOffset(1)
   If Width >= Height Then
    'Horizontal
    O = ifcoHorizontal
    Z = ScaleHeight - (BorderOffset(1) + BorderOffset(3))
    CurrentSize = ScaleWidth
   Else
    'Vertical
    O = ifcoVertical
    Z = ScaleWidth - (BorderOffset(0) + BorderOffset(2))
    CurrentSize = ScaleHeight
   End If
   For I = 1 To m_ButtonCount
    W = 0
    With m_Buttons(I)
     If .Visible Then
      B = UserControl.FontBold
       If m_BoldOnChecked Then UserControl.FontBold = -1
       'Define Size
       If O = ifcoHorizontal Then
        'horizontal
        If m_Style = tbtsFixed Then
         W = m_FixedSize
        Else
         W = IIf(.Style = tbbsPlaceholder And .PlaceholderSize <> 0, .PlaceholderSize, Z)
         If .Style = tbbsSeparator Then W = 6
         If .Caption <> "" And (m_CaptionOptions = iftoShowLabels Or m_CaptionOptions = iftoSelectedLabels And .AlwaysShowCaption) Then
          W = W + TextWidth(.Caption) + 5
         End If
        End If
        H = Z
       Else
        'vertical
        If m_Style = tbtsFixed Then
         H = m_FixedSize
        Else
         H = IIf(.Style = tbbsPlaceholder And .PlaceholderSize <> 0, .PlaceholderSize, Z)
         If .Style = tbbsSeparator Then H = 6
         If .Caption <> "" And (m_CaptionOptions = iftoShowLabels Or m_CaptionOptions = iftoSelectedLabels And .AlwaysShowCaption) Then
          H = H + TextWidth(.Caption) + 3
         End If
        End If
        W = Z
       End If
      UserControl.FontBold = B
      'Update Position
      .ClientLeft = X
      .ClientTop = Y
      .ClientWidth = W
      .ClientHeight = H
      'Draw
      If .Style = tbbsButton And .Checked = 0 Then NoBorder = -1 Else NoBorder = 0
      RefreshButton I
      If O = ifcoHorizontal Then
       If m_ButtonGap >= 4 And m_ShowSeparators And m_Appearance = ifcaFlat Then
        G = Int(m_ButtonGap / 2) - 1
        Line (X + W + G, Y)-(X + W + G, Y + H), m_ShadowColor
        Line (X + W + G + 1, Y)-(X + W + G + 1, Y + H), m_HighlightColor
       End If
       X = X + W + m_ButtonGap
       Size = X + BorderOffset(0)
      Else
       If m_ButtonGap >= 4 And m_ShowSeparators And m_Appearance = ifcaFlat Then
        G = Int(m_ButtonGap / 2) - 1
        Line (X, Y + H + G)-(X + W, Y + H + G), m_ShadowColor
        Line (X, Y + H + G + 1)-(X + W, Y + H + G + 1), m_HighlightColor
       End If
       Y = Y + H + m_ButtonGap + BorderOffset(1)
       Size = Y
      End If
     End If
    End With
   Next
   NoBorder = 0
   If m_AutoSize And CurrentSize <> Size And Extender.Align = 0 And RanOnce = 0 Then
    RanOnce = -1
    If O = ifcoHorizontal Then
     Width = Size * Screen.TwipsPerPixelX
    Else
     Height = Size * Screen.TwipsPerPixelY
    End If
    Refresh
   End If
   'Make Opaque
   If m_BackStyle = ifbsTransparent Then
    MaskColor = BackColor
    MaskPicture = Image
   End If
  End If
 On Error GoTo 0
Exit Sub

ProcErr:
 RaiseError "Refresh"
Resume Next
End Sub

Public Property Get BackStyle() As IFCBackStyles
Attribute BackStyle.VB_Description = "Returns or sets a value indicating whether the background of a Toolbar control is transparent or opaque. "
Attribute BackStyle.VB_HelpID = 2936
 '##BD Returns or sets a value indicating whether the background of a Toolbar control is transparent or opaque.
 BackStyle = m_BackStyle
End Property

Public Property Let BackStyle(ByVal BackStyle As IFCBackStyles)
 If BackStyle <> ifbsOpaque And BackStyle <> ifbsTransparent Then
  RaiseErrorEx "BackStyle", 380
 Else
  m_BackStyle = BackStyle
  UserControl.BackStyle = BackStyle
  PropertyChanged "BackStyle"
  Refresh
 End If
End Property

Public Property Get DoubleTopBorder() As Boolean
Attribute DoubleTopBorder.VB_Description = "Returns or sets if the top border is doubled, similar to a Frame border "
Attribute DoubleTopBorder.VB_HelpID = 2937
Attribute DoubleTopBorder.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets if the top border is doubled, similar to a Frame border
 DoubleTopBorder = m_DoubleTopBorder
End Property

Public Property Let DoubleTopBorder(ByVal State As Boolean)
 m_DoubleTopBorder = State
 If m_BorderStyle = 3 Then m_DoubleTopBorder = 0
 Refresh
 PropertyChanged "DoubleTopBorder"
 If State Then BorderTop = -1
End Property

Public Property Get BackColor() As OLE_COLOR
Attribute BackColor.VB_Description = "Returns or sets the background color of a Toolbar control. "
Attribute BackColor.VB_HelpID = 2938
Attribute BackColor.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets the background color of a Toolbar control.
 BackColor = m_BackColor
End Property

Public Property Let BackColor(ByVal NewCol As OLE_COLOR)
 m_BackColor = NewCol
 Refresh
 PropertyChanged "BackColor"
End Property
Public Property Get HighlightColor() As OLE_COLOR
Attribute HighlightColor.VB_Description = "Returns or sets the highlight color of a Toolbar control. "
Attribute HighlightColor.VB_HelpID = 2939
Attribute HighlightColor.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets the highlight color of a Toolbar control.
 HighlightColor = m_HighlightColor
End Property

Public Property Let HighlightColor(ByVal NewCol As OLE_COLOR)
 m_HighlightColor = NewCol
 Refresh
 PropertyChanged "HighlightColor"
End Property
Public Property Get ShadowColor() As OLE_COLOR
Attribute ShadowColor.VB_Description = "Returns or sets the shadow color of a Toolbar control. "
Attribute ShadowColor.VB_HelpID = 2940
 '##BD Returns or sets the shadow color of a Toolbar control.
 ShadowColor = m_ShadowColor
End Property

Public Property Let ShadowColor(ByVal NewCol As OLE_COLOR)
 m_ShadowColor = NewCol
 Refresh
 PropertyChanged "ShadowColor"
End Property


Public Property Get Font() As StdFont
Attribute Font.VB_Description = "Returns or sets the font used to display text in a Toolbar control "
Attribute Font.VB_HelpID = 2941
Attribute Font.VB_ProcData.VB_Invoke_Property = ";Font"
 '##BD Returns or sets the font used to display text in a Toolbar control
 Set Font = UserControl.Font
End Property

Public Property Set Font(ByVal Font As StdFont)
 Set UserControl.Font = Font
 Refresh
 PropertyChanged "Font"
End Property
Public Property Get DoubleBottomBorder() As Boolean
Attribute DoubleBottomBorder.VB_Description = "Returns or sets if the bottom border is doubled, similar to a Frame border "
Attribute DoubleBottomBorder.VB_HelpID = 2942
Attribute DoubleBottomBorder.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets if the bottom border is doubled, similar to a Frame border
 DoubleBottomBorder = m_DoubleBottomBorder
End Property

Public Property Let DoubleBottomBorder(ByVal State As Boolean)
 m_DoubleBottomBorder = State
 If m_BorderStyle = 3 Then m_DoubleBottomBorder = 0
 Refresh
 PropertyChanged "DoubleBottomBorder"
 If State Then BorderBottom = -1
End Property
Private Function BorderOffset(Side As Integer) As Integer
Attribute BorderOffset.VB_HelpID = 2943
 Dim FB, DT, DB, O
 FB = IIf(m_BorderStyle = tbbsFrame Or m_BorderStyle = tbbsInsetButton Or m_BorderStyle = tbbsRaisedButton, 1, 0)
 DT = IIf(m_DoubleTopBorder, 1, 0)
 DB = IIf(m_DoubleBottomBorder, 1, 0)
 Select Case Side
  Case 0        'Left
   O = Abs(BrdrVis(0)) + FB
  Case 1        'Right
   O = Abs(BrdrVis(2)) + FB + DT
  Case 2        'Top
   O = Abs(BrdrVis(1)) + FB
  Case 3        'Bottom
   O = Abs(BrdrVis(3)) + FB + DB
 End Select
 BorderOffset = O + 1
End Function

Public Property Get ButtonCount() As Integer
Attribute ButtonCount.VB_Description = "Returns the total number of buttons in the control. "
Attribute ButtonCount.VB_HelpID = 2944
Attribute ButtonCount.VB_ProcData.VB_Invoke_Property = ";Data"
Attribute ButtonCount.VB_MemberFlags = "400"
 '##BD Returns the total number of buttons in the control.
 ButtonCount = m_ButtonCount
End Property


Public Function AddButton() As Integer
Attribute AddButton.VB_Description = "Adds a new blank button to the control. "
Attribute AddButton.VB_HelpID = 2945
 '##BD Adds a new blank button to the control.
 AddButton = AddButtonEx()
End Function

Private Sub DrawBorders()
Attribute DrawBorders.VB_HelpID = 2946
 Dim W As Long, H As Long
 Dim TC(4) As OLE_COLOR
 'Draw Borders
 W = ScaleWidth
 H = ScaleHeight
 If m_BorderStyle <> 0 Then
  If m_BorderStyle = tbbsFrame Then
   'Frame
   TC(1) = m_HighlightColor
   TC(2) = m_ShadowColor
   Line (1, 1)-(ScaleWidth - 1, ScaleHeight - 1), TC(1), B
   Line (0, 0)-(ScaleWidth - 2, ScaleHeight - 2), TC(2), B
  ElseIf m_BorderStyle = tbbsInsetButton Or m_BorderStyle = tbbsRaisedButton Then
   'Button
   Select Case m_BorderStyle
    Case tbbsInsetButton
     TC(1) = m_ShadowColor: TC(2) = m_HighlightColor
     TC(3) = m_ShadowDarkColor: TC(4) = m_HighlightDarkColor
    Case tbbsRaisedButton
     TC(1) = m_HighlightColor: TC(2) = m_ShadowDarkColor
     TC(3) = m_HighlightDarkColor: TC(4) = m_ShadowColor
   End Select
   Box3DDC hDC, 0, 0, ScaleWidth, ScaleHeight, TC(1), TC(2)
   Box3DDC hDC, 1, 1, ScaleWidth - 2, ScaleHeight - 2, TC(3), TC(4)
  Else
   'Panel
   Select Case m_BorderStyle
    Case tbbsInset: TC(1) = m_ShadowColor: TC(2) = m_HighlightColor
    Case tbbsRaised: TC(1) = m_HighlightColor: TC(2) = m_ShadowColor
   End Select
   If BrdrVis(1) Then Line (0, 0)-(W - 1, 0), TC(1)
   If BrdrVis(2) Then Line (W - 1, 0)-(W - 1, H - 1), TC(2)
   If BrdrVis(3) Then Line (0, H - 1)-(W, H - 1), TC(2)
   If BrdrVis(0) Then Line (0, 0)-(0, H - 1), TC(1)
   If m_DoubleTopBorder Then
    Line (0, 0)-(W, 0), m_ShadowColor
    Line (0, 1)-(W - 1, 1), m_HighlightColor
   End If
   If m_DoubleBottomBorder Then
    Line (0, H - 1)-(W, H - 1), m_HighlightColor
    Line (1, H - 2)-(W - 1, H - 2), m_ShadowColor
   End If
  End If
 End If
End Sub

Public Function IsWithinButton(ByVal X As Single, ByVal Y As Single) As Integer
Attribute IsWithinButton.VB_Description = "Returns a value indicating which button is within a specified set of co-ordinates, or zero if one does not. "
Attribute IsWithinButton.VB_HelpID = 2947
 '##BD Returns a value indicating which button is within a specified set of co-ordinates, or zero if one does not.
 Dim I
 For I = 1 To m_ButtonCount
  With m_Buttons(I)
   If .Visible Then
    If X >= .ClientLeft And _
     X <= ((.ClientLeft + .ClientWidth) - 1) And _
     Y >= .ClientTop And _
     Y <= ((.ClientTop + .ClientHeight) - 1) _
     Then IsWithinButton = I: Exit For
   End If
  End With
 Next
End Function

Private Sub ResetButton(ByVal Index As Variant)
Attribute ResetButton.VB_HelpID = 2948
 Dim I
 On Error Resume Next
  I = KeyToIndex(Index)
  If I >= 1 And I <= m_ButtonCount Then
   With m_Buttons(I)
    RefreshButton I, , -1
   End With
   HideTip
   Extender.ToolTipText = ""
  End If
 On Error GoTo 0
End Sub

Public Sub RefreshButton(ByVal Index As Variant, Optional ButtonLowered As Boolean = 0, Optional ForceNoBorder As Boolean = 0)
Attribute RefreshButton.VB_Description = "Forces a complete repaint of a button in a Toolbar control "
Attribute RefreshButton.VB_HelpID = 2949
 '##BD Forces a complete repaint of a button in a Toolbar control
 Dim PX As Single, PY As Single, X As Single, Y As Single
 Dim PW As Single, PH As Single, W As Single, H As Single
 Dim Z, I, OS
 Dim P As StdPicture
 Dim hFont As Long
 Dim B As Boolean
 Dim O As IFCOrientations
 Const F = DT_SINGLELINE Or DT_CENTER Or DT_VCENTER
 I = KeyToIndex(Index)
 On Error GoTo ProcErr
  If Redraw Then
   If m_Buttons(I).Visible Then
    If Width >= Height Then O = ifcoHorizontal Else O = ifcoVertical
    With m_Buttons(I)
     X = .ClientLeft
     Y = .ClientTop
     W = .ClientWidth
     H = .ClientHeight
     If .Style = tbbsSeparator Then ForceNoBorder = 0
     If .TemporaryPicture Is Nothing Then
      Line (X, Y)-(X + W - 1, Y + H - 1), m_BackColor, BF
     Else
      PaintPicture .TemporaryPicture, X, Y
     End If
     If .Checked Then
      If CurrentButton <> I Or IsInControl(hWnd) = 0 Then
       PE.PaintCheckedPattern hDC, MB.hDC, X, Y, W, H, m_HighlightColor
      End If
      Z = 1
     End If
     If MseDwn And ButtonLowered Then Z = Z + 1
     If ButtonLowered Or .Checked Then
      'Lowered
      If m_Appearance = ifcaFlat Then
       If ((NoBorder = 0 Or LastButton = I) And ForceNoBorder = 0) Or m_SolidChecked Or .Checked Or Ambient.UserMode = 0 Then
        If .Style = tbbsButton Then
         If m_SolidChecked Then
          Outline X, Y, W - 1, H - 1, m_ShadowDarkColor, m_HighlightColor
          Outline X + 1, Y + 1, W - 3, H - 3, m_ShadowColor, m_HighlightDarkColor
         Else
          Outline X, Y, W - 1, H - 1, m_ShadowColor, m_HighlightColor
         End If
        ElseIf .Style = tbbsSeparator Then
         GoSub DrawSeperator
        End If
       End If
      Else
       If .Style = tbbsButton Then
        Outline X, Y, W - 1, H - 1, m_ShadowDarkColor, m_HighlightColor
        Outline X + 1, Y + 1, W - 3, H - 3, m_ShadowColor, m_HighlightDarkColor
       End If
      End If
     Else
      'Raised
      If m_Appearance = ifcaFlat Then
       If (NoBorder = 0 And ForceNoBorder = 0) Or Ambient.UserMode = 0 Then
        If .Style = tbbsButton Then
         Outline X, Y, W - 1, H - 1, m_HighlightColor, m_ShadowColor
        ElseIf .Style = tbbsSeparator Then
         GoSub DrawSeperator
        End If
       End If
      Else
       If .Style = tbbsButton Then
        Outline X, Y, W - 1, H - 1, m_HighlightColor, m_ShadowDarkColor
        Outline X + 1, Y + 1, W - 3, H - 3, m_HighlightDarkColor, m_ShadowColor
       End If
      End If
     End If
     'Picture
     Set P = .APicture(ifwpPicNormal)
     If CurrentButton = I And Not .APicture(ifwpPicOver) Is Nothing And IsInControl(hWnd) Then Set P = .APicture(ifwpPicOver)
     If (ButtonLowered Or .Checked) And Not .APicture(ifwpPicDown) Is Nothing Then Set P = .APicture(ifwpPicDown)
     If Not P Is Nothing Then
      PW = ScaleX(P.Width, vbHimetric, vbPixels)
      PH = ScaleY(P.Height, vbHimetric, vbPixels)
      If O = ifcoHorizontal Then
       PX = X + (Int((.ClientWidth - PW) / 2) + Z)
       PY = Y + (Int((.ClientHeight - PH) / 2) + Z)
       If Len(.Caption) Then
        Select Case m_CaptionAlignment
         Case ifcaCaptionOnTop: PY = Y + H + Z - (BorderOffset(1) + 2 + PH)
         Case ifcaCaptionOnBottom: PY = Y + (BorderOffset(1) + 2) + Z
         Case ifcaCaptionOnLeft: PX = X + W + Z - (BorderOffset(0) + 2 + PW)
         Case ifcaCaptionOnRight: PX = X + (BorderOffset(0) + 4) + Z
        End Select
       End If
      Else
       PX = Int((ScaleWidth - PW) / 2) + Z
       If .Caption = "" Then
        PY = Y + Int((H - PH) / 2) + Z
       Else
        PY = (Y + H + Z) - (PH + BorderOffset(1) + 3)
       End If
      End If
      If .Enabled = 0 Or Enabled = 0 Then
       PE.PaintDisabledPicture hDC, P, PX, PY, PW, PH, 0, 0, .MaskColor
      Else
       If P.Type = vbPicTypeIcon Then
        'DrawTransparentBitmap doesn't support icons
        PE.PaintStandardPicture hDC, P, PX, PY, PW, PH, 0, 0
       Else
        If .UseMaskColor Then
         PE.PaintTransparentPicture hDC, P, PX, PY, PW, PH, 0, 0, .MaskColor
        Else
         PE.PaintStandardPicture hDC, P, PX, PY, PW, PH, 0, 0
        End If
       End If
      End If
     End If
     'Caption
     If .Caption <> "" And (m_CaptionOptions = iftoShowLabels Or m_CaptionOptions = iftoSelectedLabels And .AlwaysShowCaption) Then
      ForeColor = 0
      SetTextColor hDC, 0    'Fix for VB bug?
      If Enabled And .Enabled Then
       If CurrentButton = I And IsInControl(hWnd) And m_HotTracking Then
        ForeColor = m_HotTrackingColor
       Else
        ForeColor = m_TextColor
       End If
      Else
       ForeColor = IIf(m_DisabledText3D, m_HighlightColor, m_TextDisabledColor)
      End If
      B = UserControl.FontBold
       If m_BoldOnChecked And .Checked Then UserControl.FontBold = -1
       If (Enabled = 0 Or .Enabled = 0) And m_DisabledText3D Then
        OS = 1
        GoSub PrintCaption
        ForeColor = m_ShadowColor
        OS = 0
        GoSub PrintCaption
       Else
        GoSub PrintCaption
       End If
      UserControl.FontBold = B
     End If
    End With
   End If
  End If
 On Error GoTo 0
Exit Sub

DrawSeperator:
 If Width >= Height Then
  'Horizontal
  Line (X + 2, Y)-(X + 2, Y + H), m_ShadowColor
  Line (X + 3, Y)-(X + 3, Y + H), m_HighlightColor
 Else
  'Vertical
  Line (X, Y + 2)-(X + W, Y + 2), m_ShadowColor
  Line (X, Y + 3)-(X + W, Y + 3), m_HighlightColor
 End If
Return

PrintCaption:
 With m_Buttons(I)
  If Width > Height Then
   'Horizontal
   Select Case m_CaptionAlignment
    Case ifcaCaptionOnTop: PaintText hDC, .Caption, X + Z + OS, Y + BorderOffset(1) + 2 + Z + OS, W, TextHeight(.Caption), F
    Case ifcaCaptionOnBottom: PaintText hDC, .Caption, X + Z + OS, Y + H + Z - (BorderOffset(1) + TextHeight(.Caption) + 2) + OS, W, TextHeight(.Caption), F
    Case ifcaCaptionOnLeft: PaintText hDC, .Caption, X + (BorderOffset(0) + 2) + Z + OS, Y + Z + OS, TextWidth(.Caption), H + Z, F
    Case ifcaCaptionOnRight: PaintText hDC, .Caption, X + PW + 5 + (BorderOffset(0) + 2) + Z + OS, Y + Z + OS, TextWidth(.Caption), H + Z, F
   End Select
  Else
   'Vertical
   Set LF.LogFont = UserControl.Font
   hFont = SelectObject(hDC, LF.handle)
   CurrentX = Int((ScaleWidth - TextHeight(.Caption)) / 2) + Z + OS
   CurrentY = Y + H + Z + OS - (PH + BorderOffset(1) + 6)
   Print .Caption
   Call SelectObject(hDC, hFont)
  End If
 End With
Return

ProcErr:
 RaiseError "RefreshButton"
Resume Next
End Sub


Public Property Get Appearance() As IFCAppearances
Attribute Appearance.VB_Description = "Returns or sets the paint style of a Toolbar control "
Attribute Appearance.VB_HelpID = 2950
Attribute Appearance.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets the paint style of a Toolbar control
 Appearance = m_Appearance
End Property

Public Property Let Appearance(ByVal NewAppearance As IFCAppearances)
 m_Appearance = NewAppearance
 Refresh
 PropertyChanged "Appearance"
End Property
Public Property Get HighlightDarkColor() As OLE_COLOR
Attribute HighlightDarkColor.VB_Description = "Returns or sets the dark highlight colour of the control. "
Attribute HighlightDarkColor.VB_HelpID = 2951
Attribute HighlightDarkColor.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets the dark highlight colour of the control.
 HighlightDarkColor = m_HighlightDarkColor
End Property

Public Property Let HighlightDarkColor(ByVal NewCol As OLE_COLOR)
 m_HighlightDarkColor = NewCol
 Refresh
 PropertyChanged "HighlightDarkColor"
End Property
Public Property Get ShadowDarkColor() As OLE_COLOR
Attribute ShadowDarkColor.VB_Description = "Returns or sets the dark shadow colour of the control. "
Attribute ShadowDarkColor.VB_HelpID = 2952
 '##BD Returns or sets the dark shadow colour of the control.
 ShadowDarkColor = m_ShadowDarkColor
End Property

Public Property Let ShadowDarkColor(ByVal NewCol As OLE_COLOR)
 m_ShadowDarkColor = NewCol
 Refresh
 PropertyChanged "ShadowDarkColor"
End Property


Public Function AddButtonEx(Optional Key$ = "", Optional Style As IFCTBButtonStyles = tbbsButton, Optional Picture As StdPicture = Nothing, Optional ToolTipText$ = "", Optional MaskColor As OLE_COLOR = 16711935, Optional UseMaskColor As Boolean = -1, Optional Caption$ = "", Optional Checked As Boolean = 0, Optional Enabled As Boolean = -1, Optional PlaceholderWidth As Single = 0, Optional Visible As Boolean = -1) As Integer
Attribute AddButtonEx.VB_Description = "Adds a new button to the control, optionally allowing many of it's properties to be set at once. "
Attribute AddButtonEx.VB_HelpID = 2953
 '##BD Adds a new button to the control, optionally allowing many of it's properties to be set at once.
 Dim Z
 m_ButtonCount = m_ButtonCount + 1
 ReDim Preserve m_Buttons(m_ButtonCount) As New clsBSButton
 Z = Redraw
 Redraw = 0
  With m_Buttons(m_ButtonCount)
   .Key = Key$
   .Style = Style
   Set .APicture(ifwpPicNormal) = Picture
   .ToolTipText = ToolTipText$
   .MaskColor = MaskColor
   .UseMaskColor = UseMaskColor
   .Caption = Caption$
   .Checked = Checked
   .Enabled = Enabled
   .PlaceholderSize = PlaceholderWidth
   .Visible = Visible
  End With
  RanOnce = 0
 Redraw = Z
 Refresh
 PropertyChanged "ButtonCount"
 AddButtonEx = m_ButtonCount
End Function

Public Property Get ButtonClientLeft(ByVal Index As Variant) As Single
Attribute ButtonClientLeft.VB_Description = "Returns the left position, in pixels, of a button. "
Attribute ButtonClientLeft.VB_HelpID = 2954
Attribute ButtonClientLeft.VB_ProcData.VB_Invoke_Property = ";Data"
Attribute ButtonClientLeft.VB_MemberFlags = "400"
 '##BD Returns the left position, in pixels, of a button.
 ButtonClientLeft = m_Buttons(KeyToIndex(Index)).ClientLeft * Screen.TwipsPerPixelX
End Property
Public Property Get ButtonClientTop(ByVal Index As Variant) As Single
Attribute ButtonClientTop.VB_Description = "Returns the top position, in pixels, of a button. "
Attribute ButtonClientTop.VB_HelpID = 2955
Attribute ButtonClientTop.VB_ProcData.VB_Invoke_Property = ";Data"
Attribute ButtonClientTop.VB_MemberFlags = "400"
 '##BD Returns the top position, in pixels, of a button.
 ButtonClientTop = m_Buttons(KeyToIndex(Index)).ClientTop * Screen.TwipsPerPixelY
End Property

Public Property Get ButtonClientWidth(ByVal Index As Variant) As Single
Attribute ButtonClientWidth.VB_Description = "Returns the width, in pixels, of a button. "
Attribute ButtonClientWidth.VB_HelpID = 2956
Attribute ButtonClientWidth.VB_ProcData.VB_Invoke_Property = ";Data"
Attribute ButtonClientWidth.VB_MemberFlags = "400"
 '##BD Returns the width, in pixels, of a button.
 ButtonClientWidth = m_Buttons(KeyToIndex(Index)).ClientWidth * Screen.TwipsPerPixelX
End Property

Public Property Get ButtonClientHeight(ByVal Index As Variant) As Single
Attribute ButtonClientHeight.VB_Description = "Returns the height, in pixels, of a button. "
Attribute ButtonClientHeight.VB_HelpID = 2957
Attribute ButtonClientHeight.VB_ProcData.VB_Invoke_Property = ";Data"
Attribute ButtonClientHeight.VB_MemberFlags = "400"
 '##BD Returns the height, in pixels, of a button.
 ButtonClientHeight = m_Buttons(KeyToIndex(Index)).ClientHeight * Screen.TwipsPerPixelY
End Property
Public Property Get ButtonCaption(ByVal Index As Variant) As String
Attribute ButtonCaption.VB_Description = "Returns or sets the caption text of a button. "
Attribute ButtonCaption.VB_HelpID = 2958
 '##BD Returns or sets the caption text of a button.
 '##BD
 '##BD Please note that, depending on the setting of the <B>CaptionOptions</B> properties button captions may not be displayed.
 ButtonCaption = m_Buttons(KeyToIndex(Index)).Caption
End Property
Public Property Let ButtonCaption(ByVal Index As Variant, ByVal ButtonCaption As String)
 Dim I
 I = KeyToIndex(Index)
 m_Buttons(I).Caption = ButtonCaption
 If m_Buttons(I).Visible Then
  RanOnce = 0
  Refresh
 End If
 PropertyChanged "ButtonCaption"
End Property
Public Property Get ButtonDescription(ByVal Index As Variant) As String
Attribute ButtonDescription.VB_Description = "Returns or sets a description associated with a button. "
Attribute ButtonDescription.VB_HelpID = 2959
Attribute ButtonDescription.VB_ProcData.VB_Invoke_Property = ";Data"
 '##BD Returns or sets a description associated with a button.
 '##BD
 '##BD This property is not used directly by the control, however third party code such as Ariad's Common Dialogs _
 feature a Toolbar Customisation dialog (source available) which uses this property.
 ButtonDescription = m_Buttons(KeyToIndex(Index)).Description
End Property
Public Property Let ButtonDescription(ByVal Index As Variant, ByVal ButtonDescription As String)
 m_Buttons(KeyToIndex(Index)).Description = ButtonDescription
 PropertyChanged "ButtonDescription"
End Property
Public Property Get ButtonToolTipText(ByVal Index As Variant) As String
Attribute ButtonToolTipText.VB_Description = "Returns or sets the popup ToolTip text associated with a button. "
Attribute ButtonToolTipText.VB_HelpID = 2960
Attribute ButtonToolTipText.VB_ProcData.VB_Invoke_Property = ";Behavior"
 '##BD Returns or sets the popup ToolTip text associated with a button.
 ButtonToolTipText = m_Buttons(KeyToIndex(Index)).ToolTipText
End Property
Public Property Let ButtonToolTipText(ByVal Index As Variant, ByVal NewStr As String)
 m_Buttons(KeyToIndex(Index)).ToolTipText = NewStr
 PropertyChanged "ButtonToolTipText"
End Property

Public Property Get ButtonKey(ByVal Index As Variant) As String
Attribute ButtonKey.VB_Description = "Returns or sets an unique key to indentify a button. "
Attribute ButtonKey.VB_HelpID = 2961
Attribute ButtonKey.VB_ProcData.VB_Invoke_Property = ";Data"
 '##BD Returns or sets an unique key to indentify a button.
 ButtonKey = m_Buttons(KeyToIndex(Index)).Key
End Property
Public Property Let ButtonKey(ByVal Index As Variant, ByVal ButtonKey As String)
 m_Buttons(KeyToIndex(Index)).Key = ButtonKey
 PropertyChanged "ButtonKey"
End Property
Public Property Get ButtonEnabled(ByVal Index As Variant) As Boolean
Attribute ButtonEnabled.VB_Description = "Returns or sets if a button is enabled for user access or not. "
Attribute ButtonEnabled.VB_HelpID = 2962
 '##BD Returns or sets if a button is enabled for user access or not.
 ButtonEnabled = m_Buttons(KeyToIndex(Index)).Enabled
End Property
Public Property Let ButtonEnabled(ByVal Index As Variant, ByVal State As Boolean)
 Dim I
 I = KeyToIndex(Index)
 If m_Buttons(I).Enabled <> State Then
  m_Buttons(I).Enabled = State
  If m_Buttons(I).Visible Then
   NoBorder = -1
    RefreshButton I
   NoBorder = 0
  End If
  PropertyChanged "ButtonEnabled"
 End If
End Property
Public Property Get ButtonAlwaysShowCaption(ByVal Index As Variant) As Boolean
Attribute ButtonAlwaysShowCaption.VB_Description = "Returns or sets if the caption is always displayed on a button. "
Attribute ButtonAlwaysShowCaption.VB_HelpID = 2963
 '##BD Returns or sets if the caption is always displayed on a button.
 '##BD
 '##BD The value of this property is ignored if the <B>CaptionOptions</B> property is set to <B>iftoNoLabels.</B>
 ButtonAlwaysShowCaption = m_Buttons(KeyToIndex(Index)).AlwaysShowCaption
End Property
Public Property Let ButtonAlwaysShowCaption(ByVal Index As Variant, ByVal State As Boolean)
 Dim I
 I = KeyToIndex(Index)
 If m_Buttons(I).AlwaysShowCaption <> State Then
  m_Buttons(I).AlwaysShowCaption = State
  If Len(m_Buttons(I).Caption) And m_Buttons(I).Visible Then Refresh
  PropertyChanged "ButtonAlwaysShowCaption"
  RanOnce = 0
 End If
End Property
Public Property Get ButtonVisible(ByVal Index As Variant) As Boolean
Attribute ButtonVisible.VB_Description = "Returns or sets if a button is visible or not. "
Attribute ButtonVisible.VB_HelpID = 2964
Attribute ButtonVisible.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets if a button is visible or not.
 ButtonVisible = m_Buttons(KeyToIndex(Index)).Visible
End Property
Public Property Let ButtonVisible(ByVal Index As Variant, ByVal State As Boolean)
 Dim I
 I = KeyToIndex(Index)
 If m_Buttons(I).Visible <> State Then
  m_Buttons(I).Visible = State
  RanOnce = 0
  Refresh
  PropertyChanged "ButtonVisible"
 End If
End Property
Public Property Get ButtonUseMaskColor(ByVal Index As Variant) As Boolean
Attribute ButtonUseMaskColor.VB_Description = "Returns or sets if a button uses the <B>ButtonMaskColor</B> property to create transparent bitmaps or not. "
Attribute ButtonUseMaskColor.VB_HelpID = 2965
Attribute ButtonUseMaskColor.VB_ProcData.VB_Invoke_Property = ";Behavior"
 '##BD Returns or sets if a button uses the <B>ButtonMaskColor</B> property to create transparent bitmaps or not.
 ButtonUseMaskColor = m_Buttons(KeyToIndex(Index)).UseMaskColor
End Property
Public Property Let ButtonUseMaskColor(ByVal Index As Variant, ByVal State As Boolean)
 Dim I
 I = KeyToIndex(Index)
 If m_Buttons(I).UseMaskColor <> State Then
  m_Buttons(I).UseMaskColor = State
  If m_Buttons(I).Visible Then
   RefreshButton I
  End If
  PropertyChanged "ButtonUseMaskColor"
 End If
End Property
Public Property Get ButtonMaskColor(ByVal Index As Variant) As OLE_COLOR
Attribute ButtonMaskColor.VB_Description = "Returns or sets the mask colour of a button, allowing button pictures to be transparent. "
Attribute ButtonMaskColor.VB_HelpID = 2966
 '##BD Returns or sets the mask colour of a button, allowing button pictures to be transparent.
 ButtonMaskColor = m_Buttons(KeyToIndex(Index)).MaskColor
End Property
Public Property Let ButtonMaskColor(ByVal Index As Variant, ByVal ButtonMaskColor As OLE_COLOR)
 Dim I
 I = KeyToIndex(Index)
 If m_Buttons(I).MaskColor <> ButtonMaskColor Then
  m_Buttons(I).MaskColor = ButtonMaskColor
  If m_Buttons(I).Visible Then
   NoBorder = -1
    RefreshButton I
   NoBorder = 0
  End If
  PropertyChanged "ButtonMaskColor"
 End If
End Property
Public Property Get ButtonPicture(ByVal Index As Variant) As StdPicture
Attribute ButtonPicture.VB_Description = "Returns or sets the default picture drawn on a button. "
Attribute ButtonPicture.VB_HelpID = 2967
Attribute ButtonPicture.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets the default picture drawn on a button.
 Set ButtonPicture = m_Buttons(KeyToIndex(Index)).APicture(ifwpPicNormal)
End Property
Public Property Set ButtonPicture(ByVal Index As Variant, ByVal ButtonPicture As StdPicture)
 Dim I
 I = KeyToIndex(Index)
 Set m_Buttons(I).APicture(ifwpPicNormal) = ButtonPicture
 If m_Buttons(I).Visible Then
  NoBorder = -1
   RefreshButton I
  NoBorder = 0
 End If
 PropertyChanged "ButtonPicture"
End Property
Public Property Get ButtonPictureOver(ByVal Index As Variant) As StdPicture
Attribute ButtonPictureOver.VB_Description = "Returns or sets the picture drawn on a button when the mouse hovers over it. "
Attribute ButtonPictureOver.VB_HelpID = 2968
Attribute ButtonPictureOver.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets the picture drawn on a button when the mouse hovers over it.
 Set ButtonPictureOver = m_Buttons(KeyToIndex(Index)).APicture(ifwpPicOver)
End Property
Public Property Set ButtonPictureOver(ByVal Index As Variant, ByVal ButtonPictureOver As StdPicture)
 Dim I
 I = KeyToIndex(Index)
 Set m_Buttons(I).APicture(ifwpPicOver) = ButtonPictureOver
 If m_Buttons(I).Visible Then
  NoBorder = -1
   RefreshButton I
  NoBorder = 0
 End If
 PropertyChanged "ButtonPictureOver" & I
End Property
Public Property Get ButtonPictureDown(ByVal Index As Variant) As StdPicture
Attribute ButtonPictureDown.VB_Description = "Returns or sets the picture drawn on a button when it is pressed or checked. "
Attribute ButtonPictureDown.VB_HelpID = 2969
Attribute ButtonPictureDown.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets the picture drawn on a button when it is pressed or checked.
 Set ButtonPictureDown = m_Buttons(KeyToIndex(Index)).APicture(ifwpPicDown)
End Property
Public Property Set ButtonPictureDown(ByVal Index As Variant, ByVal ButtonPictureDown As StdPicture)
 Dim I
 I = KeyToIndex(Index)
 Set m_Buttons(I).APicture(ifwpPicDown) = ButtonPictureDown
 If m_Buttons(I).Visible Then
  NoBorder = -1
   RefreshButton I
  NoBorder = 0
 End If
 PropertyChanged "ButtonPictureDown" & I
End Property
Public Property Get ButtonChecked(ByVal Index As Variant) As Boolean
Attribute ButtonChecked.VB_Description = "Returns or sets if a button is drawn checked and pressed. "
Attribute ButtonChecked.VB_HelpID = 2970
Attribute ButtonChecked.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets if a button is drawn checked and pressed.
 ButtonChecked = m_Buttons(KeyToIndex(Index)).Checked
End Property
Public Property Let ButtonChecked(ByVal Index As Variant, ByVal State As Boolean)
 Dim I
 I = KeyToIndex(Index)
 If m_Buttons(I).Checked <> State Then
  m_Buttons(I).Checked = State
  If m_Buttons(I).Visible Then
   NoBorder = -1
    RefreshButton I
   NoBorder = 0
  End If
  PropertyChanged "ButtonChecked" & I
 End If
End Property
Public Property Get ButtonStyle(ByVal Index As Variant) As IFCTBButtonStyles
Attribute ButtonStyle.VB_Description = "Returns or sets the style of a button. "
Attribute ButtonStyle.VB_HelpID = 2971
Attribute ButtonStyle.VB_ProcData.VB_Invoke_Property = ";Appearance"
 '##BD Returns or sets the style of a button.
 ButtonStyle = m_Buttons(KeyToIndex(Index)).Style
End Property
Public Property Let ButtonStyle(ByVal Index As Variant, ByVal NewStyle As IFCTBButtonStyles)
 Dim I
 I = KeyToIndex(Index)
 m_Buttons(I).Style = NewStyle
 If m_Buttons(I).Visible Then
  RanOnce = 0
  Refresh
 End If
 PropertyChanged "ButtonStyle"
End Property
Public Property Get ButtonPlaceholderWidth(ByVal Index As Variant) As Single
Attribute ButtonPlaceholderWidth.VB_Description = "Returns or sets the width of a button. "
Attribute ButtonPlaceholderWidth.VB_HelpID = 2972
 '##BD Returns or sets the width of a button.
 '##BD
 '##BD This property is only used when the <B>ButtonStyle</B> property is set to <B>tbbsPlaceholder</B>
 ButtonPlaceholderWidth = m_Buttons(KeyToIndex(Index)).PlaceholderSize
End Property
Public Property Let ButtonPlaceholderWidth(ByVal Index As Variant, ByVal ButtonPlaceholderWidth As Single)
 Dim I
 I = KeyToIndex(Index)
 m_Buttons(I).PlaceholderSize = ButtonPlaceholderWidth
 If m_Buttons(I).Visible Then
  RanOnce = 0
  Refresh
 End If
 PropertyChanged "ButtonPlaceholderWidth"
End Property
Public Property Get ButtonGroupID(ByVal Index As Variant) As Integer
Attribute ButtonGroupID.VB_Description = "Returns or sets the group ID of a button for creating toggle groups. "
Attribute ButtonGroupID.VB_HelpID = 2973
 '##BD Returns or sets the group ID of a button for creating toggle groups.
 ButtonGroupID = m_Buttons(KeyToIndex(Index)).GroupID
End Property
Public Property Let ButtonGroupID(ByVal Index As Variant, ByVal ButtonGroupID As Integer)
 m_Buttons(KeyToIndex(Index)).GroupID = ButtonGroupID
 PropertyChanged "ButtonGroupID"
End Property


Public Function DeleteButton(ByVal Index As Variant) As Integer
Attribute DeleteButton.VB_Description = "Deletes an existing button from the control. "
Attribute DeleteButton.VB_HelpID = 2975
 '##BD Deletes an existing button from the control.
 Dim I
 I = KeyToIndex(Index)
 If I < 1 Or I > m_ButtonCount Then
  DeleteButton = -1
  RaiseErrorEx "DeleteButton", 380
 Else
  SwapButton I, m_ButtonCount
  m_ButtonCount = m_ButtonCount - 1
  ReDim Preserve m_Buttons(m_ButtonCount)
  PropertyChanged "ButtonCount"
  Refresh
  DeleteButton = m_ButtonCount
  RanOnce = 0
 End If
End Function

Public Function SwapButton(ByVal CurIndex As Variant, ByVal NewIndex As Variant) As Integer
Attribute SwapButton.VB_Description = "Swaps one button with another. "
Attribute SwapButton.VB_HelpID = 2976
 '##BD Swaps one button with another.
 Dim CI, NI, I, S
 Dim T As New clsBSButton
 CI = KeyToIndex(CurIndex)
 NI = KeyToIndex(NewIndex)
 If CI < 1 Or CI > m_ButtonCount Or NI < 1 Or NI > m_ButtonCount Then
  RaiseErrorEx "SwapButton", 380
 Else
  If NI > CI Then S = 1 Else S = -1
  For I = CI To NI - S Step S
   Set T = m_Buttons(I)
   Set m_Buttons(I) = m_Buttons(I + S)
   Set m_Buttons(I + S) = T
  Next
  Refresh
  SwapButton = NewIndex
 End If
 Set T = Nothing
End Function

Public Property Get Button(ByVal Index As Variant) As Object
Attribute Button.VB_Description = "Returns a direct button object. "
Attribute Button.VB_HelpID = 2977
Attribute Button.VB_ProcData.VB_Invoke_Property = ";Data"
Attribute Button.VB_MemberFlags = "400"
 '##BD Returns a direct button object.
 Set Button = m_Buttons(KeyToIndex(Index))
End Property


Public Property Get Enabled() As Boolean
Attribute Enabled.VB_Description = "Returns or sets a value that determines whether a Toolbar control can respond to user-generated events. "
Attribute Enabled.VB_HelpID = 2978
Attribute Enabled.VB_ProcData.VB_Invoke_Property = ";Behavior"
 '##BD Returns or sets a value that determines whether a Toolbar control can respond to user-generated events.
 Enabled = UserControl.Enabled
End Property

Public Property Let Enabled(ByVal State As Boolean)
 Dim C As Control
 UserControl.Enabled = State
 Refresh
 On Error Resume Next
  For Each C In ContainedControls
   C.Enabled = State
  Next
 On Error GoTo 0
 PropertyChanged "State"
End Property

Public Property Get FontName() As String
Attribute FontName.VB_Description = "Returns or sets the font used to display text in a Toolbar control "
Attribute FontName.VB_HelpID = 2979
Attribute FontName.VB_ProcData.VB_Invoke_Property = ";Font"
Attribute FontName.VB_MemberFlags = "400"
 '##BD Returns or sets the font used to display text in a Toolbar control
 FontName = Font.Name
End Property
Public Property Let FontName(ByVal FontName As String)
 On Error Resume Next
  Font.Name = FontName
  PropertyChanged "Font"
  Refresh
 On Error GoTo 0
End Property
Public Property Get FontBold() As Boolean
Attribute FontBold.VB_Description = "Returns or sets the font used to display text in a Toolbar control "
Attribute FontBold.VB_HelpID = 2980
Attribute FontBold.VB_ProcData.VB_Invoke_Property = ";Font"
Attribute FontBold.VB_MemberFlags = "400"
 '##BD Returns or sets the font used to display text in a Toolbar control
 FontBold = Font.Bold
End Property
Public Property Let FontBold(ByVal State As Boolean)
 On Error Resume Next
  Font.Bold = State
  PropertyChanged "Font"
  Refresh
 On Error GoTo 0
End Property
Public Property Get FontItalic() As Boolean
Attribute FontItalic.VB_Description = "Returns or sets the font used to display text in a Toolbar control "
Attribute FontItalic.VB_HelpID = 2981
Attribute FontItalic.VB_ProcData.VB_Invoke_Property = ";Font"
Attribute FontItalic.VB_MemberFlags = "400"
 '##BD Returns or sets the font used to display text in a Toolbar control
 FontItalic = Font.Italic
End Property
Public Property Let FontItalic(ByVal State As Boolean)
 On Error Resume Next
  Font.Italic = State
  PropertyChanged "Font"
  Refresh
 On Error GoTo 0
End Property
Public Property Get FontUnderline() As Boolean
Attribute FontUnderline.VB_Description = "Returns or sets the font used to display text in a Toolbar control "
Attribute FontUnderline.VB_HelpID = 2982
Attribute FontUnderline.VB_ProcData.VB_Invoke_Property = ";Font"
Attribute FontUnderline.VB_MemberFlags = "400"
 '##BD Returns or sets the font used to display text in a Toolbar control
 FontUnderline = Font.Underline
End Property
Public Property Let FontUnderline(ByVal State As Boolean)
 On Error Resume Next
  Font.Underline = State
  PropertyChanged "Font"
  Refresh
 On Error GoTo 0
End Property
Public Property Get FontStrikethru() As Boolean
Attribute FontStrikethru.VB_Description = "Returns or sets the font used to display text in a Toolbar control "
Attribute FontStrikethru.VB_HelpID = 2983
Attribute FontStrikethru.VB_ProcData.VB_Invoke_Property = ";Font"
Attribute FontStrikethru.VB_MemberFlags = "400"
 '##BD Returns or sets the font used to display text in a Toolbar control
 FontStrikethru = Font.Strikethrough
End Property
Public Property Let FontStrikethru(ByVal State As Boolean)
 On Error Resume Next
  Font.Strikethrough = State
  PropertyChanged "Font"
  Refresh
 On Error GoTo 0
End Property
Public Property Get FontSize() As Single
Attribute FontSize.VB_Description = "Returns or sets the font used to display text in a Toolbar control "
Attribute FontSize.VB_HelpID = 2984
Attribute FontSize.VB_MemberFlags = "400"
 '##BD Returns or sets the font used to display text in a Toolbar control
 FontSize = Font.Size
End Property
Public Property Let FontSize(ByVal FontSize As Single)
 On Error Resume Next
  Font.Size = FontSize
  PropertyChanged "Font"
  Refresh
 On Error GoTo 0
End Property


Public Sub ForceResize()
Attribute ForceResize.VB_Description = "Forces the Resize() event to be raised "
Attribute ForceResize.VB_HelpID = 2985
 '##BD Forces the Resize() event to be raised
 UserControl_Resize
End Sub

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
 If Ambient.UserMode Then
  '"Runtime" - raise error
  Err.Raise Err, App.EXEName & "." & TypeName(Me) & ":" & ProcName$
 Else
  '"Design time" - display error
  VBA.MsgBox INTERR$ & vbCr & vbCr & Err.Description & " (" & Err & ")" & vbCr & vbCr & ERRTEXT$, vbCritical, App.EXEName & "." & TypeName(Me) & ":" & ProcName$
 End If
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
 If Ambient.UserMode Then
  '"Runtime" - raise error
  If Len(ErrMsg$) Then
   Err.Raise ErrNum, App.EXEName & "." & TypeName(Me) & ":" & ProcName$, ErrMsg$
  Else
   Err.Raise ErrNum, App.EXEName & "." & TypeName(Me) & ":" & ProcName$
  End If
 Else
  '"Design time" - display error
  If Len(ErrMsg$) = 0 Then
   On Error Resume Next
    Error ErrNum
    ErrMsg$ = Err.Description
   On Error GoTo 0
  End If
  VBA.MsgBox INTERR$ & vbCr & vbCr & ErrMsg$ & " (" & ErrNum & ")" & vbCr & vbCr & ERRTEXT$, vbCritical, App.EXEName & "." & TypeName(Me)
 End If
End Sub

Public Function PictureWidth(Optional What As IFCWhatPictures = ifwpPicNormal) As Single
Attribute PictureWidth.VB_Description = "Returns the width, in pixels, of a picture in a button. "
Attribute PictureWidth.VB_HelpID = 2988
 '##BD Returns the width, in pixels, of a picture in a button.
 Dim Z As Single, C As Single
 Dim I
 On Error Resume Next
  For I = 1 To m_ButtonCount
   With m_Buttons(I)
    Select Case What
     Case ifwpPicNormal: C = ScaleX(.APicture(ifwpPicNormal).Width, vbHimetric, vbPixels)
     Case ifwpPicOver: C = ScaleX(.APicture(ifwpPicOver).Width, vbHimetric, vbPixels)
     Case ifwpPicDown: C = ScaleX(.APicture(ifwpPicDown).Width, vbHimetric, vbPixels)
    End Select
    If C > Z Then Z = C
   End With
  Next
  PictureWidth = Z
 On Error GoTo 0
End Function
Public Function PictureHeight(Optional What As IFCWhatPictures = ifwpPicNormal) As Single
Attribute PictureHeight.VB_Description = "Returns the height, in pixels, of a picture in a button. "
Attribute PictureHeight.VB_HelpID = 2989
 '##BD Returns the height, in pixels, of a picture in a button.
 Dim Z As Single, C As Single
 Dim I
 On Error Resume Next
  For I = 1 To m_ButtonCount
   With m_Buttons(I)
    Select Case What
     Case ifwpPicNormal: C = ScaleX(.APicture(ifwpPicNormal).Height, vbHimetric, vbPixels)
     Case ifwpPicOver: C = ScaleX(.APicture(ifwpPicOver).Height, vbHimetric, vbPixels)
     Case ifwpPicDown: C = ScaleX(.APicture(ifwpPicDown).Height, vbHimetric, vbPixels)
    End Select
    If C > Z Then Z = C
   End With
  Next
  PictureHeight = Z
 On Error GoTo 0
End Function


Public Property Get MouseX() As Single
Attribute MouseX.VB_Description = "Returns the last X position of the mouse. "
Attribute MouseX.VB_HelpID = 2990
Attribute MouseX.VB_ProcData.VB_Invoke_Property = ";Misc"
Attribute MouseX.VB_MemberFlags = "40"
 '##BD Returns the last X position of the mouse.
 MouseX = MX
End Property

Public Property Get MouseY() As Single
Attribute MouseY.VB_Description = "Returns the last Y position of the mouse. "
Attribute MouseY.VB_HelpID = 2991
Attribute MouseY.VB_ProcData.VB_Invoke_Property = ";Misc"
 '##BD Returns the last Y position of the mouse.
 MouseY = MY
End Property
Public Property Get ShowToolTips() As Boolean
Attribute ShowToolTips.VB_Description = "Specifies if ToolTips are enabled for the Toolbar control "
Attribute ShowToolTips.VB_HelpID = 2993
Attribute ShowToolTips.VB_ProcData.VB_Invoke_Property = ";Behavior"
 '##BD Specifies if ToolTips are enabled for the Toolbar control
 ShowToolTips = m_ShowToolTips
End Property
Public Property Let ShowToolTips(ByVal State As Boolean)
 m_ShowToolTips = State
 PropertyChanged "ShowToolTips"
End Property

Public Property Get CaptionOptions() As IFCCaptionOptions
Attribute CaptionOptions.VB_Description = "Returns or sets how button captions are displayed. "
Attribute CaptionOptions.VB_HelpID = 2994
 '##BD Returns or sets how button captions are displayed.
 CaptionOptions = m_CaptionOptions
End Property

Public Property Let CaptionOptions(ByVal CaptionOptions As IFCCaptionOptions)
 m_CaptionOptions = CaptionOptions
 PropertyChanged "TextOptions"
 Refresh
End Property


Public Sub ForceClick(ByVal Index As Variant)
Attribute ForceClick.VB_Description = "Forces a button to be clicked and to raise appropriate events. "
Attribute ForceClick.VB_HelpID = 2995
 '##BD Forces a button to be clicked and to raise appropriate events.
 Dim I
 I = KeyToIndex(Index)
 If I < 1 Or I > m_ButtonCount Then
  InvalidKeyIndex "ForceClick"
 Else
  RaiseEvent ButtonClick(I, m_Buttons(I).Key)
  UpdateGroups I
 End If
End Sub

Private Sub InvalidKeyIndex(ProcName$)
Attribute InvalidKeyIndex.VB_HelpID = 2996
 RaiseErrorEx ProcName$, 9, "Invalid Key or Index value"
End Sub

Private Sub UpdateGroups(Index)
Attribute UpdateGroups.VB_HelpID = 2997
 Dim I, Z
 Z = m_Buttons(Index).GroupID
 If Z Then
  For I = 1 To m_ButtonCount
   If m_Buttons(I).GroupID = Z And I <> Index Then
    ButtonChecked(I) = 0
   End If
  Next
  ButtonChecked(Index) = -1
 End If
End Sub

Public Property Get ButtonGap() As Integer
Attribute ButtonGap.VB_Description = "Returns or sets the gaps between buttons. "
Attribute ButtonGap.VB_HelpID = 2998
 '##BD Returns or sets the gaps between buttons.
 ButtonGap = m_ButtonGap
End Property

Public Property Let ButtonGap(ByVal ButtonGap As Integer)
 m_ButtonGap = ButtonGap
 RanOnce = 0
 Refresh
 PropertyChanged "ButtonGap"
End Property

Property Get CurrentGroupID(ByVal GroupID As Integer) As Integer
Attribute CurrentGroupID.VB_Description = "Returns the selected button in the specified group. "
Attribute CurrentGroupID.VB_HelpID = 2999
 '##BD Returns the selected button in the specified group.
 Dim I
 For I = 1 To m_ButtonCount
  If m_Buttons(I).GroupID = GroupID Then
   If m_Buttons(I).Checked = -1 Then CurrentGroupID = I
  End If
 Next
End Property

Public Property Get SolidChecked() As Boolean
Attribute SolidChecked.VB_Description = "Returns or sets if double lowered borders are drawn when a button is checked. "
Attribute SolidChecked.VB_HelpID = 3000
 '##BD Returns or sets if double lowered borders are drawn when a button is checked.
 SolidChecked = m_SolidChecked
End Property

Public Property Let SolidChecked(ByVal State As Boolean)
 Dim I
 m_SolidChecked = State
 For I = 1 To m_ButtonCount
  If m_Buttons(I).Checked Then RefreshButton I
 Next
 PropertyChanged "SolidChecked"
End Property

Public Property Get ShowSeparators() As Boolean
Attribute ShowSeparators.VB_Description = "Returns or sets if seperators are automatically displayed between buttons when the <B>ButtonGap</B> property is specifed and the <B>Appearance</B> property is set to <B>ifcaFlat</B> "
Attribute ShowSeparators.VB_HelpID = 3001
 '##BD Returns or sets if seperators are automatically displayed between buttons when the <B>ButtonGap</B> property is specifed _
 and the <B>Appearance</B> property is set to <B>ifcaFlat</B>
 ShowSeparators = m_ShowSeparators
End Property

Public Property Let ShowSeparators(ByVal State As Boolean)
 m_ShowSeparators = State
 PropertyChanged "ShowSeparators"
 If m_Appearance = ifcaFlat Then Refresh
End Property

Public Property Get TextColor() As OLE_COLOR
Attribute TextColor.VB_Description = "Returns or sets the text color of a Toolbar control. "
Attribute TextColor.VB_HelpID = 3002
 '##BD Returns or sets the text color of a Toolbar control.
 TextColor = m_TextColor
End Property
Public Property Let TextColor(ByVal TextColor As OLE_COLOR)
 Dim I
 m_TextColor = TextColor
 For I = 1 To m_ButtonCount
  If Len(m_Buttons(I).Caption) Then RefreshButton I
 Next
 PropertyChanged "TextColor"
End Property
Public Property Get TextDisabledColor() As OLE_COLOR
Attribute TextDisabledColor.VB_Description = "Returns or sets the colour used to draw disabled captions. "
Attribute TextDisabledColor.VB_HelpID = 3003
 '##BD Returns or sets the colour used to draw disabled captions.
 '##BD
 '##BD This property is only used when the <B>DisabledText3D</B> property is <B>False.</B>
 TextDisabledColor = m_TextDisabledColor
End Property
Public Property Let TextDisabledColor(ByVal TextDisabledColor As OLE_COLOR)
 Dim I
 m_TextDisabledColor = TextDisabledColor
 For I = 1 To m_ButtonCount
  If Len(m_Buttons(I).Caption) And m_Buttons(I).Enabled = 0 Then RefreshButton I
 Next
 PropertyChanged "TextDisabledColor"
End Property
Public Property Get HotTracking() As Boolean
Attribute HotTracking.VB_Description = "Returns or sets if hottracking is used to colour button captions as the mouse moves over a button. "
Attribute HotTracking.VB_HelpID = 3004
 '##BD Returns or sets if hottracking is used to colour button captions as the mouse moves over a button.
 HotTracking = m_HotTracking
End Property
Public Property Let HotTracking(ByVal State As Boolean)
 m_HotTracking = State
 PropertyChanged "HotTracking"
End Property
Public Property Get HotTrackingColor() As OLE_COLOR
Attribute HotTrackingColor.VB_Description = "Returns or sets colour used to draw button captions when the <B>HotTracking</B> property is specified and the mouse is hovered over a button. "
Attribute HotTrackingColor.VB_HelpID = 3005
 '##BD Returns or sets colour used to draw button captions when the <B>HotTracking</B> property _
 is specified and the mouse is hovered over a button.
 HotTrackingColor = m_HotTrackingColor
End Property
Public Property Let HotTrackingColor(ByVal HotTrackingColor As OLE_COLOR)
 m_HotTrackingColor = HotTrackingColor
 PropertyChanged "HotTrackingColor"
End Property


Public Property Get BoldOnChecked() As Boolean
Attribute BoldOnChecked.VB_Description = "Returns or sets if captions are displayed in <B>Bold</B> text when buttons are checked. "
Attribute BoldOnChecked.VB_HelpID = 3006
 '##BD Returns or sets if captions are displayed in <B>Bold</B> text when buttons are checked.
 BoldOnChecked = m_BoldOnChecked
End Property

Public Property Let BoldOnChecked(ByVal State As Boolean)
 m_BoldOnChecked = State
 PropertyChanged "BoldOnChecked"
 Refresh
End Property

Public Property Get CaptionAlignment() As IFCCaptionAlignments
Attribute CaptionAlignment.VB_Description = "Returns or sets the position of caption text related to button pictures. "
Attribute CaptionAlignment.VB_HelpID = 3007
 '##BD Returns or sets the position of caption text related to button pictures.
 CaptionAlignment = m_CaptionAlignment
End Property

Public Property Let CaptionAlignment(ByVal CaptionAlignment As IFCCaptionAlignments)
 m_CaptionAlignment = CaptionAlignment
 Refresh
 PropertyChanged "CaptionAlignment"
End Property

Public Property Get AutoSize() As Boolean
Attribute AutoSize.VB_Description = "Returns or sets if the control automatically resizes itself to ensure that all buttons are visible. "
Attribute AutoSize.VB_HelpID = 3008
 '##BD Returns or sets if the control automatically resizes itself to ensure that all buttons are visible.
 '##BD
 '##BD This property is best used when the Toolbar control is hosted in other controls, such as the <B>asxPager</B> control.
 AutoSize = m_AutoSize
End Property

Public Property Let AutoSize(ByVal State As Boolean)
 If Extender.Align And State = -1 Then
  RaiseErrorEx "AutoSize", vbObjectError + 1, "AutoSize property cannot be set to True when Align property is set."
 Else
  m_AutoSize = State
  PropertyChanged "AutoSize"
  Refresh
 End If
End Property

Public Property Get Style() As IFCTBStyle
Attribute Style.VB_Description = "Returns or sets how buttons are sized. "
Attribute Style.VB_HelpID = 3009
 '##BD Returns or sets how buttons are sized.
 Style = m_Style
End Property

Public Property Let Style(ByVal Style As IFCTBStyle)
 m_Style = Style
 PropertyChanged "Style"
 Refresh
End Property

Public Property Get FixedSize() As Single
Attribute FixedSize.VB_Description = "Returns or sets the size of buttons when the <B>Style</B> property is set to <B>tbtsFixed</B> "
Attribute FixedSize.VB_HelpID = 3010
 '##BD Returns or sets the size of buttons when the <B>Style</B> property is set to <B>tbtsFixed</B>
 FixedSize = m_FixedSize
End Property

Public Property Let FixedSize(ByVal FixedSize As Single)
 m_FixedSize = FixedSize
 PropertyChanged "FixedSize"
 Refresh
End Property


Public Property Get DisabledText3D() As Boolean
Attribute DisabledText3D.VB_Description = "Returns or sets if the captions on disabled buttons are drawn in 3D text or not. "
Attribute DisabledText3D.VB_HelpID = 3011
 '##BD Returns or sets if the captions on disabled buttons are drawn in 3D text or not.
 DisabledText3D = m_DisabledText3D
End Property

Public Property Let DisabledText3D(ByVal State As Boolean)
 m_DisabledText3D = State
 PropertyChanged "DisabledText3D"
 Refresh
End Property
