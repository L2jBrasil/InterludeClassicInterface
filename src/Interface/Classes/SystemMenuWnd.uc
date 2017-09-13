//================================================================================
// SystemMenuWnd.
//================================================================================

class SystemMenuWnd extends UICommonAPI;

function OnLoad ()
{
	RegisterEvent(1710);
	RegisterEvent(1900);
	SetMenuString();
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "BtnCommunity":
		HandleShowBoardWnd();
		break;
		case "BtnMacro":
		HandleShowMacroListWnd();
		break;
		case "BtnOption":
		HandleShowOptionWnd();
		Class'UIAPI_WINDOW'.HideWindow("SystemMenuWnd");
		break;
		case "BtnRestart":
		if ( UnknownFunction243(GetOptionBool("Unload","ReportWnd"),True) )
		{
			ExecuteEvent(2930);
		} else {
			DialogHide();
			DialogShow(4,GetSystemMessage(126));
			DialogSetID(0);
		}
		break;
		case "BtnQuit":
		if ( UnknownFunction243(GetOptionBool("Unload","ReportWnd"),True) )
		{
			ExecuteEvent(2940);
		} else {
			DialogHide();
			DialogShow(4,GetSystemMessage(125));
			DialogSetID(1);
		}
		break;
		case "BtnPrivateStore":
		ToggleOpenStoreWnd();
		break;
		case "BtnMailBox":
		break;
		case "BtnClanEntry":
		L2jBRFunction84();
		break;
		case "BtnParty":
		L2jBRFunction22();
		break;
		case "BtnFriend":
		ToggleMsnWindow();
		break;
		case "BtnAddFunction":
		ToggleAddWindow();
		break;
		case "BtnService":
		ToggleServicWindow();
		break;
		case "BtnShortcut":
		ToggleShortcutWindow();
		break;
		case "BtnSell":
		DoAction(10);
		break;
		case "BtnBuy":
		DoAction(28);
		break;
		case "BtnBatch":
		DoAction(10);
		Class'UIAPI_CHECKBOX'.SetCheck("PrivateShopWnd.CheckBulk",True);
		break;
		case "BtnFind":
		DoAction(57);
		break;
		case "BtnVideo":
		DoAction(55);
		break;
		case "BtnReplay":
		DoAction(55);
		break;
		case "BtnHelp":
		HandleShowHelpHtmlWnd();
		break;
		case "BtnWeb":
		break;
		default:
	}
	if ( UnknownFunction130(UnknownFunction130(UnknownFunction123(strID,"BtnPrivateStore"),UnknownFunction123(strID,"BtnAddFunction")),UnknownFunction123(strID,"BtnService")) )
	{
		HideWithBranch();
	}
}

function ToggleOpenStoreWnd ()
{
	if ( Class'UIAPI_WINDOW'.IsShowWindow("SystemStoreWnd") )
	{
		Class'UIAPI_WINDOW'.HideWindow("SystemStoreWnd");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("SystemStoreWnd");
		Class'UIAPI_WINDOW'.HideWindow("SystemAddWnd");
		Class'UIAPI_WINDOW'.HideWindow("SystemServiceWnd");
	}
}

function ToggleAddWindow ()
{
	if ( Class'UIAPI_WINDOW'.IsShowWindow("SystemAddWnd") )
	{
		Class'UIAPI_WINDOW'.HideWindow("SystemAddWnd");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("SystemAddWnd");
		Class'UIAPI_WINDOW'.HideWindow("SystemStoreWnd");
		Class'UIAPI_WINDOW'.HideWindow("SystemServiceWnd");
	}
}

function ToggleServicWindow ()
{
	if ( Class'UIAPI_WINDOW'.IsShowWindow("SystemServiceWnd") )
	{
		Class'UIAPI_WINDOW'.HideWindow("SystemServiceWnd");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("SystemServiceWnd");
		Class'UIAPI_WINDOW'.HideWindow("SystemStoreWnd");
		Class'UIAPI_WINDOW'.HideWindow("SystemAddWnd");
	}
}

