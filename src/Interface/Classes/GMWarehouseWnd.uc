//================================================================================
// GMWarehouseWnd.
//================================================================================

class GMWarehouseWnd extends WarehouseWnd;

var bool bShow;

function OnLoad ()
{
	RegisterEvent(2360);
	RegisterEvent(2370);
	L2jBRFunction2();
	bShow = False;
}

function OnShow ()
{
	Class'UIAPI_WINDOW'.HideWindow("GMWarehouseWnd.OKButton");
	Class'UIAPI_WINDOW'.HideWindow("GMWarehouseWnd.CancelButton");
}

function ShowWarehouse (string _L2jBRVar17_)
{
	if ( UnknownFunction122(_L2jBRVar17_,"") )
	{
		return;
	}
	if ( bShow )
	{
		Clear();
		m_hOwnerWnd.HideWindow();
		bShow = False;
	} else {
		Debug(UnknownFunction112("GMwareShow param :",_L2jBRVar17_));
		Class'GMAPI'.RequestGMCommand(6,_L2jBRVar17_);
		bShow = True;
	}
}

function OnClickButton (string strID)
{
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2360:
		HandleGMObservingWarehouseItemListStart(_L2jBRVar17_);
		break;
		case 2370:
		HandleGMObservingWarehouseItemList(_L2jBRVar17_);
		break;
		default:
	}
}

function HandleGMObservingWarehouseItemListStart (string _L2jBRVar17_)
{

	L2jBRFunction6(_L2jBRVar17_);
}

function HandleGMObservingWarehouseItemList (string _L2jBRVar17_)
{
	HandleAddItem(_L2jBRVar17_);
}

function MoveItemTopToBottom (int Index, bool bAllItem)
{
}

function MoveItemBottomToTop (int Index, bool bAllItem)
{
}

defaultproperties
{
    L2jBRVar13="GMWarehouseWnd"

}
