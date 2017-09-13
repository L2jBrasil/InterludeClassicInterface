//================================================================================
// EventMatchGMWnd.
//================================================================================

class EventMatchGMWnd extends UICommonAPI;

var HtmlHandle m_hCommandHtml;
var WindowHandle m_hEventMatchGMCommandWnd;
var WindowHandle m_hEventMatchGMFenceWnd;
var ButtonHandle m_hCreateEventMatchButton;
var ButtonHandle m_hSetTeam1LeaderButton;
var ButtonHandle m_hLockTeam1Button;
var ButtonHandle m_hSetTeam2LeaderButton;
var ButtonHandle m_hLockTeam2Button;
var ButtonHandle m_hPauseButton;
var ButtonHandle m_hStartButton;
var ButtonHandle m_hSetScoreButton;
var ButtonHandle m_hSendAnnounceButton;
var ButtonHandle m_hShowCommandWndButton;
var ButtonHandle m_hSendGameEndMsgButton;
var ButtonHandle m_hSetFenceButton;
var ButtonHandle m_hTeam1FirecrackerButton;
var ButtonHandle m_hTeam2FirecrackerButton;
var ButtonHandle Summon2Team;
var ButtonHandle SetAllHeal;
var ButtonHandle DelayReset;
var ButtonHandle Summon1Team;
var EditBoxHandle m_hTeam1NameEditBox;
var EditBoxHandle m_hTeam2NameEditBox;
var EditBoxHandle m_hTeam1LeaderNameEditBox;
var EditBoxHandle m_hTeam2LeaderNameEditBox;
var EditBoxHandle m_hOptionFileEditBox;
var EditBoxHandle m_hCommandFileEditBox;
var EditBoxHandle m_hTeam1ScoreEditBox;
var EditBoxHandle m_hTeam2ScoreEditBox;
var EditBoxHandle m_hAnnounceEditBox;
var TextBoxHandle m_hMatchIDTextBox;
var ListCtrlHandle m_hTeam1ListCtrl;
var ListCtrlHandle m_hTeam2ListCtrl;
var int m_CountDown;
var int m_MatchID;
var bool m_Team1Locked;
var bool m_Team2Locked;
var bool m_Paused;
var string m_Team1Name;
var string m_Team2Name;
const TIMERID_CountDown= 1;

function OnLoad ()
{
	RegisterEvent(2180);
	RegisterEvent(2190);
	RegisterEvent(2250);
	RegisterEvent(2210);
	UnknownFunction113('HidingState');
	m_hEventMatchGMCommandWnd = GetHandle("EventMatchGMCommandWnd");
	m_hCommandHtml = HtmlHandle(GetHandle("EventMatchGMCommandWnd.HtmlCtrl"));
	m_hEventMatchGMFenceWnd = GetHandle("EventMatchGMFenceWnd");
	m_hCreateEventMatchButton = ButtonHandle(GetHandle("CreateEventMatchButton"));
	m_hSetTeam1LeaderButton = ButtonHandle(GetHandle("SetTeam1LeaderButton"));
	m_hLockTeam1Button = ButtonHandle(GetHandle("LockTeam1Button"));
	m_hSetTeam2LeaderButton = ButtonHandle(GetHandle("SetTeam2LeaderButton"));
	m_hLockTeam2Button = ButtonHandle(GetHandle("LockTeam2Button"));
	m_hPauseButton = ButtonHandle(GetHandle("PauseButton"));
	m_hStartButton = ButtonHandle(GetHandle("StartButton"));
	Summon2Team = ButtonHandle(GetHandle("Summon2Team"));
	SetAllHeal = ButtonHandle(GetHandle("SetAllHeal"));
	DelayReset = ButtonHandle(GetHandle("DelayReset"));
	Summon1Team = ButtonHandle(GetHandle("Summon1Team"));
	m_hSetScoreButton = ButtonHandle(GetHandle("SetScoreButton"));
	m_hSendAnnounceButton = ButtonHandle(GetHandle("SendAnnounceButton"));
	m_hShowCommandWndButton = ButtonHandle(GetHandle("ShowCommandWndButton"));
	m_hSendGameEndMsgButton = ButtonHandle(GetHandle("SendGameEndMsgButton"));
	m_hSetFenceButton = ButtonHandle(GetHandle("SetFenceButton"));
	m_hTeam1FirecrackerButton = ButtonHandle(GetHandle("Team1FirecrackerButton"));
	m_hTeam2FirecrackerButton = ButtonHandle(GetHandle("Team2FirecrackerButton"));
	m_hTeam1NameEditBox = EditBoxHandle(GetHandle("Team1NameEditBox"));
	m_hTeam2NameEditBox = EditBoxHandle(GetHandle("Team2NameEditBox"));
	m_hTeam1LeaderNameEditBox = EditBoxHandle(GetHandle("Team1LeaderNameEditBox"));
	m_hTeam2LeaderNameEditBox = EditBoxHandle(GetHandle("Team2LeaderNameEditBox"));
	m_hOptionFileEditBox = EditBoxHandle(GetHandle("OptionFileEditBox"));
	m_hCommandFileEditBox = EditBoxHandle(GetHandle("CommandFileEditBox"));
	m_hTeam1ScoreEditBox = EditBoxHandle(GetHandle("Team1ScoreEditBox"));
	m_hTeam2ScoreEditBox = EditBoxHandle(GetHandle("Team2ScoreEditBox"));
	m_hAnnounceEditBox = EditBoxHandle(GetHandle("AnnounceEditBox"));
	m_hMatchIDTextBox = TextBoxHandle(GetHandle("MatchIDTextBox"));
	m_hTeam1ListCtrl = ListCtrlHandle(GetHandle("Team1ListCtrl"));
	m_hTeam2ListCtrl = ListCtrlHandle(GetHandle("Team2ListCtrl"));
}

