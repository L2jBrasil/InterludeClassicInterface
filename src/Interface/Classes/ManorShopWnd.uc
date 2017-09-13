//================================================================================
// ManorShopWnd.
//================================================================================

class ManorShopWnd extends ShopWnd;

function OnLoad ()
{
	RegisterEvent(2680);
	RegisterEvent(2690);
	RegisterEvent(1710);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 2680:
		
		L2jBRFunction6(L2jBRVar1);
		break;
		case 2690:
		HandleAddItem(L2jBRVar1);
		break;
		case 1710:
		HandleDialogOK();
		break;
		default:
		break;
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
			if ( UnknownFunction132(UnknownFunction154(m_shopType,2),UnknownFunction154(m_shopType,1)) )
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
					bottomIndex = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID(UnknownFunction112(L2jBRVar13,".BottomList"),Info.ClassID);
					if ( UnknownFunction130(UnknownFunction153(bottomIndex,0),IsStackableItem(Info.ConsumeType)) )
					{
						Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".BottomList"),bottomIndex,bottomInfo);
						UnknownFunction161(bottomInfo.ItemNum,Info.ItemNum);
						Class'UIAPI_ITEMWINDOW'.SetItem(UnknownFunction112(L2jBRVar13,".BottomList"),bottomIndex,bottomInfo);
					} else {
						Class'UIAPI_ITEMWINDOW'.AddItem(UnknownFunction112(L2jBRVar13,".BottomList"),Info);
						Class'UIAPI_INVENWEIGHT'.AddWeight(UnknownFunction112(L2jBRVar13,".InvenWeight"),UnknownFunction144(Info.Weight,Info.ItemNum));
					}
					if ( bAllItem )
					{
						Class'UIAPI_ITEMWINDOW'.DeleteItem(UnknownFunction112(L2jBRVar13,".TopList"),Index);
					}
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

function L2jBRFunction6 (string L2jBRVar1)
{
	Super.
	L2jBRFunction6(L2jBRVar1);
	Class'UIAPI_WINDOW'.SetWindowTitle(L2jBRVar13,738);
	Class'UIAPI_WINDOW'.SetTooltipType(UnknownFunction112(L2jBRVar13,".TopList"),"InventoryPrice1HideEnchant");
}

function HandleAddItem (string L2jBRVar1)
{
	local ItemInfo Info;

	ParamToItemInfo(L2jBRVar1,Info);
	Info.bShowCount = False;
	Class'UIAPI_ITEMWINDOW'.AddItem(UnknownFunction112(L2jBRVar13,".TopList"),Info);
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
JL01C3:
		RequestBuySeed(L2jBRVar1);
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
			RequestProcureCrop(L2jBRVar1);
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
    L2jBRVar13="ManorShopWnd"

}
