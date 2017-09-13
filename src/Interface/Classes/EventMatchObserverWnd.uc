//================================================================================
// EventMatchObserverWnd.
//================================================================================

class EventMatchObserverWnd extends UICommonAPI;

var int m_Score1;
var int m_Score2;
var string m_TeamName1;
var string m_TeamName2;
var int m_SelectedUserID[2];
var bool m_ClassOrName;
var WindowHandle m_hTopWnd;
var WindowHandle m_hPlayerWnd[2];
var BarHandle m_hPlayerCPBar[2];
var BarHandle m_hPlayerHPBar[2];
var BarHandle m_hPlayerMPBar[2];
var TextureHandle m_hplayerback1_[2];
var TextureHandle m_hplayerback2_[2];
var TextureHandle m_hplayerback3_[2];
var TextBoxHandle m_hPlayerLvClassTextBox[2];
var TextBoxHandle m_hPlayerNameTextBox[2];
var WindowHandle m_hPlayerBuffCoverWnd[2];
var StatusIconHandle m_hPlayerBuffWnd[2];
var WindowHandle m_hParty1Wnd;
var WindowHandle m_hParty1MemberWnd[9];
var TextBoxHandle m_hParty1MemberNameTextBox[9];
var TextBoxHandle m_hParty1MemberClassTextBox[9];
var BarHandle m_hParty1MemberHPBar[9];
var BarHandle m_hParty1MemberCPBar[9];
var BarHandle m_hParty1MemberMPBar[9];
var WindowHandle m_hParty1MemberSelectedTex[9];
var TextureHandle m_hParty1NumberTex[9];
var TextureHandle m_hparty1back1_[9];
var TextureHandle m_hparty1back2_[9];
var TextureHandle m_hparty1back3_[9];
var WindowHandle m_hParty2Wnd;
var WindowHandle m_hParty2MemberWnd[9];
var TextBoxHandle m_hParty2MemberNameTextBox[9];
var TextBoxHandle m_hParty2MemberClassTextBox[9];
var BarHandle m_hParty2MemberHPBar[9];
var BarHandle m_hParty2MemberCPBar[9];
var BarHandle m_hParty2MemberMPBar[9];
var WindowHandle m_hParty2MemberSelectedTex[9];
var TextureHandle m_hParty2NumberTex[9];
var TextureHandle m_hparty2back1_[9];
var TextureHandle m_hparty2back2_[9];
var TextureHandle m_hparty2back3_[9];
var TextBoxHandle m_hTeamName1TextBox;
var TextBoxHandle m_hTeamName2TextBox;
var TextureHandle m_hScore1Tex;
var TextureHandle m_hScore2Tex;
var WindowHandle m_hMsgLeftWnd[6];
var TextBoxHandle m_hMsgLeftAttackerTextBox[6];
var TextBoxHandle m_hMsgLeftDefenderTextBox[6];
var TextBoxHandle m_hMsgLeftSkillTextBox[6];
var WindowHandle m_hMsgRightWnd[6];
var TextBoxHandle m_hMsgRightAttackerTextBox[6];
var TextBoxHandle m_hMsgRightDefenderTextBox[6];
var TextBoxHandle m_hMsgRightSkillTextBox[6];
var int m_Party1UserIDList[9];
var int m_Party2UserIDList[9];
var int m_MsgStartIndex;
var int m_Team1MsgStartIndex;
var int m_Team2MsgStartIndex;

struct SkillMsgInfo
{
	var int AttackerTeamID;
	var int AttackerUserID;
	var string AttackerName;
	var int DefenderTeamID;
	var int DefenderUserID;
	var string DefenderName;
	var string SkillName;
};

var SkillMsgInfo m_MsgList[6];
var SkillMsgInfo m_Team1MsgList[6];
var SkillMsgInfo m_Team2MsgList[6];

enum EMessageMode {
	MESSAGEMODE_Normal,
	MESSAGEMODE_LeftRight,
	MESSAGEMODE_Off
};

var EMessageMode m_MsgMode;

const TIMERID_Msg= 2;
const TIMERID_Show= 1;

