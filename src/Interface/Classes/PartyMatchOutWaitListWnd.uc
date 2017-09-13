//================================================================================
// PartyMatchOutWaitListWnd.
//================================================================================

class PartyMatchOutWaitListWnd extends PartyMatchWndCommon;

var int entire_page;
var int current_page;
var int MinLevel;
var int MaxLevel;

function OnLoad ()
{
	RegisterEvent(1610);
	RegisterEvent(1620);
	entire_page = 1;
	current_page = 1;
	Class'UIAPI_EDITBOX'.SetString("PartyMatchOutWaitListWnd.MinLevel","1");
	Class'UIAPI_EDITBOX'.SetString("PartyMatchOutWaitListWnd.MaxLevel","80");
}

function OnShow ()
{
	current_page = 1;
}

function OnEvent (int L2jBRVar16, string L2jBRVar1)
{
	switch (L2jBRVar16)
	{
		case 1610:
		HandlePartyMatchWaitListStart(L2jBRVar1);
		break;
		case 1620:
		HandlePartyMatchWaitList(L2jBRVar1);
		break;
		default:
	}
}

function HandlePartyMatchWaitListStart (string L2jBRVar1)
{
	local int AllCount;
	local int L2jBRVar15_;
	local string totalPages;
	local string currentPage;
	local string page_info;

	ParseInt(L2jBRVar1,"AllCount",AllCount);
	ParseInt(L2jBRVar1,"Count",L2jBRVar15_);
	totalPages = string(UnknownFunction146(UnknownFunction145(AllCount,64),1));
	entire_page = UnknownFunction146(UnknownFunction145(AllCount,64),1);
	currentPage = string(current_page);
	page_info = UnknownFunction112(UnknownFunction112(currentPage,"/"),totalPages);
	Class'UIAPI_TEXTBOX'.SetText("PartyMatchOutWaitListWnd.MemberCount",page_info);
	Class'UIAPI_LISTCTRL'.DeleteAllItem("PartyMatchOutWaitListWnd.WaitListCtrl");
	CheckButtonAlive();
}

function HandlePartyMatchWaitList (string L2jBRVar1)
{
	local string Name;
	local int ClassID;
	local int Level;
	local LVDataRecord Record;

	ParseString(L2jBRVar1,"Name",Name);
	ParseInt(L2jBRVar1,"ClassID",ClassID);
	ParseInt(L2jBRVar1,"Level",Level);
	Record.LVDataList.Length = 3;
	Record.LVDataList[0].szData = Name;
	Record.LVDataList[1].szTexture = GetClassIconName(ClassID);
	Record.LVDataList[1].nTextureWidth = 11;
	Record.LVDataList[1].nTextureHeight = 11;
	Record.LVDataList[1].szData = string(ClassID);
	Record.LVDataList[2].szData = GetAmbiguousLevelString(Level,False);
	Record.nReserved1 = Level;
	Class'UIAPI_LISTCTRL'.InsertRecord("PartyMatchOutWaitListWnd.WaitListCtrl",Record);
}

function OnClickButton (string a_strButtonName)
{
	switch (a_strButtonName)
	{
		case "RefreshButton":
		OnRefreshButtonClick();
		break;
		case "WhisperButton":
		OnWhisperButtonClick();
		break;
		case "PartyInviteButton":
		OnInviteButtonClick();
		break;
		case "CloseButton":
		OnCloseButtonClick();
		break;
		case "btn_Search":
		OnSearchBtnClick();
		break;
		case "prev_btn":
		OnPrevbuttonClick();
		break;
		case "next_btn":
		OnNextbuttonClick();
		break;
		default:
	}
}

function OnRefreshButtonClick ()
{
	MinLevel = int(Class'UIAPI_EDITBOX'.GetString("PartyMatchOutWaitListWnd.MinLevel"));
	MaxLevel = int(Class'UIAPI_EDITBOX'.GetString("PartyMatchOutWaitListWnd.MaxLevel"));
	Class'PartyMatchAPI'.RequestPartyMatchWaitList(current_page,MinLevel,MaxLevel,1);
}

function OnNextbuttonClick ()
{
	current_page = UnknownFunction146(current_page,1);
	Class'PartyMatchAPI'.RequestPartyMatchWaitList(current_page,MinLevel,MaxLevel,1);
}

