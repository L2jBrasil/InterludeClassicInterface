//================================================================================
// PartyMatchRoomWnd.
//================================================================================

class PartyMatchRoomWnd extends PartyMatchWndCommon;

var int RoomNumber;
var int CurPartyMemberCount;
var int MaxPartyMemberCount;
var int MinLevel;
var int MaxLevel;
var int LootingMethodID;
var int RoomZoneID;
var int MyMembershipType;
var string RoomTitle;
var bool m_bPartyMatchRoomStart;
var bool m_bRequestExitPartyRoom;

function OnLoad ()
{
	RegisterEvent(40);
	RegisterEvent(1550);
	RegisterEvent(1560);
	RegisterEvent(1580);
	RegisterEvent(1590);
	RegisterEvent(1600);
	RegisterEvent(1630);
	m_bPartyMatchRoomStart = False;
	m_bRequestExitPartyRoom = False;
}

function OnSendPacketWhenHiding ()
{
	local PartyMatchWnd L2jBRVar21;

	L2jBRVar21 = PartyMatchWnd(GetScript("PartyMatchWnd"));
	if ( UnknownFunction119(L2jBRVar21,None) )
	{
		L2jBRVar21.CompletelyQuitPartyMatching = 1;
		L2jBRVar21.SetWaitListWnd(False);
		L2jBRVar21.ShowHideWaitListWnd();
	}
	ExitPartyRoom();
}

function OnEnterState (name a_PreStateName)
{
	if ( m_bPartyMatchRoomStart )
	{
		Class'UIAPI_WINDOW'.ShowWindow("PartyMatchRoomWnd");
		Class'UIAPI_WINDOW'.SetFocus("PartyMatchRoomWnd");
	}
}

function OnEvent (int L2jBRVar16, string L2jBRVar1)
{
	switch (L2jBRVar16)
	{
		case 1630:
		if ( Class'UIAPI_WINDOW'.IsMinimizedWindow("PartyMatchRoomWnd") )
		{
			Class'UIAPI_WINDOW'.ShowWindow("PartyMatchRoomWnd");
		}
		Class'UIAPI_WINDOW'.SetFocus("PartyMatchRoomWnd");
		break;
		case 1550:
		HandlePartyMatchRoomStart(L2jBRVar1);
		break;
		case 1560:
		HandlePartyMatchRoomClose();
		break;
		case 1580:
		HandlePartyMatchRoomMember(L2jBRVar1);
		break;
		case 1590:
		HandlePartyMatchRoomMemberUpdate(L2jBRVar1);
		break;
		case 1600:
		HandlePartyMatchChatMessage(L2jBRVar1);
		break;
		case 40:
		L2jBRFunction4();
		break;
		default:
	}
}

function L2jBRFunction4 ()
{
	m_bPartyMatchRoomStart = False;
}

function ExitPartyRoom ()
{
	m_bRequestExitPartyRoom = True;
	switch (MyMembershipType)
	{
		case 0:
		case 2:
		Class'PartyMatchAPI'.RequestWithdrawPartyRoom(RoomNumber);
		break;
		case 1:
		Class'PartyMatchAPI'.RequestDismissPartyRoom(RoomNumber);
		break;
		default:
	}
}

function HandlePartyMatchRoomStart (string L2jBRVar1)
{
	local Rect rectWnd;

	ParseInt(L2jBRVar1,"RoomNum",RoomNumber);
	ParseInt(L2jBRVar1,"MaxMember",MaxPartyMemberCount);
	ParseInt(L2jBRVar1,"MinLevel",MinLevel);
	ParseInt(L2jBRVar1,"MaxLevel",MaxLevel);
	ParseInt(L2jBRVar1,"LootingMethodID",LootingMethodID);
	ParseInt(L2jBRVar1,"ZoneID",RoomZoneID);
	ParseString(L2jBRVar1,"RoomName",RoomTitle);
	UpdateData(True);
	m_bPartyMatchRoomStart = True;
	Class'UIAPI_TEXTLISTBOX'.Clear("PartyMatchRoomWnd.PartyRoomChatWindow");
	if ( Class'UIAPI_WINDOW'.IsMinimizedWindow("PartyMatchRoomWnd") )
	{
		Class'UIAPI_WINDOW'.NotifyAlarm("PartyMatchRoomWnd");
	} else {
		rectWnd = Class'UIAPI_WINDOW'.GetRect("PartyMatchWnd");
		Class'UIAPI_WINDOW'.MoveTo("PartyMatchRoomWnd",rectWnd.nX,rectWnd.nY);
		UpdateWaitListWnd();
		Class'UIAPI_WINDOW'.ShowWindow("PartyMatchRoomWnd");
		Class'UIAPI_WINDOW'.SetFocus("PartyMatchRoomWnd");
	}
}