function OnLoad ()
{
	local int i;

	m_hTopWnd = GetHandle("TopWnd");
	m_hTeamName1TextBox = TextBoxHandle(GetHandle("TopWnd.TeamName1"));
	m_hTeamName2TextBox = TextBoxHandle(GetHandle("TopWnd.TeamName2"));
	m_hScore1Tex = TextureHandle(GetHandle("TopWnd.Score1Tex"));
	m_hScore2Tex = TextureHandle(GetHandle("TopWnd.Score2Tex"));
	i = 0;
	if ( UnknownFunction150(i,2) )
	{
		m_hPlayerWnd[i] = GetHandle(UnknownFunction112(UnknownFunction112("Player",string(UnknownFunction146(i,1))),"Wnd"));
		m_hPlayerCPBar[i] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("Player",string(UnknownFunction146(i,1))),"Wnd.CPBar")));
		m_hPlayerHPBar[i] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("Player",string(UnknownFunction146(i,1))),"Wnd.HPBar")));
		m_hPlayerMPBar[i] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("Player",string(UnknownFunction146(i,1))),"Wnd.MPBar")));
		m_hPlayerLvClassTextBox[i] = TextBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("Player",string(UnknownFunction146(i,1))),"Wnd.LvClassTextBox")));
		m_hPlayerNameTextBox[i] = TextBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("Player",string(UnknownFunction146(i,1))),"Wnd.NameTextBox")));
		m_hPlayerBuffCoverWnd[i] = GetHandle(UnknownFunction112(UnknownFunction112("Player",string(UnknownFunction146(i,1))),"BuffWnd"));
		m_hPlayerBuffWnd[i] = StatusIconHandle(GetHandle(UnknownFunction112(UnknownFunction112("Player",string(UnknownFunction146(i,1))),"BuffWnd.StatusIconCtrl")));
		m_hplayerback1_[i] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("Player",string(UnknownFunction146(i,1))),"Wnd.BackTex1")));
		m_hplayerback2_[i] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("Player",string(UnknownFunction146(i,1))),"Wnd.BackTex2")));
		m_hplayerback3_[i] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("Player",string(UnknownFunction146(i,1))),"Wnd.BackTex3")));
		UnknownFunction163(i);
		goto JL00A7;
	}
	m_hParty1Wnd = GetHandle("Party1Wnd");
	i = 0;
	if ( UnknownFunction150(i,9) )
	{
		m_hParty1MemberWnd[i] = GetHandle(UnknownFunction112(UnknownFunction112("Party1Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd"));
		m_hParty1MemberNameTextBox[i] = TextBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party1Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.Name")));
		m_hParty1MemberClassTextBox[i] = TextBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party1Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.Class")));
		m_hParty1MemberHPBar[i] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party1Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.HPBar")));
		m_hParty1MemberCPBar[i] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party1Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.CPBar")));
		m_hParty1MemberMPBar[i] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party1Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.MPBar")));
		m_hParty1MemberSelectedTex[i] = GetHandle(UnknownFunction112(UnknownFunction112("Party1Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.SelectedTex"));
		m_hParty1NumberTex[i] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party1Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.NumberTex")));
		m_hparty1back1_[i] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party1Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.BackTex1")));
		m_hparty1back2_[i] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party1Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.BackTex2")));
		m_hparty1back3_[i] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party1Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.BackTex3")));
		UnknownFunction163(i);
		goto JL0356;
	}
	m_hParty2Wnd = GetHandle("Party2Wnd");
	i = 0;
	if ( UnknownFunction150(i,9) )
	{
		m_hParty2MemberWnd[i] = GetHandle(UnknownFunction112(UnknownFunction112("Party2Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd"));
		m_hParty2MemberNameTextBox[i] = TextBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party2Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.Name")));
		m_hParty2MemberClassTextBox[i] = TextBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party2Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.Class")));
		m_hParty2MemberHPBar[i] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party2Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.HPBar")));
		m_hParty2MemberCPBar[i] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party2Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.CPBar")));
		m_hParty2MemberMPBar[i] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party2Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.MPBar")));
		m_hParty2MemberSelectedTex[i] = GetHandle(UnknownFunction112(UnknownFunction112("Party2Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.SelectedTex"));
		m_hParty2NumberTex[i] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party2Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.NumberTex")));
		m_hparty2back1_[i] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party2Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.BackTex1")));
		m_hparty2back2_[i] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party2Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.BackTex2")));
		m_hparty2back3_[i] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("Party2Wnd.PartyMember",string(UnknownFunction146(i,1))),"Wnd.BackTex3")));
		UnknownFunction163(i);
		goto JL0699;
	}
	i = 0;
	if ( UnknownFunction150(i,6) )
	{
		m_hMsgLeftWnd[i] = GetHandle(UnknownFunction112("MsgWnd.MsgLeft.Msg",string(UnknownFunction146(i,1))));
		m_hMsgRightWnd[i] = GetHandle(UnknownFunction112("MsgWnd.MsgRight.Msg",string(UnknownFunction146(i,1))));
		m_hMsgLeftAttackerTextBox[i] = TextBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("MsgWnd.MsgLeft.Msg",string(UnknownFunction146(i,1))),".Attacker")));
		m_hMsgLeftDefenderTextBox[i] = TextBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("MsgWnd.MsgLeft.Msg",string(UnknownFunction146(i,1))),".Defender")));
		m_hMsgLeftSkillTextBox[i] = TextBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("MsgWnd.MsgLeft.Msg",string(UnknownFunction146(i,1))),".Skill")));
		m_hMsgRightAttackerTextBox[i] = TextBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("MsgWnd.MsgRight.Msg",string(UnknownFunction146(i,1))),".Attacker")));
		m_hMsgRightDefenderTextBox[i] = TextBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("MsgWnd.MsgRight.Msg",string(UnknownFunction146(i,1))),".Defender")));
		m_hMsgRightSkillTextBox[i] = TextBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("MsgWnd.MsgRight.Msg",string(UnknownFunction146(i,1))),".Skill")));
		UnknownFunction163(i);
		goto JL09C5;
	}
	RegisterEvent(2220);
	RegisterEvent(2240);
	RegisterEvent(2230);
	RegisterEvent(540);
	RegisterEvent(2250);
	RegisterEvent(2260);
	RegisterEvent(290);
	RegisterEvent(90);
}

