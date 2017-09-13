//================================================================================
// TradeWnd.
//================================================================================

class TradeWnd extends UICommonAPI;

const DIALOG_ID_ITEM_NUMBER= 1;
const DIALOG_ID_TRADE_REQUEST= 0;

function OnLoad ()
{
	RegisterEvent(1710);
	RegisterEvent(1720);
	RegisterEvent(1950);
	RegisterEvent(1960);
	RegisterEvent(1970);
	RegisterEvent(1980);
	RegisterEvent(1990);
	RegisterEvent(2000);
}

function OnSendPacketWhenHiding ()
{
	RequestTradeDone(False);
}

function OnHide ()
{
	Clear();
}

function OnEvent (int EventID, string L2jBRVar1)
{
	switch (EventID)
	{
		case 1950:
		HandleStartTrade(L2jBRVar1);
		break;
		case 1960:
		HandleTradeAddItem(L2jBRVar1);
		break;
		case 1970:
		HandleTradeDone(L2jBRVar1);
		break;
		case 1980:
		HandleTradeOtherOK(L2jBRVar1);
		break;
		case 1990:
		HandleTradeUpdateInventoryItem(L2jBRVar1);
		break;
		case 2000:
		HandleReceiveStartTrade(L2jBRVar1);
		break;
		case 1710:
		HandleDialogOK();
		break;
		case 1720:
		HandleDialogCancel();
		break;
		default:
		break;
	}
}

function OnClickButton (string ControlName)
{
	if ( UnknownFunction122(ControlName,"OKButton") )
	{
		Class'UIAPI_ITEMWINDOW'.SetFaded("TradeWnd.MyList",True);
		RequestTradeDone(True);
	} else {
		if ( UnknownFunction122(ControlName,"CancelButton") )
		{
			RequestTradeDone(False);
		} else {
			if ( UnknownFunction122(ControlName,"MoveButton") )
			{
				HandleMoveButton();
			}
		}
	}
}

function OnDBClickItem (string ControlName, int Index)
{
	local ItemInfo Info;

	if ( UnknownFunction122(ControlName,"InventoryList") )
	{
		if ( Class'UIAPI_ITEMWINDOW'.GetItem("TradeWnd.InventoryList",Index,Info) )
		{
			if ( UnknownFunction130(IsStackableItem(Info.ConsumeType),UnknownFunction155(Info.ItemNum,1)) )
			{
				DialogSetID(1);
				DialogSetReservedInt(Info.ServerID);
				DialogSetParamInt(Info.ItemNum);
				DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),Info.Name,""));
			} else {
				RequestAddTradeItem(Info.ServerID,1);
			}
		}
	}
}

function OnDropItem (string strID, ItemInfo Info, int X, int Y)
{
	if ( UnknownFunction130(UnknownFunction122(strID,"MyList"),UnknownFunction122(Info.DragSrcName,"InventoryList")) )
	{
		if ( IsStackableItem(Info.ConsumeType) )
		{
			if ( UnknownFunction151(Info.AllItemCount,0) )
			{
				RequestAddTradeItem(Info.ServerID,Info.AllItemCount);
			} else {
				if ( UnknownFunction154(Info.ItemNum,1) )
				{
					RequestAddTradeItem(Info.ServerID,1);
				} else {
					DialogSetID(1);
					DialogSetReservedInt(Info.ServerID);
					DialogSetParamInt(Info.ItemNum);
					DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),Info.Name,""));
				}
			}
		} else {
			RequestAddTradeItem(Info.ServerID,1);
		}
	}
}

function MoveToMyList (int Index, int Num)
{
	local ItemInfo Info;

	if ( Class'UIAPI_ITEMWINDOW'.GetItem("TradeWnd.InventoryList",Index,Info) )
	{
		RequestAddTradeItem(Info.ServerID,Num);
	}
}

