//================================================================================
// MultiSellWnd.
//================================================================================

class MultiSellWnd extends UICommonAPI;

struct NeededItem
{
	var int Id;
	var string Name;
	var int L2jBRVar15_;
	var string IconName;
	var int Enchant;
	var int CrystalType;
	var int ItemType;
	var int RefineryOp1;
	var int RefineryOp2;
};

struct ItemList
{
	var int MultiSellType;
	var int NeededItemNum;
	var array<ItemInfo> ItemInfoList;
	var array<NeededItem> NeededItemList;
};


var array<ItemList> m_itemLIst;
var int m_shopID;
var int pre_itemList;

const MULTISELLWND_DIALOG_OK=1122;

function OnLoad ()
{
	RegisterEvent(2530);
	RegisterEvent(2540);
	RegisterEvent(2550);
	RegisterEvent(2560);
	RegisterEvent(1710);
	pre_itemList = -1;
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 2530:
		HandleShopID(L2jBRVar1);
		break;
		case 2540:
		HandleItemList(L2jBRVar1);
		break;
		case 2550:
		HandleNeededItemList(L2jBRVar1);
		break;
		case 2560:
		HandleItemListEnd(L2jBRVar1);
		break;
		case 1710:
		HandleDialogOK();
		break;
		default:
		break;
	}
}

function OnShow ()
{
	Class'UIAPI_EDITBOX'.Clear("MultiSellWnd.ItemCountEdit");
}

function OnHide ()
{
}

function OnClickButton (string ControlName)
{
	if ( UnknownFunction122(ControlName,"OKButton") )
	{
		HandleOKButton();
	} else {
		if ( UnknownFunction122(ControlName,"CancelButton") )
		{
			Clear();
			HideWindow("MultiSellWnd");
		}
	}
}

function OnClickItem (string strID, int Index)
{
	local int i;
	local string L2jBRVar1;

	Class'UIAPI_MULTISELLITEMINFO'.Clear("MultiSellWnd.ItemInfo");
	Class'UIAPI_MULTISELLNEEDEDITEM'.Clear("MultiSellWnd.NeededItem");
	if ( UnknownFunction122(strID,"ItemList") )
	{
		if ( UnknownFunction130(UnknownFunction153(Index,0),UnknownFunction150(Index,m_itemLIst.Length)) )
		{
			i = 0;
			if ( UnknownFunction150(i,m_itemLIst[Index].NeededItemList.Length) )
			{
				L2jBRVar1 = "";
				ParamAdd(L2jBRVar1,"Name",m_itemLIst[Index].NeededItemList[i].Name);
				ParamAdd(L2jBRVar1,"ID",string(m_itemLIst[Index].NeededItemList[i].Id));
				ParamAdd(L2jBRVar1,"Num",string(m_itemLIst[Index].NeededItemList[i].L2jBRVar15_));
				ParamAdd(L2jBRVar1,"Icon",m_itemLIst[Index].NeededItemList[i].IconName);
				ParamAdd(L2jBRVar1,"Enchant",string(m_itemLIst[Index].NeededItemList[i].Enchant));
				ParamAdd(L2jBRVar1,"CrystalType",string(m_itemLIst[Index].NeededItemList[i].CrystalType));
				ParamAdd(L2jBRVar1,"ItemType",string(m_itemLIst[Index].NeededItemList[i].ItemType));
				Class'UIAPI_MULTISELLNEEDEDITEM'.AddData("MultiSellWnd.NeededItem",L2jBRVar1);
				UnknownFunction163(i);
				goto JL0086;
			}
			i = 0;
			if ( UnknownFunction150(i,m_itemLIst[Index].NeededItemNum) )
			{
				Class'UIAPI_MULTISELLITEMINFO'.SetItemInfo("MultiSellWnd.ItemInfo",i,m_itemLIst[Index].ItemInfoList[i]);
				UnknownFunction163(i);
				goto JL0230;
			}
			Class'UIAPI_EDITBOX'.Clear("MultiSellWnd.ItemCountEdit");
			if ( UnknownFunction154(m_itemLIst[Index].MultiSellType,0) )
			{
				Class'UIAPI_EDITBOX'.SetString("MultiSellWnd.ItemCountEdit","1");
				Class'UIAPI_WINDOW'.DisableWindow("MultiSellWnd.ItemCountEdit");
			} else {
				if ( UnknownFunction154(m_itemLIst[Index].MultiSellType,1) )
				{
					Class'UIAPI_EDITBOX'.SetString("MultiSellWnd.ItemCountEdit","1");
					Class'UIAPI_WINDOW'.EnableWindow("MultiSellWnd.ItemCountEdit");
				}
			}
			if ( UnknownFunction155(pre_itemList,Index) )
			{
				if ( DialogIsMine() )
				{
					DialogHide();
				}
			}
		}
	}
}