function ToggleShortcutWindow ()
{
	if ( Class'UIAPI_WINDOW'.IsShowWindow("NPHRN_KeyWnd") )
	{
		Class'UIAPI_WINDOW'.HideWindow("NPHRN_KeyWnd");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("NPHRN_KeyWnd");
	}
}

function L2jBRFunction84()
{
	if ( IsShowWindow("ClanWnd") )
	{
		Class'UIAPI_WINDOW'.HideWindow("ClanWnd");
		PlaySound("InterfaceSound.charstat_close_01");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("ClanWnd");
		Class'UIAPI_WINDOW'.SetFocus("ClanWnd");
		PlaySound("InterfaceSound.charstat_open_01");
	}
}

function L2jBRFunction22 ()
{
	if ( Class'UIAPI_WINDOW'.IsShowWindow("PartyMatchWnd") )
	{
		Class'UIAPI_WINDOW'.HideWindow("PartyMatchWnd");
		PlaySound("InterfaceSound.charstat_close_01");
		Class'UIAPI_TEXTBOX'.SetText("PartyMatchWnd.PartyText","OFF");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("PartyMatchWnd");
		Class'UIAPI_WINDOW'.SetFocus("PartyMatchWnd");
		PlaySound("InterfaceSound.charstat_open_01");
		Class'UIAPI_TEXTBOX'.SetText("PartyMatchWnd.PartyText","ON");
	}
}

function HideWithBranch ()
{
	Class'UIAPI_WINDOW'.HideWindow("SystemMenuWnd");
	Class'UIAPI_WINDOW'.HideWindow("SystemStoreWnd");
	Class'UIAPI_WINDOW'.HideWindow("SystemAddWnd");
	Class'UIAPI_WINDOW'.HideWindow("SystemServiceWnd");
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,1710) )
	{
		if ( DialogIsMine() )
		{
			if ( UnknownFunction154(DialogGetID(),0) )
			{
				Class'UIAPI_WINDOW'.HideWindow("SystemMenuWnd");
				ExecRestart();
			} else {
				L2jBRFunction8();
			}
		}
	} else {
		if ( UnknownFunction154(Event_ID,1900) )
		{
			SetMenuString();
		}
	}
}

function HandleShowBoardWnd ()
{
	local string strParam;

	ParamAdd(strParam,"Init","1");
	ExecuteEvent(1190,strParam);
}

function HandleShowHelpHtmlWnd ()
{
	local string strParam;

	ParamAdd(strParam,"FilePath","..\L2text\help.htm");
	ExecuteEvent(1210,strParam);
}

function HandleShowMacroListWnd ()
{
	ExecuteEvent(1230);
}

function HandleShowPetitionBegin ()
{
	if ( Class'UIAPI_WINDOW'.IsShowWindow("UserPetitionWnd") )
	{
		PlayConsoleSound(6);
		Class'UIAPI_WINDOW'.HideWindow("UserPetitionWnd");
	} else {
		PlayConsoleSound(5);
		Class'UIAPI_WINDOW'.ShowWindow("UserPetitionWnd");
		Class'UIAPI_WINDOW'.SetFocus("UserPetitionWnd");
	}
}

function HandleShowOptionWnd ()
{
	if ( Class'UIAPI_WINDOW'.IsShowWindow("OptionWnd") )
	{
		PlayConsoleSound(6);
		Class'UIAPI_WINDOW'.HideWindow("OptionWnd");
	} else {
		PlayConsoleSound(5);
		Class'UIAPI_WINDOW'.ShowWindow("OptionWnd");
		Class'UIAPI_WINDOW'.SetFocus("OptionWnd");
	}
}

function SetMenuString ()
{
	Class'UIAPI_TEXTBOX'.SetText("SystemMenuWnd.txtBBS",GetSystemString(387));
	Class'UIAPI_TEXTBOX'.SetText("SystemMenuWnd.txtMacro",GetSystemString(711));
}