function OnClickButtonWithHandle (ButtonHandle a_ButtonHandle)
{
	switch (a_ButtonHandle)
	{
		case m_hCreateEventMatchButton:
		OnClickCreateEventMatchButton();
		break;
		case m_hSetTeam1LeaderButton:
		OnClickSetTeam1LeaderButton();
		break;
		case m_hLockTeam1Button:
		OnClickLockTeam1Button();
		break;
		case m_hSetTeam2LeaderButton:
		OnClickSetTeam2LeaderButton();
		break;
		case m_hLockTeam2Button:
		OnClickLockTeam2Button();
		break;
		case m_hPauseButton:
		OnClickPauseButton();
		break;
		case m_hStartButton:
		OnClickStartButton();
		break;
		case m_hSetScoreButton:
		OnClickSetScoreButton();
		break;
		case m_hSendAnnounceButton:
		OnClickSendAnnounceButton();
		break;
		case m_hShowCommandWndButton:
		OnClickShowCommandWndButton();
		break;
		case m_hSendGameEndMsgButton:
		OnClickSendGameEngMsgButton();
		break;
		case m_hSetFenceButton:
		OnClickSetFenceButton();
		break;
		case m_hTeam1FirecrackerButton:
		OnClickTeam1FirecrackerButton();
		break;
		case m_hTeam2FirecrackerButton:
		OnClickTeam2FirecrackerButton();
		break;
		case Summon2Team:
		OnClickSummon2Team();
		break;
		case SetAllHeal:
		OnClickSetAllHeal();
		break;
		case DelayReset:
		OnClickDelayReset();
		break;
		case Summon1Team:
		OnClickSummon1Team();
		break;
		default:
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2180:
		HandleShowEventMatchGMWnd();
		break;
		case 2190:
		HandleEventMatchCreated(_L2jBRVar17_);
		break;
		case 2250:
		HandleEventMatchUpdateTeamInfo(_L2jBRVar17_);
		break;
		case 2210:
		HandleEventMatchManage(_L2jBRVar17_);
		break;
		default:
	}
}

function OnHide ()
{
	UnknownFunction113('HidingState');
}

function OnClickCreateEventMatchButton ();

function OnClickSetTeam1LeaderButton ();

function OnClickLockTeam1Button ();

function OnClickSetTeam2LeaderButton ();

function OnClickLockTeam2Button ();

function OnClickPauseButton ();

function OnClickStartButton ();

function OnClickSetScoreButton ();

function OnClickSendAnnounceButton ();

function OnClickShowCommandWndButton ()
{
	local string CommandFileName;
	local int L2jBRVar15_;
	local string HtmlString;
	local int i;
	local string CommandString;

	CommandFileName = m_hCommandFileEditBox.GetString();
	if ( UnknownFunction122(CommandFileName,"") )
	{
		DialogShow(5,GetSystemMessage(1415));
		return;
	}
	RefreshINI(CommandFileName);
	if ( UnknownFunction129(GetINIInt("Cmd","CmdCnt",L2jBRVar15_,CommandFileName)) )
	{
		L2jBRVar15_ = 0;
	}
	HtmlString = "<html><body>";
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar15_) )
	{
		if ( GetINIString("Cmd",UnknownFunction112("Cmd",string(i)),CommandString,CommandFileName) )
		{
			HtmlString = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(HtmlString,"<a cmd = ""),CommandString),"">"),CommandString),"</a><br1>");
		}
		UnknownFunction163(i);
		goto JL0085;
	}
	HtmlString = UnknownFunction112(HtmlString,"</body></html>");
	m_hEventMatchGMCommandWnd.ShowWindow();
	m_hEventMatchGMCommandWnd.SetFocus();
	m_hCommandHtml.LoadHtmlFromString(HtmlString);
}

