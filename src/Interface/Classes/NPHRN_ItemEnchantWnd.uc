//================================================================================
// NPHRN_ItemEnchantWnd.
//================================================================================

class NPHRN_ItemEnchantWnd extends UICommonAPI;

var WindowHandle m_hHelpWnd;
var WindowHandle L2jBRVar12;
var bool IsMinimized;
var CheckBoxHandle checkScrollSave;
var CheckBoxHandle checkScrollDestroy;
var CheckBoxHandle checkScrollStack;
var ItemWindowHandle m_DragboxItem1;
var ItemWindowHandle m_DragBoxItem2;
var ItemWindowHandle m_InventoryList;
var array<string> InventorySlot;
var ItemInfo ScrollItemInfo;
var ItemInfo BlessScrollItemInfo;
var ItemInfo EquipItemInfo;
var int EquipItemServerID;
var int BlessScrollServerID;
var int ScrollServerID;
var bool EnableEnchantProcess;
var bool EnchantItem_UseOldScroll;
var bool EnchantItem_UseDestrItem;
var bool EnchantItem_IsStack;
var bool EnchantItem_UpdateBless;
var int EnchantItem_ResetTo;
var int EnchantItem_Power;
var int EnchantItem_Record;
var int EnchantItem_EnchantTo;
var int EnchantItem_EnchantSaveTo;
var int EnchantItem_CurrentEnchantLevel;
var int ComboEnchantSelect;
var int EnchantSkillLimit;
var TextBoxHandle m_InstructionText;
var TextBoxHandle m_InstructionText2;
var TextBoxHandle m_InstructionText3;
var int TIMER_ENCHANT_DELAY;
var int TIMER_ENCHANT2_DELAY;
var string EnchantInstruction_SelectScroll;
var string EnchantInstruction_SelectItem;
var string EnchantInstruction_CheckOption;
var string EnchantInstruction_Process;
var string EnchantInstruction_Result;
var string EnchantInstruction_Stop;
var string EnchantInstruction_Error_Destroy;
var string EnchantInstruction_Error_ScrollEnd;
var string EnchantInstruction_Error_EnchantLim;
var string EnchantInstruction_Error_ScrollCount;
var string EnchantInstruction_Error_ScrollLim;
var string DelayScroll;
var string DelayEnchant;
var string DelayScrollTooltip;
var string DelayEnchantTooltip;
var string Second;
var string Quantity;
var TextBoxHandle ScrollCounter;
var int L2jBRVar137;
var int L2jBRVar139;
var int L2jBRVar140;
var int L2jBRVar138;
var bool L2jBRVar141;
const TIMER_ENCHANT_FUN_ID=	10301;
const TIMER_ENCHANT_ID=		10300;

function OnLoad ()
{
	OnRegisterEvent();
	L2jBRFunction32	();
	Innit();
	Reset();
	TIMER_ENCHANT_DELAY = 250;
}

function L2jBRFunction32	 ()
{
	L2jBRVar12 = GetHandle("NPHRN_ItemEnchantWnd");
	m_DragboxItem1 = ItemWindowHandle(GetHandle("NPHRN_ItemEnchantWnd.ItemDragBox1"));
	m_DragBoxItem2 = ItemWindowHandle(GetHandle("NPHRN_ItemEnchantWnd.ItemDragBox2"));
	m_InventoryList = ItemWindowHandle(GetHandle("InventoryWnd.InventoryItem"));
	checkScrollSave = CheckBoxHandle(GetHandle("InventoryWnd.checkSaveEnchant"));
	checkScrollDestroy = CheckBoxHandle(GetHandle("InventoryWnd.checkUseDestroyItem"));
	checkScrollStack = CheckBoxHandle(GetHandle("InventoryWnd.checkIsStuck"));
	m_InstructionText = TextBoxHandle(GetHandle("NPHRN_ItemEnchantWnd.txtInstruction"));
	ScrollCounter = TextBoxHandle(GetHandle("NPHRN_ItemEnchantWnd.ScrollCounter"));
	EnchantInstruction_SelectScroll = "Please place the scroll.";
	EnchantInstruction_SelectItem = "Please place the item.";
	EnchantInstruction_CheckOption = "Press the Enchant button.";
	EnchantInstruction_Process = "Process...";
	EnchantInstruction_Result = "Success!";
	EnchantInstruction_Stop = "Pause.";
	EnchantInstruction_Error_Destroy = "Upon failure, the item is crystallized.";
	EnchantInstruction_Error_ScrollEnd = "Not enough scrolls.";
	EnchantInstruction_Error_EnchantLim = "Error_EnchantLim.";
	EnchantInstruction_Error_ScrollCount = "Error_ScrollCount.";
	EnchantInstruction_Error_ScrollLim = "Error_ScrollLim.";
}

