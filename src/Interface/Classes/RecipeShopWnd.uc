//================================================================================
// RecipeShopWnd.
//================================================================================

class RecipeShopWnd extends UICommonAPI;

var int m_BookItemCount;
var int m_ShopItemCount;
var array<int> m_arrBookItem;
var array<int> m_arrShopItem;
var int m_BookType;
var ItemInfo m_HandleItem;
const RECIPESHOP_MAX_ITEM_SELL= 20;

function OnLoad ()
{
	RegisterEvent(850);
	RegisterEvent(860);
	RegisterEvent(870);
	RegisterEvent(1710);
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnEnd":
		Class'RecipeAPI'.RequestRecipeShopManageQuit();
		CloseWindow();
		break;
		case "btnMsg":
		DialogSetEditBoxMaxLength(29);
		DialogShow(2,GetSystemMessage(334));
		DialogSetID(0);
		DialogSetString(Class'UIDATA_PLAYER'.GetRecipeShopMsg());
		break;
		case "btnStart":
		StartRecipeShop();
		CloseWindow();
		break;
		case "btnMoveUp":
		HandleMoveUpItem();
		break;
		case "btnMoveDown":
		HandleMoveDownItem();
		break;
		default:
	}
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local string strPrice;
	local int RecipeID;
	local int CanbeMade;
	local int MakingFee;
	local int Price;
	local InventoryWnd InventoryWnd;

	InventoryWnd = InventoryWnd(GetScript("InventoryWnd"));
	if ( UnknownFunction154(Event_ID,850) )
	{
		Clear();
		InventoryWnd.LoadItemOrder();
		Class'UIAPI_WINDOW'.ShowWindow("RecipeShopWnd");
		Class'UIAPI_WINDOW'.SetFocus("RecipeShopWnd");
		ParseInt(L2jBRVar1,"Type",m_BookType);
		if ( UnknownFunction154(m_BookType,1) )
		{
			Class'UIAPI_WINDOW'.SetWindowTitle("RecipeShopWnd",1212);
		} else {
			Class'UIAPI_WINDOW'.SetWindowTitle("RecipeShopWnd",1213);
		}
	} else {
		if ( UnknownFunction154(Event_ID,860) )
		{
			ParseInt(L2jBRVar1,"RecipeID",RecipeID);
			AddRecipeBookItem(RecipeID);
		} else {
			if ( UnknownFunction154(Event_ID,870) )
			{
				ParseInt(L2jBRVar1,"RecipeID",RecipeID);
				ParseInt(L2jBRVar1,"CanbeMade",CanbeMade);
				ParseInt(L2jBRVar1,"MakingFee",MakingFee);
				AddRecipeShopItem(RecipeID,CanbeMade,MakingFee);
			} else {
				if ( UnknownFunction154(Event_ID,1710) )
				{
					if ( DialogIsMine() )
					{
						if ( UnknownFunction154(DialogGetID(),0) )
						{
							Class'RecipeAPI'.RequestRecipeShopMessageSet(DialogGetString());
						} else {
							if ( UnknownFunction154(DialogGetID(),1) )
							{
								strPrice = DialogGetString();
								if ( UnknownFunction151(UnknownFunction125(strPrice),0) )
								{
									Price = int(strPrice);
									if ( UnknownFunction153(Price,2000000000) )
									{
										DialogSetID(2);
										DialogShow(4,GetSystemMessage(1369));
									} else {
										m_HandleItem.Price = Price;
										UpdateShopItem(m_HandleItem);
									}
								}
								ClearHandleItem();
							}
						}
					}
				}
			}
		}
	}
}

function OnSendPacketWhenHiding ()
{
	Class'RecipeAPI'.RequestRecipeShopManageQuit();
	Clear();
}

function CloseWindow ()
{
	Clear();
	Class'UIAPI_WINDOW'.HideWindow("RecipeShopWnd");
	PlayConsoleSound(6);
}

function OnDBClickItem (string strID, int Index)
{
	local int L2jBRVar29;
	local int i;
	local ItemInfo L2jBRVar3;
	local ItemInfo DeleteItem;

	ClearHandleItem();
	if ( UnknownFunction130(UnknownFunction122(strID,"BookItemWnd"),UnknownFunction151(m_BookItemCount,Index)) )
	{
		Class'UIAPI_ITEMWINDOW'.GetItem("RecipeShopWnd.BookItemWnd",Index,L2jBRVar3);
		L2jBRVar29 = Class'UIAPI_ITEMWINDOW'.GetItemNum("RecipeShopWnd.ShopItemWnd");
		i = 0;
		if ( UnknownFunction150(i,L2jBRVar29) )
		{
			if ( Class'UIAPI_ITEMWINDOW'.GetItem("RecipeShopWnd.ShopItemWnd",i,DeleteItem) )
			{
				if ( UnknownFunction154(DeleteItem.ClassID,L2jBRVar3.ClassID) )
				{
					DeleteShopItem(L2jBRVar3);
					return;
				}
			}
			UnknownFunction165(i);
			goto JL0099;
		}
		Class'UIAPI_ITEMWINDOW'.GetItem("RecipeShopWnd.BookItemWnd",Index,L2jBRVar3);
		ShowShopItemAddDialog(L2jBRVar3);
	} else {
		if ( UnknownFunction130(UnknownFunction122(strID,"ShopItemWnd"),UnknownFunction151(m_ShopItemCount,Index)) )
		{
			Class'UIAPI_ITEMWINDOW'.GetItem("RecipeShopWnd.ShopItemWnd",Index,L2jBRVar3);
			DeleteShopItem(L2jBRVar3);
		}
	}
}

