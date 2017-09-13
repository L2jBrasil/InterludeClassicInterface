//================================================================================
// EventMatchGMFenceWnd.
//================================================================================

class EventMatchGMFenceWnd extends UICommonAPI;

var ButtonHandle m_hOKButton;
var ButtonHandle m_hCancelButton;
var ButtonHandle m_hMyLocationButton;
var EditBoxHandle m_hXEditBox;
var EditBoxHandle m_hYEditBox;
var EditBoxHandle m_hZEditBox;
var EditBoxHandle m_hXLengthEditBox;
var EditBoxHandle m_hYLengthEditBox;

function OnLoad ()
{
	RegisterEvent(2180);
	m_hOKButton = ButtonHandle(GetHandle("OKButton"));
	m_hCancelButton = ButtonHandle(GetHandle("CancelButton"));
	m_hMyLocationButton = ButtonHandle(GetHandle("MyLocationButton"));
	m_hXEditBox = EditBoxHandle(GetHandle("XEditBox"));
	m_hYEditBox = EditBoxHandle(GetHandle("YEditBox"));
	m_hZEditBox = EditBoxHandle(GetHandle("ZEditBox"));
	m_hXLengthEditBox = EditBoxHandle(GetHandle("XLengthEditBox"));
	m_hYLengthEditBox = EditBoxHandle(GetHandle("YLengthEditBox"));
}

function OnClickButtonWithHandle (ButtonHandle a_ButtonHandle)
{
	switch (a_ButtonHandle)
	{
		case m_hOKButton:
		OnClickOKButton();
		break;
		case m_hCancelButton:
		OnClickCancelButton();
		break;
		case m_hMyLocationButton:
		OnClickMyLocationButton();
		break;
		default:
	}
}

function OnClickOKButton ()
{
	local int XLength;
	local int YLength;
	local Vector Position;
	local EventMatchGMWnd GMWndScript;

	XLength = int(m_hXLengthEditBox.GetString());
	if ( UnknownFunction129(UnknownFunction130(UnknownFunction152(100,XLength),UnknownFunction151(5000,XLength))) )
	{
		DialogShow(5,GetSystemMessage(1414));
		return;
	}
	YLength = int(m_hYLengthEditBox.GetString());
	if ( UnknownFunction129(UnknownFunction130(UnknownFunction152(100,YLength),UnknownFunction151(5000,YLength))) )
	{
		DialogShow(5,GetSystemMessage(1414));
		return;
	}
	Position.X = int(m_hXEditBox.GetString());
	Position.Y = int(m_hYEditBox.GetString());
	Position.Z = int(m_hZEditBox.GetString());
	m_hOwnerWnd.HideWindow();
	GMWndScript = EventMatchGMWnd(GetScript("EventMatchGMWnd"));
	if ( UnknownFunction119(GMWndScript,None) )
	{
		GMWndScript.NotifyFenceInfo(Position,XLength,YLength);
	}
}

function OnClickCancelButton ()
{
	m_hOwnerWnd.HideWindow();
}

function OnClickMyLocationButton ()
{
	local Vector PlayerPosition;

	PlayerPosition = GetPlayerPosition();
	m_hXEditBox.SetString(string(int(PlayerPosition.X)));
	m_hYEditBox.SetString(string(int(PlayerPosition.Y)));
	m_hZEditBox.SetString(string(int(PlayerPosition.Z)));
}

