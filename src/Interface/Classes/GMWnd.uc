//================================================================================
// GMWnd.
//================================================================================

class GMWnd extends UICommonAPI;

var Color m_WhiteColor;
var EditBoxHandle m_hEditBox;
var WindowHandle m_hGMwnd;
var WindowHandle m_hGMDetailStatusWnd;
var WindowHandle m_hGMInventoryWnd;
var WindowHandle m_hGMMagicSkillWnd;
var WindowHandle m_hGMQuestWnd;
var WindowHandle m_hGMWarehouseWnd;
var WindowHandle m_hGMClanWnd;
var int L2jBRVar90;
const DIALOGID_SkillList= 4;
const DIALOGID_ItemList= 3;
const DIALOGID_NPCList= 2;
const DIALOGID_SendHome= 1;
const DIALOGID_Recall= 0;

function OnLoad ()
{
	RegisterEvent(2280);
	RegisterEvent(1710);
	RegisterEvent(1720);
	RegisterEvent(980);
	m_hGMwnd = GetHandle("GMWnd");
	m_hEditBox = EditBoxHandle(GetHandle("EditBox"));
	m_hGMDetailStatusWnd = GetHandle("GMDetailStatusWnd");
	m_hGMInventoryWnd = GetHandle("GMInventoryWnd");
	m_hGMMagicSkillWnd = GetHandle("GMMagicSkillWnd");
	m_hGMQuestWnd = GetHandle("GMQuestWnd");
	m_hGMWarehouseWnd = GetHandle("GMWarehouseWnd");
	m_hGMClanWnd = GetHandle("GMClanWnd");
	m_WhiteColor.R = 220;
	m_WhiteColor.G = 220;
	m_WhiteColor.B = 220;
	m_WhiteColor.A = 255;
	L2jBRVar90 = 0;
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2280:
		HandleShowGMWnd();
		break;
		case 1710:
		HandleDialogOK();
		break;
		case 1720:
		HandleDialogCancel();
		break;
		case 980:
		HandleTargetUpdate();
		break;
		default:
	}
}

function HandleShowGMWnd ()
{
	if ( m_hOwnerWnd.IsShowWindow() )
	{
		m_hOwnerWnd.HideWindow();
	} else {
		m_hOwnerWnd.ShowWindow();
		m_hGMwnd.SetFocus();
	}
}

function HandleDialogOK ()
{
	if ( UnknownFunction129(DialogIsMine()) )
	{
		return;
	}
	switch (DialogGetID())
	{
		case 0:
		Recall();
		break;
		case 1:
		SendHome();
		break;
		default:
	}
}

function HandleTargetUpdate ()
{
	local int m_nowTargetID;
	local UserInfo Info;

	m_nowTargetID = Class'UIDATA_TARGET'.GetTargetID();
	if ( UnknownFunction154(m_nowTargetID,L2jBRVar90) )
	{
		return;
	}
	if ( UnknownFunction150(m_nowTargetID,1) )
	{
		L2jBRVar90 = 0;
		m_hEditBox.SetString("");
		return;
	}
	GetTargetInfo(Info);
	if ( UnknownFunction130(UnknownFunction151(m_nowTargetID,0),UnknownFunction242(Info.bNpc,False)) )
	{
		m_hEditBox.SetString(Info.Name);
	}
	L2jBRVar90 = m_nowTargetID;
}

function HandleDialogCancel ()
{
	if ( UnknownFunction129(DialogIsMine()) )
	{
		return;
	}
}

function OnClickButton (string a_ButtonID)
{
	switch (a_ButtonID)
	{
		case "TeleButton":
		OnClickTeleButton();
		break;
		case "MoveButton":
		OnClickMoveButton();
		break;
		case "RecallButton":
		OnClickRecallButton();
		break;
		case "DetailStatusButton":
		OnClickDetailStatusButton();
		break;
		case "InventoryButton":
		OnClickInventoryButton();
		break;
		case "MagicSkillButton":
		OnClickMagicSkillButton();
		break;
		case "QuestButton":
		OnClickQuestButton();
		break;
		case "InfoButton":
		OnClickInfoButton();
		break;
		case "StoreButton":
		OnClickStoreButton();
		break;
		case "ClanButton":
		OnClickClanButton();
		break;
		case "PetitionButton":
		OnClickPetitionButton();
		break;
		case "SendHomeButton":
		OnClickSendHomeButton();
		break;
		case "NPCListButton":
		OnClickNPCListButton();
		break;
		case "ItemListButton":
		OnClickItemListButton();
		break;
		case "SkillListButton":
		OnClickSkillListButton();
		break;
		case "ForcePetitionButton":
		OnClickForcePetitionButton();
		break;
		case "ChangeServerButton":
		OnClickChangeServerButton();
		break;
		default:
	}
}

