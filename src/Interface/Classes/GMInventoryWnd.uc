//================================================================================
// GMInventoryWnd.
//================================================================================

class GMInventoryWnd extends InventoryWnd;

var bool bShow;
var int m_ObservingUserInvenLimit;
var int m_Adena;
var bool m_HasLEar;
var bool m_HasLFinger;
struct GMHennaInfo
{
	var int HennaID;
	var int IsActive;
};
var array<GMHennaInfo> m_HennaInfoList;

function OnLoad ()
{
	local WindowHandle hCrystallizeButton;
	local WindowHandle hTrashButton;
	local WindowHandle hInvenWeight;

	RegisterEvent(2401);
	RegisterEvent(2402);
	RegisterEvent(2403);
	RegisterEvent(2404);
	L2jBRFunction2();
	bShow = False;
	m_hOwnerWnd.SetWindowTitle(" ");
	hCrystallizeButton = GetHandle("CrystallizeButton");
	hTrashButton = GetHandle("TrashButton");
	hInvenWeight = GetHandle("InvenWeight");
	hCrystallizeButton.HideWindow();
	hTrashButton.HideWindow();
	hInvenWeight.HideWindow();
}

function OnShow ()
{
	SetAdenaText();
	SetFocus();
}

function ShowInventory (string _L2jBRVar17_)
{
	if ( UnknownFunction122(_L2jBRVar17_,"") )
	{
		return;
	}
	if ( bShow )
	{
		HandleClear();
		m_hOwnerWnd.HideWindow();
		bShow = False;
	} else {
		Class'GMAPI'.RequestGMCommand(5,_L2jBRVar17_);
		bShow = True;
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2401:
		HandleGMObservingInventoryAddItem(_L2jBRVar17_);
		break;
		case 2402:
		HandleGMObservingInventoryClear(_L2jBRVar17_);
		break;
		case 2403:
		HandleGMAddHennaInfo(_L2jBRVar17_);
		break;
		case 2404:
		HandleGMUpdateHennaInfo(_L2jBRVar17_);
		break;
		default:
	}
}

function HandleGMObservingInventoryAddItem (string _L2jBRVar17_)
{
	HandleAddItem(_L2jBRVar17_);
	L2jBRFunction42();
}

function HandleAddItem (string L2jBRVar1)
{
	local ItemInfo Info;

	ParamToItemInfo(L2jBRVar1,Info);
	if ( IsEquipItem(Info) )
	{
		EquipItemUpdate(Info);
	} else {
		if ( IsQuestItem(Info) )
		{
			m_questItem.AddItem(Info);
		} else {
			if ( UnknownFunction154(Info.ClassID,57) )
			{
				SetAdena(Info.ItemNum);
			}
			m_invenItem.AddItem(Info);
		}
	}
}

function SetAdena (int a_Adena)
{
	m_Adena = a_Adena;
	SetAdenaText();
}

function SetAdenaText ()
{
	local string L2jBRVar14;

	L2jBRVar14 = MakeCostString(string(m_Adena));
	L2jBRVar143.SetText(L2jBRVar14);
	L2jBRVar143.SetTooltipString(ConvertNumToText(string(m_Adena)));
}

function int GetMyInventoryLimit ()
{
	return m_ObservingUserInvenLimit;
}

function HandleGMObservingInventoryClear (string _L2jBRVar17_)
{
	HandleClear();
	ParseInt(_L2jBRVar17_,"InvenLimit",m_ObservingUserInvenLimit);
	m_hOwnerWnd.ShowWindow();
	m_hOwnerWnd.SetFocus();
}

function HandleGMAddHennaInfo (string _L2jBRVar17_)
{
	m_HennaInfoList.Length = UnknownFunction146(m_HennaInfoList.Length,1);
	ParseInt(_L2jBRVar17_,"ID",m_HennaInfoList[UnknownFunction147(m_HennaInfoList.Length,1)].HennaID);
	ParseInt(_L2jBRVar17_,"bActive",m_HennaInfoList[UnknownFunction147(m_HennaInfoList.Length,1)].IsActive);
	UpdateHennaInfo();
}