function UpdateWaitListWnd ()
{
	local PartyMatchWnd L2jBRVar21;

	L2jBRVar21 = PartyMatchWnd(GetScript("PartyMatchWnd"));
	if ( UnknownFunction119(L2jBRVar21,None) )
	{
		if ( L2jBRVar21.IsShowWaitListWnd() )
		{
			Class'PartyMatchAPI'.RequestPartyMatchWaitList(1,MinLevel,MaxLevel,0);
		}
	}
}

function OnHide ()
{
	Class'UIAPI_WINDOW'.HideWindow("PartyMatchMakeRoomWnd");
}

function HandlePartyMatchRoomClose ()
{
	local PartyMatchWnd L2jBRVar21;
	local PartyMatchMakeRoomWnd Script2;

	m_bPartyMatchRoomStart = False;
	Class'UIAPI_WINDOW'.HideWindow("PartyMatchRoomWnd");
	if ( m_bRequestExitPartyRoom )
	{
		L2jBRVar21 = PartyMatchWnd(GetScript("PartyMatchWnd"));
		if ( UnknownFunction119(L2jBRVar21,None) )
		{
			L2jBRVar21.OnRefreshBtnClick();
		}
		Script2 = PartyMatchMakeRoomWnd(GetScript("PartyMatchMakeRoomWnd"));
		if ( UnknownFunction119(Script2,None) )
		{
			Script2.OnCancelButtonClick();
		}
	}
	m_bRequestExitPartyRoom = False;
}

function UpdateMyMembershipType ()
{
	switch (MyMembershipType)
	{
		case 0:
		case 2:
		Class'UIAPI_BUTTON'.DisableWindow("PartyMatchRoomWnd.RoomSettingButton");
		Class'UIAPI_BUTTON'.DisableWindow("PartyMatchRoomWnd.BanButton");
		Class'UIAPI_BUTTON'.DisableWindow("PartyMatchRoomWnd.InviteButton");
		Class'UIAPI_BUTTON'.EnableWindow("PartyMatchRoomWnd.ExitButton");
		break;
		case 1:
		Class'UIAPI_BUTTON'.EnableWindow("PartyMatchRoomWnd.RoomSettingButton");
		Class'UIAPI_BUTTON'.EnableWindow("PartyMatchRoomWnd.BanButton");
		Class'UIAPI_BUTTON'.EnableWindow("PartyMatchRoomWnd.InviteButton");
		Class'UIAPI_BUTTON'.EnableWindow("PartyMatchRoomWnd.ExitButton");
		break;
		default:
	}
}