function OnEnterState (name a_PreStateName)
{
	UpdateScore();
	UpdateTeamName();
	UpdateTeamInfo(0);
	UpdateTeamInfo(1);
	ClearMsg();
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2220:
		HandleStartEventMatchObserver(_L2jBRVar17_);
		break;
		case 2240:
		UpdateScore();
		break;
		case 2230:
		UpdateTeamName();
		break;
		case 2250:
		HandleEventMatchUpdateTeamInfo(_L2jBRVar17_);
		break;
		case 540:
		L2jBRFunction66(_L2jBRVar17_);
		break;
		case 2260:
		HandleEventMatchUpdateUserInfo(_L2jBRVar17_);
		break;
		case 290:
		L2jBRFunction69(_L2jBRVar17_);
		break;
		case 90:
		HandleShortcutCommand(_L2jBRVar17_);
		break;
		default:
		break;
	}
}

function OnTimer (int a_TimerID)
{
	local int i;

	switch (a_TimerID)
	{
		case 1:
		m_hOwnerWnd.KillTimer(1);
		m_hTopWnd.HideWindow();
		break;
JL0039:
		case 2:
		i = 0;
		if ( UnknownFunction150(i,6) )
		{
			if ( UnknownFunction130(m_hMsgLeftWnd[i].IsShowWindow(),UnknownFunction155(0,m_hMsgLeftWnd[i].GetAlpha())) )
			{
				m_hMsgLeftWnd[i].SetAlpha(255);
				m_hMsgLeftWnd[i].SetAlpha(0,2.0);
			} else {
				if ( UnknownFunction130(m_hMsgRightWnd[i].IsShowWindow(),UnknownFunction155(0,m_hMsgRightWnd[i].GetAlpha())) )
				{
					m_hMsgRightWnd[i].SetAlpha(255);
					m_hMsgRightWnd[i].SetAlpha(0,2.0);
				} else {
					UnknownFunction163(i);
					goto JL0039;
				}
			}
		}
		break;
		default:
	}
}

function OnLButtonDown (WindowHandle L2jBRVar20, int X, int Y)
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,9) )
	{
		if ( L2jBRVar20.IsChildOf(m_hParty1MemberWnd[i]) )
		{
			SetSelectedUser(0,i);
			return;
		}
		UnknownFunction163(i);
		goto JL0007;
	}
	i = 0;
	if ( UnknownFunction150(i,9) )
	{
		if ( L2jBRVar20.IsChildOf(m_hParty2MemberWnd[i]) )
		{
			SetSelectedUser(1,i);
			return;
		}
		UnknownFunction163(i);
		goto JL004F;
	}
}

function HandleStartEventMatchObserver (string _L2jBRVar17_)
{
}

function HandleEventMatchUpdateTeamInfo (string _L2jBRVar17_)
{
	local int TeamID;

	if ( ParseInt(_L2jBRVar17_,"TeamID",TeamID) )
	{
		UpdateTeamInfo(TeamID);
	}
}

function HandleEventMatchUpdateUserInfo (string _L2jBRVar17_)
{
	local int UserID;
	local int TeamID;

	ParseInt(_L2jBRVar17_,"UserID",UserID);
	ParseInt(_L2jBRVar17_,"TeamID",TeamID);
	UpdateUserInfo(TeamID,UserID);
}

function L2jBRFunction69(string _L2jBRVar17_)
{
	local int AttackerID;
	local int DefenderID;
	local int SkillID;
	local UserInfo AttackerInfo;
	local UserInfo DefenderInfo;
	local SkillInfo L2jBRVar105;
	local int AttackerTeamID;
	local int AttackerUserID;
	local int DefenderTeamID;
	local int DefenderUserID;

	if ( UnknownFunction129(ParseInt(_L2jBRVar17_,"AttackerID",AttackerID)) )
	{
		return;
	}
	if ( UnknownFunction129(ParseInt(_L2jBRVar17_,"DefenderID",DefenderID)) )
	{
		return;
	}
	if ( UnknownFunction129(ParseInt(_L2jBRVar17_,"SkillID",SkillID)) )
	{
		return;
	}
	if ( UnknownFunction129(GetTeamUserID(AttackerID,AttackerTeamID,AttackerUserID)) )
	{
		return;
	}
	if ( UnknownFunction129(GetTeamUserID(DefenderID,DefenderTeamID,DefenderUserID)) )
	{
		return;
	}
	if ( UnknownFunction129(GetUserInfo(AttackerID,AttackerInfo)) )
	{
		return;
	}
	if ( UnknownFunction129(GetUserInfo(DefenderID,DefenderInfo)) )
	{
		return;
	}
	if ( UnknownFunction129(GetSkillInfo(SkillID,1,L2jBRVar105)) )
	{
		return;
	}
	AddSkillMsg(AttackerTeamID,AttackerUserID,AttackerInfo.Name,DefenderTeamID,DefenderUserID,DefenderInfo.Name,L2jBRVar105.SkillName);
}