function OnClickSendGameEngMsgButton ();

function OnClickSetFenceButton ();

function OnClickTeam1FirecrackerButton ();

function OnClickTeam2FirecrackerButton ();

function NotifyFenceInfo (Vector a_Position, int a_XLength, int a_YLength);

function HandleShowEventMatchGMWnd ();

function HandleEventMatchCreated (string _L2jBRVar17_);

function HandleEventMatchUpdateTeamInfo (string _L2jBRVar17_)
{
	local int TeamID;
	local int i;
	local int PartyMemberCount;
	local LVDataRecord Record;
	local EventMatchUserData UserData;
	local ListCtrlHandle hTeamListCtrl;

	if ( ParseInt(_L2jBRVar17_,"TeamID",TeamID) )
	{
		PartyMemberCount = Class'EventMatchAPI'.GetPartyMemberCount(TeamID);
		switch (TeamID)
		{
			case 0:
			m_hLockTeam1Button.EnableWindow();
			if ( UnknownFunction155(0,PartyMemberCount) )
			{
				m_hLockTeam1Button.SetButtonName(1072);
				m_Team1Locked = True;
			}
			hTeamListCtrl = m_hTeam1ListCtrl;
			break;
			case 1:
			m_hLockTeam2Button.EnableWindow();
			if ( UnknownFunction155(0,PartyMemberCount) )
			{
				m_hLockTeam2Button.SetButtonName(1072);
				m_Team2Locked = True;
			}
			hTeamListCtrl = m_hTeam2ListCtrl;
			break;
			default:
			break;
		}
		hTeamListCtrl.DeleteAllItem();
		Record.LVDataList.Length = 3;
		i = 0;
		if ( UnknownFunction150(i,PartyMemberCount) )
		{
			if ( Class'EventMatchAPI'.GetUserData(TeamID,i,UserData) )
			{
				Record.LVDataList[0].szData = UserData.Username;
				Record.LVDataList[1].szData = string(UserData.UserLv);
				Record.LVDataList[2].szData = GetClassType(UserData.UserClass);
				hTeamListCtrl.InsertRecord(Record);
			}
			UnknownFunction163(i);
			goto JL00F6;
		}
		RefreshLockStatus();
	}
}

function RefreshLockStatus ();

function StartCountDown ();

state HidingState
{
	function BeginState ()
	{
		m_hOwnerWnd.HideWindow();
	}
	
	function EndState ()
	{
		m_hOwnerWnd.ShowWindow();
	}
	
	function HandleShowEventMatchGMWnd ()
	{
		UnknownFunction113('WaitingState');
	}
	
}