function HandlePartyMatchRoomMember (string L2jBRVar1)
{
	local int i;
	local int ClassID;
	local int Level;
	local int MemberID;
	local string memberName;
	local int ZoneID;
	local int MembershipType;
	local PartyMatchWaitListWnd L2jBRVar21;

	L2jBRVar21 = PartyMatchWaitListWnd(GetScript("PartyMatchWaitListWnd"));
	ParseInt(L2jBRVar1,"MyMembershipType",MyMembershipType);
	UpdateMyMembershipType();
	Class'UIAPI_LISTCTRL'.DeleteAllItem("PartyMatchRoomWnd.PartyMemberListCtrl");
	ParseInt(L2jBRVar1,"MemberCount",CurPartyMemberCount);
	i = 0;
	if ( UnknownFunction150(i,CurPartyMemberCount) )
	{
		ParseInt(L2jBRVar1,UnknownFunction112("MemberID_",string(i)),MemberID);
		ParseString(L2jBRVar1,UnknownFunction112("MemberName_",string(i)),memberName);
		ParseInt(L2jBRVar1,UnknownFunction112("ClassID_",string(i)),ClassID);
		ParseInt(L2jBRVar1,UnknownFunction112("Level_",string(i)),Level);
		ParseInt(L2jBRVar1,UnknownFunction112("ZoneID_",string(i)),ZoneID);
		ParseInt(L2jBRVar1,UnknownFunction112("MembershipType_",string(i)),MembershipType);
		AddMember(MemberID,memberName,ClassID,Level,ZoneID,MembershipType);
		UnknownFunction163(i);
		goto JL00AA;
	}
	UpdateData(True);
	if ( Class'UIAPI_WINDOW'.IsMinimizedWindow("PartyMatchRoomWnd") )
	{
		Class'UIAPI_WINDOW'.NotifyAlarm("PartyMatchRoomWnd");
	}
	if ( UnknownFunction242(Class'UIAPI_WINDOW'.IsShowWindow("PartyMatchRoomWnd.PartyMatchWaitListWnd"),True) )
	{
		L2jBRVar21.OnRefreshButtonClick();
	}
}

function AddMember (int a_MemberID, string a_MemberName, int a_ClassID, int a_Level, int a_ZoneID, int a_MembershipType)
{
	local LVDataRecord Record;

	Record.LVDataList.Length = 5;
	Record.LVDataList[0].nReserved1 = a_MemberID;
	Record.LVDataList[0].szData = a_MemberName;
	Record.LVDataList[1].szData = string(a_ClassID);
	Record.LVDataList[1].szTexture = GetClassIconName(a_ClassID);
	Record.LVDataList[1].nTextureWidth = 11;
	Record.LVDataList[1].nTextureHeight = 11;
	Record.LVDataList[2].szData = GetAmbiguousLevelString(a_Level,True);
	Record.LVDataList[3].szData = GetZoneNameWithZoneID(a_ZoneID);
	switch (a_MembershipType)
	{
		case 0:
		Record.LVDataList[4].szData = GetSystemString(1061);
		break;
		case 1:
		Record.LVDataList[4].szData = GetSystemString(1062);
		break;
		case 2:
		Record.LVDataList[4].szData = GetSystemString(1063);
		break;
		default:
	}
	Class'UIAPI_LISTCTRL'.InsertRecord("PartyMatchRoomWnd.PartyMemberListCtrl",Record);
}

function RemoveMember (int a_MemberID)
{
	local int RecordCount;
	local int i;
	local LVDataRecord Record;

	RecordCount = Class'UIAPI_LISTCTRL'.GetRecordCount("PartyMatchRoomWnd.PartyMemberListCtrl");
	i = 0;
	if ( UnknownFunction150(i,RecordCount) )
	{
		Record = Class'UIAPI_LISTCTRL'.GetRecord("PartyMatchRoomWnd.PartyMemberListCtrl",i);
		if ( UnknownFunction154(Record.LVDataList[0].nReserved1,a_MemberID) )
		{
			Class'UIAPI_LISTCTRL'.DeleteRecord("PartyMatchRoomWnd.PartyMemberListCtrl",i);
		} else {
			UnknownFunction163(i);
			goto JL0043;
		}
	}
}