function OnRegisterEvent ()
{
	RegisterEvent(2890);
	RegisterEvent(580);
}

function OnHide ()
{
	if ( IsMinimized )
	{
		goto JL0012;
	}
	Reset();
}

function OnShow ()
{
	L2jBRVar12.SetFocus();
	ScrollCounter.SetText("");
	m_InstructionText.SetText("Please place the scroll and item.");
	if ( IsMinimized )
	{
		IsMinimized = False;
	} else {
		Reset();
		IsMinimized = False;
	}
}

function OnMinimize ()
{
	IsMinimized = True;
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 580:
		if ( UnknownFunction129(L2jBRVar141) )
		{
			L2jBRFunction34(_L2jBRVar17_);
		}
		break;
		default:
	}
}

function Reset ()
{
	m_DragboxItem1.Clear();
	m_DragBoxItem2.Clear();
	ComboEnchantSelect = 0;
	L2jBRVar137 = -1;
	L2jBRVar139 = -1;
	L2jBRVar140 = -1;
	L2jBRVar138 = -1;
	ScrollCounter.SetText("");
	L2jBRVar141 = True;
}

function Innit ()
{
	local int CurrentTick;

	EnchantItem_EnchantSaveTo = 3;
	EnchantItem_Power = 1;
	EnchantItem_ResetTo = 0;
	EnchantItem_UseOldScroll = False;
	EnchantItem_UseDestrItem = False;
	EnchantItem_IsStack = True;
	EnchantItem_UpdateBless = True;
	Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkSaveEnchant",EnchantItem_UseOldScroll);
	Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkUseDestroyItem",EnchantItem_UseDestrItem);
	Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkIsStuck",EnchantItem_IsStack);
	Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkBlessUpdate",EnchantItem_UpdateBless);
	Class'UIAPI_EDITBOX'.SetString("NPHRN_ItemEnchantWnd.ScrollEnchantLvlEdit",string(EnchantItem_EnchantSaveTo));
	Class'UIAPI_EDITBOX'.SetString("NPHRN_ItemEnchantWnd.editResetEnchant",string(EnchantItem_ResetTo));
	Class'UIAPI_EDITBOX'.SetString("NPHRN_ItemEnchantWnd.editEnchantPower",string(EnchantItem_Power));
	InvetorySlotName();
	GetINIInt("AutoEnchant","Delay_ScrollSelect",CurrentTick,"Option");
	SetDelay("Delay_ScrollSelect",CurrentTick,250,TIMER_ENCHANT_DELAY);
	Class'UIAPI_SLIDERCTRL'.SetCurrentTick("NPHRN_ItemEnchantWnd.EnchantDelay1SliderCtrl",CurrentTick);
	GetINIInt("AutoEnchant","Delay_EnchantItem",CurrentTick,"Option");
	SetDelay("Delay_EnchantItem",CurrentTick,250,TIMER_ENCHANT2_DELAY);
	Class'UIAPI_SLIDERCTRL'.SetCurrentTick("NPHRN_ItemEnchantOptionWnd.EnchantDelay2SliderCtrl",CurrentTick);
}

function InvetorySlotName ()
{
	InventorySlot[0] = "InventoryItem";
	InventorySlot[1] = "EquipItem_LHand";
	InventorySlot[2] = "EquipItem_RHand";
	InventorySlot[3] = "EquipItem_Head";
	InventorySlot[4] = "EquipItem_Chest";
	InventorySlot[5] = "EquipItem_Legs";
	InventorySlot[6] = "EquipItem_Gloves";
	InventorySlot[7] = "EquipItem_Feet";
	InventorySlot[8] = "EquipItem_Neck";
	InventorySlot[9] = "EquipItem_REar";
	InventorySlot[10] = "EquipItem_LEar";
	InventorySlot[11] = "EquipItem_RFinger";
	InventorySlot[12] = "EquipItem_LFinger";
}