state WaitingState
{
	function BeginState ()
	{
		SetMatchID(-1);
		m_hLockTeam1Button.SetButtonName(1071);
		m_hLockTeam2Button.SetButtonName(1071);
		m_hTeam1ListCtrl.DeleteAllItem();
		m_hTeam2ListCtrl.DeleteAllItem();
		m_Team1Locked = False;
		m_Team2Locked = False;
		SetPause(False);
		m_hCreateEventMatchButton.SetButtonName(1068);
		m_hCreateEventMatchButton.EnableWindow();
		m_hSetTeam1LeaderButton.DisableWindow();
		m_hLockTeam1Button.DisableWindow();
		m_hSetTeam2LeaderButton.DisableWindow();
		m_hLockTeam2Button.DisableWindow();
		m_hPauseButton.DisableWindow();
		m_hStartButton.DisableWindow();
		m_hSetScoreButton.DisableWindow();
		m_hSendAnnounceButton.DisableWindow();
		m_hSendGameEndMsgButton.DisableWindow();
		m_hSetFenceButton.DisableWindow();
		m_hTeam1FirecrackerButton.DisableWindow();
		m_hTeam2FirecrackerButton.DisableWindow();
	}
	
	function OnClickCreateEventMatchButton ()
	{
		local string Team1Name;
		local string Team2Name;
	
		Team1Name = m_hTeam1NameEditBox.GetString();
		if ( UnknownFunction122(Team1Name,"") )
		{
			DialogShow(5,GetSystemMessage(1418));
			return;
		}
		Team2Name = m_hTeam2NameEditBox.GetString();
		if ( UnknownFunction122(Team2Name,"") )
		{
			DialogShow(5,GetSystemMessage(1419));
			return;
		}
		if ( UnknownFunction122(Team1Name,Team2Name) )
		{
			DialogShow(5,GetSystemMessage(1420));
			return;
		}
		m_Team1Name = Team1Name;
		m_Team2Name = Team2Name;
		m_hEventMatchGMFenceWnd.ShowWindow();
		m_hEventMatchGMFenceWnd.SetFocus();
	}
	
	function NotifyFenceInfo (Vector a_Position, int a_XLength, int a_YLength)
	{
		ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168(UnknownFunction168(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch create 1",m_Team1Name),m_Team2Name),string(int(a_Position.X))),string(int(a_Position.Y))),string(int(a_Position.Z))),string(a_XLength)),string(a_YLength)));
		UnknownFunction113('CreatingState');
	}
	
}

state CreatingState
{
	function BeginState ()
	{
		m_hCreateEventMatchButton.SetButtonName(1099);
		m_hCreateEventMatchButton.DisableWindow();
	}
	
	function HandleEventMatchCreated (string _L2jBRVar17_)
	{
		local int MatchID;
	
		if ( ParseInt(_L2jBRVar17_,"MatchID",MatchID) )
		{
			SetMatchID(MatchID);
			UnknownFunction113('CreatedState');
		}
	}
	
}

state CreatedState
{
	function BeginState ()
	{
		m_hCreateEventMatchButton.SetButtonName(1069);
		m_hStartButton.SetButtonName(1075);
		m_hCreateEventMatchButton.EnableWindow();
		m_hSetTeam1LeaderButton.EnableWindow();
		m_hLockTeam1Button.EnableWindow();
		m_hSetTeam2LeaderButton.EnableWindow();
		m_hLockTeam2Button.EnableWindow();
		m_hPauseButton.DisableWindow();
		RefreshLockStatus();
		m_hSetScoreButton.EnableWindow();
		m_hSendAnnounceButton.EnableWindow();
		m_hSendGameEndMsgButton.EnableWindow();
		m_hSetFenceButton.EnableWindow();
		m_hTeam1FirecrackerButton.EnableWindow();
		m_hTeam2FirecrackerButton.EnableWindow();
		SetPause(False);
	}
	
	function OnClickCreateEventMatchButton ()
	{
		RemoveEventMatch();
	}
	
	function OnClickSetTeam1LeaderButton ()
	{
		local UserInfo TargetInfo;
	
		if ( GetTargetInfo(TargetInfo) )
		{
			m_hTeam1LeaderNameEditBox.SetString(TargetInfo.Name);
		}
	}
	
	function OnClickLockTeam1Button ()
	{
		if ( m_Team1Locked )
		{
			ExecuteCommand(UnknownFunction168(UnknownFunction168("//eventmatch unlock",string(m_MatchID)),"1"));
			m_hLockTeam1Button.SetButtonName(1071);
			m_Team1Locked = False;
			m_hTeam1ListCtrl.DeleteAllItem();
			RefreshLockStatus();
		} else {
			ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch leader",string(m_MatchID)),"1"),m_hTeam1LeaderNameEditBox.GetString()));
			ExecuteCommand(UnknownFunction168(UnknownFunction168("//eventmatch lock",string(m_MatchID)),"1"));
		}
	}
	
	function OnClickSetTeam2LeaderButton ()
	{
		local UserInfo TargetInfo;
	
		if ( GetTargetInfo(TargetInfo) )
		{
			m_hTeam2LeaderNameEditBox.SetString(TargetInfo.Name);
		}
	}
	
	function OnClickLockTeam2Button ()
	{
		if ( m_Team2Locked )
		{
			ExecuteCommand(UnknownFunction168(UnknownFunction168("//eventmatch unlock",string(m_MatchID)),"2"));
			m_hLockTeam2Button.SetButtonName(1071);
			m_Team2Locked = False;
			m_hTeam2ListCtrl.DeleteAllItem();
			RefreshLockStatus();
		} else {
			ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch leader",string(m_MatchID)),"2"),m_hTeam2LeaderNameEditBox.GetString()));
			ExecuteCommand(UnknownFunction168(UnknownFunction168("//eventmatch lock",string(m_MatchID)),"2"));
		}
	}
	
	function RefreshLockStatus ()
	{
		if ( UnknownFunction130(m_Team1Locked,m_Team2Locked) )
		{
			m_hStartButton.EnableWindow();
		} else {
			m_hStartButton.DisableWindow();
		}
	}
	
	function OnClickSetFenceButton ()
	{
		SetFence();
	}
	
	function OnClickStartButton ()
	{
		local string OptionFile;
	
		OptionFile = m_hOptionFileEditBox.GetString();
		if ( UnknownFunction122(OptionFile,"") )
		{
			DialogShow(5,GetSystemMessage(1421));
			return;
		}
		RefreshINI(OptionFile);
		if ( UnknownFunction129(ApplySkillRule(OptionFile)) )
		{
			return;
		}
		if ( UnknownFunction129(ApplyItemRule(OptionFile)) )
		{
			return;
		}
		if ( UnknownFunction129(CheckBuffRule(OptionFile)) )
		{
			return;
		}
		UnknownFunction113('CountDownState');
	}
	
	function OnClickSetScoreButton ()
	{
		SetScore();
	}
	
	function OnClickSendAnnounceButton ()
	{
		SendAnnounce();
	}
	
	function OnClickSendGameEngMsgButton ()
	{
		SendGameEndMsg();
	}
	
	function OnClickTeam1FirecrackerButton ()
	{
		Firecracker(0);
	}
	
	function OnClickTeam2FirecrackerButton ()
	{
		Firecracker(1);
	}
	
	function OnCompleteEditBox (string a_EditBoxID)
	{
		if ( UnknownFunction122(a_EditBoxID,"AnnounceEditBox") )
		{
			SendAnnounce();
		}
	}
	
}

state CountDownState
{
	function BeginState ()
	{
		m_hStartButton.DisableWindow();
		m_hStartButton.SetButtonName(1102);
		m_hOwnerWnd.SetTimer(1,1000);
		m_CountDown = 4;
		ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch msg",string(m_MatchID)),string(8)),"NULL"));
	}
	
	function OnClickCreateEventMatchButton ()
	{
		RemoveEventMatch();
	}
	
	function OnClickSetFenceButton ()
	{
		SetFence();
	}
	
	function OnTimer (int a_TimerID)
	{
		switch (a_TimerID)
		{
			case 1:
			switch (m_CountDown)
			{
				case 4:
				ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch msg",string(m_MatchID)),string(7)),"NULL"));
				m_CountDown = 3;
				break;
				case 3:
				ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch msg",string(m_MatchID)),string(6)),"NULL"));
				m_CountDown = 2;
				break;
				case 2:
				ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch msg",string(m_MatchID)),string(5)),"NULL"));
				m_CountDown = 1;
				break;
				case 1:
				ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch msg",string(m_MatchID)),string(4)),"NULL"));
				m_CountDown = 0;
				break;
				case 0:
				ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch msg",string(m_MatchID)),string(2)),"NULL"));
				if ( UnknownFunction129(ApplyBuffRule()) )
				{
					return;
				}
				ExecuteCommand(UnknownFunction168("//eventmatch start",string(m_MatchID)));
				UnknownFunction113('GamingState');
				default:
				m_hOwnerWnd.KillTimer(1);
				m_CountDown = -1;
				break;
			}
			break;
			default:
		}
	}
	
	function OnClickSetScoreButton ()
	{
		SetScore();
	}
	
	function OnClickSendAnnounceButton ()
	{
		SendAnnounce();
	}
	
	function OnClickSendGameEngMsgButton ()
	{
		SendGameEndMsg();
	}
	
	function OnClickTeam1FirecrackerButton ()
	{
		Firecracker(0);
	}
	
	function OnClickTeam2FirecrackerButton ()
	{
		Firecracker(1);
	}
	
	function OnCompleteEditBox (string a_EditBoxID)
	{
		if ( UnknownFunction122(a_EditBoxID,"AnnounceEditBox") )
		{
			SendAnnounce();
		}
	}
	
}

state GamingState
{
	function BeginState ()
	{
		m_hPauseButton.SetButtonName(1073);
		m_hStartButton.SetButtonName(1076);
		m_hCreateEventMatchButton.EnableWindow();
		m_hSetTeam1LeaderButton.DisableWindow();
		m_hLockTeam1Button.DisableWindow();
		m_hSetTeam2LeaderButton.DisableWindow();
		m_hLockTeam2Button.DisableWindow();
		m_hPauseButton.EnableWindow();
		m_hStartButton.EnableWindow();
		m_hSetScoreButton.EnableWindow();
		m_hSendAnnounceButton.EnableWindow();
		m_hSendGameEndMsgButton.EnableWindow();
		m_hSetFenceButton.EnableWindow();
		m_hTeam1FirecrackerButton.EnableWindow();
		m_hTeam2FirecrackerButton.EnableWindow();
	}
	
	function OnClickCreateEventMatchButton ()
	{
		RemoveEventMatch();
	}
	
	function OnClickStartButton ()
	{
		ExecuteCommand(UnknownFunction168("//eventmatch dispelall",string(m_MatchID)));
		ExecuteCommand(UnknownFunction168("//eventmatch end",string(m_MatchID)));
		ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch msg",string(m_MatchID)),string(1)),"NULL"));
		UnknownFunction113('CreatedState');
	}
	
	function OnClickSetFenceButton ()
	{
		SetFence();
	}
	
	function OnClickPauseButton ()
	{
		SetPause(UnknownFunction129(m_Paused),True);
	}
	
	function OnClickSetScoreButton ()
	{
		SetScore();
	}
	
	function OnClickSendAnnounceButton ()
	{
		SendAnnounce();
	}
	
	function OnClickSendGameEngMsgButton ()
	{
		SendGameEndMsg();
	}
	
	function OnClickTeam1FirecrackerButton ()
	{
		Firecracker(0);
	}
	
	function OnClickTeam2FirecrackerButton ()
	{
		Firecracker(1);
	}
	
	function OnCompleteEditBox (string a_EditBoxID)
	{
		if ( UnknownFunction122(a_EditBoxID,"AnnounceEditBox") )
		{
			SendAnnounce();
		}
	}
	
}

function bool ApplySkillRule (string a_OptionFile)
{
	local int DefaultAllow;
	local string Command;
	local int i;
	local int L2jBRVar15_;
	local int Id;

	if ( UnknownFunction129(GetINIBool("Skill","DefaultAllow",DefaultAllow,a_OptionFile)) )
	{
		DialogShow(5,GetSystemMessage(1425));
		return False;
	}
	Command = UnknownFunction168("//eventmatch skill_rule",string(m_MatchID));
	if ( UnknownFunction154(1,DefaultAllow) )
	{
		Command = UnknownFunction168(Command,"allow_all");
	} else {
		Command = UnknownFunction168(Command,"deny_all");
	}
	if ( UnknownFunction129(GetINIInt("Skill","ExpSkillCnt",L2jBRVar15_,a_OptionFile)) )
	{
		L2jBRVar15_ = 0;
	}
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar15_) )
	{
		if ( UnknownFunction129(GetINIInt("Skill",UnknownFunction112("ExpSkillID",string(i)),Id,a_OptionFile)) )
		{
			DialogShow(5,MakeFullSystemMsg(GetSystemMessage(1427),string(i)));
			return False;
		}
		if ( UnknownFunction154(1,DefaultAllow) )
		{
			Command = UnknownFunction168(Command,"D");
		} else {
			Command = UnknownFunction168(Command,"A");
		}
		Command = UnknownFunction112(Command,string(Id));
		UnknownFunction163(i);
		goto JL00DB;
	}
	ExecuteCommand(Command);
	return True;
}

