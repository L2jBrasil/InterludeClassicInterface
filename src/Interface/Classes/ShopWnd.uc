//================================================================================
// ShopWnd.
//================================================================================

class ShopWnd extends UICommonAPI;

enum ShopType {
	ShopNone,
	ShopBuy,
	ShopSell,
	ShopPreview
};


var string L2jBRVar13;
var ShopType m_shopType;
var int m_merchantID;
var int m_npcID;
var INT64 m_currentPrice;

const DIALOG_PREVIEW= 333;
const DIALOG_BOTTOM_TO_TOP= 222;
const DIALOG_TOP_TO_BOTTOM= 111;

function OnLoad ()
{
	RegisterEvent(2080);
	RegisterEvent(2090);
	RegisterEvent(1710);
}

function Clear ()
{
	m_shopType = 0;
	m_merchantID = -1;
	m_npcID = -1;
	m_currentPrice = Int2Int64(0);
	Class'UIAPI_ITEMWINDOW'.Clear(UnknownFunction112(L2jBRVar13,".TopList"));
	Class'UIAPI_ITEMWINDOW'.Clear(UnknownFunction112(L2jBRVar13,".BottomList"));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".PriceText"),"0");
	Class'UIAPI_TEXTBOX'.SetTooltipString(UnknownFunction112(L2jBRVar13,".PriceText"),"");
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".AdenaText"),"0");
	Class'UIAPI_TEXTBOX'.SetTooltipString(UnknownFunction112(L2jBRVar13,".AdenaText"),"");
	Class'UIAPI_INVENWEIGHT'.ZeroWeight(UnknownFunction112(L2jBRVar13,".InvenWeight"));
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 2080:
		
		L2jBRFunction6(L2jBRVar1);
		break;
		case 2090:
		HandleAddItem(L2jBRVar1);
		break;
		case 1710:
		HandleDialogOK();
		break;
		default:
		break;
	}
}

function OnClickButton (string ControlName)
{
	local int Index;

	if ( UnknownFunction122(ControlName,"UpButton") )
	{
		Index = Class'UIAPI_ITEMWINDOW'.GetSelectedNum(UnknownFunction112(L2jBRVar13,".BottomList"));
		MoveItemBottomToTop(Index,False);
	} else {
		if ( UnknownFunction122(ControlName,"DownButton") )
		{
			Index = Class'UIAPI_ITEMWINDOW'.GetSelectedNum(UnknownFunction112(L2jBRVar13,".TopList"));
			MoveItemTopToBottom(Index,False);
		} else {
			if ( UnknownFunction122(ControlName,"OKButton") )
			{
				HandleOKButton();
			} else {
				if ( UnknownFunction122(ControlName,"CancelButton") )
				{
					Clear();
					HideWindow(L2jBRVar13);
				}
			}
		}
	}
}

function OnDBClickItem (string ControlName, int Index)
{
	if ( UnknownFunction122(ControlName,"TopList") )
	{
		MoveItemTopToBottom(Index,False);
	} else {
		if ( UnknownFunction122(ControlName,"BottomList") )
		{
			MoveItemBottomToTop(Index,False);
		}
	}
}

function OnDropItem (string strID, ItemInfo Info, int X, int Y)
{
	local int Index;

	if ( UnknownFunction130(UnknownFunction122(strID,"TopList"),UnknownFunction122(Info.DragSrcName,"BottomList")) )
	{
		Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID(UnknownFunction112(L2jBRVar13,".BottomList"),Info.ClassID);
		if ( UnknownFunction153(Index,0) )
		{
			MoveItemBottomToTop(Index,UnknownFunction151(Info.AllItemCount,0));
		}
	} else {
		if ( UnknownFunction130(UnknownFunction122(strID,"BottomList"),UnknownFunction122(Info.DragSrcName,"TopList")) )
		{
			Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID(UnknownFunction112(L2jBRVar13,".TopList"),Info.ClassID);
			if ( UnknownFunction153(Index,0) )
			{
				MoveItemTopToBottom(Index,UnknownFunction151(Info.AllItemCount,0));
			}
		}
	}
}