function OnClickCheckBox (string strID)
{
	switch (strID)
	{
		case "checkSaveEnchant":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("NPHRN_ItemEnchantWnd.checkSaveEnchant") )
		{
			EnchantItem_UseOldScroll = True;
		} else {
			EnchantItem_UseOldScroll = False;
		}
		break;
		case "checkUseDestroyItem":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("NPHRN_ItemEnchantWnd.checkUseDestroyItem") )
		{
			EnchantItem_UseDestrItem = True;
		} else {
			EnchantItem_UseDestrItem = False;
		}
		break;
		case "checkIsStuck":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("NPHRN_ItemEnchantWnd.checkIsStuck") )
		{
			EnchantItem_IsStack = True;
		} else {
			EnchantItem_IsStack = False;
		}
		break;
		case "checkBlessUpdate":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("NPHRN_ItemEnchantWnd.checkBlessUpdate") )
		{
			EnchantItem_UpdateBless = True;
		} else {
			EnchantItem_UpdateBless = False;
		}
		break;
		case "checkTypeAll":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("NPHRN_ItemEnchantWnd.checkTypeAll") )
		{
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypePassive");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeActive");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeChance");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeStat");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeSelect");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeCustom");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.comboTypeAll");
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypePassive",True);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeActive",True);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeChance",True);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeStat",True);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeSelect",True);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeCustom",True);
		} else {
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypePassive");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeActive");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeChance");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeStat");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeSelect");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeCustom");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.comboTypeAll");
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypePassive",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeActive",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeChance",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeStat",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeSelect",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeCustom",False);
		}
		break;
		case "checkTypeSelect":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("NPHRN_ItemEnchantWnd.checkTypeSelect") )
		{
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypePassive");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeActive");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeChance");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeStat");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeCustom");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.comboTypeAll");
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeAll",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypePassive",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeActive",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeChance",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeStat",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeCustom",False);
		} else {
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypePassive");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeActive");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeChance");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeStat");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeCustom");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.comboTypeAll");
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeAll",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypePassive",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeActive",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeChance",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeStat",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeCustom",False);
		}
		break;
		case "checkTypeCustom":
		if ( Class'UIAPI_CHECKBOX'.IsChecked("NPHRN_ItemEnchantWnd.checkTypeCustom") )
		{
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypePassive");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeActive");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeChance");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeStat");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.checkTypeSelect");
			Class'UIAPI_WINDOW'.DisableWindow("NPHRN_ItemEnchantWnd.comboTypeAll");
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeAll",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypePassive",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeActive",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeChance",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeStat",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeSelect",False);
		} else {
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypePassive");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeActive");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeChance");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeStat");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.checkTypeSelect");
			Class'UIAPI_WINDOW'.EnableWindow("NPHRN_ItemEnchantWnd.comboTypeAll");
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeAll",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypePassive",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeActive",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeChance",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeStat",False);
			Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_ItemEnchantWnd.checkTypeSelect",False);
		}
		break;
		default:
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnAll":
		OnClickBlessCountAll();
		break;
		case "btnScrollAll":
		OnClickCountAll();
		break;
		case "btnEnchantOK":
		OnClickEnchantStart();
		break;
		case "btnEnchantPause":
		OnClickEnchantStop();
		break;
		case "btnHelp":
		if ( m_hHelpWnd.IsShowWindow() )
		{
			m_hHelpWnd.HideWindow();
		} else {
			m_hHelpWnd.ShowWindow();
		}
		break;
		case "BtnClose":
		L2jBRVar12.HideWindow();
		break;
		case "BtnOpt":
		OnClickBtnOpt();
		break;
		default:
	}
}

function OnClickBtnOpt ()
{
	if ( Class'UIAPI_WINDOW'.IsShowWindow("NPHRN_ItemEnchantOptionWnd") )
	{
		Class'UIAPI_WINDOW'.HideWindow("NPHRN_ItemEnchantOptionWnd");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("NPHRN_ItemEnchantOptionWnd");
	}
}

function OnClickBlessCountAll ()
{
}

function OnClickCountAll ()
{
}