function bool ApplyItemRule (string a_OptionFile)
{
	local int DefaultAllow;
	local string Command;
	local int i;
	local int L2jBRVar15_;
	local int Id;

	if ( UnknownFunction129(GetINIBool("Item","DefaultAllow",DefaultAllow,a_OptionFile)) )
	{
		DialogShow(5,GetSystemMessage(1425));
		return False;
	}
	Command = UnknownFunction168("//eventmatch item_rule",string(m_MatchID));
	if ( UnknownFunction154(1,DefaultAllow) )
	{
		Command = UnknownFunction168(Command,"allow_all");
	} else {
		Command = UnknownFunction168(Command,"deny_all");
	}
	if ( UnknownFunction129(GetINIInt("Item","ExpItemCnt",L2jBRVar15_,a_OptionFile)) )
	{
		L2jBRVar15_ = 0;
	}
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar15_) )
	{
		if ( UnknownFunction129(GetINIInt("Item",UnknownFunction112("ExpItemID",string(i)),Id,a_OptionFile)) )
		{
			DialogShow(5,MakeFullSystemMsg(GetSystemMessage(1427),string(i)));
			return False;
		}
		if ( UnknownFunction154(1,DefaultAllow) )
		{
			Command = UnknownFunction168(Command,"D");
		} else {
			Command = UnknownFunction168(Command,"A");
		}
		Command = UnknownFunction112(Command,string(Id));
		UnknownFunction163(i);
		goto JL00D7;
	}
	ExecuteCommand(Command);
	return True;
}