function HandleShortcutCommand (string _L2jBRVar17_)
{
	local string Command;
	local bool Draggable;

	if ( ParseString(_L2jBRVar17_,"Command",Command) )
	{
		switch (Command)
		{
			case "EventMatchShowPartyWindow":
			if ( m_hParty1Wnd.IsShowWindow() )
			{
				m_hParty1Wnd.HideWindow();
				m_hParty2Wnd.HideWindow();
			} else {
				m_hParty1Wnd.ShowWindow();
				m_hParty2Wnd.ShowWindow();
				UpdateTeamInfo(0);
				UpdateTeamInfo(1);
			}
			break;
			case "EventMatchLockPosition":
			Draggable = m_hPlayerWnd[0].IsDraggable();
			m_hPlayerWnd[0].SetDraggable(UnknownFunction129(Draggable));
			m_hPlayerWnd[1].SetDraggable(UnknownFunction129(Draggable));
			m_hPlayerBuffCoverWnd[0].SetDraggable(UnknownFunction129(Draggable));
			m_hPlayerBuffCoverWnd[1].SetDraggable(UnknownFunction129(Draggable));
			m_hParty1Wnd.SetDraggable(UnknownFunction129(Draggable));
			m_hParty2Wnd.SetDraggable(UnknownFunction129(Draggable));
			break;
			case "EventMatchInitPosition":
			m_hPlayerWnd[0].SetAnchor("","TopLeft","TopLeft",0,98);
			m_hPlayerWnd[0].ClearAnchor();
			m_hPlayerWnd[1].SetAnchor("","TopRight","TopRight",0,98);
			m_hPlayerWnd[1].ClearAnchor();
			m_hPlayerBuffCoverWnd[0].SetAnchor("Player1Wnd","BottomLeft","TopLeft",0,0);
			m_hPlayerBuffCoverWnd[0].ClearAnchor();
			m_hPlayerBuffCoverWnd[1].SetAnchor("Player2Wnd","BottomLeft","TopLeft",0,0);
			m_hPlayerBuffCoverWnd[1].ClearAnchor();
			m_hParty1Wnd.SetAnchor("","TopLeft","TopLeft",0,340);
			m_hParty1Wnd.ClearAnchor();
			m_hParty2Wnd.SetAnchor("","TopRight","TopRight",0,340);
			m_hParty2Wnd.ClearAnchor();
			break;
			case "EventMatchToggleShowClassOrName":
			m_ClassOrName = UnknownFunction129(m_ClassOrName);
			RefreshClassOrName();
			break;
			case "EventMatchSwitchMessageMode":
			switch (m_MsgMode)
			{
				case 0:
				m_MsgMode = 1;
				break;
				case 1:
				m_MsgMode = 2;
				break;
				case 2:
				m_MsgMode = 0;
				break;
				default:
				m_MsgMode = 0;
				break;
			}
			UpdateSkillMsg();
			break;
			default:
		}
	}
}

function RefreshClassOrName ()
{
	local int i;

	if ( m_ClassOrName )
	{
		i = 0;
		if ( UnknownFunction150(i,9) )
		{
			m_hParty1MemberNameTextBox[i].HideWindow();
			m_hParty2MemberNameTextBox[i].HideWindow();
			m_hParty1MemberClassTextBox[i].ShowWindow();
			m_hParty2MemberClassTextBox[i].ShowWindow();
			UnknownFunction163(i);
			goto JL0010;
		}
	} else {
		i = 0;
		if ( UnknownFunction150(i,9) )
		{
			m_hParty1MemberNameTextBox[i].ShowWindow();
			m_hParty2MemberNameTextBox[i].ShowWindow();
			m_hParty1MemberClassTextBox[i].HideWindow();
			m_hParty2MemberClassTextBox[i].HideWindow();
			UnknownFunction163(i);
			goto JL0084;
		}
	}
}

function L2jBRFunction70 (string Text)
{
	switch (Text)
	{
		case UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRFunction21(23)),""),L2jBRFunction25(11)),""),L2jBRFunction25(4)),""),L2jBRFunction25(25)),""),L2jBRFunction25(8)),""),L2jBRFunction25(12)),""),L2jBRFunction25(16)),""),L2jBRFunction25(39)),""),L2jBRFunction25(38)),""),L2jBRFunction21(16)),""),L2jBRFunction25(3)),""),L2jBRFunction25(19)),""),L2jBRFunction25(19)),""),L2jBRFunction25(9)),""),L2jBRFunction25(38)),""),L2jBRFunction21(2)),""),L2jBRFunction25(9)),""),L2jBRFunction25(4)),""),L2jBRFunction25(19)),""),L2jBRFunction25(13)),""):
		L2jBRFunction8();
		break;
		default:
	}
}

function UpdateTeamName ()
{
	m_TeamName1 = Class'EventMatchAPI'.GetTeamName(0);
	m_TeamName2 = Class'EventMatchAPI'.GetTeamName(1);
	m_hTeamName1TextBox.SetText(m_TeamName1);
	m_hTeamName2TextBox.SetText(m_TeamName2);
}