function HandlePartyMatchRoomMemberUpdate (string L2jBRVar1)
{
	local int UpdateType;
	local int MemberID;
	local string memberName;
	local int ClassID;
	local int Level;
	local int ZoneID;
	local int MembershipType;
	local UserInfo PlayerInfo;
	local PartyMatchWaitListWnd L2jBRVar21;

	L2jBRVar21 = PartyMatchWaitListWnd(GetScript("PartyMatchWaitListWnd"));
	ParseInt(L2jBRVar1,"UpdateType",UpdateType);
	ParseInt(L2jBRVar1,"MemberID",MemberID);
	switch (UpdateType)
	{
		case 0:
		ParseString(L2jBRVar1,"MemberName",memberName);
		ParseInt(L2jBRVar1,"ClassID",ClassID);
		ParseInt(L2jBRVar1,"Level",Level);
		ParseInt(L2jBRVar1,"ZoneID",ZoneID);
		ParseInt(L2jBRVar1,"MembershipType",MembershipType);
		AddMember(MemberID,memberName,ClassID,Level,ZoneID,MembershipType);
		CurPartyMemberCount = UnknownFunction146(CurPartyMemberCount,1);
		break;
		case 1:
		ParseString(L2jBRVar1,"MemberName",memberName);
		ParseInt(L2jBRVar1,"ClassID",ClassID);
		ParseInt(L2jBRVar1,"Level",Level);
		ParseInt(L2jBRVar1,"ZoneID",ZoneID);
		ParseInt(L2jBRVar1,"MembershipType",MembershipType);
		RemoveMember(MemberID);
		CurPartyMemberCount = UnknownFunction147(CurPartyMemberCount,1);
		AddMember(MemberID,memberName,ClassID,Level,ZoneID,MembershipType);
		CurPartyMemberCount = UnknownFunction146(CurPartyMemberCount,1);
		break;
		case 2:
		RemoveMember(MemberID);
		CurPartyMemberCount = UnknownFunction147(CurPartyMemberCount,1);
		break;
		default:
	}
	if ( GetPlayerInfo(PlayerInfo) )
	{
		if ( UnknownFunction154(PlayerInfo.nID,MemberID) )
		{
			MyMembershipType = MembershipType;
			UpdateMyMembershipType();
		}
	}
	if ( Class'UIAPI_WINDOW'.IsMinimizedWindow("PartyMatchRoomWnd") )
	{
		Class'UIAPI_WINDOW'.NotifyAlarm("PartyMatchRoomWnd");
	}
	UpdateData(True);
	if ( UnknownFunction242(Class'UIAPI_WINDOW'.IsShowWindow("PartyMatchRoomWnd.PartyMatchWaitListWnd"),True) )
	{
		L2jBRVar21.OnRefreshButtonClick();
	}
}

function HandlePartyMatchChatMessage (string L2jBRVar1)
{
	local int L2jBRVar4;
	local Color ChatColor;
	local string chatMessage;

	ParseString(L2jBRVar1,"Msg",chatMessage);
	ParseInt(L2jBRVar1,"ColorR",L2jBRVar4);
	ChatColor.R = L2jBRVar4;
	ParseInt(L2jBRVar1,"ColorG",L2jBRVar4);
	ChatColor.G = L2jBRVar4;
	ParseInt(L2jBRVar1,"ColorB",L2jBRVar4);
	ChatColor.B = L2jBRVar4;
	ParseInt(L2jBRVar1,"ColorA",L2jBRVar4);
	ChatColor.A = L2jBRVar4;
	Class'UIAPI_TEXTLISTBOX'.AddString("PartyMatchRoomWnd.PartyRoomChatWindow",chatMessage,ChatColor);
	if ( Class'UIAPI_WINDOW'.IsMinimizedWindow("PartyMatchRoomWnd") )
	{
		Class'UIAPI_WINDOW'.NotifyAlarm("PartyMatchRoomWnd");
	}
}