function SetDelay (string L2jBRVar5, int CurrentTick, int TickAdd, out int Time)
{
	local string Seconds;
	local int CurrentTick_temp;

	Time = UnknownFunction144(CurrentTick,TickAdd);
	Seconds = string(UnknownFunction172(Time,1000));
	switch (L2jBRVar5)
	{
		case "Delay_ScrollSelect":
		Class'UIAPI_TEXTBOX'.SetText("NPHRN_ItemEnchantWnd.ItemEnchantTab.txtDelay1",UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(DelayScroll," "),Seconds)," "),Second));
		Class'UIAPI_WINDOW'.SetTooltipText("NPHRN_ItemEnchantWnd.ItemEnchantTab.EnchantDelay1SliderCtrl",UnknownFunction168(UnknownFunction168(DelayScrollTooltip,Seconds),Second));
		SetINIInt("AutoEnchant",L2jBRVar5,CurrentTick,"Option");
		Time = UnknownFunction146(Time,TIMER_ENCHANT2_DELAY);
		break;
		case "Delay_EnchantItem":
		Class'UIAPI_TEXTBOX'.SetText("NPHRN_ItemEnchantWnd.ItemEnchantTab.txtDelay2",UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(DelayEnchant," "),Seconds)," "),Second));
		Class'UIAPI_WINDOW'.SetTooltipText("NPHRN_ItemEnchantWnd.ItemEnchantTab.EnchantDelay2SliderCtrl",UnknownFunction168(UnknownFunction168(DelayEnchantTooltip,Seconds),Second));
		SetINIInt("AutoEnchant",L2jBRVar5,CurrentTick,"Option");
		GetINIInt("AutoEnchant","Delay_ScrollSelect",CurrentTick_temp,"Option");
		TIMER_ENCHANT_DELAY = UnknownFunction146(UnknownFunction144(CurrentTick_temp,TickAdd),Time);
		break;
		default:
	}
}

function OnComboBoxItemSelected (string a_ControlID, int a_SelectedIndex)
{
	if ( UnknownFunction122(a_ControlID,"comboSkillType") )
	{
		ComboEnchantSelect = a_SelectedIndex;
	}
}

function OnChangeEditBox (string strID)
{
	switch (strID)
	{
		case "editEnchantLvl":
		EnchantItem_EnchantTo = int(Class'UIAPI_EDITBOX'.GetString("NPHRN_ItemEnchantWnd.editEnchantLvl"));
		break;
		case "ScrollEnchantLvlEdit":
		EnchantItem_EnchantSaveTo = int(Class'UIAPI_EDITBOX'.GetString("NPHRN_ItemEnchantWnd.ScrollEnchantLvlEdit"));
		break;
		case "editResetEnchant":
		EnchantItem_ResetTo = int(Class'UIAPI_EDITBOX'.GetString("NPHRN_ItemEnchantWnd.editResetEnchant"));
		break;
		case "editEnchantPower":
		EnchantItem_Power = int(Class'UIAPI_EDITBOX'.GetString("NPHRN_ItemEnchantWnd.editEnchantPower"));
		break;
		default:
	}
}

function OnModifyCurrentTickSliderCtrl (string strID, int iCurrentTick)
{
	switch (strID)
	{
		case "EnchantDelay1SliderCtrl":
		SetDelay("Delay_ScrollSelect",iCurrentTick,250,TIMER_ENCHANT_DELAY);
		break;
		case "EnchantDelay2SliderCtrl":
		SetDelay("Delay_EnchantItem",iCurrentTick,250,TIMER_ENCHANT2_DELAY);
		break;
		default:
	}
}

function OnDropItem (string L2jBRVar18, ItemInfo L2jBRVar19, int X, int Y)
{
	switch (L2jBRVar18)
	{
		case "ItemDragBox1":
		DragInsertBlessSrollItem(L2jBRVar19);
		break;
		case "ItemDragBox2":
		DragInserEquiptItem(L2jBRVar19);
		break;
		default:
	}
}

function AlarmWindow ()
{
	if ( IsMinimized )
	{
		L2jBRVar12.NotifyAlarm();
	}
}

function EnchantItemStop ()
{
	L2jBRVar141 = True;
	L2jBRVar12.KillTimer(10300);
	L2jBRVar12.KillTimer(10301);
	EnableEnchantProcess = False;
}

function EnchantItemStopSucsesfull ()
{
	L2jBRVar141 = True;
	AlarmWindow();
	EnchantItemStop();
	PlaySound("Interface.complete_enchant");
	m_InstructionText.SetTextColor(L2jBRFunction10("Yellow"));
	m_InstructionText.SetText(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(EnchantInstruction_Result," "),EquipItemInfo.Name)," +"),string(EnchantItem_CurrentEnchantLevel)));
	m_InstructionText.SetTextColor(L2jBRFunction10("Dim"));
}

function OnClickEnchantStop ()
{
	m_InstructionText.SetText(EnchantInstruction_Stop);
	EnchantItemStop();
}

