//================================================================================
// PartyMatchWnd.
//================================================================================

class PartyMatchWnd extends UIScript;

var int m_CurrentPageNum;
var int CompletelyQuitPartyMatching;
var bool bOpenStateLobby;

function OnLoad ()
{
	RegisterEvent(1540);
	RegisterEvent(1570);
	RegisterEvent(1550);
	m_CurrentPageNum = 0;
	CompletelyQuitPartyMatching = 0;
	bOpenStateLobby = False;
	Class'UIAPI_COMBOBOX'.SetSelectedNum("PartyMatchWnd.LocationFilterComboBox",1);
	Class'UIAPI_COMBOBOX'.SetSelectedNum("PartyMatchWnd.LevelFilterComboBox",1);
}

function OnShow ()
{
	Class'UIAPI_LISTCTRL'.ShowScrollBar("PartyMatchWnd.PartyMatchListCtrl",False);
}

function OnSendPacketWhenHiding ()
{
	Class'PartyMatchAPI'.RequestExitPartyMatchingWaitingRoom();
}

function OnHide ()
{
	Class'UIAPI_WINDOW'.HideWindow("PartyMatchMakeRoomWnd");
}

function OnEvent (int L2jBRVar16, string L2jBRVar1)
{
	local PartyMatchMakeRoomWnd L2jBRVar21;

	L2jBRVar21 = PartyMatchMakeRoomWnd(GetScript("PartyMatchMakeRoomWnd"));
	switch (L2jBRVar16)
	{
		case 1540:
		if ( UnknownFunction154(CompletelyQuitPartyMatching,1) )
		{
			Class'PartyMatchAPI'.RequestExitPartyMatchingWaitingRoom();
			Class'UIAPI_WINDOW'.HideWindow("PartyMatchWnd");
			L2jBRVar21.OnCancelButtonClick();
			CompletelyQuitPartyMatching = 0;
			SetWaitListWnd(False);
		} else {
			UpdateWaitListWnd();
			if ( UnknownFunction242(Class'UIAPI_WINDOW'.IsShowWindow("PartyMatchWnd"),False) )
			{
				Class'UIAPI_WINDOW'.ShowWindow("PartyMatchWnd");
				Class'UIAPI_LISTCTRL'.ShowScrollBar("PartyMatchWnd.PartyMatchListCtrl",False);
			}
			Class'UIAPI_WINDOW'.SetFocus("PartyMatchWnd");
		}
		break;
		case 1570:
		HandlePartyMatchList(L2jBRVar1);
		break;
		case 1550:
		Class'UIAPI_WINDOW'.HideWindow("PartyMatchWnd");
		break;
		default:
	}
}

function OnButtonTimer (bool bExpired)
{
	if ( bExpired )
	{
		Class'UIAPI_BUTTON'.EnableWindow("PartyMatchWnd.PrevBtn");
		Class'UIAPI_BUTTON'.EnableWindow("PartyMatchWnd.NextBtn");
		Class'UIAPI_BUTTON'.EnableWindow("PartyMatchWnd.AutoJoinBtn");
		Class'UIAPI_BUTTON'.EnableWindow("PartyMatchWnd.RefreshBtn");
	} else {
		Class'UIAPI_BUTTON'.DisableWindow("PartyMatchWnd.PrevBtn");
		Class'UIAPI_BUTTON'.DisableWindow("PartyMatchWnd.NextBtn");
		Class'UIAPI_BUTTON'.DisableWindow("PartyMatchWnd.AutoJoinBtn");
		Class'UIAPI_BUTTON'.DisableWindow("PartyMatchWnd.RefreshBtn");
	}
}

