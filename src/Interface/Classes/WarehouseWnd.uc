//================================================================================
// WarehouseWnd.
//================================================================================

class WarehouseWnd extends UICommonAPI;

enum WarehouseType {
	WT_Deposit,
	WT_Withdraw
};

enum WarehouseCategory {
	WC_None,
	WC_Private,
	WC_Clan,
	WC_Castle,
	WC_Etc
};


var WarehouseCategory m_category;
var WarehouseType m_type;
var int m_maxPrivateCount;
var string L2jBRVar13;
var ItemWindowHandle m_topList;
var ItemWindowHandle m_bottomList;

const DIALOG_BOTTOM_TO_TOP= 222;
const DIALOG_TOP_TO_BOTTOM= 111;
const DEFAULT_MAX_COUNT= 200;
const KEEPING_PRICE= 30;

function OnLoad ()
{
	RegisterEvent(2100);
	RegisterEvent(2110);
	RegisterEvent(2070);
	RegisterEvent(1710);
	L2jBRFunction2();
}

function L2jBRFunction2 ()
{
	m_topList = ItemWindowHandle(GetHandle("TopList"));
	m_bottomList = ItemWindowHandle(GetHandle("BottomList"));
}

function Clear ()
{
	m_type = 0;
	m_category = 0;
	m_topList.Clear();
	m_bottomList.Clear();
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".PriceText"),"0");
	Class'UIAPI_TEXTBOX'.SetTooltipString(UnknownFunction112(L2jBRVar13,".PriceText"),"");
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".AdenaText"),"0");
	Class'UIAPI_TEXTBOX'.SetTooltipString(UnknownFunction112(L2jBRVar13,".AdenaText"),"");
	Class'UIAPI_INVENWEIGHT'.ZeroWeight("WarehouseWnd.InvenWeight");
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 2100:
		
		L2jBRFunction6(L2jBRVar1);
		break;
		case 2110:
		HandleAddItem(L2jBRVar1);
		break;
		case 2070:
		HandleSetMaxCount(L2jBRVar1);
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
		Index = m_bottomList.GetSelectedNum();
		MoveItemBottomToTop(Index,False);
	} else {
		if ( UnknownFunction122(ControlName,"DownButton") )
		{
			Index = m_topList.GetSelectedNum();
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

function OnClickItem (string ControlName, int Index)
{
	local WindowHandle m_dialogWnd;

	m_dialogWnd = GetHandle("DialogBox");
	if ( UnknownFunction122(ControlName,"TopList") )
	{
		if ( UnknownFunction130(DialogIsMine(),m_dialogWnd.IsShowWindow()) )
		{
			DialogHide();
			m_dialogWnd.HideWindow();
		}
	}
}

function OnDropItem (string strID, ItemInfo Info, int X, int Y)
{
	local int Index;

	if ( UnknownFunction130(UnknownFunction122(strID,"TopList"),UnknownFunction122(Info.DragSrcName,"BottomList")) )
	{
		Index = m_bottomList.FindItemWithClassID(Info.ClassID);
		if ( UnknownFunction153(Index,0) )
		{
			MoveItemBottomToTop(Index,UnknownFunction151(Info.AllItemCount,0));
		}
	} else {
		if ( UnknownFunction130(UnknownFunction122(strID,"BottomList"),UnknownFunction122(Info.DragSrcName,"TopList")) )
		{
			Index = m_topList.FindItemWithClassID(Info.ClassID);
			if ( UnknownFunction153(Index,0) )
			{
				MoveItemTopToBottom(Index,UnknownFunction151(Info.AllItemCount,0));
			}
		}
	}
}

function MoveItemTopToBottom (int Index, bool bAllItem)
{
	local ItemInfo topInfo;
	local ItemInfo bottomInfo;
	local int bottomIndex;

	if ( m_topList.GetItem(Index,topInfo) )
	{
		if ( UnknownFunction130(UnknownFunction130(UnknownFunction129(bAllItem),IsStackableItem(topInfo.ConsumeType)),UnknownFunction151(topInfo.ItemNum,1)) )
		{
			DialogSetID(111);
			DialogSetReservedInt(topInfo.ClassID);
			DialogSetParamInt(topInfo.ItemNum);
			DialogSetDefaultOK();
			DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),topInfo.Name,""));
		} else {
			bottomIndex = m_bottomList.FindItemWithClassID(topInfo.ClassID);
			if ( UnknownFunction130(UnknownFunction155(bottomIndex,-1),IsStackableItem(topInfo.ConsumeType)) )
			{
				m_bottomList.GetItem(bottomIndex,bottomInfo);
				UnknownFunction161(bottomInfo.ItemNum,topInfo.ItemNum);
				m_bottomList.SetItem(bottomIndex,bottomInfo);
			} else {
				m_bottomList.AddItem(topInfo);
			}
			m_topList.DeleteItem(Index);
			if ( UnknownFunction154(m_type,1) )
			{
				Class'UIAPI_INVENWEIGHT'.AddWeight("WarehouseWnd.InvenWeight",UnknownFunction144(topInfo.ItemNum,topInfo.Weight));
			}
			AdjustPrice();
			AdjustCount();
		}
	}
}