function MoveItemTopToBottom (int Index, bool bAllItem)
{
	local int bottomIndex;
	local ItemInfo Info;
	local ItemInfo bottomInfo;

	if ( Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".TopList"),Index,Info) )
	{
		if ( UnknownFunction130(UnknownFunction130(UnknownFunction129(bAllItem),IsStackableItem(Info.ConsumeType)),UnknownFunction155(Info.ItemNum,1)) )
		{
			DialogSetID(111);
			DialogSetReservedInt(Info.ClassID);
			DialogSetDefaultOK();
			if ( UnknownFunction154(m_shopType,2) )
			{
				DialogSetParamInt(Info.ItemNum);
			} else {
				DialogSetParamInt(-1);
			}
			DialogSetDefaultOK();
			DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),Info.Name,""));
		} else {
			Info.bShowCount = False;
			if ( UnknownFunction154(m_shopType,2) )
			{
				bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID(UnknownFunction112(L2jBRVar13,".BottomList"),Info.ClassID);
				if ( UnknownFunction130(UnknownFunction153(bottomIndex,0),IsStackableItem(Info.ConsumeType)) )
				{
					Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".BottomList"),bottomIndex,bottomInfo);
					UnknownFunction161(bottomInfo.ItemNum,Info.ItemNum);
					Class'UIAPI_ITEMWINDOW'.SetItem(UnknownFunction112(L2jBRVar13,".BottomList"),bottomIndex,bottomInfo);
				} else {
					Class'UIAPI_ITEMWINDOW'.AddItem(UnknownFunction112(L2jBRVar13,".BottomList"),Info);
				}
				Class'UIAPI_ITEMWINDOW'.DeleteItem(UnknownFunction112(L2jBRVar13,".TopList"),Index);
			} else {
				if ( UnknownFunction154(m_shopType,1) )
				{
					Info.ItemNum = 1;
					Class'UIAPI_ITEMWINDOW'.AddItem(UnknownFunction112(L2jBRVar13,".BottomList"),Info);
					Class'UIAPI_INVENWEIGHT'.AddWeight(UnknownFunction112(L2jBRVar13,".InvenWeight"),UnknownFunction144(Info.Weight,Info.ItemNum));
				} else {
					if ( UnknownFunction154(m_shopType,3) )
					{
						bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID(UnknownFunction112(L2jBRVar13,".BottomList"),Info.ClassID);
						Info.ItemNum = 1;
						Class'UIAPI_ITEMWINDOW'.AddItem(UnknownFunction112(L2jBRVar13,".BottomList"),Info);
					}
				}
			}
			AddPrice(Int64Mul(Info.Price,Info.ItemNum));
		}
	}
}

function MoveItemBottomToTop (int Index, bool bAllItem)
{
	local ItemInfo Info;
	local ItemInfo info2;
	local int bottomIndex;

	if ( Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".BottomList"),Index,Info) )
	{
		if ( UnknownFunction130(UnknownFunction129(bAllItem),IsStackableItem(Info.ConsumeType)) )
		{
			DialogSetID(222);
			DialogSetDefaultOK();
			DialogSetReservedInt(Info.ClassID);
			DialogSetParamInt(Info.ItemNum);
			DialogSetDefaultOK();
			DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),Info.Name,""));
		} else {
			Class'UIAPI_ITEMWINDOW'.DeleteItem(UnknownFunction112(L2jBRVar13,".BottomList"),Index);
			if ( UnknownFunction154(m_shopType,2) )
			{
				bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithServerID(UnknownFunction112(L2jBRVar13,".TopList"),Info.ServerID);
				if ( UnknownFunction154(bottomIndex,-1) )
				{
					Class'UIAPI_ITEMWINDOW'.AddItem(UnknownFunction112(L2jBRVar13,".TopList"),Info);
				} else {
					Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".TopList"),bottomIndex,info2);
					UnknownFunction161(info2.ItemNum,Info.ItemNum);
					Class'UIAPI_ITEMWINDOW'.SetItem(UnknownFunction112(L2jBRVar13,".TopList"),bottomIndex,info2);
				}
			} else {
				if ( UnknownFunction154(m_shopType,1) )
				{
					Class'UIAPI_INVENWEIGHT'.ReduceWeight(UnknownFunction112(L2jBRVar13,".InvenWeight"),UnknownFunction144(Info.Weight,Info.ItemNum));
				}
			}
			AddPrice(Int64Mul(UnknownFunction143(Info.Price),Info.ItemNum));
		}
	}
}