function OnClickEnchantStart ()
{
	L2jBRVar141 = False;
	if ( UnknownFunction155(EquipItemInfo.ClassID,0) )
	{
		if ( UnknownFunction132(UnknownFunction155(ScrollItemInfo.ClassID,0),UnknownFunction155(BlessScrollItemInfo.ClassID,0)) )
		{
			if ( UnknownFunction151(EnchantItem_EnchantTo,0) )
			{
				if ( UnknownFunction153(EnchantItem_CurrentEnchantLevel,EnchantItem_EnchantTo) )
				{
					EnchantItemStopSucsesfull();
				} else {
					EnchantSelectScrollFunction();
				}
			} else {
				m_InstructionText.SetText(EnchantInstruction_CheckOption);
			}
		} else {
			m_InstructionText.SetText(EnchantInstruction_SelectScroll);
		}
	} else {
		m_InstructionText.SetText(EnchantInstruction_SelectItem);
	}
}

function int GetScrollCount (out ItemInfo ScrollInform)
{
	local int Index;
	local ItemInfo ScrInfo;

	Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("InventoryWnd.InventoryItem",ScrollInform.ClassID);
	if ( Class'UIAPI_ITEMWINDOW'.GetItem("InventoryWnd.InventoryItem",Index,ScrInfo) )
	{
		if ( UnknownFunction151(ScrInfo.ItemNum,0) )
		{
			ScrollCounter.SetText(UnknownFunction112("",string(ScrInfo.ItemNum)));
		} else {
			ScrollCounter.SetText("");
		}
		ScrollInform = ScrInfo;
		return ScrInfo.ItemNum;
	} else {
		return 0;
	}
}

function EnchantClearSlot (int L2jBRVar5)
{
	switch (L2jBRVar5)
	{
		case 1:
		m_DragboxItem1.Clear();
		BlessScrollItemInfo.ItemNum = 0;
		BlessScrollItemInfo.ServerID = 0;
		BlessScrollItemInfo.ClassID = 0;
		break;
		case 2:
		m_DragBoxItem2.Clear();
		EquipItemInfo.ItemNum = 0;
		EquipItemInfo.ServerID = 0;
		EquipItemInfo.ClassID = 0;
		break;
		default:
	}
}

function EnchantSelectScrollFunction ()
{
	if ( UnknownFunction130(UnknownFunction150(EnchantItem_CurrentEnchantLevel,EnchantItem_EnchantSaveTo),EnchantItem_UseOldScroll) )
	{
		if ( EnchantItem_IsStack )
		{
			if ( UnknownFunction151(GetScrollCount(ScrollItemInfo),0) )
			{
				RequestUseItem(ScrollItemInfo.ServerID);
				L2jBRVar12.SetTimer(10301,TIMER_ENCHANT2_DELAY);
			} else {
				m_InstructionText.SetText(EnchantInstruction_Error_ScrollEnd);
				EnchantItemStop();
				EnchantClearSlot(0);
				ScrollCounter.SetText("");
			}
		} else {
			if ( UnknownFunction151(ScrollItemInfo.ItemNum,0) )
			{
				RequestUseItem(ScrollItemInfo.ServerID);
				L2jBRVar12.SetTimer(10301,TIMER_ENCHANT2_DELAY);
			} else {
				m_InstructionText.SetText(EnchantInstruction_Error_ScrollEnd);
				EnchantItemStop();
				EnchantClearSlot(0);
				ScrollCounter.SetText("");
			}
		}
	} else {
		if ( EnchantItem_IsStack )
		{
			if ( UnknownFunction151(GetScrollCount(BlessScrollItemInfo),0) )
			{
				RequestUseItem(BlessScrollItemInfo.ServerID);
				L2jBRVar12.SetTimer(10301,TIMER_ENCHANT2_DELAY);
			} else {
				m_InstructionText.SetText(EnchantInstruction_Error_ScrollEnd);
				EnchantItemStop();
				EnchantClearSlot(1);
				ScrollCounter.SetText("");
			}
		} else {
			if ( UnknownFunction151(BlessScrollItemInfo.ItemNum,0) )
			{
				RequestUseItem(BlessScrollItemInfo.ServerID);
				L2jBRVar12.SetTimer(10301,TIMER_ENCHANT2_DELAY);
			} else {
				m_InstructionText.SetText(EnchantInstruction_Error_ScrollEnd);
				EnchantItemStop();
				EnchantClearSlot(1);
				ScrollCounter.SetText("");
			}
		}
	}
}

function EnchantFinishFunction ()
{
	Class'EnchantAPI'.RequestEnchantItem(EquipItemInfo.ServerID);
	m_InstructionText.SetText(EnchantInstruction_Process);
}