function HandleGMUpdateHennaInfo (string _L2jBRVar17_)
{
	m_HennaInfoList.Length = 0;
}

function OnDropItem (string strTarget, ItemInfo Info, int X, int Y)
{
}

function OnDropItemSource (string strTarget, ItemInfo Info)
{
}

function OnDBClickItem (string strID, int Index)
{
}

function OnRClickItem (string strID, int Index)
{
}

function EquipItemUpdate (ItemInfo a_Info)
{
	local ItemWindowHandle hItemWnd;

	Super.EquipItemUpdate(a_Info);
	switch (a_Info.SlotBitType)
	{
		case 2:
		case 4:
		case 6:
		if ( UnknownFunction154(0,m_equipItem[8].GetItemNum()) )
		{
			hItemWnd = m_equipItem[8];
		} else {
			hItemWnd = m_equipItem[9];
		}
		break;
		case 16:
		case 32:
		case 48:
		if ( UnknownFunction154(0,m_equipItem[13].GetItemNum()) )
		{
			hItemWnd = m_equipItem[13];
		} else {
			hItemWnd = m_equipItem[14];
		}
		break;
		default:
	}
	if ( UnknownFunction119(None,hItemWnd) )
	{
		hItemWnd.Clear();
		hItemWnd.AddItem(a_Info);
	}
}

function int IsLOrREar (int a_ServerID)
{
	return 0;
}

function int IsLOrRFinger (int a_ServerID)
{
	return 0;
}

function UpdateHennaInfo ()
{
	local int i;
	local ItemInfo HennaItemInfo;

	m_hHennaItemWindow.Clear();
	m_hHennaItemWindow.SetRow(m_HennaInfoList.Length);
	i = 0;
	if ( UnknownFunction150(i,m_HennaInfoList.Length) )
	{
		if ( UnknownFunction129(Class'UIDATA_HENNA'.GetItemName(m_HennaInfoList[i].HennaID,HennaItemInfo.Name)) )
		{
			goto JL011F;
		}
		if ( UnknownFunction129(Class'UIDATA_HENNA'.GetDescription(m_HennaInfoList[i].HennaID,HennaItemInfo.Description)) )
		{
			goto JL011F;
		}
		if ( UnknownFunction129(Class'UIDATA_HENNA'.GetIconTex(m_HennaInfoList[i].HennaID,HennaItemInfo.IconName)) )
		{
			goto JL011F;
		}
		if ( UnknownFunction154(0,m_HennaInfoList[i].IsActive) )
		{
			HennaItemInfo.bDisabled = True;
		} else {
			HennaItemInfo.bDisabled = False;
		}
		m_hHennaItemWindow.AddItem(HennaItemInfo);
		UnknownFunction163(i);
		goto JL002B;
	}
}

function OnClickButton (string Name)
{
	switch (Name)
	{
		case "BtnClose":
		Class'UIAPI_WINDOW'.HideWindow("GMInventoryWnd");
		break;
		default:
	}
}

function SetFocus ()
{
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.ItemCount");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_Underwear");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_Head");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_Hair");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_Hair2");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_Neck");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_RHand");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_Chest");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_LHand");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_REar");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_LEar");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_Gloves");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_Legs");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_Feet");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_RFinger");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.EquipItem_LFinger");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.HennaItem");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.InventoryItem");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.QuestItem");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.InventoryTab");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.CrystallizeButton");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.TrashButton");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.AdenaText");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.AdenaIcon");
	Class'UIAPI_WINDOW'.SetFocus("GMInventoryWnd.InvenWeight");
}

defaultproperties
{
    L2jBRVar13="GMInventoryWnd"

}