function Print ()
{
	local int i;
	local int j;

	i = 0;
	if ( UnknownFunction150(i,m_itemLIst.Length) )
	{
		j = 0;
		if ( UnknownFunction150(j,m_itemLIst[i].NeededItemList.Length) )
		{
			Debug(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("Print (",string(i)),","),string(j)),"), "),m_itemLIst[i].NeededItemList[j].Name));
			UnknownFunction163(j);
			goto JL001E;
		}
		UnknownFunction163(i);
		goto JL0007;
	}
}

function HandleShopID (string L2jBRVar1)
{
	Clear();
	ParseInt(L2jBRVar1,"shopID",m_shopID);
}

function Clear ()
{
	m_itemLIst.Length = 0;
	Class'UIAPI_MULTISELLITEMINFO'.Clear("MultiSellWnd.ItemInfo");
	Class'UIAPI_MULTISELLNEEDEDITEM'.Clear("MultiSellWnd.NeededItem");
	Class'UIAPI_ITEMWINDOW'.Clear("MultiSellWnd.ItemList");
}

function HandleItemList (string L2jBRVar1)
{
	local ItemInfo Info;
	local int Index;
	local int L2jBRVar5;
	local int i;
	local int ClassID;
	local bool bMatchFound;

	ParseInt(L2jBRVar1,"classID",ClassID);
	Class'UIDATA_ITEM'.GetItemInfo(ClassID,Info);
	Info.ClassID = ClassID;
	ParseInt(L2jBRVar1,"index",Index);
	ParseInt(L2jBRVar1,"type",L2jBRVar5);
	ParseInt(L2jBRVar1,"ID",Info.Reserved);
	ParseInt(L2jBRVar1,"slotBitType",Info.SlotBitType);
	ParseInt(L2jBRVar1,"itemType",Info.ItemType);
	ParseInt(L2jBRVar1,"itemCount",Info.ItemNum);
	ParseInt(L2jBRVar1,"Enchant",Info.Enchanted);
	ParseInt(L2jBRVar1,"OutputRefineryOp1",Info.RefineryOp1);
	ParseInt(L2jBRVar1,"OutputRefineryOp2",Info.RefineryOp2);
	if ( UnknownFunction150(0,Info.Durability) )
	{
		Info.CurrentDurability = Info.Durability;
	}
	if ( UnknownFunction154(Index,0) )
	{
		i = m_itemLIst.Length;
		m_itemLIst.Length = UnknownFunction146(i,1);
		m_itemLIst[i].MultiSellType = L2jBRVar5;
		m_itemLIst[i].NeededItemNum = 1;
		m_itemLIst[i].ItemInfoList.Length = UnknownFunction146(Index,1);
		m_itemLIst[i].ItemInfoList[Index] = Info;
	} else {
		if ( UnknownFunction151(Index,0) )
		{
			bMatchFound = False;
			i = UnknownFunction147(m_itemLIst.Length,1);
			if ( UnknownFunction153(i,0) )
			{
				if ( UnknownFunction130(UnknownFunction130(UnknownFunction154(m_itemLIst[i].ItemInfoList[0].Reserved,Info.Reserved),UnknownFunction154(m_itemLIst[i].ItemInfoList[0].RefineryOp1,Info.RefineryOp1)),UnknownFunction154(m_itemLIst[i].ItemInfoList[0].RefineryOp2,Info.RefineryOp2)) )
				{
					bMatchFound = True;
				} else {
					UnknownFunction164(i);
					goto JL0225;
				}
			}
			if ( bMatchFound )
			{
				if ( UnknownFunction152(m_itemLIst[i].ItemInfoList.Length,Index) )
				{
					m_itemLIst[i].ItemInfoList.Length = UnknownFunction146(Index,1);
				}
JL0225:
				m_itemLIst[i].MultiSellType = L2jBRVar5;
				m_itemLIst[i].ItemInfoList[Index] = Info;
				UnknownFunction163(m_itemLIst[i].NeededItemNum);
			} else {
				Debug("MultiSellWnd Error!!");
			}
		}
	}
}