function bool ApplyBuffRule ()
{
	local string OptionFile;
	local string Command;
	local int i;
	local int L2jBRVar15_;
	local int Level;
	local int Id;

	OptionFile = m_hOptionFileEditBox.GetString();
	if ( UnknownFunction129(GetINIInt("Buff","BuffCnt",L2jBRVar15_,OptionFile)) )
	{
		DialogShow(5,GetSystemMessage(1422));
		return False;
	}
	if ( UnknownFunction153(0,L2jBRVar15_) )
	{
		return True;
	}
	Command = UnknownFunction168("//eventmatch useskill",string(m_MatchID));
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar15_) )
	{
		if ( UnknownFunction129(GetINIInt("Buff",UnknownFunction112("BuffID",string(i)),Id,OptionFile)) )
		{
			DialogShow(5,MakeFullSystemMsg(GetSystemMessage(1423),string(i)));
			return False;
		}
		if ( UnknownFunction129(GetINIInt("Buff",UnknownFunction112("BuffLv",string(i)),Level,OptionFile)) )
		{
			DialogShow(5,MakeFullSystemMsg(GetSystemMessage(1424),string(i)));
			return False;
		}
		Command = UnknownFunction168(UnknownFunction168(Command,string(Id)),string(Level));
		UnknownFunction163(i);
		goto JL0088;
	}
	ExecuteCommand(Command);
	return True;
}