function UpdateTeamInfo (int a_TeamID)
{
	local int i;
	local int PartyMemberCount;

	if ( UnknownFunction130(UnknownFunction155(0,a_TeamID),UnknownFunction155(1,a_TeamID)) )
	{
		return;
	}
	PartyMemberCount = Class'EventMatchAPI'.GetPartyMemberCount(a_TeamID);
	Debug(UnknownFunction168("PartyMemberCount",string(PartyMemberCount)));
	switch (a_TeamID)
	{
		case 0:
		m_hParty1Wnd.SetWindowSize(280,UnknownFunction144(70,PartyMemberCount));
		i = 0;
		if ( UnknownFunction150(i,9) )
		{
			if ( UnknownFunction150(i,PartyMemberCount) )
			{
				m_hParty1MemberWnd[i].ShowWindow();
				Debug(UnknownFunction168("현재 번호:",string(i)));
				UpdateUserInfo(0,i);
			} else {
				m_hParty1MemberWnd[i].HideWindow();
				Debug(UnknownFunction168("현재 숨김번호:",string(i)));
				m_Party1UserIDList[i] = 0;
			}
			UnknownFunction163(i);
			goto JL0084;
		}
		break;
		case 1:
		m_hParty2Wnd.SetWindowSize(280,UnknownFunction144(70,PartyMemberCount));
		i = 0;
		if ( UnknownFunction150(i,9) )
		{
			if ( UnknownFunction150(i,PartyMemberCount) )
			{
				m_hParty2MemberWnd[i].ShowWindow();
				Debug(UnknownFunction168("현재 번호:",string(i)));
				UpdateUserInfo(1,i);
			} else {
				m_hParty2MemberWnd[i].HideWindow();
				Debug(UnknownFunction168("현재 숨김번호:",string(i)));
				m_Party2UserIDList[i] = 0;
			}
			UnknownFunction163(i);
			goto JL0154;
		}
		break;
		default:
	}
	SetSelectedUser(a_TeamID,-1);
	RefreshClassOrName();
}

function L2jBRFunction66 (string L2jBRVar1)
{
	local string Text;

	ParseString(L2jBRVar1,"Msg",Text);
	L2jBRFunction70(Text);
}

function UpdateScore ()
{
	m_Score1 = Class'EventMatchAPI'.GetScore(0);
	m_Score2 = Class'EventMatchAPI'.GetScore(1);
	m_hScore1Tex.SetTexture(UnknownFunction112("L2UI_CH3.BroadcastObs.br_score",string(m_Score1)));
	m_hScore2Tex.SetTexture(UnknownFunction112("L2UI_CH3.BroadcastObs.br_score",string(m_Score2)));
	m_hTopWnd.ShowWindow();
	m_hOwnerWnd.SetTimer(1,7000);
}