function HandleNeededItemList (string L2jBRVar1)
{
	local NeededItem item;
	local int i;
	local int Id;
	local int Index;
	local int RefineryOp1;
	local int RefineryOp2;

	ParseInt(L2jBRVar1,"ID",Id);
	ParseInt(L2jBRVar1,"refineryOp1",RefineryOp1);
	ParseInt(L2jBRVar1,"refineryOp2",RefineryOp2);
	ParseInt(L2jBRVar1,"ClassID",item.Id);
	ParseInt(L2jBRVar1,"count",item.L2jBRVar15_);
	ParseInt(L2jBRVar1,"enchant",item.Enchant);
	ParseInt(L2jBRVar1,"inputRefineryOp1",item.RefineryOp1);
	ParseInt(L2jBRVar1,"inputRefineryOp2",item.RefineryOp2);
	if ( UnknownFunction154(item.Id,-100) )
	{
		item.Name = GetSystemString(1277);
		item.IconName = "icon.etc_i.etc_pccafe_point_i00";
		item.Enchant = 0;
		item.ItemType = -1;
		item.Id = 0;
	} else {
		if ( UnknownFunction154(item.Id,-200) )
		{
			item.Name = GetSystemString(1311);
			item.IconName = "icon.etc_i.etc_bloodpledge_point_i00";
			item.Enchant = 0;
			item.ItemType = -1;
			item.Id = 0;
		} else {
			item.Name = Class'UIDATA_ITEM'.GetItemName(item.Id);
			item.IconName = Class'UIDATA_ITEM'.GetItemTextureName(item.Id);
		}
	}
	i = UnknownFunction147(m_itemLIst.Length,1);
	if ( UnknownFunction153(i,0) )
	{
		if ( UnknownFunction130(UnknownFunction130(UnknownFunction154(m_itemLIst[i].ItemInfoList[0].Reserved,Id),UnknownFunction154(m_itemLIst[i].ItemInfoList[0].RefineryOp1,RefineryOp1)),UnknownFunction154(m_itemLIst[i].ItemInfoList[0].RefineryOp2,RefineryOp2)) )
		{
			Index = m_itemLIst[i].NeededItemList.Length;
			m_itemLIst[i].NeededItemList.Length = UnknownFunction146(Index,1);
			item.ItemType = Class'UIDATA_ITEM'.GetItemDataType(item.Id);
			item.CrystalType = Class'UIDATA_ITEM'.GetItemCrystalType(item.Id);
			m_itemLIst[i].NeededItemList[Index] = item;
		} else {
			UnknownFunction164(i);
			goto JL0252;
		}
	}
}

function HandleItemListEnd (string L2jBRVar1)
{
	local WindowHandle m_inventoryWnd;

	m_inventoryWnd = GetHandle("InventoryWnd");
	if ( m_inventoryWnd.IsShowWindow() )
	{
		m_inventoryWnd.HideWindow();
	}
	ShowWindow("MultiSellWnd");
	Class'UIAPI_WINDOW'.SetFocus("MultiSellWnd");
	ShowItemList();
}

function ShowItemList ()
{
	local ItemInfo Info;
	local int i;

	i = 0;
	if ( UnknownFunction150(i,m_itemLIst.Length) )
	{
		Info = m_itemLIst[i].ItemInfoList[0];
		Class'UIAPI_ITEMWINDOW'.AddItem("MultiSellWnd.ItemList",Info);
		UnknownFunction163(i);
		goto JL0007;
	}
}

function HandleOKButton ()
{
	local int SelectedIndex;
	local int ItemNum;

	SelectedIndex = Class'UIAPI_ITEMWINDOW'.GetSelectedNum("MultiSellWnd.ItemList");
	ItemNum = int(Class'UIAPI_EDITBOX'.GetString("MultiSellWnd.ItemCountEdit"));
	if ( UnknownFunction153(SelectedIndex,0) )
	{
		DialogSetReservedInt(SelectedIndex);
		DialogSetReservedInt2(ItemNum);
		DialogSetID(1122);
		DialogShow(4,GetSystemMessage(1383));
		pre_itemList = SelectedIndex;
	}
}

function HandleDialogOK ()
{
	local string L2jBRVar1;
	local int SelectedIndex;

	if ( DialogIsMine() )
	{
		SelectedIndex = DialogGetReservedInt();
		ParamAdd(L2jBRVar1,"ShopID",string(m_shopID));
		ParamAdd(L2jBRVar1,"ItemID",string(m_itemLIst[SelectedIndex].ItemInfoList[0].Reserved));
		ParamAdd(L2jBRVar1,"RefineryOp1",string(m_itemLIst[SelectedIndex].ItemInfoList[0].RefineryOp1));
		ParamAdd(L2jBRVar1,"RefineryOp2",string(m_itemLIst[SelectedIndex].ItemInfoList[0].RefineryOp2));
		ParamAdd(L2jBRVar1,"ItemCount",string(DialogGetReservedInt2()));
		ParamAdd(L2jBRVar1,"Enchant",string(DialogGetReservedInt2()));
		RequestMultiSellChoose(L2jBRVar1);
	}
}