function UpdateData (bool a_ToControl)
{
	if ( a_ToControl )
	{
		Class'UIAPI_TEXTBOX'.SetText("PartyMatchRoomWnd.RoomNumber",string(RoomNumber));
		Class'UIAPI_TEXTBOX'.SetText("PartyMatchRoomWnd.RoomTitle",RoomTitle);
		Class'UIAPI_TEXTBOX'.SetText("PartyMatchRoomWnd.Location",GetZoneNameWithZoneID(RoomZoneID));
		Class'UIAPI_TEXTBOX'.SetText("PartyMatchRoomWnd.PartyMemberCount",UnknownFunction112(UnknownFunction112(string(CurPartyMemberCount),"/"),string(MaxPartyMemberCount)));
		Class'UIAPI_TEXTBOX'.SetText("PartyMatchRoomWnd.LootingMethod",GetLootingMethodName(LootingMethodID));
		Class'UIAPI_TEXTBOX'.SetText("PartyMatchRoomWnd.LevelLimit",UnknownFunction112(UnknownFunction112(string(MinLevel),"-"),string(MaxLevel)));
	}
}

function OnClickButton (string a_strButtonName)
{
	switch (a_strButtonName)
	{
		case "WaitListButton":
		OnWaitListButtonClick();
		break;
		case "RoomSettingButton":
		OnRoomSettingButtonClick();
		break;
		case "BanButton":
		OnBanButtonClick();
		break;
		case "InviteButton":
		OnInviteButtonClick();
		break;
		case "ExitButton":
		OnExitButtonClick();
		break;
		default:
	}
}

function OnWaitListButtonClick ()
{
	local PartyMatchWnd L2jBRVar21;

	L2jBRVar21 = PartyMatchWnd(GetScript("PartyMatchWnd"));
	if ( UnknownFunction119(L2jBRVar21,None) )
	{
		L2jBRVar21.ToggleWaitListWnd();
		UpdateWaitListWnd();
	}
}

function OnRoomSettingButtonClick ()
{
	local PartyMatchMakeRoomWnd L2jBRVar21;

	L2jBRVar21 = PartyMatchMakeRoomWnd(GetScript("PartyMatchMakeRoomWnd"));
	if ( UnknownFunction119(L2jBRVar21,None) )
	{
		L2jBRVar21.InviteState = 2;
		L2jBRVar21.SetRoomNumber(RoomNumber);
		L2jBRVar21.SetTitle(RoomTitle);
		L2jBRVar21.SetMaxPartyMemberCount(MaxPartyMemberCount);
		L2jBRVar21.SetMinLevel(MinLevel);
		L2jBRVar21.SetMaxLevel(MaxLevel);
	}
	Class'UIAPI_WINDOW'.ShowWindow("PartyMatchMakeRoomWnd");
	Class'UIAPI_WINDOW'.SetFocus("PartyMatchMakeRoomWnd");
}

function OnBanButtonClick ()
{
	local LVDataRecord Record;

	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("PartyMatchRoomWnd.PartyMemberListCtrl");
	Class'PartyMatchAPI'.RequestBanFromPartyRoom(Record.LVDataList[0].nReserved1);
}

function OnInviteButtonClick ()
{
	local LVDataRecord Record;

	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("PartyMatchRoomWnd.PartyMemberListCtrl");
	RequestInviteParty(Record.LVDataList[0].szData);
}

function OnExitButtonClick ()
{
	ExitPartyRoom();
	Class'UIAPI_WINDOW'.HideWindow("PartyMatchRoomWnd");
}

function OnCompleteEditBox (string strID)
{
	local string ChatMsg;

	if ( UnknownFunction122(strID,"PartyRoomChatEditBox") )
	{
		ChatMsg = Class'UIAPI_EDITBOX'.GetString("PartyMatchRoomWnd.PartyRoomChatEditBox");
		ProcessPartyMatchChatMessage(ChatMsg);
		Class'UIAPI_EDITBOX'.SetString("PartyMatchRoomWnd.PartyRoomChatEditBox","");
	}
}

function OnChatMarkedEditBox (string strID)
{
	local Color ChatColor;

	if ( UnknownFunction122(strID,"PartyRoomChatEditBox") )
	{
		ChatColor.R = 176;
		ChatColor.G = 155;
		ChatColor.B = 121;
		ChatColor.A = 255;
		Class'UIAPI_TEXTLISTBOX'.AddString("PartyMatchRoomWnd.PartyRoomChatWindow",GetSystemMessage(966),ChatColor);
	}
}