function bool CheckBuffRule (string a_OptionFile)
{
	local int i;
	local int L2jBRVar15_;
	local int Level;
	local int Id;

	if ( UnknownFunction129(GetINIInt("Buff","BuffCnt",L2jBRVar15_,a_OptionFile)) )
	{
		DialogShow(5,GetSystemMessage(1422));
		return False;
	}
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar15_) )
	{
		if ( UnknownFunction129(GetINIInt("Buff",UnknownFunction112("BuffID",string(i)),Id,a_OptionFile)) )
		{
			DialogShow(5,MakeFullSystemMsg(GetSystemMessage(1423),string(i)));
			return False;
		}
		if ( UnknownFunction129(GetINIInt("Buff",UnknownFunction112("BuffLv",string(i)),Level,a_OptionFile)) )
		{
			DialogShow(5,MakeFullSystemMsg(GetSystemMessage(1424),string(i)));
			return False;
		}
		UnknownFunction163(i);
		goto JL0040;
	}
	return True;
}

function SetFence ()
{
	if ( UnknownFunction122(m_hSetFenceButton.GetButtonName(),GetSystemString(1081)) )
	{
		m_hSetFenceButton.SetButtonName(1082);
		ExecuteCommand(UnknownFunction168(UnknownFunction168("//eventmatch fence",string(m_MatchID)),"2"));
	} else {
		if ( UnknownFunction122(m_hSetFenceButton.GetButtonName(),GetSystemString(1082)) )
		{
			m_hSetFenceButton.SetButtonName(1081);
			ExecuteCommand(UnknownFunction168(UnknownFunction168("//eventmatch fence",string(m_MatchID)),"1"));
		}
	}
}

function RemoveEventMatch ()
{
	m_Team1Name = "";
	m_Team2Name = "";
	ExecuteCommand(UnknownFunction168("//eventmatch remove",string(m_MatchID)));
	UnknownFunction113('WaitingState');
}

function SetScore ()
{
	ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch score",string(m_MatchID)),m_hTeam1ScoreEditBox.GetString()),m_hTeam2ScoreEditBox.GetString()));
}

function SendAnnounce ()
{
	ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch msg",string(m_MatchID)),string(0))," "),m_hAnnounceEditBox.GetString())," "));
	m_hAnnounceEditBox.Clear();
}

function SendGameEndMsg ()
{
	ExecuteCommand(UnknownFunction168(UnknownFunction168(UnknownFunction168("//eventmatch msg",string(m_MatchID)),string(3)),"NULL"));
}

function Firecracker (int a_TeamID)
{
	local int PartyMemberCount;
	local int i;
	local EventMatchUserData UserData;

	PartyMemberCount = Class'EventMatchAPI'.GetPartyMemberCount(a_TeamID);
	i = 0;
	if ( UnknownFunction150(i,PartyMemberCount) )
	{
		if ( Class'EventMatchAPI'.GetUserData(a_TeamID,i,UserData) )
		{
			ExecuteCommand(UnknownFunction168("//eventmatch firecracker",UserData.Username));
		}
		UnknownFunction163(i);
		goto JL0021;
	}
}

function HandleEventMatchManage (string _L2jBRVar17_)
{
	local int MatchID;
	local int MatchStat;
	local int FenceStat;
	local string Team1Name;
	local string Team2Name;
	local int Team1Stat;
	local int Team2Stat;

	ParseInt(_L2jBRVar17_,"MatchID",MatchID);
	ParseInt(_L2jBRVar17_,"MatchStat",MatchStat);
	ParseInt(_L2jBRVar17_,"FenceStat",FenceStat);
	ParseString(_L2jBRVar17_,"Team1Name",Team1Name);
	ParseString(_L2jBRVar17_,"Team2Name",Team2Name);
	ParseInt(_L2jBRVar17_,"Team1Stat",Team1Stat);
	ParseInt(_L2jBRVar17_,"Team2Stat",Team2Stat);
	SetMatchID(MatchID);
	switch (MatchStat)
	{
		case 1:
		UnknownFunction113('CreatedState');
		break;
		case 2:
		UnknownFunction113('GamingState');
		SetPause(False);
		break;
		case 3:
		UnknownFunction113('GamingState');
		SetPause(True);
		break;
		default:
	}
	switch (FenceStat)
	{
		case 0:
		case 1:
		m_hSetFenceButton.SetButtonName(1081);
		break;
		case 2:
		m_hSetFenceButton.SetButtonName(1082);
		break;
		default:
	}
	if ( UnknownFunction154(0,Team1Stat) )
	{
		m_hLockTeam1Button.SetButtonName(1071);
		m_Team1Locked = False;
	} else {
		m_hLockTeam1Button.SetButtonName(1072);
		m_Team1Locked = True;
	}
	if ( UnknownFunction154(0,Team2Stat) )
	{
		m_hLockTeam2Button.SetButtonName(1071);
		m_Team2Locked = False;
	} else {
		m_hLockTeam2Button.SetButtonName(1072);
		m_Team2Locked = True;
	}
	m_hTeam1NameEditBox.SetString(Team1Name);
	m_hTeam2NameEditBox.SetString(Team2Name);
	m_hTeam1ListCtrl.DeleteAllItem();
	m_hTeam2ListCtrl.DeleteAllItem();
}

