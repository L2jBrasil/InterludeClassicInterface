//================================================================================
// PartyMatchWaitListWnd.
//================================================================================

class PartyMatchWaitListWnd extends PartyMatchWndCommon;

var int entire_page;
var int current_page;
var int RoomNumber;
var int MaxPartyMemberCount;
var int MinLevel;
var int MaxLevel;
var int LootingMethodID;
var int RoomZoneID;

function OnLoad ()
{
	RegisterEvent(1550);
	RegisterEvent(1610);
	RegisterEvent(1620);
	entire_page = 1;
	current_page = 1;
}

function OnShow ()
{
	current_page = 1;
}

function OnEvent (int L2jBRVar16, string L2jBRVar1)
{
	switch (L2jBRVar16)
	{
		case 1550:
		HandlePartyMatchRoomStart(L2jBRVar1);
		break;
		case 1610:
		HandlePartyMatchWaitListStart(L2jBRVar1);
		break;
		case 1620:
		HandlePartyMatchWaitList(L2jBRVar1);
		break;
		default:
	}
}

function HandlePartyMatchRoomStart (string L2jBRVar1)
{
	ParseInt(L2jBRVar1,"RoomNum",RoomNumber);
	ParseInt(L2jBRVar1,"MaxMember",MaxPartyMemberCount);
	ParseInt(L2jBRVar1,"MinLevel",MinLevel);
	ParseInt(L2jBRVar1,"MaxLevel",MaxLevel);
	ParseInt(L2jBRVar1,"LootingMethodID",LootingMethodID);
	ParseInt(L2jBRVar1,"ZoneID",RoomZoneID);
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
	Class'UIAPI_TEXTBOX'.SetText("PartyMatchWaitListWnd.MemberCount",page_info);
	Class'UIAPI_LISTCTRL'.DeleteAllItem("PartyMatchWaitListWnd.WaitListCtrl");
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
	Class'UIAPI_LISTCTRL'.InsertRecord("PartyMatchWaitListWnd.WaitListCtrl",Record);
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
	Class'PartyMatchAPI'.RequestPartyMatchWaitList(current_page,MinLevel,MaxLevel,0);
}

function OnNextbuttonClick ()
{
	current_page = UnknownFunction146(current_page,1);
	Class'PartyMatchAPI'.RequestPartyMatchWaitList(current_page,MinLevel,MaxLevel,0);
}

function OnPrevbuttonClick ()
{
	current_page = UnknownFunction147(current_page,1);
	Class'PartyMatchAPI'.RequestPartyMatchWaitList(current_page,MinLevel,MaxLevel,0);
}

function OnWhisperButtonClick ()
{
	local LVDataRecord Record;
	local string szData1;

	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("PartyMatchWaitListWnd.WaitListCtrl");
	szData1 = Record.LVDataList[0].szData;
	if ( UnknownFunction123(szData1,"") )
	{
		SetChatMessage(UnknownFunction112(UnknownFunction112(" ",szData1)," "));
	}
}

function OnInviteButtonClick ()
{
	local LVDataRecord Record;

	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("PartyMatchWaitListWnd.WaitListCtrl");
	Class'PartyMatchAPI'.RequestAskJoinPartyRoom(Record.LVDataList[0].szData);
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
	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("PartyMatchWaitListWnd.WaitListCtrl");
	SetChatMessage(UnknownFunction112(UnknownFunction112(" ",Record.LVDataList[0].szData)," "));
}

function CheckButtonAlive ()
{
	Class'UIAPI_WINDOW'.EnableWindow("PartyMatchWaitListWnd.prev_btn");
	Class'UIAPI_WINDOW'.EnableWindow("PartyMatchWaitListWnd.next_btn");
	if ( UnknownFunction154(current_page,1) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("PartyMatchWaitListWnd.prev_btn");
	}
	if ( UnknownFunction154(current_page,entire_page) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("PartyMatchWaitListWnd.next_btn");
	}
}