function OnDropItem (string strID, ItemInfo L2jBRVar3, int X, int Y)
{
	if ( UnknownFunction122(strID,"BookItemWnd") )
	{
		if ( UnknownFunction122(L2jBRVar3.DragSrcName,"ShopItemWnd") )
		{
			DeleteShopItem(L2jBRVar3);
		}
	} else {
		if ( UnknownFunction122(strID,"ShopItemWnd") )
		{
			if ( UnknownFunction122(L2jBRVar3.DragSrcName,"BookItemWnd") )
			{
				ShowShopItemAddDialog(L2jBRVar3);
			}
		}
	}
}

function Clear ()
{
	ClearHandleItem();
	m_BookItemCount = 0;
	m_ShopItemCount = 0;
	UpdateShopItemCount(0);
	m_arrBookItem.Remove (0,m_arrBookItem.Length);
	m_arrShopItem.Remove (0,m_arrShopItem.Length);
	Class'UIAPI_ITEMWINDOW'.Clear("RecipeShopWnd.BookItemWnd");
	Class'UIAPI_ITEMWINDOW'.Clear("RecipeShopWnd.ShopItemWnd");
}

function ClearHandleItem ()
{
	local ItemInfo ItemClear;

	m_HandleItem = ItemClear;
}

function AddRecipeBookItem (int RecipeID)
{
	local ItemInfo L2jBRVar3;
	local int ProductID;
	local int Index;

	ProductID = Class'UIDATA_RECIPE'.GetRecipeProductID(RecipeID);
	Index = Class'UIDATA_RECIPE'.GetRecipeIndex(RecipeID);
	L2jBRVar3.ClassID = Class'UIDATA_RECIPE'.GetRecipeClassID(RecipeID);
	L2jBRVar3.Level = Class'UIDATA_RECIPE'.GetRecipeLevel(RecipeID);
	L2jBRVar3.ServerID = Class'UIDATA_RECIPE'.GetRecipeIndex(RecipeID);
	L2jBRVar3.Name = Class'UIDATA_ITEM'.GetItemName(L2jBRVar3.ClassID);
	L2jBRVar3.Description = Class'UIDATA_ITEM'.GetItemDescription(L2jBRVar3.ClassID);
	L2jBRVar3.Weight = Class'UIDATA_ITEM'.GetItemWeight(L2jBRVar3.ClassID);
	L2jBRVar3.IconName = Class'UIDATA_ITEM'.GetItemTextureName(ProductID);
	L2jBRVar3.CrystalType = Class'UIDATA_RECIPE'.GetRecipeCrystalType(RecipeID);
	Class'UIAPI_ITEMWINDOW'.AddItem("RecipeShopWnd.BookItemWnd",L2jBRVar3);
	byte(m_arrBookItem)
	m_arrBookItem.Length
	1
	m_arrBookItem[UnknownFunction147(m_arrBookItem.Length,1)] = Index;
	UnknownFunction165(m_BookItemCount);
}

function AddRecipeShopItem (int RecipeID, int CanbeMade, int MakingFee)
{
	local ItemInfo L2jBRVar3;
	local int ProductID;
	local int Index;

	ProductID = Class'UIDATA_RECIPE'.GetRecipeProductID(RecipeID);
	Index = Class'UIDATA_RECIPE'.GetRecipeIndex(RecipeID);
	L2jBRVar3.ClassID = Class'UIDATA_RECIPE'.GetRecipeClassID(RecipeID);
	L2jBRVar3.Level = Class'UIDATA_RECIPE'.GetRecipeLevel(RecipeID);
	L2jBRVar3.ServerID = Class'UIDATA_RECIPE'.GetRecipeIndex(RecipeID);
	L2jBRVar3.Price = MakingFee;
	L2jBRVar3.Reserved = CanbeMade;
	L2jBRVar3.Name = Class'UIDATA_ITEM'.GetItemName(L2jBRVar3.ClassID);
	L2jBRVar3.Description = Class'UIDATA_ITEM'.GetItemDescription(L2jBRVar3.ClassID);
	L2jBRVar3.Weight = Class'UIDATA_ITEM'.GetItemWeight(L2jBRVar3.ClassID);
	L2jBRVar3.IconName = Class'UIDATA_ITEM'.GetItemTextureName(ProductID);
	L2jBRVar3.CrystalType = Class'UIDATA_RECIPE'.GetRecipeCrystalType(RecipeID);
	Class'UIAPI_ITEMWINDOW'.AddItem("RecipeShopWnd.ShopItemWnd",L2jBRVar3);
	byte(m_arrShopItem)
	m_arrShopItem.Length
	1
	m_arrShopItem[UnknownFunction147(m_arrShopItem.Length,1)] = Index;
	UnknownFunction165(m_ShopItemCount);
	UpdateShopItemCount(m_ShopItemCount);
}