function OnClickTeleButton ()
{
	local string EditBoxString;

	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction123(EditBoxString,"") )
	{
		ExecuteCommand(UnknownFunction168("//teleportto",EditBoxString));
	}
}

function OnClickMoveButton ()
{
	ExecuteCommand("//instant_move");
}

function OnClickRecallButton ()
{
	DialogSetID(0);
	DialogShow(0,GetSystemMessage(1220));
}

function Recall ()
{
	local string EditBoxString;

	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction123(EditBoxString,"") )
	{
		ExecuteCommand(UnknownFunction168("//recall",EditBoxString));
	}
}

function OnClickDetailStatusButton ()
{
	local string EditBoxString;
	local GMDetailStatusWnd GMDetailStatusWndScript;

	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction123(EditBoxString,"") )
	{
		GMDetailStatusWndScript = GMDetailStatusWnd(m_hGMDetailStatusWnd.GetScript());
		GMDetailStatusWndScript.ShowStatus(EditBoxString);
	} else {
		AddSystemMessage(GetSystemMessage(364),m_WhiteColor);
	}
}

function OnClickInventoryButton ()
{
	local string EditBoxString;
	local GMInventoryWnd GMInventoryWndScript;

	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction123(EditBoxString,"") )
	{
		GMInventoryWndScript = GMInventoryWnd(m_hGMInventoryWnd.GetScript());
		GMInventoryWndScript.ShowInventory(EditBoxString);
	} else {
		AddSystemMessage(GetSystemMessage(364),m_WhiteColor);
	}
}

function OnClickMagicSkillButton ()
{
	local string EditBoxString;
	local GMMagicSkillWnd GMMagicSkillWndScript;

	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction123(EditBoxString,"") )
	{
		GMMagicSkillWndScript = GMMagicSkillWnd(m_hGMMagicSkillWnd.GetScript());
		GMMagicSkillWndScript.ShowMagicSkill(EditBoxString);
	} else {
		AddSystemMessage(GetSystemMessage(364),m_WhiteColor);
	}
}

function OnClickQuestButton ()
{
	local string EditBoxString;
	local GMQuestWnd GMQuestWndScript;

	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction123(EditBoxString,"") )
	{
		GMQuestWndScript = GMQuestWnd(m_hGMQuestWnd.GetScript());
		GMQuestWndScript.ShowQuest(EditBoxString);
	} else {
		AddSystemMessage(GetSystemMessage(364),m_WhiteColor);
	}
}

function OnClickInfoButton ()
{
	local string EditBoxString;

	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction123(EditBoxString,"") )
	{
		ExecuteCommand(UnknownFunction168("//debug",EditBoxString));
	}
}

function OnClickStoreButton ()
{
	local string EditBoxString;
	local GMWarehouseWnd GMWarehouseWndScript;

	Debug("GMstore");
	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction123(EditBoxString,"") )
	{
		GMWarehouseWndScript = GMWarehouseWnd(m_hGMWarehouseWnd.GetScript());
		GMWarehouseWndScript.ShowWarehouse(EditBoxString);
	} else {
		AddSystemMessage(GetSystemMessage(364),m_WhiteColor);
	}
}

function OnClickClanButton ()
{
	local string EditBoxString;
	local GMClanWnd GMClanWndScript;

	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction123(EditBoxString,"") )
	{
		GMClanWndScript = GMClanWnd(m_hGMClanWnd.GetScript());
		GMClanWndScript.ShowClan(EditBoxString);
	} else {
		AddSystemMessage(GetSystemMessage(364),m_WhiteColor);
	}
}

function OnClickPetitionButton ()
{
	local string EditBoxString;

	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction123(EditBoxString,"") )
	{
		ExecuteCommand(UnknownFunction168("//add_peti_chat",EditBoxString));
	}
}

