//================================================================================
// EventMatchGMMsgWnd.
//================================================================================

class EventMatchGMMsgWnd extends UICommonAPI;

var TextBoxHandle MessageTextBox;
const TIMERID_Hide= 1;

function OnLoad ()
{
	MessageTextBox = TextBoxHandle(GetHandle("MsgTextBox"));
	RegisterEvent(2270);
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2270:
		HandleEventMatchGMMessage(_L2jBRVar17_);
		break;
		default:
		break;
	}
}

function OnTimer (int a_TimerID)
{
	switch (a_TimerID)
	{
		case 1:
		m_hOwnerWnd.HideWindow();
		MessageTextBox.SetText("");
		m_hOwnerWnd.KillTimer(1);
		break;
		default:
		break;
	}
}

function HandleEventMatchGMMessage (string _L2jBRVar17_)
{
	local int L2jBRVar5;
	local string Message;

	ParseInt(_L2jBRVar17_,"Type",L2jBRVar5);
	ParseString(_L2jBRVar17_,"Message",Message);
	switch (L2jBRVar5)
	{
		case 0:
		m_hOwnerWnd.ShowWindow();
		MessageTextBox.SetText(Message);
		m_hOwnerWnd.KillTimer(1);
		m_hOwnerWnd.SetTimer(1,5000);
		break;
		default:
		break;
	}
}