function HandlePartyMatchList (string L2jBRVar1)
{
	local int L2jBRVar15_;
	local int i;
	local LVDataRecord Record;
	local int L2jBRVar40;
	local string PartyRoomName;
	local string PartyLeader;
	local int ZoneID;
	local int MinLevel;
	local int MaxLevel;
	local int MinMemberCnt;
	local int MaxMemberCnt;

	Class'UIAPI_LISTCTRL'.DeleteAllItem("PartyMatchWnd.PartyMatchListCtrl");
	Record.LVDataList.Length = 6;
	ParseInt(L2jBRVar1,"PageNum",m_CurrentPageNum);
	ParseInt(L2jBRVar1,"RoomCount",L2jBRVar15_);
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar15_) )
	{
		ParseInt(L2jBRVar1,UnknownFunction112("RoomNum_",string(i)),L2jBRVar40);
		ParseString(L2jBRVar1,UnknownFunction112("Leader_",string(i)),PartyLeader);
		ParseInt(L2jBRVar1,UnknownFunction112("ZoneID_",string(i)),ZoneID);
		ParseInt(L2jBRVar1,UnknownFunction112("MinLevel_",string(i)),MinLevel);
		ParseInt(L2jBRVar1,UnknownFunction112("MaxLevel_",string(i)),MaxLevel);
		ParseInt(L2jBRVar1,UnknownFunction112("CurMember_",string(i)),MinMemberCnt);
		ParseInt(L2jBRVar1,UnknownFunction112("MaxMember_",string(i)),MaxMemberCnt);
		ParseString(L2jBRVar1,UnknownFunction112("RoomName_",string(i)),PartyRoomName);
		Record.LVDataList[0].szData = string(L2jBRVar40);
		Record.LVDataList[1].szData = PartyLeader;
		Record.LVDataList[2].szData = PartyRoomName;
		Record.LVDataList[3].szData = GetZoneNameWithZoneID(ZoneID);
		Record.LVDataList[4].szData = UnknownFunction112(UnknownFunction112(string(MinLevel),"-"),string(MaxLevel));
		Record.LVDataList[5].szData = UnknownFunction112(UnknownFunction112(string(MinMemberCnt),"/"),string(MaxMemberCnt));
		Class'UIAPI_LISTCTRL'.InsertRecord("PartyMatchWnd.PartyMatchListCtrl",Record);
		UnknownFunction163(i);
		goto JL007A;
	}
}

function OnClickButton (string a_strButtonName)
{
	switch (a_strButtonName)
	{
		case "RefreshBtn":
		OnRefreshBtnClick();
		break;
		case "PrevBtn":
		OnPrevBtnClick();
		break;
		case "NextBtn":
		OnNextBtnClick();
		break;
		case "MakeRoomBtn":
		OnMakeRoomBtnClick();
		break;
		case "AutoJoinBtn":
		OnAutoJoinBtnClick();
		break;
		case "WaitListButton":
		OnWaitListButton();
		break;
		default:
	}
}

function OnWaitListButton ()
{
	ToggleWaitListWnd();
	UpdateWaitListWnd();
}

function OnRefreshBtnClick ()
{
	RequestPartyRoomListLocal(1);
}

function OnPrevBtnClick ()
{
	local int WantedPageNum;

	if ( UnknownFunction153(1,m_CurrentPageNum) )
	{
		WantedPageNum = 1;
	} else {
		WantedPageNum = UnknownFunction147(m_CurrentPageNum,1);
	}
	RequestPartyRoomListLocal(WantedPageNum);
}

function OnNextBtnClick ()
{
	RequestPartyRoomListLocal(UnknownFunction146(m_CurrentPageNum,1));
}

function RequestPartyRoomListLocal (int a_Page)
{
	Class'PartyMatchAPI'.RequestPartyRoomList(a_Page,GetLocationFilter(),GetLevelFilter());
}

