//================================================================================
// EventMatchSpecialMsgWnd.
//================================================================================

class EventMatchSpecialMsgWnd extends UICommonAPI;

var TextureHandle MessageTex;
const TIMERID_Hide= 1;

function OnLoad ()
{
	MessageTex = TextureHandle(GetHandle("MsgTex"));
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
	local string TextureName;
	local int TextureWidth;
	local int TextureHeight;

	ParseInt(_L2jBRVar17_,"Type",L2jBRVar5);
	ParseString(_L2jBRVar17_,"Message",Message);
	switch (L2jBRVar5)
	{
		case 1:
		TextureName = "L2UI_CH3.BroadcastObs.br_msg1_finish";
		TextureWidth = 512;
		TextureHeight = 256;
		break;
		case 2:
		TextureName = "L2UI_CH3.BroadcastObs.br_msg1_start";
		TextureWidth = 512;
		TextureHeight = 512;
		break;
		case 3:
		TextureName = "L2UI_CH3.BroadcastObs.br_msg1_gameover";
		TextureWidth = 512;
		TextureHeight = 256;
		break;
		case 4:
		TextureName = "L2UI_CH3.BroadcastObs.br_msg1_count1";
		TextureWidth = 256;
		TextureHeight = 256;
		break;
		case 5:
		TextureName = "L2UI_CH3.BroadcastObs.br_msg1_count2";
		TextureWidth = 256;
		TextureHeight = 256;
		break;
		case 6:
		TextureName = "L2UI_CH3.BroadcastObs.br_msg1_count3";
		TextureWidth = 256;
		TextureHeight = 256;
		break;
		case 7:
		TextureName = "L2UI_CH3.BroadcastObs.br_msg1_count4";
		TextureWidth = 256;
		TextureHeight = 256;
		break;
		case 8:
		TextureName = "L2UI_CH3.BroadcastObs.br_msg1_count5";
		TextureWidth = 256;
		TextureHeight = 256;
		break;
		default:
		return;
	}
	MessageTex.SetWindowSize(TextureWidth,TextureHeight);
	MessageTex.SetTextureSize(TextureWidth,TextureHeight);
	MessageTex.SetTexture(TextureName);
	m_hOwnerWnd.ShowWindow();
	m_hOwnerWnd.KillTimer(1);
	m_hOwnerWnd.SetTimer(1,5000);
}