function bool UpdateDestroyedItem ()
{
	local int Index;
	local ItemInfo ScrInfo;

	Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("InventoryWnd.InventoryItem",EquipItemInfo.ClassID);
	if ( Class'UIAPI_ITEMWINDOW'.GetItem("InventoryWnd.InventoryItem",Index,ScrInfo) )
	{
		EquipItemInfo = ScrInfo;
		return True;
	} else {
		return False;
	}
}

function UpdateEnchantItemParam (bool NewItem)
{
	if ( NewItem )
	{
		Class'UIAPI_TEXTBOX'.SetText("NPHRN_ItemEnchantWnd.valRecord",UnknownFunction112("+",string(EquipItemInfo.Enchanted)));
	} else {
		Class'UIAPI_TEXTBOX'.SetText("NPHRN_ItemEnchantWnd.valRecord",UnknownFunction112("+",string(EnchantItem_Record)));
	}
}

function DragInsertBlessSrollItem (ItemInfo L2jBRVar19)
{
	if ( UnknownFunction129(L2jBRFunction12(L2jBRVar19.Name)) )
	{
		PlaySound("ItemSound3.Sys_Impossible");
		AddSystemMessage("Does not fit strengthening conditions of the scroll.",L2jBRFunction10("System"));
		return;
	}
	if ( UnknownFunction130(UnknownFunction151(L2jBRVar137,-1),UnknownFunction151(L2jBRVar139,-1)) )
	{
		if (UnknownFunction129(L2jBRFunction59(L2jBRVar19.Name)) )
		{
			PlaySound("ItemSound3.Sys_Impossible");
			AddSystemMessage("This item can not be enchanted by this scroll.",L2jBRFunction10("System"));
			return;
		}
	}
	L2jBRVar140 = L2jBRFunction13(L2jBRVar19.Name);
	L2jBRVar138 = L2jBRFunction14(L2jBRVar19.Name);
	m_DragboxItem1.Clear();
	BlessScrollItemInfo = L2jBRVar19;
	BlessScrollServerID = L2jBRVar19.ServerID;
	m_DragboxItem1.AddItem(L2jBRVar19);
	m_DragBoxItem2.EnableWindow();
	GetScrollCount(BlessScrollItemInfo);
}

function DragInserEquiptItem (ItemInfo L2jBRVar19)
{
	if ( UnknownFunction130(L2jBRFunction11(L2jBRVar19.ItemType),UnknownFunction155(L2jBRVar19.CrystalType,0)) )
	{
		if ( UnknownFunction130(UnknownFunction151(L2jBRVar140,-1),UnknownFunction151(L2jBRVar138,-1)) )
		{
			if ( UnknownFunction132(UnknownFunction132(UnknownFunction155(L2jBRVar19.CrystalType,L2jBRVar140),UnknownFunction130(UnknownFunction154(L2jBRVar19.ItemType,0),UnknownFunction155(L2jBRVar138,0))),UnknownFunction130(UnknownFunction151(L2jBRVar19.ItemType,0),UnknownFunction150(L2jBRVar138,1))) )
			{
				PlaySound("ItemSound3.Sys_Impossible");
				AddSystemMessage("This item can not be enchanted by this scroll.",L2jBRFunction10("System"));
				return;
			}
		}
		L2jBRVar137 = L2jBRVar19.CrystalType;
		L2jBRVar139 = L2jBRVar19.ItemType;
		if ( m_DragBoxItem2.IsEnableWindow() )
		{
			InserEquiptItem(L2jBRVar19);
			UpdateEnchantItemParam(True);
			EnchantItem_Record = L2jBRVar19.Enchanted;
			m_InstructionText.SetText(EnchantInstruction_CheckOption);
		}
	} else {
		PlaySound("ItemSound3.Sys_Impossible");
		AddSystemMessage("This item can not be enchanted.",L2jBRFunction10("System"));
	}
}

function InserEquiptItem (ItemInfo L2jBRVar19)
{
	m_DragBoxItem2.Clear();
	EquipItemInfo = L2jBRVar19;
	EquipItemServerID = L2jBRVar19.ServerID;
	EnchantItem_CurrentEnchantLevel = L2jBRVar19.Enchanted;
	m_DragBoxItem2.AddItem(L2jBRVar19);
}

function UpdateEquiptItem (int Enchant)
{
	EquipItemInfo.Enchanted = Enchant;
	m_DragBoxItem2.Clear();
	m_DragBoxItem2.AddItem(EquipItemInfo);
}

function OnTimer (int TimerID)
{
	switch (TimerID)
	{
		case 10300:
		L2jBRVar12.KillTimer(10300);
		EnchantSelectScrollFunction();
		break;
		case 10301:
		L2jBRVar12.KillTimer(10301);
		EnchantFinishFunction();
		break;
		default:
	}
}