function OnMakeRoomBtnClick ()
{
	local PartyMatchMakeRoomWnd L2jBRVar21;
	local UserInfo PlayerInfo;

	L2jBRVar21 = PartyMatchMakeRoomWnd(GetScript("PartyMatchMakeRoomWnd"));
	if ( UnknownFunction119(L2jBRVar21,None) )
	{
		L2jBRVar21.SetRoomNumber(0);
		L2jBRVar21.SetTitle(GetSystemMessage(1398));
		L2jBRVar21.SetMaxPartyMemberCount(12);
		if ( GetPlayerInfo(PlayerInfo) )
		{
			if ( UnknownFunction151(UnknownFunction147(PlayerInfo.nLevel,5),0) )
			{
				L2jBRVar21.SetMinLevel(UnknownFunction147(PlayerInfo.nLevel,5));
			} else {
				L2jBRVar21.SetMinLevel(1);
			}
			if ( UnknownFunction152(UnknownFunction146(PlayerInfo.nLevel,5),80) )
			{
				L2jBRVar21.SetMaxLevel(UnknownFunction146(PlayerInfo.nLevel,5));
			} else {
				L2jBRVar21.SetMaxLevel(80);
			}
		}
	}
	L2jBRVar21.InviteState = 0;
	Class'UIAPI_WINDOW'.ShowWindow("PartyMatchMakeRoomWnd");
	Class'UIAPI_WINDOW'.SetFocus("PartyMatchMakeRoomWnd");
}

function OnDBClickListCtrlRecord (string a_ListCtrlName)
{
	local int SelectedRecordIndex;
	local LVDataRecord Record;

	if ( UnknownFunction123(a_ListCtrlName,"PartyMatchListCtrl") )
	{
		return;
	}
	SelectedRecordIndex = Class'UIAPI_LISTCTRL'.GetSelectedIndex("PartyMatchWnd.PartyMatchListCtrl");
	Record = Class'UIAPI_LISTCTRL'.GetRecord("PartyMatchWnd.PartyMatchListCtrl",SelectedRecordIndex);
	Class'PartyMatchAPI'.RequestJoinPartyRoom(int(Record.LVDataList[0].szData));
}

function OnAutoJoinBtnClick ()
{
	Class'PartyMatchAPI'.RequestJoinPartyRoomAuto(m_CurrentPageNum,GetLocationFilter(),GetLevelFilter());
}

function int GetLocationFilter ()
{
	return Class'UIAPI_COMBOBOX'.GetReserved("PartyMatchWnd.LocationFilterComboBox",Class'UIAPI_COMBOBOX'.GetSelectedNum("PartyMatchWnd.LocationFilterComboBox"));
}

function int GetLevelFilter ()
{
	return Class'UIAPI_COMBOBOX'.GetSelectedNum("PartyMatchWnd.LevelFilterComboBox");
}

function SetWaitListWnd (bool bShow)
{
	bOpenStateLobby = bShow;
}

function ShowHideWaitListWnd ()
{
	if ( bOpenStateLobby )
	{
		Class'UIAPI_WINDOW'.ShowWindow("PartyMatchWnd.PartyMatchOutWaitListWnd");
		Class'UIAPI_WINDOW'.ShowWindow("PartyMatchWnd.PartyMatchWaitListWnd");
	} else {
		Class'UIAPI_WINDOW'.HideWindow("PartyMatchWnd.PartyMatchOutWaitListWnd");
		Class'UIAPI_WINDOW'.HideWindow("PartyMatchWnd.PartyMatchWaitListWnd");
	}
}

function UpdateWaitListWnd ()
{
	local int MinLevel;
	local int MaxLevel;

	if ( IsShowWaitListWnd() )
	{
		MinLevel = int(Class'UIAPI_EDITBOX'.GetString("PartyMatchOutWaitListWnd.MinLevel"));
		MaxLevel = int(Class'UIAPI_EDITBOX'.GetString("PartyMatchOutWaitListWnd.MaxLevel"));
		Class'PartyMatchAPI'.RequestPartyMatchWaitList(1,MinLevel,MaxLevel,1);
	}
}

function ToggleWaitListWnd ()
{
	bOpenStateLobby = UnknownFunction129(bOpenStateLobby);
	ShowHideWaitListWnd();
}

function bool IsShowWaitListWnd ()
{
	return bOpenStateLobby;
}