function MoveItemBottomToTop (int Index, bool bAllItem)
{
	local ItemInfo bottomInfo;
	local ItemInfo topInfo;
	local int topIndex;

	if ( m_bottomList.GetItem(Index,bottomInfo) )
	{
		if ( UnknownFunction130(UnknownFunction130(UnknownFunction129(bAllItem),IsStackableItem(bottomInfo.ConsumeType)),UnknownFunction151(bottomInfo.ItemNum,1)) )
		{
			DialogSetID(222);
			DialogSetReservedInt(bottomInfo.ClassID);
			DialogSetParamInt(bottomInfo.ItemNum);
			DialogSetDefaultOK();
			DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),bottomInfo.Name,""));
		} else {
			topIndex = m_topList.FindItemWithClassID(bottomInfo.ClassID);
			if ( UnknownFunction130(UnknownFunction155(topIndex,-1),IsStackableItem(bottomInfo.ConsumeType)) )
			{
				m_topList.GetItem(topIndex,topInfo);
				UnknownFunction161(topInfo.ItemNum,bottomInfo.ItemNum);
				m_topList.SetItem(topIndex,topInfo);
			} else {
				m_topList.AddItem(bottomInfo);
			}
			m_bottomList.DeleteItem(Index);
			if ( UnknownFunction154(m_type,1) )
			{
				Class'UIAPI_INVENWEIGHT'.ReduceWeight("WarehouseWnd.InvenWeight",UnknownFunction144(bottomInfo.ItemNum,bottomInfo.Weight));
			}
			AdjustPrice();
			AdjustCount();
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

	if ( DialogIsMine() )
	{
		Id = DialogGetID();
		Num = int(DialogGetString());
		ClassID = DialogGetReservedInt();
		if ( UnknownFunction130(UnknownFunction154(Id,111),UnknownFunction151(Num,0)) )
		{
			topIndex = m_topList.FindItemWithClassID(ClassID);
			if ( UnknownFunction153(topIndex,0) )
			{
				m_topList.GetItem(topIndex,topInfo);
				Index = m_bottomList.FindItemWithClassID(ClassID);
				if ( UnknownFunction153(Index,0) )
				{
					m_bottomList.GetItem(Index,Info);
					UnknownFunction161(Info.ItemNum,Num);
					m_bottomList.SetItem(Index,Info);
				} else {
					Info = topInfo;
					Info.ItemNum = Num;
					Info.bShowCount = False;
					m_bottomList.AddItem(Info);
				}
				if ( UnknownFunction154(m_type,1) )
				{
					Class'UIAPI_INVENWEIGHT'.AddWeight("WarehouseWnd.InvenWeight",UnknownFunction144(Info.ItemNum,Info.Weight));
				}
				UnknownFunction162(topInfo.ItemNum,Num);
				if ( UnknownFunction152(topInfo.ItemNum,0) )
				{
					m_topList.DeleteItem(topIndex);
				} else {
					m_topList.SetItem(topIndex,topInfo);
				}
			}
		} else {
			if ( UnknownFunction130(UnknownFunction154(Id,222),UnknownFunction151(Num,0)) )
			{
				Index = m_bottomList.FindItemWithClassID(ClassID);
				if ( UnknownFunction153(Index,0) )
				{
					m_bottomList.GetItem(Index,Info);
					UnknownFunction162(Info.ItemNum,Num);
					if ( UnknownFunction151(Info.ItemNum,0) )
					{
						m_bottomList.SetItem(Index,Info);
					} else {
						m_bottomList.DeleteItem(Index);
					}
					topIndex = m_topList.FindItemWithClassID(ClassID);
					if ( UnknownFunction130(UnknownFunction153(topIndex,0),IsStackableItem(Info.ConsumeType)) )
					{
						m_topList.GetItem(topIndex,topInfo);
						UnknownFunction161(topInfo.ItemNum,Num);
						m_topList.SetItem(topIndex,topInfo);
					} else {
						Info.ItemNum = Num;
						m_topList.AddItem(Info);
					}
					if ( UnknownFunction154(m_type,1) )
					{
						Class'UIAPI_INVENWEIGHT'.ReduceWeight("WarehouseWnd.InvenWeight",UnknownFunction144(Info.ItemNum,Info.Weight));
					}
				}
			}
		}
		AdjustPrice();
		AdjustCount();
	}
}