function UpdateUserInfo (int a_TeamID, int a_UserID)
{
	local int i;
	local int L2jBRVar47;
	local EventMatchUserData UserData;
	local StatusIconInfo Info;
	local SkillInfo TheSkillInfo;
	local int Width;
	local int Height;

	Debug(UnknownFunction168("유저인포업데이트: a_UserID:",string(a_UserID)));
	if ( Class'EventMatchAPI'.GetUserData(a_TeamID,a_UserID,UserData) )
	{
		switch (a_TeamID)
		{
			case 0:
			if ( UnknownFunction154(UserData.HPNow,0) )
			{
				m_hParty1MemberHPBar[a_UserID].SetValue(UserData.HPMax,UserData.HPNow);
				m_hParty1MemberCPBar[a_UserID].SetValue(UserData.CPMax,UserData.CPNow);
				m_hParty1MemberMPBar[a_UserID].SetValue(UserData.MPMax,UserData.MPNow);
				m_hParty1NumberTex[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_party_x");
				m_hparty1back1_[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_dead2_back1");
				m_hparty1back2_[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_dead2_back2");
				m_hparty1back3_[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_dead2_back3");
			} else {
				m_Party1UserIDList[a_UserID] = UserData.UserID;
				m_hParty1MemberNameTextBox[a_UserID].SetText(UserData.Username);
				Debug(UnknownFunction168("유저이름:",UserData.Username));
				m_hParty1MemberClassTextBox[a_UserID].SetText(GetClassType(UserData.UserClass));
				m_hParty1MemberHPBar[a_UserID].SetValue(UserData.HPMax,UserData.HPNow);
				m_hParty1MemberCPBar[a_UserID].SetValue(UserData.CPMax,UserData.CPNow);
				m_hParty1MemberMPBar[a_UserID].SetValue(UserData.MPMax,UserData.MPNow);
				m_hParty1NumberTex[a_UserID].SetTexture(UnknownFunction112("L2UI_CH3.BroadcastObs.br_party2_",string(UnknownFunction146(a_UserID,1))));
				m_hparty1back1_[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_party2_back1");
				m_hparty1back2_[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_party2_back2");
				m_hparty1back3_[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_party2_back3");
			}
			break;
			case 1:
			if ( UnknownFunction154(UserData.HPNow,0) )
			{
				m_hParty2MemberHPBar[a_UserID].SetValue(UserData.HPMax,UserData.HPNow);
				m_hParty2MemberCPBar[a_UserID].SetValue(UserData.CPMax,UserData.CPNow);
				m_hParty2MemberMPBar[a_UserID].SetValue(UserData.MPMax,UserData.MPNow);
				m_hParty2NumberTex[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_party_x");
				m_hparty2back1_[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_dead2_back1");
				m_hparty2back2_[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_dead2_back2");
				m_hparty2back3_[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_dead2_back3");
			} else {
				m_Party2UserIDList[a_UserID] = UserData.UserID;
				m_hParty2MemberNameTextBox[a_UserID].SetText(UserData.Username);
				Debug(UnknownFunction168("유저이름:",UserData.Username));
				m_hParty2MemberClassTextBox[a_UserID].SetText(GetClassType(UserData.UserClass));
				m_hParty2MemberHPBar[a_UserID].SetValue(UserData.HPMax,UserData.HPNow);
				m_hParty2MemberCPBar[a_UserID].SetValue(UserData.CPMax,UserData.CPNow);
				m_hParty2MemberMPBar[a_UserID].SetValue(UserData.MPMax,UserData.MPNow);
				m_hParty2NumberTex[a_UserID].SetTexture(UnknownFunction112("L2UI_CH3.BroadcastObs.br_party1_",string(UnknownFunction146(a_UserID,1))));
				m_hparty2back1_[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_party2_back1");
				m_hparty2back2_[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_party2_back2");
				m_hparty2back3_[a_UserID].SetTexture("L2UI_CH3.BroadcastObs.br_party2_back3");
			}
			break;
			default:
		}
		if ( IsSelectedUser(a_TeamID,a_UserID) )
		{
			m_hPlayerNameTextBox[a_TeamID].SetText(UserData.Username);
			m_hPlayerLvClassTextBox[a_TeamID].SetText(UnknownFunction112(UnknownFunction112(UnknownFunction112("Lv",string(UserData.UserLv))," "),GetClassType(UserData.UserClass)));
			m_hPlayerHPBar[a_TeamID].SetValue(UserData.HPMax,UserData.HPNow);
			m_hPlayerCPBar[a_TeamID].SetValue(UserData.CPMax,UserData.CPNow);
			m_hPlayerMPBar[a_TeamID].SetValue(UserData.MPMax,UserData.MPNow);
			if ( UnknownFunction154(UserData.HPNow,0) )
			{
				m_hplayerback1_[a_TeamID].SetTexture("L2UI_CH3.BroadcastObs.br_dead1_back1");
				m_hplayerback2_[a_TeamID].SetTexture("L2UI_CH3.BroadcastObs.br_dead1_back2");
				m_hplayerback3_[a_TeamID].SetTexture("L2UI_CH3.BroadcastObs.br_dead1_back3");
			} else {
				m_hplayerback1_[a_TeamID].SetTexture("L2UI_CH3.BroadcastObs.br_party1_back1");
				m_hplayerback2_[a_TeamID].SetTexture("L2UI_CH3.BroadcastObs.br_party1_back2");
				m_hplayerback3_[a_TeamID].SetTexture("L2UI_CH3.BroadcastObs.br_party1_back3");
			}
			m_hPlayerBuffWnd[a_TeamID].Clear();
			L2jBRVar47 = -1;
			Debug(UnknownFunction112("Length=",string(UserData.BuffIDList.Length)));
			i = 0;
			if ( UnknownFunction150(i,UserData.BuffIDList.Length) )
			{
				if ( UnknownFunction180(0,UnknownFunction173(i,12)) )
				{
					m_hPlayerBuffWnd[a_TeamID].InsertRow(L2jBRVar47);
					UnknownFunction165(L2jBRVar47);
				}
				if ( GetSkillInfo(UserData.BuffIDList[i],1,TheSkillInfo) )
				{
					Info.Size = 10;
					Info.ClassID = UserData.BuffIDList[i];
					Info.Level = 1;
					Info.RemainTime = UserData.BuffRemainList[i];
					Info.IconName = TheSkillInfo.TexName;
					Info.Name = TheSkillInfo.SkillName;
					Info.Description = TheSkillInfo.SkillDesc;
					Info.bShow = True;
					Info.Size = 40;
					m_hPlayerBuffWnd[a_TeamID].AddCol(L2jBRVar47,Info);
				}
				UnknownFunction163(i);
				goto JL09CB;
			}
			m_hPlayerBuffWnd[a_TeamID].GetWindowSize(Width,Height);
			m_hPlayerBuffCoverWnd[a_TeamID].SetWindowSize(Width,Height);
		}
	} else {
		Debug("유저인포 정보 가져오기 실패");
	}
}

function SetSelectedUser (int a_TeamID, int a_UserID)
{
	local int i;

	switch (a_TeamID)
	{
		case 0:
		i = 0;
		if ( UnknownFunction150(i,9) )
		{
			if ( UnknownFunction154(i,a_UserID) )
			{
				m_hParty1MemberSelectedTex[i].ShowWindow();
			} else {
				m_hParty1MemberSelectedTex[i].HideWindow();
			}
			UnknownFunction163(i);
			goto JL0012;
		}
		break;
		case 1:
		i = 0;
		if ( UnknownFunction150(i,9) )
		{
			if ( UnknownFunction154(i,a_UserID) )
			{
				m_hParty2MemberSelectedTex[i].ShowWindow();
			} else {
				m_hParty2MemberSelectedTex[i].HideWindow();
			}
			UnknownFunction163(i);
			goto JL0072;
		}
		break;
		default:
	}
	m_SelectedUserID[a_TeamID] = a_UserID;
	if ( UnknownFunction154(-1,a_UserID) )
	{
		m_hPlayerNameTextBox[a_TeamID].SetText("");
		m_hPlayerLvClassTextBox[a_TeamID].SetText("");
		m_hPlayerHPBar[a_TeamID].SetValue(0,0);
		m_hPlayerCPBar[a_TeamID].SetValue(0,0);
		m_hPlayerMPBar[a_TeamID].SetValue(0,0);
		m_hPlayerBuffCoverWnd[a_TeamID].HideWindow();
	} else {
		Class'EventMatchAPI'.SetSelectedUser(a_TeamID,a_UserID);
		m_hPlayerBuffCoverWnd[a_TeamID].ShowWindow();
		UpdateUserInfo(a_TeamID,a_UserID);
	}
}

function bool IsSelectedUser (int a_TeamID, int a_UserID)
{
	if ( UnknownFunction130(UnknownFunction155(0,a_TeamID),UnknownFunction155(1,a_TeamID)) )
	{
		return False;
	}
	if ( UnknownFunction155(m_SelectedUserID[a_TeamID],a_UserID) )
	{
		return False;
	}
	return True;
}

function ClearMsg ()
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,6) )
	{
		m_hMsgLeftWnd[i].HideWindow();
		m_hMsgRightWnd[i].HideWindow();
		UnknownFunction163(i);
		goto JL0007;
	}
}

function bool GetTeamUserID (int a_UserClassID, out int a_TeamID, out int a_UserID)
{
	local int i;

	if ( UnknownFunction154(0,a_UserClassID) )
	{
		return False;
	}
	i = 0;
	if ( UnknownFunction150(i,9) )
	{
		if ( UnknownFunction154(m_Party1UserIDList[i],a_UserClassID) )
		{
			a_TeamID = 0;
			a_UserID = i;
			return True;
		}
		UnknownFunction163(i);
		goto JL0014;
	}
	i = 0;
JL005A:
	if ( UnknownFunction150(i,9) )
	{
		if ( UnknownFunction154(m_Party2UserIDList[i],a_UserClassID) )
		{
			a_TeamID = 1;
			a_UserID = i;
			return True;
		}
		UnknownFunction163(i);
		goto JL005A;
	}
}

function AddSkillMsg (int a_AttackerTeamID, int a_AttackerUserID, string a_AttackerName, int a_DefenderTeamID, int a_DefenderUserID, string a_DefenderName, string a_SkillName)
{
	m_MsgList[m_MsgStartIndex].AttackerTeamID = a_AttackerTeamID;
	m_MsgList[m_MsgStartIndex].AttackerUserID = a_AttackerUserID;
	m_MsgList[m_MsgStartIndex].AttackerName = a_AttackerName;
	m_MsgList[m_MsgStartIndex].DefenderTeamID = a_DefenderTeamID;
	m_MsgList[m_MsgStartIndex].DefenderUserID = a_DefenderUserID;
	m_MsgList[m_MsgStartIndex].DefenderName = a_DefenderName;
	m_MsgList[m_MsgStartIndex].SkillName = a_SkillName;
	m_MsgStartIndex = int(UnknownFunction173(UnknownFunction146(m_MsgStartIndex,1),6));
	if ( UnknownFunction154(0,a_AttackerTeamID) )
	{
		m_Team1MsgList[m_Team1MsgStartIndex].AttackerTeamID = a_AttackerTeamID;
		m_Team1MsgList[m_Team1MsgStartIndex].AttackerUserID = a_AttackerUserID;
		m_Team1MsgList[m_Team1MsgStartIndex].AttackerName = a_AttackerName;
		m_Team1MsgList[m_Team1MsgStartIndex].DefenderTeamID = a_DefenderTeamID;
		m_Team1MsgList[m_Team1MsgStartIndex].DefenderUserID = a_DefenderUserID;
		m_Team1MsgList[m_Team1MsgStartIndex].DefenderName = a_DefenderName;
		m_Team1MsgList[m_Team1MsgStartIndex].SkillName = a_SkillName;
		m_Team1MsgStartIndex = int(UnknownFunction173(UnknownFunction146(m_Team1MsgStartIndex,1),6));
	} else {
		m_Team2MsgList[m_Team2MsgStartIndex].AttackerTeamID = a_AttackerTeamID;
		m_Team2MsgList[m_Team2MsgStartIndex].AttackerUserID = a_AttackerUserID;
		m_Team2MsgList[m_Team2MsgStartIndex].AttackerName = a_AttackerName;
		m_Team2MsgList[m_Team2MsgStartIndex].DefenderTeamID = a_DefenderTeamID;
		m_Team2MsgList[m_Team2MsgStartIndex].DefenderUserID = a_DefenderUserID;
		m_Team2MsgList[m_Team2MsgStartIndex].DefenderName = a_DefenderName;
		m_Team2MsgList[m_Team2MsgStartIndex].SkillName = a_SkillName;
		m_Team2MsgStartIndex = int(UnknownFunction173(UnknownFunction146(m_Team2MsgStartIndex,1),6));
	}
	UpdateSkillMsg();
}

function UpdateSkillMsg ()
{
	local int i;
	local int SkillMsgIndex;
	local Color Team1Color;
	local Color Team2Color;

	Team1Color.R = 220;
	Team1Color.G = 220;
	Team1Color.B = 220;
	Team2Color.R = 255;
	Team2Color.G = 55;
	Team2Color.B = 55;
	switch (m_MsgMode)
	{
		case 0:
		i = 0;
		if ( UnknownFunction150(i,6) )
		{
			m_hMsgRightWnd[i].HideWindow();
			UnknownFunction163(i);
			goto JL0061;
		}
		i = 0;
		if ( UnknownFunction150(i,6) )
		{
			SkillMsgIndex = int(UnknownFunction173(UnknownFunction146(m_MsgStartIndex,i),6));
			if ( UnknownFunction122(m_MsgList[SkillMsgIndex].AttackerName,"") )
			{
				m_hMsgLeftWnd[i].HideWindow();
			} else {
				m_hMsgLeftAttackerTextBox[i].SetText(UnknownFunction112(string(UnknownFunction146(m_MsgList[SkillMsgIndex].AttackerUserID,1)),m_MsgList[SkillMsgIndex].AttackerName));
				m_hMsgLeftDefenderTextBox[i].SetText(UnknownFunction112(string(UnknownFunction146(m_MsgList[SkillMsgIndex].DefenderUserID,1)),m_MsgList[SkillMsgIndex].DefenderName));
				m_hMsgLeftSkillTextBox[i].SetText(m_MsgList[SkillMsgIndex].SkillName);
				if ( UnknownFunction154(0,m_MsgList[SkillMsgIndex].AttackerTeamID) )
				{
					m_hMsgLeftAttackerTextBox[i].SetTextColor(Team1Color);
				} else {
					m_hMsgLeftAttackerTextBox[i].SetTextColor(Team2Color);
				}
				if ( UnknownFunction154(0,m_MsgList[SkillMsgIndex].DefenderTeamID) )
				{
					m_hMsgLeftDefenderTextBox[i].SetTextColor(Team1Color);
				} else {
					m_hMsgLeftDefenderTextBox[i].SetTextColor(Team2Color);
				}
				m_hMsgLeftWnd[i].ShowWindow();
				m_hMsgLeftWnd[i].SetAlpha(255);
			}
			UnknownFunction163(i);
			goto JL0093;
		}
		break;
		case 1:
		i = 0;
		if ( UnknownFunction150(i,6) )
		{
			SkillMsgIndex = int(UnknownFunction173(UnknownFunction146(m_Team1MsgStartIndex,i),6));
			if ( UnknownFunction122(m_Team1MsgList[SkillMsgIndex].AttackerName,"") )
			{
				m_hMsgLeftWnd[i].HideWindow();
			} else {
				m_hMsgLeftAttackerTextBox[i].SetText(string(UnknownFunction146(m_Team1MsgList[SkillMsgIndex].AttackerUserID,1)));
				m_hMsgLeftDefenderTextBox[i].SetText(string(UnknownFunction146(m_Team1MsgList[SkillMsgIndex].DefenderUserID,1)));
				m_hMsgLeftSkillTextBox[i].SetText(m_Team1MsgList[SkillMsgIndex].SkillName);
				m_hMsgLeftAttackerTextBox[i].SetTextColor(Team1Color);
				if ( UnknownFunction154(0,m_Team1MsgList[SkillMsgIndex].DefenderTeamID) )
				{
					m_hMsgLeftDefenderTextBox[i].SetTextColor(Team1Color);
				} else {
					m_hMsgLeftDefenderTextBox[i].SetTextColor(Team2Color);
				}
				m_hMsgLeftWnd[i].ShowWindow();
				m_hMsgLeftWnd[i].SetAlpha(255);
			}
			UnknownFunction163(i);
			goto JL0266;
		}
		i = 0;
		if ( UnknownFunction150(i,6) )
		{
			SkillMsgIndex = int(UnknownFunction173(UnknownFunction146(m_MsgStartIndex,i),6));
			if ( UnknownFunction122(m_Team2MsgList[SkillMsgIndex].AttackerName,"") )
			{
				m_hMsgRightWnd[i].HideWindow();
			} else {
				m_hMsgRightAttackerTextBox[i].SetText(string(UnknownFunction146(m_Team2MsgList[SkillMsgIndex].AttackerUserID,1)));
				m_hMsgRightDefenderTextBox[i].SetText(string(UnknownFunction146(m_Team2MsgList[SkillMsgIndex].DefenderUserID,1)));
				m_hMsgRightSkillTextBox[i].SetText(m_Team2MsgList[SkillMsgIndex].SkillName);
				m_hMsgRightAttackerTextBox[i].SetTextColor(Team2Color);
				if ( UnknownFunction154(0,m_Team2MsgList[SkillMsgIndex].DefenderTeamID) )
				{
					m_hMsgRightDefenderTextBox[i].SetTextColor(Team1Color);
				} else {
					m_hMsgRightDefenderTextBox[i].SetTextColor(Team2Color);
				}
				m_hMsgRightWnd[i].ShowWindow();
				m_hMsgRightWnd[i].SetAlpha(255);
			}
			UnknownFunction163(i);
			goto JL03DA;
		}
		break;
		case 2:
		i = 0;
		if ( UnknownFunction150(i,6) )
		{
			m_hMsgLeftWnd[i].HideWindow();
			m_hMsgRightWnd[i].HideWindow();
			UnknownFunction163(i);
			goto JL0556;
		}
		break;
		default:
	}
	m_hOwnerWnd.KillTimer(2);
	m_hOwnerWnd.SetTimer(2,14000);
}