function HandleDialogOK ()
{
	local int Id;
	local int Num;
	local int ClassID;
	local int Index;
	local int topIndex;
	local ItemInfo Info;
	local ItemInfo topInfo;
	local string L2jBRVar1;

	if ( DialogIsMine() )
	{
		Id = DialogGetID();
		Num = int(DialogGetString());
		ClassID = DialogGetReservedInt();
		if ( UnknownFunction130(UnknownFunction154(Id,111),UnknownFunction151(Num,0)) )
		{
			topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID(UnknownFunction112(L2jBRVar13,".TopList"),ClassID);
			if ( UnknownFunction153(topIndex,0) )
			{
				Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".TopList"),topIndex,topInfo);
				if ( UnknownFunction154(m_shopType,2) )
				{
					Num = UnknownFunction249(Num,topInfo.ItemNum);
				}
				Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID(UnknownFunction112(L2jBRVar13,".BottomList"),ClassID);
				if ( UnknownFunction153(Index,0) )
				{
					Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".BottomList"),Index,Info);
					UnknownFunction161(Info.ItemNum,Num);
					Class'UIAPI_ITEMWINDOW'.SetItem(UnknownFunction112(L2jBRVar13,".BottomList"),Index,Info);
					AddPrice(Int64Mul(Num,Info.Price));
				} else {
					Info = topInfo;
					Info.ItemNum = Num;
					Info.bShowCount = False;
					Class'UIAPI_ITEMWINDOW'.AddItem(UnknownFunction112(L2jBRVar13,".BottomList"),Info);
					AddPrice(Int64Mul(Num,Info.Price));
				}
				if ( UnknownFunction154(m_shopType,2) )
				{
					UnknownFunction162(topInfo.ItemNum,Num);
					if ( UnknownFunction152(topInfo.ItemNum,0) )
					{
						Class'UIAPI_ITEMWINDOW'.DeleteItem(UnknownFunction112(L2jBRVar13,".TopList"),topIndex);
					} else {
						Class'UIAPI_ITEMWINDOW'.SetItem(UnknownFunction112(L2jBRVar13,".TopList"),topIndex,topInfo);
					}
				} else {
					if ( UnknownFunction154(m_shopType,1) )
					{
						Class'UIAPI_INVENWEIGHT'.AddWeight(UnknownFunction112(L2jBRVar13,".InvenWeight"),UnknownFunction144(Info.Weight,Num));
					}
				}
			}
		} else {
			if ( UnknownFunction130(UnknownFunction154(Id,222),UnknownFunction151(Num,0)) )
			{
				Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID(UnknownFunction112(L2jBRVar13,".BottomList"),ClassID);
				if ( UnknownFunction153(Index,0) )
				{
					Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".BottomList"),Index,Info);
					UnknownFunction162(Info.ItemNum,Num);
					if ( UnknownFunction151(Info.ItemNum,0) )
					{
						Class'UIAPI_ITEMWINDOW'.SetItem(UnknownFunction112(L2jBRVar13,".BottomList"),Index,Info);
					} else {
						Class'UIAPI_ITEMWINDOW'.DeleteItem(UnknownFunction112(L2jBRVar13,".BottomList"),Index);
					}
					if ( UnknownFunction154(m_shopType,2) )
					{
						topIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID(UnknownFunction112(L2jBRVar13,".TopList"),ClassID);
						if ( UnknownFunction130(UnknownFunction153(topIndex,0),IsStackableItem(Info.ConsumeType)) )
						{
							Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".TopList"),topIndex,topInfo);
							UnknownFunction161(topInfo.ItemNum,Num);
							Class'UIAPI_ITEMWINDOW'.SetItem(UnknownFunction112(L2jBRVar13,".TopList"),topIndex,topInfo);
						} else {
							Info.ItemNum = Num;
							Class'UIAPI_ITEMWINDOW'.AddItem(UnknownFunction112(L2jBRVar13,".TopList"),Info);
						}
					} else {
						if ( UnknownFunction154(m_shopType,1) )
						{
							Class'UIAPI_INVENWEIGHT'.ReduceWeight(UnknownFunction112(L2jBRVar13,".InvenWeight"),UnknownFunction144(Info.Weight,Num));
						}
					}
					if ( UnknownFunction152(Info.ItemNum,0) )
					{
						Num = UnknownFunction146(Info.ItemNum,Num);
					}
					AddPrice(Int64Mul(UnknownFunction143(Num),Info.Price));
				}
			} else {
				if ( UnknownFunction154(Id,333) )
				{
					Num = Class'UIAPI_ITEMWINDOW'.GetItemNum(UnknownFunction112(L2jBRVar13,".BottomList"));
					if ( UnknownFunction151(Num,0) )
					{
						ParamAdd(L2jBRVar1,"merchant",string(m_merchantID));
						ParamAdd(L2jBRVar1,"npc",string(m_npcID));
						ParamAdd(L2jBRVar1,"num",string(Num));
						Index = 0;
						if ( UnknownFunction150(Index,Num) )
						{
							Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".BottomList"),Index,Info);
							ParamAdd(L2jBRVar1,UnknownFunction112("classID",string(Index)),string(Info.ClassID));
							UnknownFunction163(Index);
							goto JL05DD;
						}
						RequestPreviewItem(L2jBRVar1);
					}
				}
			}
		}
	}
}