function L2jBRFunction6 (string L2jBRVar1)
{
	local string L2jBRVar5;
	local int Adena;
	local int tmpInt;
	local string L2jBRVar14;
	local WindowHandle m_inventoryWnd;

	m_inventoryWnd = GetHandle("InventoryWnd");
	Clear();
	ParseString(L2jBRVar1,"type",L2jBRVar5);
	ParseInt(L2jBRVar1,"category",tmpInt);
	m_category = tmpInt;
	ParseInt(L2jBRVar1,"adena",Adena);
	switch (m_category)
	{
		case 1:
		Class'UIAPI_WINDOW'.SetWindowTitle(L2jBRVar13,1216);
		break;
		case 2:
		Class'UIAPI_WINDOW'.SetWindowTitle(L2jBRVar13,1217);
		break;
		case 3:
		Class'UIAPI_WINDOW'.SetWindowTitle(L2jBRVar13,1218);
		break;
		case 4:
		Class'UIAPI_WINDOW'.SetWindowTitle(L2jBRVar13,131);
		break;
		default:
		break;
	}
	if ( UnknownFunction122(L2jBRVar5,"deposit") )
	{
		m_type = 0;
	} else {
		if ( UnknownFunction122(L2jBRVar5,"withdraw") )
		{
			m_type = 1;
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
	if ( UnknownFunction154(m_type,0) )
	{
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".TopText"),GetSystemString(138));
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".BottomText"),GetSystemString(132));
		ShowWindow(UnknownFunction112(L2jBRVar13,".BottomCountText"));
		HideWindow(UnknownFunction112(L2jBRVar13,".TopCountText"));
	} else {
		if ( UnknownFunction154(m_type,1) )
		{
			Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".TopText"),GetSystemString(132));
			Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".BottomText"),GetSystemString(133));
			ShowWindow(UnknownFunction112(L2jBRVar13,".TopCountText"));
			HideWindow(UnknownFunction112(L2jBRVar13,".BottomCountText"));
		}
	}
}

function HandleAddItem (string L2jBRVar1)
{
	local ItemInfo Info;

	ParamToItemInfo(L2jBRVar1,Info);
	m_topList.AddItem(Info);
	AdjustCount();
}

function AdjustPrice ()
{
	local string Adena;
	local int L2jBRVar15_;

	if ( UnknownFunction154(m_type,0) )
	{
		L2jBRVar15_ = m_bottomList.GetItemNum();
		Adena = MakeCostString(string(UnknownFunction144(L2jBRVar15_,30)));
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".PriceText"),Adena);
		Class'UIAPI_TEXTBOX'.SetTooltipString(UnknownFunction112(L2jBRVar13,".PriceText"),ConvertNumToText(string(UnknownFunction144(L2jBRVar15_,30))));
	}
}

function AdjustCount ()
{
	local int Num;
	local int maxNum;

	if ( UnknownFunction154(m_category,1) )
	{
		maxNum = m_maxPrivateCount;
	} else {
		maxNum = 200;
	}
	if ( UnknownFunction154(m_type,0) )
	{
		Num = m_bottomList.GetItemNum();
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".BottomCountText"),UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(Num)),"/"),string(maxNum)),")"));
	} else {
		if ( UnknownFunction154(m_type,1) )
		{
			Num = m_topList.GetItemNum();
			Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".TopCountText"),UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(Num)),"/"),string(maxNum)),")"));
		}
	}
}

function HandleOKButton ()
{
	local string L2jBRVar1;
	local int bottomCount;
	local int bottomIndex;
	local ItemInfo bottomInfo;

	bottomCount = m_bottomList.GetItemNum();
	if ( UnknownFunction154(m_type,0) )
	{
		ParamAdd(L2jBRVar1,"num",string(bottomCount));
		bottomIndex = 0;
		if ( UnknownFunction150(bottomIndex,bottomCount) )
		{
			m_bottomList.GetItem(bottomIndex,bottomInfo);
			ParamAdd(L2jBRVar1,UnknownFunction112("dbID",string(bottomIndex)),string(bottomInfo.Reserved));
			ParamAdd(L2jBRVar1,UnknownFunction112("count",string(bottomIndex)),string(bottomInfo.ItemNum));
			UnknownFunction163(bottomIndex);
			goto JL0043;
		}
		RequestWarehouseDeposit(L2jBRVar1);
	} else {
		if ( UnknownFunction154(m_type,1) )
		{
			ParamAdd(L2jBRVar1,"num",string(bottomCount));
			bottomIndex = 0;
			if ( UnknownFunction150(bottomIndex,bottomCount) )
			{
				m_bottomList.GetItem(bottomIndex,bottomInfo);
				ParamAdd(L2jBRVar1,UnknownFunction112("dbID",string(bottomIndex)),string(bottomInfo.Reserved));
				ParamAdd(L2jBRVar1,UnknownFunction112("count",string(bottomIndex)),string(bottomInfo.ItemNum));
				UnknownFunction163(bottomIndex);
				goto JL00FE;
			}
			RequestWarehouseWithdraw(L2jBRVar1);
		}
	}
	HideWindow(L2jBRVar13);
}

function HandleSetMaxCount (string L2jBRVar1)
{
	ParseInt(L2jBRVar1,"warehousePrivate",m_maxPrivateCount);
}

defaultproperties
{
    L2jBRVar13="WarehouseWnd"

}