function OnPrevbuttonClick ()
{
	current_page = UnknownFunction147(current_page,1);
	Class'PartyMatchAPI'.RequestPartyMatchWaitList(current_page,MinLevel,MaxLevel,1);
}

function OnSearchBtnClick ()
{
	MinLevel = int(Class'UIAPI_EDITBOX'.GetString("PartyMatchOutWaitListWnd.MinLevel"));
	MaxLevel = int(Class'UIAPI_EDITBOX'.GetString("PartyMatchOutWaitListWnd.MaxLevel"));
	Class'PartyMatchAPI'.RequestPartyMatchWaitList(1,MinLevel,MaxLevel,1);
}

function OnWhisperButtonClick ()
{
	local LVDataRecord Record;
	local string szData1;

	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("PartyMatchOutWaitListWnd.WaitListCtrl");
	szData1 = Record.LVDataList[0].szData;
	if ( UnknownFunction123(szData1,"") )
	{
		SetChatMessage(UnknownFunction112(UnknownFunction112(" ",szData1)," "));
	}
}

function OnInviteButtonClick ()
{
	local LVDataRecord Record;

	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("PartyMatchOutWaitListWnd.WaitListCtrl");
	MakeRoomFirst(Record.nReserved1,Record.LVDataList[0].szData);
}

function OnCloseButtonClick ()
{
	local PartyMatchWnd L2jBRVar21;

	L2jBRVar21 = PartyMatchWnd(GetScript("PartyMatchWnd"));
	if ( UnknownFunction119(L2jBRVar21,None) )
	{
		L2jBRVar21.SetWaitListWnd(False);
		L2jBRVar21.ShowHideWaitListWnd();
	}
}

function OnDBClickListCtrlRecord (string a_ListCtrlName)
{
	local LVDataRecord Record;

	if ( UnknownFunction123(a_ListCtrlName,"WaitListCtrl") )
	{
		return;
	}
	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("PartyMatchOutWaitListWnd.WaitListCtrl");
	SetChatMessage(UnknownFunction112(UnknownFunction112(" ",Record.LVDataList[0].szData)," "));
}

function MakeRoomFirst (int TargetLevel, string InviteTargetName)
{
	local PartyMatchMakeRoomWnd L2jBRVar21;
	local UserInfo PlayerInfo;
	local int LevelMin;
	local int LevelMax;

	L2jBRVar21 = PartyMatchMakeRoomWnd(GetScript("PartyMatchMakeRoomWnd"));
	if ( UnknownFunction119(L2jBRVar21,None) )
	{
		L2jBRVar21.InviteState = 1;
		L2jBRVar21.InvitedName = InviteTargetName;
		L2jBRVar21.SetRoomNumber(0);
		L2jBRVar21.SetTitle(GetSystemMessage(1398));
		L2jBRVar21.SetMaxPartyMemberCount(12);
		if ( GetPlayerInfo(PlayerInfo) )
		{
			if ( UnknownFunction150(TargetLevel,PlayerInfo.nLevel) )
			{
				LevelMin = TargetLevel;
				LevelMax = PlayerInfo.nLevel;
			} else {
				LevelMin = PlayerInfo.nLevel;
				LevelMax = TargetLevel;
			}
			if ( UnknownFunction151(UnknownFunction147(LevelMin,5),0) )
			{
				L2jBRVar21.SetMinLevel(UnknownFunction147(LevelMin,5));
			} else {
				L2jBRVar21.SetMinLevel(1);
			}
			if ( UnknownFunction152(UnknownFunction146(LevelMax,5),80) )
			{
				L2jBRVar21.SetMaxLevel(UnknownFunction146(LevelMax,5));
			} else {
				L2jBRVar21.SetMaxLevel(80);
			}
		}
	}
	Class'UIAPI_WINDOW'.ShowWindow("PartyMatchMakeRoomWnd");
	Class'UIAPI_WINDOW'.SetFocus("PartyMatchMakeRoomWnd");
}

function CheckButtonAlive ()
{
	Class'UIAPI_WINDOW'.EnableWindow("PartyMatchOutWaitListWnd.prev_btn");
	Class'UIAPI_WINDOW'.EnableWindow("PartyMatchOutWaitListWnd.next_btn");
	if ( UnknownFunction154(current_page,1) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("PartyMatchOutWaitListWnd.prev_btn");
	}
	if ( UnknownFunction154(current_page,entire_page) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("PartyMatchOutWaitListWnd.next_btn");
	}
}