function HandleMoveButton ()
{
	local int Selected;
	local ItemInfo Info;

	Selected = Class'UIAPI_ITEMWINDOW'.GetSelectedNum("TradeWnd.InventoryList");
	if ( UnknownFunction153(Selected,0) )
	{
		Class'UIAPI_ITEMWINDOW'.GetItem("TradeWnd.InventoryList",Selected,Info);
		if ( UnknownFunction154(Info.ItemNum,1) )
		{
			MoveToMyList(Selected,1);
		} else {
			DialogSetID(1);
			DialogSetReservedInt(Info.ServerID);
			DialogSetParamInt(Info.ItemNum);
			DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),Info.Name,""));
		}
	}
}

function HandleStartTrade (string L2jBRVar1)
{
	local int L2jBRVar210;
	local UserInfo TargetInfo;
	local string ClanName;
	local WindowHandle m_inventoryWnd;
	local WindowHandle m_warehouseWnd;
	local WindowHandle m_privateShopWnd;
	local WindowHandle m_shopWnd;
	local WindowHandle m_multiSellWnd;

	m_inventoryWnd = GetHandle("InventoryWnd");
	m_warehouseWnd = GetHandle("WarehouseWnd");
	m_privateShopWnd = GetHandle("PrivateShopWnd");
	m_shopWnd = GetHandle("ShopWnd");
	m_multiSellWnd = GetHandle("MultiSellWnd");
	if ( m_inventoryWnd.IsShowWindow() )
	{
		m_inventoryWnd.HideWindow();
	}
	if ( m_warehouseWnd.IsShowWindow() )
	{
		m_warehouseWnd.HideWindow();
	}
	if ( m_privateShopWnd.IsShowWindow() )
	{
		m_privateShopWnd.HideWindow();
	}
	if ( m_shopWnd.IsShowWindow() )
	{
		m_shopWnd.HideWindow();
	}
	if ( m_multiSellWnd.IsShowWindow() )
	{
		m_multiSellWnd.HideWindow();
	}
	Class'UIAPI_WINDOW'.ShowWindow("TradeWnd");
	Class'UIAPI_WINDOW'.SetFocus("TradeWnd");
	ParseInt(L2jBRVar1,"targetId",L2jBRVar210);
	if ( UnknownFunction151(L2jBRVar210,0) )
	{
		GetUserInfo(L2jBRVar210,TargetInfo);
		if ( UnknownFunction151(TargetInfo.nClanID,0) )
		{
			ClanName = GetClanName(TargetInfo.nClanID);
			Class'UIAPI_TEXTBOX'.SetText("TradeWnd.Targetname",UnknownFunction112(UnknownFunction112(TargetInfo.Name," - "),ClanName));
		} else {
			Class'UIAPI_TEXTBOX'.SetText("TradeWnd.Targetname",TargetInfo.Name);
		}
	}
}

function HandleTradeAddItem (string L2jBRVar1)
{
	local string strDest;	
	local ItemInfo tempInfo;
	local ItemInfo ItemInfo;
	local int Index;

	ParseString(L2jBRVar1,"destination",strDest);
	ParamToItemInfo(L2jBRVar1,ItemInfo);
	if ( UnknownFunction122(strDest,"inventoryList") )
	{
		strDest = "TradeWnd.InventoryList";
	} else {
		if ( UnknownFunction122(strDest,"myList") )
		{
			strDest = "TradeWnd.MyList";
			Class'UIAPI_INVENWEIGHT'.ReduceWeight("TradeWnd.InvenWeight",UnknownFunction144(ItemInfo.ItemNum,ItemInfo.Weight));
		} else {
			if ( UnknownFunction122(strDest,"otherList") )
			{
				strDest = "TradeWnd.OtherList";
				Class'UIAPI_INVENWEIGHT'.AddWeight("TradeWnd.InvenWeight",UnknownFunction144(ItemInfo.ItemNum,ItemInfo.Weight));
			}
		}
	}
	Index = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID(strDest,ItemInfo.ServerID);
	if ( UnknownFunction153(Index,0) )
	{
		if ( IsStackableItem(ItemInfo.ConsumeType) )
		{
			Class'UIAPI_ITEMWINDOW'.GetItem(strDest,Index,tempInfo);
			UnknownFunction161(ItemInfo.ItemNum,tempInfo.ItemNum);
			Class'UIAPI_ITEMWINDOW'.SetItem(strDest,Index,ItemInfo);
		}
	} else {
		Class'UIAPI_ITEMWINDOW'.AddItem(strDest,ItemInfo);
	}
}