function OnClickSendHomeButton ()
{
	DialogSetID(1);
	DialogShow(0,GetSystemMessage(1221));
}

function SendHome ()
{
	local string EditBoxString;

	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction123(EditBoxString,"") )
	{
		ExecuteCommand(UnknownFunction168("//sendhome",EditBoxString));
	}
}

function OnClickNPCListButton ()
{
	local int Id;
	local string EditBoxString;
	local WindowHandle m_dialogWnd;

	m_dialogWnd = GetHandle("DialogBox");
	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction122(EditBoxString,"") )
	{
		return;
	}
	Id = Class'UIDATA_NPC'.GetFirstID();
	if ( UnknownFunction155(-1,Id) )
	{
		if ( UnknownFunction130(Class'UIDATA_NPC'.IsValidData(Id),UnknownFunction122(Class'UIDATA_NPC'.GetNPCName(Id),EditBoxString)) )
		{
			if ( UnknownFunction130(DialogIsMine(),m_dialogWnd.IsShowWindow()) )
			{
				DialogHide();
				m_dialogWnd.HideWindow();
			}
			DialogSetID(2);
			DialogShow(1,UnknownFunction112(UnknownFunction168(UnknownFunction112("ClassID:",string(UnknownFunction146(Id,1000000))),"Name:"),EditBoxString));
		} else {
			Id = Class'UIDATA_NPC'.GetNextID();
			goto JL004F;
		}
	}
}

function OnClickItemListButton ()
{
	local int Id;
	local string EditBoxString;
	local WindowHandle m_dialogWnd;

	m_dialogWnd = GetHandle("DialogBox");
	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction122(EditBoxString,"") )
	{
		return;
	}
	Id = Class'UIDATA_ITEM'.GetFirstID();
	if ( UnknownFunction155(-1,Id) )
	{
		if ( UnknownFunction122(Class'UIDATA_ITEM'.GetItemName(Id),EditBoxString) )
		{
			if ( UnknownFunction130(DialogIsMine(),m_dialogWnd.IsShowWindow()) )
			{
				DialogHide();
				m_dialogWnd.HideWindow();
			}
			DialogSetID(3);
			DialogShow(1,UnknownFunction112(UnknownFunction168(UnknownFunction112("ClassID:",string(Id)),"Name:"),EditBoxString));
		} else {
			Id = Class'UIDATA_ITEM'.GetNextID();
			goto JL004F;
		}
	}
}

function OnClickSkillListButton ()
{
	local int Id;
	local string EditBoxString;
	local WindowHandle m_dialogWnd;

	m_dialogWnd = GetHandle("DialogBox");
	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction122(EditBoxString,"") )
	{
		return;
	}
	Id = Class'UIDATA_SKILL'.GetFirstID();
	if ( UnknownFunction155(-1,Id) )
	{
		if ( UnknownFunction122(Class'UIDATA_SKILL'.GetName(Id,1),EditBoxString) )
		{
			if ( UnknownFunction130(DialogIsMine(),m_dialogWnd.IsShowWindow()) )
			{
				DialogHide();
				m_dialogWnd.HideWindow();
			}
			DialogSetID(4);
			DialogShow(1,UnknownFunction112(UnknownFunction168(UnknownFunction112("ClassID:",string(Id)),"Name:"),EditBoxString));
		} else {
			Id = Class'UIDATA_SKILL'.GetNextID();
			goto JL004F;
		}
	}
}

function OnClickForcePetitionButton ()
{
	local string EditBoxString;

	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction123(EditBoxString,"") )
	{
		ExecuteCommand(UnknownFunction168(UnknownFunction168("//force_peti",EditBoxString),GetSystemMessage(1528)));
	}
}

function OnClickChangeServerButton ()
{
	local string EditBoxString;
	local UserInfo PlayerInfo;

	EditBoxString = m_hEditBox.GetString();
	if ( UnknownFunction122(EditBoxString,"") )
	{
		return;
	}
	if ( UnknownFunction129(GetPlayerInfo(PlayerInfo)) )
	{
		return;
	}
	Class'GMAPI'.BeginGMChangeServer(int(EditBoxString),PlayerInfo.Loc);
}