function ShowShopItemAddDialog (ItemInfo AddItem)
{
	m_HandleItem = AddItem;
	DialogSetID(1);
	DialogSetParamInt(-1);
	DialogSetDefaultOK();
	DialogShow(6,GetSystemMessage(963));
}

function UpdateShopItem (ItemInfo AddItem)
{
	local int i;
	local int L2jBRVar29;
	local ItemInfo L2jBRVar3;
	local bool bDuplicated;

	bDuplicated = False;
	L2jBRVar29 = Class'UIAPI_ITEMWINDOW'.GetItemNum("RecipeShopWnd.ShopItemWnd");
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar29) )
	{
		if ( Class'UIAPI_ITEMWINDOW'.GetItem("RecipeShopWnd.ShopItemWnd",i,L2jBRVar3) )
		{
			if ( UnknownFunction154(AddItem.ClassID,L2jBRVar3.ClassID) )
			{
				bDuplicated = True;
			} else {
				UnknownFunction165(i);
				goto JL003F;
			}
		}
	}
	if ( UnknownFunction129(bDuplicated) )
	{
		Class'UIAPI_ITEMWINDOW'.AddItem("RecipeShopWnd.ShopItemWnd",AddItem);
		UnknownFunction165(m_ShopItemCount);
		UpdateShopItemCount(m_ShopItemCount);
	}
}

function DeleteShopItem (ItemInfo DeleteItem)
{
	local int i;
	local int L2jBRVar29;
	local ItemInfo L2jBRVar3;

	L2jBRVar29 = Class'UIAPI_ITEMWINDOW'.GetItemNum("RecipeShopWnd.ShopItemWnd");
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar29) )
	{
		if ( Class'UIAPI_ITEMWINDOW'.GetItem("RecipeShopWnd.ShopItemWnd",i,L2jBRVar3) )
		{
			if ( UnknownFunction154(DeleteItem.ClassID,L2jBRVar3.ClassID) )
			{
				Class'UIAPI_ITEMWINDOW'.DeleteItem("RecipeShopWnd.ShopItemWnd",i);
				UnknownFunction166(m_ShopItemCount);
				UpdateShopItemCount(m_ShopItemCount);
			} else {
				UnknownFunction165(i);
				goto JL0037;
			}
		}
	}
}

function UpdateShopItemCount (int L2jBRVar15_)
{
	Class'UIAPI_TEXTBOX'.SetText("RecipeShopWnd.txtCount",UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(L2jBRVar15_)),"/"),string(20)),")"));
}

function StartRecipeShop ()
{
	local int i;
	local int L2jBRVar29;
	local ItemInfo L2jBRVar3;
	local string L2jBRVar1;
	local int ServerID;
	local int Price;

	L2jBRVar29 = Class'UIAPI_ITEMWINDOW'.GetItemNum("RecipeShopWnd.ShopItemWnd");
	ParamAdd(L2jBRVar1,"Max",string(L2jBRVar29));
JL004E:
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar29) )
	{
		ServerID = 0;
		Price = 0;
		if ( Class'UIAPI_ITEMWINDOW'.GetItem("RecipeShopWnd.ShopItemWnd",i,L2jBRVar3) )
		{
			ServerID = L2jBRVar3.ServerID;
			Price = L2jBRVar3.Price;
		}
		ParamAdd(L2jBRVar1,UnknownFunction112("ServerID_",string(i)),string(ServerID));
		ParamAdd(L2jBRVar1,UnknownFunction112("Price_",string(i)),string(Price));
		UnknownFunction165(i);
		goto JL004E;
	}
	Class'RecipeAPI'.RequestRecipeShopListSet(L2jBRVar1);
}

function HandleMoveUpItem ()
{
	local ItemInfo L2jBRVar3;

	if ( Class'UIAPI_ITEMWINDOW'.GetSelectedItem("RecipeShopWnd.ShopItemWnd",L2jBRVar3) )
	{
		DeleteShopItem(L2jBRVar3);
	}
}

function HandleMoveDownItem ()
{
	local ItemInfo L2jBRVar3;

	if ( Class'UIAPI_ITEMWINDOW'.GetSelectedItem("RecipeShopWnd.BookItemWnd",L2jBRVar3) )
	{
		ShowShopItemAddDialog(L2jBRVar3);
	}
}