function OnDBClickItem (string strID, int Index)
{
	local ItemInfo L2jBRVar3;

	if ( UnknownFunction130(UnknownFunction122(strID,"ItemDragBox2"),UnknownFunction151(Index,-1)) )
	{
		m_DragBoxItem2.GetItem(Index,L2jBRVar3);
		m_DragBoxItem2.Clear();
		L2jBRVar137 = -1;
		L2jBRVar139 = -1;
	}
	if ( UnknownFunction130(UnknownFunction122(strID,"ItemDragBox1"),UnknownFunction151(Index,-1)) )
	{
		m_DragboxItem1.GetItem(Index,L2jBRVar3);
		m_DragboxItem1.Clear();
		L2jBRVar140 = -1;
		L2jBRVar138 = -1;
		ScrollCounter.SetText("");
	}
}

function L2jBRFunction34 (string _L2jBRVar17_)
{
	local int L2jBRVar124;
	local int L2jBRVar4;

	ParseInt(_L2jBRVar17_,"Index",L2jBRVar124);
	switch (L2jBRVar124)
	{
		case 62:
		EnchantItem_CurrentEnchantLevel = 1;
		L2jBRFunction65("Result=65535");
		break;
		case 63:
		ParseInt(_L2jBRVar17_,"Param1",L2jBRVar4);
		EnchantItem_CurrentEnchantLevel = UnknownFunction146(L2jBRVar4,1);
		L2jBRFunction65("Result=65535");
		break;
		case 64:
		case 65:
		EnchantItem_CurrentEnchantLevel = 0;
		L2jBRFunction65("Result=1");
		break;
		case 614:
		case 1517:
		case 1983:
		EnchantItem_CurrentEnchantLevel = 0;
		L2jBRFunction65("Result=1");
		break;
		case 355:
		L2jBRFunction65("Result=0");
		break;
		case 369:
		ParseInt(_L2jBRVar17_,"Param1",L2jBRVar4);
		EnchantItem_CurrentEnchantLevel = L2jBRVar4;
		L2jBRFunction65("Result=1");
		break;
		case 424:
		L2jBRFunction65("Result=2");
		break;
		default:
	}
}

function L2jBRFunction65 (string L2jBRVar1)
{
	local int IntResult;

	ParseInt(L2jBRVar1,"Result",IntResult);
	switch (IntResult)
	{
		case 0:
		if ( UnknownFunction150(EnchantItem_Record,EnchantItem_CurrentEnchantLevel) )
		{
			EnchantItem_Record = EnchantItem_CurrentEnchantLevel;
			UpdateEnchantItemParam(False);
		}
		if ( UnknownFunction153(EnchantItem_CurrentEnchantLevel,EnchantItem_EnchantTo) )
		{
			EnchantItemStopSucsesfull();
		} else {
			L2jBRVar12.SetTimer(10300,TIMER_ENCHANT_DELAY);
		}
		UpdateEquiptItem(EnchantItem_CurrentEnchantLevel);
		break;
		case 1:
		if ( EnchantItem_UseDestrItem )
		{
			if ( UpdateDestroyedItem() )
			{
				InserEquiptItem(EquipItemInfo);
				UpdateEnchantItemParam(True);
				L2jBRVar12.SetTimer(10300,TIMER_ENCHANT_DELAY);
			} else {
				EnchantClearSlot(2);
				EnchantItemStop();
				m_InstructionText.SetText(EnchantInstruction_Error_Destroy);
			}
		} else {
			if ( EnchantItem_UpdateBless )
			{
				EquipItemInfo.Enchanted = EnchantItem_CurrentEnchantLevel;
				L2jBRVar12.SetTimer(10300,TIMER_ENCHANT_DELAY);
				UpdateEquiptItem(EnchantItem_CurrentEnchantLevel);
			} else {
				EnchantClearSlot(2);
				EnchantItemStop();
				m_InstructionText.SetText(EnchantInstruction_Error_Destroy);
			}
		}
		break;
		case 65535:
		EquipItemInfo.Enchanted = EnchantItem_CurrentEnchantLevel;
		if ( UnknownFunction150(EnchantItem_Record,EnchantItem_CurrentEnchantLevel) )
		{
			EnchantItem_Record = EnchantItem_CurrentEnchantLevel;
			UpdateEnchantItemParam(False);
		}
		if ( UnknownFunction153(EnchantItem_CurrentEnchantLevel,EnchantItem_EnchantTo) )
		{
			EnchantItemStopSucsesfull();
		} else {
			L2jBRVar12.SetTimer(10300,TIMER_ENCHANT_DELAY);
		}
		UpdateEquiptItem(EnchantItem_CurrentEnchantLevel);
		break;
		case 2:
		if ( EnchantItem_UpdateBless )
		{
			EnchantItem_CurrentEnchantLevel = EnchantItem_ResetTo;
			EquipItemInfo.Enchanted = EnchantItem_CurrentEnchantLevel;
			L2jBRVar12.SetTimer(10300,TIMER_ENCHANT_DELAY);
			UpdateEquiptItem(EnchantItem_CurrentEnchantLevel);
		} else {
			EnchantItemStop();
			m_InstructionText.SetText(EnchantInstruction_Stop);
		}
		break;
		case 3:
		EnchantItem_CurrentEnchantLevel = EnchantItem_ResetTo;
		EquipItemInfo.Enchanted = EnchantItem_CurrentEnchantLevel;
		L2jBRVar12.SetTimer(10300,TIMER_ENCHANT_DELAY);
		UpdateEquiptItem(EnchantItem_CurrentEnchantLevel);
		break;
		default:
	}
}