function HandleTradeDone (string L2jBRVar1)
{
	Class'UIAPI_WINDOW'.HideWindow("TradeWnd");
}

function HandleTradeOtherOK (string L2jBRVar1)
{
	Class'UIAPI_ITEMWINDOW'.SetFaded("TradeWnd.OtherList",True);
}

function HandleTradeUpdateInventoryItem (string L2jBRVar1)
{
	local ItemInfo Info;
	local string L2jBRVar5;
	local int Index;

	ParseString(L2jBRVar1,"type",L2jBRVar5);
	ParamToItemInfo(L2jBRVar1,Info);
	if ( UnknownFunction122(L2jBRVar5,"add") )
	{
		Class'UIAPI_ITEMWINDOW'.AddItem("TradeWnd.InventoryList",Info);
	} else {
		if ( UnknownFunction122(L2jBRVar5,"update") )
		{
			Index = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("TradeWnd.InventoryList",Info.ServerID);
			if ( UnknownFunction153(Index,0) )
			{
				Class'UIAPI_ITEMWINDOW'.SetItem("TradeWnd.InventoryList",Index,Info);
			}
		} else {
			if ( UnknownFunction122(L2jBRVar5,"delete") )
			{
				Index = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID("TradeWnd.InventoryList",Info.ServerID);
				if ( UnknownFunction153(Index,0) )
				{
					Class'UIAPI_ITEMWINDOW'.DeleteItem("TradeWnd.InventoryList",Index);
				}
			}
		}
	}
}

function HandleReceiveStartTrade (string L2jBRVar1)
{
	local int L2jBRVar210;
	local UserInfo Info;

	ParseInt(L2jBRVar1,"targetID",L2jBRVar210);
	if ( UnknownFunction130(UnknownFunction151(L2jBRVar210,0),GetUserInfo(L2jBRVar210,Info)) )
	{
		DialogSetID(0);
		DialogSetParamInt(UnknownFunction144(10,1000));
		DialogShow(7,MakeFullSystemMsg(GetSystemMessage(100),Info.Name,""));
	}
}

function HandleDialogOK ()
{
	local int ServerID;
	local int Num;

	if ( DialogIsMine() )
	{
		if ( UnknownFunction154(DialogGetID(),0) )
		{
			AnswerTradeRequest(True);
		} else {
			if ( UnknownFunction154(DialogGetID(),1) )
			{
				ServerID = DialogGetReservedInt();
				Num = int(DialogGetString());
				RequestAddTradeItem(ServerID,Num);
			}
		}
	}
}

function HandleDialogCancel ()
{
	if ( DialogIsMine() )
	{
		if ( UnknownFunction154(DialogGetID(),0) )
		{
			AnswerTradeRequest(False);
		}
	}
}

function Clear ()
{
	Class'UIAPI_ITEMWINDOW'.Clear("TradeWnd.InventoryList");
	Class'UIAPI_ITEMWINDOW'.Clear("TradeWnd.MyList");
	Class'UIAPI_ITEMWINDOW'.Clear("TradeWnd.OtherList");
	Class'UIAPI_TEXTBOX'.SetText("TradeWnd.TargetName","");
	Class'UIAPI_INVENWEIGHT'.ZeroWeight("TradeWnd.InvenWeight");
}

