//================================================================================
// PartyMatchMakeRoomWnd.
//================================================================================

class PartyMatchMakeRoomWnd extends UIScript;

var int InviteState;
var int RoomNumber;
var string InvitedName;

function OnLoad ()
{
}

function OnShow ()
{
	if ( UnknownFunction154(InviteState,1) )
	{
		Class'UIAPI_TEXTBOX'.SetText("PartyMatchMakeRoomWnd.TitletoDo",GetSystemString(1458));
	} else {
		if ( UnknownFunction154(InviteState,2) )
		{
			Class'UIAPI_TEXTBOX'.SetText("PartyMatchMakeRoomWnd.TitletoDo",GetSystemString(1460));
		} else {
			Class'UIAPI_TEXTBOX'.SetText("PartyMatchMakeRoomWnd.TitletoDo",GetSystemString(1457));
		}
	}
}

function OnClickButton (string a_strButtonName)
{
	switch (a_strButtonName)
	{
		case "OKButton":
		OnOKButtonClick();
		break;
		case "CancelButton":
		OnCancelButtonClick();
		break;
		default:
	}
}

function OnOKButtonClick ()
{
	local int MaxPartyMemberCount;
	local int MinLevel;
	local int MaxLevel;
	local string RoomTitle;

	MaxPartyMemberCount = UnknownFunction146(Class'UIAPI_COMBOBOX'.GetSelectedNum("PartyMatchMakeRoomWnd.MaxPartyMemberCountComboBox"),2);
	MinLevel = UnknownFunction251(int(Class'UIAPI_EDITBOX'.GetString("PartyMatchMakeRoomWnd.MinLevelEditBox")),1,80);
	MaxLevel = UnknownFunction251(int(Class'UIAPI_EDITBOX'.GetString("PartyMatchMakeRoomWnd.MaxLevelEditBox")),1,80);
	RoomTitle = Class'UIAPI_EDITBOX'.GetString("PartyMatchMakeRoomWnd.TitleEditBox");
	Class'PartyMatchAPI'.RequestManagePartyRoom(RoomNumber,MaxPartyMemberCount,MinLevel,MaxLevel,RoomTitle);
	Class'UIAPI_WINDOW'.HideWindow("PartyMatchMakeRoomWnd");
	if ( UnknownFunction154(InviteState,1) )
	{
		Class'PartyMatchAPI'.RequestAskJoinPartyRoom(InvitedName);
		InviteState = 0;
	}
}

function OnCancelButtonClick ()
{
	Class'UIAPI_WINDOW'.HideWindow("PartyMatchMakeRoomWnd");
	if ( UnknownFunction154(InviteState,1) )
	{
		InviteState = 0;
	}
}

function SetRoomNumber (int a_RoomNumber)
{
	Debug(UnknownFunction112("PartyMatchMakeRoomWnd.SetRoomNumber ",string(a_RoomNumber)));
	RoomNumber = a_RoomNumber;
}

function SetTitle (string a_Title)
{
	Debug(UnknownFunction112("PartyMatchMakeRoomWnd.SetTitle ",a_Title));
	Class'UIAPI_EDITBOX'.SetString("PartyMatchMakeRoomWnd.TitleEditBox",a_Title);
}

function SetMinLevel (int a_MinLevel)
{
	Debug(UnknownFunction112("PartyMatchMakeRoomWnd.SetMinLevel ",string(a_MinLevel)));
	Class'UIAPI_EDITBOX'.SetString("PartyMatchMakeRoomWnd.MinLevelEditBox",string(a_MinLevel));
}

function SetMaxLevel (int a_MaxLevel)
{
	Debug(UnknownFunction112("PartyMatchMakeRoomWnd.SetMaxLevel ",string(a_MaxLevel)));
	Class'UIAPI_EDITBOX'.SetString("PartyMatchMakeRoomWnd.MaxLevelEditBox",string(a_MaxLevel));
}

function SetMaxPartyMemberCount (int a_MaxPartyMemberCount)
{
	Debug(UnknownFunction112("PartyMatchMakeRoomWnd.SetMaxPartyMemberCount ",string(a_MaxPartyMemberCount)));
	Class'UIAPI_COMBOBOX'.SetSelectedNum("PartyMatchMakeRoomWnd.MaxPartyMemberCountComboBox",UnknownFunction147(a_MaxPartyMemberCount,2));
}