function L2jBRFunction6 (string L2jBRVar1)
{
	local string L2jBRVar5;
	local int Adena;
	local string L2jBRVar14;
	local WindowHandle m_inventoryWnd;

	m_inventoryWnd = GetHandle("InventoryWnd");
	Clear();
	ParseString(L2jBRVar1,"type",L2jBRVar5);
	ParseInt(L2jBRVar1,"merchant",m_merchantID);
	ParseInt(L2jBRVar1,"adena",Adena);
	if ( UnknownFunction122(L2jBRVar5,"buy") )
	{
		m_shopType = 1;
	} else {
		if ( UnknownFunction122(L2jBRVar5,"sell") )
		{
			m_shopType = 2;
		} else {
			if ( UnknownFunction122(L2jBRVar5,"preview") )
			{
				m_shopType = 3;
			} else {
				m_shopType = 0;
			}
		}
	}
	L2jBRVar14 = MakeCostString(string(Adena));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".AdenaText"),L2jBRVar14);
	Class'UIAPI_TEXTBOX'.SetTooltipString(UnknownFunction112(L2jBRVar13,".AdenaText"),ConvertNumToText(string(Adena)));
	if ( m_inventoryWnd.IsShowWindow() )
	{
		m_inventoryWnd.HideWindow();
	}
	ShowWindow(L2jBRVar13);
	Class'UIAPI_WINDOW'.SetFocus(L2jBRVar13);
	if ( UnknownFunction122(L2jBRVar5,"buy") )
	{
		Class'UIAPI_WINDOW'.SetTooltipType(UnknownFunction112(L2jBRVar13,".TopList"),"InventoryPrice1HideEnchantStackable");
		Class'UIAPI_WINDOW'.SetTooltipType(UnknownFunction112(L2jBRVar13,".BottomList"),"InventoryPrice1");
		Class'UIAPI_WINDOW'.SetWindowTitle(L2jBRVar13,136);
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".TopText"),GetSystemString(137));
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".BottomText"),GetSystemString(139));
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".PriceConstText"),GetSystemString(142));
	} else {
		if ( UnknownFunction122(L2jBRVar5,"sell") )
		{
			Class'UIAPI_WINDOW'.SetTooltipType(UnknownFunction112(L2jBRVar13,".TopList"),"InventoryPrice2");
			Class'UIAPI_WINDOW'.SetTooltipType(UnknownFunction112(L2jBRVar13,".BottomList"),"InventoryPrice2");
			Class'UIAPI_WINDOW'.SetWindowTitle(L2jBRVar13,136);
			Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".TopText"),GetSystemString(138));
			Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".BottomText"),GetSystemString(137));
			Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".PriceConstText"),GetSystemString(143));
		} else {
			if ( UnknownFunction122(L2jBRVar5,"preview") )
			{
				ParseInt(L2jBRVar1,"npc",m_npcID);
				Class'UIAPI_WINDOW'.SetTooltipType(UnknownFunction112(L2jBRVar13,".TopList"),"InventoryPrice1HideEnchantStackable");
				Class'UIAPI_WINDOW'.SetTooltipType(UnknownFunction112(L2jBRVar13,".BottomList"),"InventoryPrice1");
				Class'UIAPI_WINDOW'.SetWindowTitle(L2jBRVar13,847);
				Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".TopText"),GetSystemString(811));
				Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".BottomText"),GetSystemString(812));
				Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".PriceConstText"),GetSystemString(813));
			}
		}
	}
}

function HandleAddItem (string L2jBRVar1)
{
	local ItemInfo Info;

	ParamToItemInfo(L2jBRVar1,Info);
	if ( UnknownFunction130(UnknownFunction154(m_shopType,1),UnknownFunction151(Info.ItemNum,0)) )
	{
		Info.bShowCount = True;
	}
	Class'UIAPI_ITEMWINDOW'.AddItem(UnknownFunction112(L2jBRVar13,".TopList"),Info);
}