function SetPause (bool a_Pause, optional bool a_SendToServer)
{
	Debug(UnknownFunction168(UnknownFunction168(UnknownFunction168("SetPause",string(a_Pause)),"m_Paused"),string(m_Paused)));
	if ( UnknownFunction242(m_Paused,a_Pause) )
	{
		return;
	}
	if ( a_Pause )
	{
		m_hPauseButton.SetButtonName(1074);
		if ( a_SendToServer )
		{
			ExecuteCommand(UnknownFunction168("//eventmatch pause",string(m_MatchID)));
		}
	} else {
		m_hPauseButton.SetButtonName(1073);
		if ( a_SendToServer )
		{
			ExecuteCommand(UnknownFunction168("//eventmatch start",string(m_MatchID)));
		}
	}
	m_Paused = a_Pause;
}

function SetMatchID (int a_MatchID)
{
	m_MatchID = a_MatchID;
	if ( UnknownFunction154(-1,m_MatchID) )
	{
		m_hMatchIDTextBox.SetText("");
	} else {
		m_hMatchIDTextBox.SetText(string(m_MatchID));
	}
}

function OnClickSummon2Team ()
{
	local int i;
	local int PartyMemberCount;
	local EventMatchUserData UserData;

	PartyMemberCount = Class'EventMatchAPI'.GetPartyMemberCount(1);
	i = 0;
	if ( UnknownFunction150(i,PartyMemberCount) )
	{
		if ( Class'EventMatchAPI'.GetUserData(1,i,UserData) )
		{
			ExecuteCommand(UnknownFunction168("//소환",UserData.Username));
		}
		UnknownFunction163(i);
		goto JL001D;
	}
}

function OnClickSetAllHeal ()
{
	local int PartyMemberCount0;
	local int PartyMemberCount1;
	local EventMatchUserData UserData;
	local int i;

	PartyMemberCount0 = Class'EventMatchAPI'.GetPartyMemberCount(0);
	PartyMemberCount1 = Class'EventMatchAPI'.GetPartyMemberCount(1);
	i = 0;
	if ( UnknownFunction150(i,PartyMemberCount0) )
	{
		if ( Class'EventMatchAPI'.GetUserData(0,i,UserData) )
		{
			ExecuteCommand(UnknownFunction168("//건강",UserData.Username));
		}
		UnknownFunction163(i);
		goto JL0033;
	}
	i = 1;
	if ( UnknownFunction150(i,PartyMemberCount1) )
	{
		if ( Class'EventMatchAPI'.GetUserData(1,i,UserData) )
		{
			ExecuteCommand(UnknownFunction168("//건강",UserData.Username));
		}
		UnknownFunction163(i);
		goto JL008A;
	}
}

function OnClickDelayReset ()
{
	local int PartyMemberCount0;
	local int PartyMemberCount1;
	local EventMatchUserData UserData;
	local int i;

	PartyMemberCount0 = Class'EventMatchAPI'.GetPartyMemberCount(0);
	PartyMemberCount1 = Class'EventMatchAPI'.GetPartyMemberCount(1);
	i = 0;
	if ( UnknownFunction150(i,PartyMemberCount0) )
	{
		if ( Class'EventMatchAPI'.GetUserData(0,i,UserData) )
		{
			ExecuteCommand(UnknownFunction168("//타겟",UserData.Username));
			ExecuteCommand("//remove_skill_delay all");
		}
		UnknownFunction163(i);
		goto JL0033;
	}
	i = 1;
	if ( UnknownFunction150(i,PartyMemberCount1) )
	{
		if ( Class'EventMatchAPI'.GetUserData(1,i,UserData) )
		{
			ExecuteCommand(UnknownFunction168("//타겟",UserData.Username));
			ExecuteCommand("//remove_skill_delay all");
		}
		UnknownFunction163(i);
		goto JL00AA;
	}
}

function OnClickSummon1Team ()
{
	local int PartyMemberCount;
	local int i;
	local EventMatchUserData UserData;

	PartyMemberCount = Class'EventMatchAPI'.GetPartyMemberCount(0);
	i = 0;
	if ( UnknownFunction150(i,PartyMemberCount) )
	{
		if ( Class'EventMatchAPI'.GetUserData(0,i,UserData) )
		{
			ExecuteCommand(UnknownFunction168("//소환",UserData.Username));
		}
		UnknownFunction163(i);
		goto JL001D;
	}
}

