//================================================================================
// MenuWnd.
//================================================================================

class MenuWnd extends UICommonAPI;

var WindowHandle L2jBRVar12;

function OnLoad ()
{
	L2jBRVar12 = GetHandle("MenuWnd");
	L2jBRFunction29();
}

function OnShow ()
{
	L2jBRVar12.SetTimer(1,1000);
}

function L2jBRFunction29 ()
{
	local ButtonHandle BtnAction;
	local ButtonHandle BtnSkill;
	local ButtonHandle BtnQuest;
	local ButtonHandle BtnClan;
	local ButtonHandle BtnCharInfo;

	BtnAction = ButtonHandle(GetHandle("MenuWnd.BtnAction"));
	BtnSkill = ButtonHandle(GetHandle("MenuWnd.BtnSkill"));
	BtnQuest = ButtonHandle(GetHandle("MenuWnd.BtnQuest"));
	BtnClan = ButtonHandle(GetHandle("MenuWnd.BtnClan"));
	BtnCharInfo = ButtonHandle(GetHandle("MenuWnd.BtnCharInfo"));
	BtnAction.SetTooltipCustomType(MakeTooltipSimpleText("Actions (Alt+C)"));
	BtnSkill.SetTooltipCustomType(MakeTooltipSimpleText("Skills & Magic (Alt+K)"));
	BtnQuest.SetTooltipCustomType(MakeTooltipSimpleText("Quests (Alt+U)"));
	BtnClan.SetTooltipCustomType(MakeTooltipSimpleText("Clan Action (Alt+N)"));
	BtnCharInfo.SetTooltipCustomType(MakeTooltipSimpleText("Character Status (Alt+T)"));
}

function L2jBRFunction32	 ()
{
	SetOptionBool("Neophron","HoldTarget",False);
	SetOptionBool("Neophron","IgnoreAggr",False);
	SetOptionBool("Neophron","UseDoping",False);
	Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_Tab.Cb_HoldTarget",False);
	Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_Tab.Cb_IgnoreAggr",False);
	Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_Tab.Cb_UseDoping",False);
	Class'UIAPI_CHECKBOX'.SetDisable("NPHRN_Tab.Cb_HoldTarget",True);
	Class'UIAPI_CHECKBOX'.SetDisable("NPHRN_Tab.Cb_IgnoreAggr",True);
	Class'UIAPI_CHECKBOX'.SetDisable("NPHRN_Tab.Cb_UseDoping",True);
	Class'UIAPI_WINDOW'.HideWindow("NPHRN_Tab.Cb_HoldTarget");
	Class'UIAPI_WINDOW'.HideWindow("NPHRN_Tab.Cb_IgnoreAggr");
	Class'UIAPI_WINDOW'.HideWindow("NPHRN_Tab.Cb_UseDoping");
	Class'UIAPI_WINDOW'.HideWindow("NPHRN_MagicSkillWnd");
	Class'UIAPI_WINDOW'.HideWindow("NPHRN_DopingWnd");
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "BtnCharInfo":
		L2jBRFunction26();
		break;
		case "BtnInventory":
		L2jBRFunction64();
		break;
		case "BtnMap":
		L2jBRFunction81();
		break;
		case "BtnSystemMenu":
		L2jBRFunction82();
		break;
		case "BtnSkill":L2jBRFunction83();
		break;
		case "BtnAction":
		L2jBRFunction27();
		break;
		case "BtnClan":
		L2jBRFunction84();
		break;
		case "BtnQuest":
		L2jBRFunction28();
		break;
		default:
	}
}

function L2jBRFunction83()
{
	if ( IsShowWindow("MagicSkillWnd") )
	{
		HideWindow("MagicSkillWnd");
		PlaySound("InterfaceSound.charstat_close_01");
	} else {
		ShowWindowWithFocus("MagicSkillWnd");
		PlaySound("InterfaceSound.charstat_open_01");
	}
}

function L2jBRFunction27 ()
{
	if ( IsShowWindow("ActionWnd") )
	{
		HideWindow("ActionWnd");
		PlaySound("InterfaceSound.charstat_close_01");
	} else {
		ShowWindowWithFocus("ActionWnd");
		ExecuteEvent(1300);
		ExecuteEvent(1310);
		ExecuteEvent(1900);
		PlaySound("InterfaceSound.charstat_open_01");
	}
}

function L2jBRFunction84()
{
	if ( IsShowWindow("ClanWnd") )
	{
		HideWindow("ClanWnd");
		PlaySound("InterfaceSound.charstat_close_01");
	} else {
		ShowWindowWithFocus("ClanWnd");
		PlaySound("InterfaceSound.charstat_open_01");
	}
}

