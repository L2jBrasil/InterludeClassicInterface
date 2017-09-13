//================================================================================
// SelectDeliverWnd.
//================================================================================

class SelectDeliverWnd extends UICommonAPI;

function OnLoad ()
{
	RegisterEvent(2140);
	RegisterEvent(2150);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 2140:
		Class'UIAPI_COMBOBOX'.Clear("SelectDeliverWnd.SelectDeliverCombo");
		ShowWindow("SelectDeliverWnd");
		Class'UIAPI_WINDOW'.SetFocus("SelectDeliverWnd");
		break;
		case 2150:
		HandleAddName(L2jBRVar1);
		break;
		default:
		break;
	}
}

function HandleAddName (string L2jBRVar1)
{
	local string Name;
	local int Id;

	ParseString(L2jBRVar1,"name",Name);
	ParseInt(L2jBRVar1,"id",Id);
	Class'UIAPI_COMBOBOX'.AddStringWithReserved("SelectDeliverWnd.SelectDeliverCombo",Name,Id);
}

function OnClickButton (string ControlName)
{
	if ( UnknownFunction122(ControlName,"OKButton") )
	{
		HandleOKButtonClick();
	} else {
		if ( UnknownFunction122(ControlName,"CancelButton") )
		{
			HideWindow("SelectDeliverWnd");
		}
	}
}

function HandleOKButtonClick ()
{
	local int Selected;
	local int reservedID;

	Selected = Class'UIAPI_COMBOBOX'.GetSelectedNum("SelectDeliverWnd.SelectDeliverCombo");
	if ( UnknownFunction153(Selected,0) )
	{
		reservedID = Class'UIAPI_COMBOBOX'.GetReserved("SelectDeliverWnd.SelectDeliverCombo",Selected);
		RequestPackageSendableItemList(reservedID);
	}
	HideWindow("SelectDeliverWnd");
}

