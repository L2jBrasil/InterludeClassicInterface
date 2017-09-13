//================================================================================
// RecipeBookWnd.
//================================================================================

class RecipeBookWnd extends UICommonAPI;

var int m_ItemCount;
var array<int> m_arrItem;
var int m_BookType;
var int m_ItemMaxCount_Dwarf;
var int m_ItemMaxCount_Normal;
var int m_DeleteItemID;

function OnLoad ()
{
	RegisterEvent(820);
	RegisterEvent(830);
	RegisterEvent(2070);
	RegisterEvent(1710);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local Rect rectWnd;
	local int RecipeAddBookItem;

	if ( UnknownFunction154(Event_ID,820) )
	{
		Clear();
		rectWnd = Class'UIAPI_WINDOW'.GetRect("RecipeManufactureWnd");
		Class'UIAPI_WINDOW'.MoveTo("RecipeBookWnd",rectWnd.nX,rectWnd.nY);
		Class'UIAPI_WINDOW'.ShowWindow("RecipeBookWnd");
		Class'UIAPI_WINDOW'.SetFocus("RecipeBookWnd");
		ParseInt(L2jBRVar1,"Type",m_BookType);
		if ( UnknownFunction154(m_BookType,1) )
		{
			Class'UIAPI_WINDOW'.SetWindowTitle("RecipeBookWnd",1214);
		} else {
			Class'UIAPI_WINDOW'.SetWindowTitle("RecipeBookWnd",1215);
		}
	} else {
		if ( UnknownFunction154(Event_ID,830) )
		{
			ParseInt(L2jBRVar1,"RecipeID",RecipeAddBookItem);
			AddRecipeBookItem(RecipeAddBookItem);
		} else {
			if ( UnknownFunction154(Event_ID,2070) )
			{
				ParseInt(L2jBRVar1,"recipe",m_ItemMaxCount_Normal);
				ParseInt(L2jBRVar1,"dwarvenRecipe",m_ItemMaxCount_Dwarf);
				L2jBRFunction42(m_ItemCount);
			} else {
				if ( UnknownFunction154(Event_ID,1710) )
				{
					if ( DialogIsMine() )
					{
						Class'RecipeAPI'.RequestRecipeItemDelete(m_DeleteItemID);
					}
				}
			}
		}
	}
}

function OnDBClickItem (string strID, int Index)
{
	if ( UnknownFunction130(UnknownFunction122(strID,"RecipeItem"),UnknownFunction151(m_ItemCount,Index)) )
	{
		Class'RecipeAPI'.RequestRecipeItemMakeInfo(m_arrItem[Index]);
	}
}

function OnDropItem (string strID, ItemInfo L2jBRVar3, int X, int Y)
{
	if ( UnknownFunction122(strID,"btnTrash") )
	{
		DeleteItem(L2jBRVar3);
	}
}

function OnClickButton (string strID)
{
	local ItemInfo L2jBRVar3;

	switch (strID)
	{
		case "btnTrash":
		if ( Class'UIAPI_ITEMWINDOW'.GetSelectedItem("RecipeBookWnd.RecipeItem",L2jBRVar3) )
		{
			DeleteItem(L2jBRVar3);
		}
		break;
		default:
	}
}

function Clear ()
{
	L2jBRFunction42(0);
	m_arrItem.Remove (0,m_arrItem.Length);
	Class'UIAPI_ITEMWINDOW'.Clear("RecipeBookWnd.RecipeItem");
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
	L2jBRVar3.ItemSubType = 5;
	L2jBRVar3.Name = Class'UIDATA_ITEM'.GetItemName(L2jBRVar3.ClassID);
	L2jBRVar3.Description = Class'UIDATA_ITEM'.GetItemDescription(L2jBRVar3.ClassID);
	L2jBRVar3.Weight = Class'UIDATA_ITEM'.GetItemWeight(L2jBRVar3.ClassID);
	L2jBRVar3.IconName = Class'UIDATA_ITEM'.GetItemTextureName(ProductID);
	L2jBRVar3.CrystalType = Class'UIDATA_RECIPE'.GetRecipeCrystalType(RecipeID);
	Class'UIAPI_ITEMWINDOW'.AddItem("RecipeBookWnd.RecipeItem",L2jBRVar3);
	byte(m_arrItem)
	m_arrItem.Length
	1
	m_arrItem[UnknownFunction147(m_arrItem.Length,1)] = Index;
	UnknownFunction165(m_ItemCount);
	L2jBRFunction42(m_ItemCount);
}

function L2jBRFunction42 (int MaxCount)
{
	local int nTmp;

	m_ItemCount = MaxCount;
	if ( UnknownFunction154(m_BookType,1) )
	{
		nTmp = m_ItemMaxCount_Normal;
	} else {
		nTmp = m_ItemMaxCount_Dwarf;
	}
	Class'UIAPI_TEXTBOX'.SetText("RecipeBookWnd.txtCount",UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(m_ItemCount)),"/"),string(nTmp)),")"));
}

function DeleteItem (ItemInfo L2jBRVar3)
{
	local string strMsg;

	strMsg = MakeFullSystemMsg(GetSystemMessage(74),L2jBRVar3.Name,"");
	m_DeleteItemID = L2jBRVar3.ServerID;
	DialogShow(4,strMsg);
}