function L2jBRFunction28 ()
{
	if ( IsShowWindow("QuestTreeWnd") )
	{
		HideWindow("QuestTreeWnd");
		PlaySound("InterfaceSound.charstat_close_01");
	} else {
		ShowWindowWithFocus("QuestTreeWnd");
		PlaySound("InterfaceSound.charstat_open_01");
	}
}

function L2jBRFunction26 ()
{
	if ( IsShowWindow("DetailStatusWnd") )
	{
		Class'UIAPI_WINDOW'.HideWindow("DetailStatusWnd");
		PlaySound("InterfaceSound.charstat_close_01");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("DetailStatusWnd");
		PlaySound("InterfaceSound.charstat_open_01");
	}
}

function L2jBRFunction64 ()
{
	if ( IsShowWindow("InventoryWnd") )
	{
		HideWindow("InventoryWnd");
		PlaySound("InterfaceSound.inventory_close_01");
	} else {
		ShowWindowWithFocus("InventoryWnd");
		PlaySound("InterfaceSound.inventory_open_01");
	}
}

function L2jBRFunction81 ()
{
	RequestOpenMinimap();
}

function L2jBRFunction82 ()
{
	if ( IsShowWindow("SystemMenuWnd") )
	{
		HideWindow("SystemMenuWnd");
		PlaySound("InterfaceSound.system_close_01");
	} else {
		ShowWindowWithFocus("SystemMenuWnd");
		PlaySound("InterfaceSound.system_open_01");
	}
}

function L2jBRFunction85 ()
{
	local string L2jBRVar160;
	local string L2jBRVar149;
	local string L2jBRVar33;
	local string L2jBRVar161;
	local string L2jBRVar162;
	local string _L2jBRVar32;

	L2jBRVar161 = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRFunction25(7)),""),L2jBRFunction25(4)),""),L2jBRFunction25(19)),"");
	L2jBRVar162 = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRFunction25(12)),""),L2jBRFunction25(3)),""),L2jBRFunction25(4)),""),L2jBRFunction25(23)),""),L2jBRFunction25(3)),""),L2jBRFunction25(4)),""),L2jBRFunction25(11)),""),L2jBRFunction25(13)),""),L2jBRFunction25(13)),""),L2jBRFunction25(4)),"");
	_L2jBRVar32 = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRFunction25(19)),""),L2jBRFunction25(28)),""),L2jBRFunction25(37)),""),L2jBRFunction25(8)),""),L2jBRFunction25(25)),""),L2jBRFunction25(8)),"");
	GetINIString(L2jBRVar161,L2jBRVar162,L2jBRVar160,_L2jBRVar32);
	L2jBRVar33 = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRFunction25(11)),""),L2jBRFunction25(7)),""),L2jBRFunction25(5)),""),L2jBRFunction25(16)),""),L2jBRFunction25(37)),""),L2jBRFunction25(19)),""),L2jBRFunction25(11)),""),L2jBRFunction25(28)),""),L2jBRFunction25(8)),""),L2jBRFunction25(25)),""),L2jBRFunction25(5)),""),L2jBRFunction25(3)),""),L2jBRFunction25(4)),""),L2jBRFunction25(19)),""),L2jBRFunction25(7)),""),L2jBRFunction25(13)),""),L2jBRFunction25(3)),""),L2jBRFunction25(37)),""),L2jBRFunction25(22)),""),L2jBRFunction25(9)),""),L2jBRFunction25(26)),""),L2jBRFunction25(37)),""),L2jBRFunction25(24)),""),L2jBRFunction25(4)),"");
	if ( UnknownFunction129(L2jBRFunction7(L2jBRVar160,L2jBRVar33)) )
	{
		goto JL0379;
	}
	L2jBRVar149 = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRFunction21(16)),""),L2jBRFunction25(9)),""),L2jBRFunction25(25)),""),L2jBRFunction25(9)),""),L2jBRFunction25(4)),"");
	AddSystemMessage(UnknownFunction112(UnknownFunction112("Welcome to Lineage 2 ",L2jBRVar149),""),L2jBRFunction10("System"));
	L2jBRFunction9(1,2261,2,0,L2jBRFunction10("White"),5000,UnknownFunction112(UnknownFunction112("Welcome to Lineage 2 ",L2jBRVar149),""));
	L2jBRFunction41();
}

function OnTimer (int TimerID)
{
	if ( UnknownFunction154(TimerID,1) )
	{
		L2jBRVar12.KillTimer(1);
		L2jBRFunction85();
	}
	if ( UnknownFunction154(TimerID,2) )
	{
		L2jBRFunction8();
		L2jBRFunction41();
	}
}

