//================================================================================
// ItemEnchantWnd.
//================================================================================

class ItemEnchantWnd extends UICommonAPI;

var WindowHandle L2jBRVar12;
var ItemWindowHandle ItemWnd;
var NPHRN_ItemEnchantWnd L2jBRVar21;

function OnLoad ()
{
	RegisterEvent(2860);
	RegisterEvent(2870);
	RegisterEvent(2880);
	RegisterEvent(2890);
	L2jBRVar12 = GetHandle("ItemEnchantWnd");
	ItemWnd = ItemWindowHandle(GetHandle("ItemEnchantWnd.ItemWnd"));
	L2jBRVar21 = NPHRN_ItemEnchantWnd(GetScript("NPHRN_ItemEnchantWnd"));
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction129(L2jBRVar21.L2jBRVar141) )
	{
		return;
	}
	if ( UnknownFunction154(Event_ID,2860) )
	{
		HandleEnchantShow(L2jBRVar1);
	} else {
		if ( UnknownFunction154(Event_ID,2870) )
		{
			HandleEnchantHide();
		} else {
			if ( UnknownFunction154(Event_ID,2880) )
			{
				HandleEnchantItemList(L2jBRVar1);
			} else {
				if ( UnknownFunction154(Event_ID,2890) )
				{
					L2jBRFunction65(L2jBRVar1);
				}
			}
		}
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnOK":
		OnOKClick();
		break;
		case "btnCancel":
		OnCancelClick();
		break;
		default:
	}
}

function OnOKClick ()
{
	local ItemInfo L2jBRVar3;

	ItemWnd.GetSelectedItem(L2jBRVar3);
	if ( UnknownFunction151(L2jBRVar3.ServerID,0) )
	{
		Class'EnchantAPI'.RequestEnchantItem(L2jBRVar3.ServerID);
	}
}

function OnCancelClick ()
{
	Class'EnchantAPI'.RequestEnchantItem(-1);
	L2jBRVar12.HideWindow();
	Clear();
}

function Clear ()
{
	ItemWnd.Clear();
}

function HandleEnchantShow (string L2jBRVar1)
{
	local int ClassID;

	Clear();
	ParseInt(L2jBRVar1,"ClassID",ClassID);
	L2jBRVar12.SetWindowTitle(UnknownFunction112(UnknownFunction112(UnknownFunction112(GetSystemString(1220),"("),Class'UIDATA_ITEM'.GetItemName(ClassID)),")"));
	L2jBRVar12.ShowWindow();
	L2jBRVar12.SetFocus();
}

function HandleEnchantHide ()
{
	L2jBRVar12.HideWindow();
	Clear();
}

function HandleEnchantItemList (string L2jBRVar1)
{
	local ItemInfo L2jBRVar3;

	ParamToItemInfo(L2jBRVar1,L2jBRVar3);
	ItemWnd.AddItem(L2jBRVar3);
}

function L2jBRFunction65 (string L2jBRVar1)
{
	L2jBRVar12.HideWindow();
	Clear();
}