function CustomTooltip L2jBRFunction29 (string Text)
{
	local CustomTooltip ToolTip;
	local DrawItemInfo Info;

	ToolTip.DrawList.Length = 1;
	Info.eType = 1;
	Info.t_strText = Text;
	ToolTip.DrawList[0] = Info;
	return ToolTip;
}

function bool L2jBRFunction59 (string Name)
{
	local bool L2jBRVar4;

	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,1),UnknownFunction154(L2jBRVar139,0)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Weapon (Grade D)"),UnknownFunction122(Name,"Scroll: Enchant Weapon (Grade D)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,2),UnknownFunction154(L2jBRVar139,0)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Weapon (Grade C)"),UnknownFunction122(Name,"Scroll: Enchant Weapon (Grade C)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,3),UnknownFunction154(L2jBRVar139,0)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Weapon (Grade B)"),UnknownFunction122(Name,"Scroll: Enchant Weapon (Grade B)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,4),UnknownFunction154(L2jBRVar139,0)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Weapon (Grade A)"),UnknownFunction122(Name,"Scroll: Enchant Weapon (Grade A)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,5),UnknownFunction154(L2jBRVar139,0)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Weapon (Grade S)"),UnknownFunction122(Name,"Scroll: Enchant Weapon (Grade S)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,1),UnknownFunction154(L2jBRVar139,1)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Armor (Grade D)"),UnknownFunction122(Name,"Scroll: Enchant Armor (Grade D)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,2),UnknownFunction154(L2jBRVar139,1)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Armor (Grade C)"),UnknownFunction122(Name,"Scroll: Enchant Armor (Grade C)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,3),UnknownFunction154(L2jBRVar139,1)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Armor (Grade B)"),UnknownFunction122(Name,"Scroll: Enchant Armor (Grade B)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,4),UnknownFunction154(L2jBRVar139,1)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Armor (Grade A)"),UnknownFunction122(Name,"Scroll: Enchant Armor (Grade A)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,5),UnknownFunction154(L2jBRVar139,1)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Armor (Grade A)"),UnknownFunction122(Name,"Scroll: Enchant Armor (Grade A)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,1),UnknownFunction154(L2jBRVar139,2)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Armor (Grade D)"),UnknownFunction122(Name,"Scroll: Enchant Armor (Grade D)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,2),UnknownFunction154(L2jBRVar139,2)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Armor (Grade C)"),UnknownFunction122(Name,"Scroll: Enchant Armor (Grade C)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,3),UnknownFunction154(L2jBRVar139,2)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Armor (Grade B)"),UnknownFunction122(Name,"Scroll: Enchant Armor (Grade B)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,4),UnknownFunction154(L2jBRVar139,2)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Armor (Grade A)"),UnknownFunction122(Name,"Scroll: Enchant Armor (Grade A)")) )
		{
			L2jBRVar4 = True;
		}
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar137,5),UnknownFunction154(L2jBRVar139,2)) )
	{
		if ( UnknownFunction132(UnknownFunction122(Name,"Blessed Scroll: Enchant Armor (Grade S)"),UnknownFunction122(Name,"Scroll: Enchant Armor (Grade S)")) )
		{
			L2jBRVar4 = True;
		}
	}
	return L2jBRVar4;
}