function AddPrice (INT64 Price)
{
	local string Adena;

	m_currentPrice = Int64Add(m_currentPrice,Price);
	if ( UnknownFunction132(UnknownFunction150(m_currentPrice.nLeft,0),UnknownFunction150(m_currentPrice.nRight,0)) )
	{
		m_currentPrice = Int2Int64(0);
	}
	Adena = MakeCostStringInt64(m_currentPrice);
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".PriceText"),Adena);
	Class'UIAPI_TEXTBOX'.SetTooltipString(UnknownFunction112(L2jBRVar13,".PriceText"),ConvertNumToText(Int64ToString(m_currentPrice)));
}

function HandleOKButton ()
{
	local string L2jBRVar1;
	local int topCount;
	local int bottomCount;
	local int topIndex;
	local int bottomIndex;
	local ItemInfo topInfo;
	local ItemInfo bottomInfo;
	local int limitedItemCount;

	bottomCount = Class'UIAPI_ITEMWINDOW'.GetItemNum(UnknownFunction112(L2jBRVar13,".BottomList"));
	if ( UnknownFunction154(m_shopType,1) )
	{
		topCount = Class'UIAPI_ITEMWINDOW'.GetItemNum(UnknownFunction112(L2jBRVar13,".TopList"));
		topIndex = 0;
		if ( UnknownFunction150(topIndex,topCount) )
		{
			Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".TopList"),topIndex,topInfo);
			if ( UnknownFunction151(topInfo.ItemNum,0) )
			{
				limitedItemCount = 0;
				bottomCount = Class'UIAPI_ITEMWINDOW'.GetItemNum(UnknownFunction112(L2jBRVar13,".BottomList"));
				bottomIndex = 0;
				if ( UnknownFunction150(bottomIndex,bottomCount) )
				{
					Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".BottomList"),bottomIndex,bottomInfo);
					if ( UnknownFunction154(bottomInfo.ClassID,topInfo.ClassID) )
					{
						UnknownFunction161(limitedItemCount,bottomInfo.ItemNum);
					}
					UnknownFunction163(bottomIndex);
					goto JL00E6;
				}
				if ( UnknownFunction151(limitedItemCount,topInfo.ItemNum) )
				{
					DialogShow(4,GetSystemMessage(1338));
					return;
				}
			}
			UnknownFunction163(topIndex);
			goto JL0066;
		}
		ParamAdd(L2jBRVar1,"merchant",string(m_merchantID));
		ParamAdd(L2jBRVar1,"num",string(bottomCount));
		bottomIndex = 0;
		if ( UnknownFunction150(bottomIndex,bottomCount) )
		{
			Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".BottomList"),bottomIndex,bottomInfo);
			ParamAdd(L2jBRVar1,UnknownFunction112("classID",string(bottomIndex)),string(bottomInfo.ClassID));
			ParamAdd(L2jBRVar1,UnknownFunction112("count",string(bottomIndex)),string(bottomInfo.ItemNum));
			UnknownFunction163(bottomIndex);
			goto JL01C3;
		}
		RequestBuyItem(L2jBRVar1);
	} else {
		if ( UnknownFunction154(m_shopType,2) )
		{
			ParamAdd(L2jBRVar1,"merchant",string(m_merchantID));
			ParamAdd(L2jBRVar1,"num",string(bottomCount));
			bottomIndex = 0;
			if ( UnknownFunction150(bottomIndex,bottomCount) )
			{
				Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".BottomList"),bottomIndex,bottomInfo);
				ParamAdd(L2jBRVar1,UnknownFunction112("serverID",string(bottomIndex)),string(bottomInfo.ServerID));
				ParamAdd(L2jBRVar1,UnknownFunction112("classID",string(bottomIndex)),string(bottomInfo.ClassID));
				ParamAdd(L2jBRVar1,UnknownFunction112("count",string(bottomIndex)),string(bottomInfo.ItemNum));
				UnknownFunction163(bottomIndex);
				goto JL02B1;
			}
			RequestSellItem(L2jBRVar1);
		} else {
			if ( UnknownFunction154(m_shopType,3) )
			{
				if ( UnknownFunction151(bottomCount,0) )
				{
					DialogSetID(333);
					DialogShow(4,GetSystemMessage(1157));
				}
			}
		}
	}
	HideWindow(L2jBRVar13);
}

defaultproperties
{
    L2jBRVar13="ShopWnd"

}
