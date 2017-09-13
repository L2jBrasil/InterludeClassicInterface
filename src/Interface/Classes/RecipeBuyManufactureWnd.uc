//================================================================================
// RecipeBuyManufactureWnd.
//================================================================================

class RecipeBuyManufactureWnd extends UIScript;

var int m_merchantID;
var int m_RecipeID;
var int m_SuccessRate;
var int m_Adena;
var int m_MaxMP;
const RECIPEWND_MAX_MP_WIDTH= 165.0f;

function OnLoad ()
{
	RegisterEvent(800);
	RegisterEvent(210);
	RegisterEvent(2600);
	RegisterEvent(2610);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local Rect rectWnd;
	local int ServerID;
	local int MPValue;
	local int MerchantID;
	local int RecipeID;
	local int currentMP;
	local int maxMP;
	local int MakingResult;
	local int Adena;

	if ( UnknownFunction154(Event_ID,800) )
	{
		Class'UIAPI_WINDOW'.HideWindow("RecipeBuyListWnd");
		Clear();
		rectWnd = Class'UIAPI_WINDOW'.GetRect("RecipeBuyListWnd");
		Class'UIAPI_WINDOW'.MoveTo("RecipeBuyManufactureWnd",rectWnd.nX,rectWnd.nY);
		Class'UIAPI_WINDOW'.ShowWindow("RecipeBuyManufactureWnd");
		Class'UIAPI_WINDOW'.SetFocus("RecipeBuyManufactureWnd");
		ParseInt(L2jBRVar1,"MerchantID",MerchantID);
		ParseInt(L2jBRVar1,"RecipeID",RecipeID);
		ParseInt(L2jBRVar1,"CurrentMP",currentMP);
		ParseInt(L2jBRVar1,"MaxMP",maxMP);
		ParseInt(L2jBRVar1,"MakingResult",MakingResult);
		ParseInt(L2jBRVar1,"Adena",Adena);
		ReceiveRecipeShopSellList(MerchantID,RecipeID,currentMP,maxMP,MakingResult,Adena);
	} else {
		if ( UnknownFunction154(Event_ID,210) )
		{
			ParseInt(L2jBRVar1,"ServerID",ServerID);
			ParseInt(L2jBRVar1,"CurrentMP",MPValue);
			if ( UnknownFunction130(UnknownFunction154(m_merchantID,ServerID),UnknownFunction151(m_merchantID,0)) )
			{
				SetMPBar(MPValue);
			}
		} else {
			if ( UnknownFunction132(UnknownFunction154(Event_ID,2600),UnknownFunction154(Event_ID,2610)) )
			{
				HandleInventoryItem(L2jBRVar1);
			}
		}
	}
}

function OnClickButton (string strID)
{
	local string L2jBRVar1;

	switch (strID)
	{
		case "btnClose":
		CloseWindow();
		break;
		case "btnPrev":
		Class'RecipeAPI'.RequestRecipeShopSellList(m_merchantID);
		CloseWindow();
		break;
		case "btnRecipeTree":
		if ( Class'UIAPI_WINDOW'.IsShowWindow("RecipeTreeWnd") )
		{
			Class'UIAPI_WINDOW'.HideWindow("RecipeTreeWnd");
		} else {
			ParamAdd(L2jBRVar1,"RecipeID",string(m_RecipeID));
			ParamAdd(L2jBRVar1,"SuccessRate",string(m_SuccessRate));
			ExecuteEvent(810,L2jBRVar1);
		}
		break;
		case "btnManufacture":
		Class'RecipeAPI'.RequestRecipeShopMakeDo(m_merchantID,m_RecipeID,m_Adena);
		break;
		default:
	}
}

function CloseWindow ()
{
	Clear();
	Class'UIAPI_WINDOW'.HideWindow("RecipeBuyManufactureWnd");
	PlayConsoleSound(6);
}

function Clear ()
{
	m_merchantID = 0;
	m_RecipeID = 0;
	m_SuccessRate = 0;
	m_Adena = 0;
	m_MaxMP = 0;
	Class'UIAPI_ITEMWINDOW'.Clear("RecipeBuyManufactureWnd.ItemWnd");
}

function ReceiveRecipeShopSellList (int MerchantID, int RecipeID, int currentMP, int maxMP, int MakingResult, int Adena)
{
	local int i;
	local string strTmp;
	local int nTmp;
	local int ProductID;
	local int ProductNum;
	local string ItemName;
	local ParamStack L2jBRVar1;
	local ItemInfo L2jBRVar3;

	m_merchantID = MerchantID;
	m_RecipeID = RecipeID;
	m_SuccessRate = Class'UIDATA_RECIPE'.GetRecipeSuccessRate(RecipeID);
	m_Adena = Adena;
	m_MaxMP = maxMP;
	strTmp = UnknownFunction112(UnknownFunction112(GetSystemString(663)," - "),Class'UIDATA_USER'.GetUserName(MerchantID));
	Class'UIAPI_WINDOW'.SetWindowTitleByText("RecipeBuyManufactureWnd",strTmp);
	ProductID = Class'UIDATA_RECIPE'.GetRecipeProductID(RecipeID);
	strTmp = Class'UIDATA_ITEM'.GetItemTextureName(ProductID);
	Class'UIAPI_TEXTURECTRL'.SetTexture("RecipeBuyManufactureWnd.texItem",strTmp);
	ItemName = MakeFullItemName(ProductID);
	nTmp = Class'UIDATA_RECIPE'.GetRecipeCrystalType(RecipeID);
	strTmp = GetItemGradeString(nTmp);
	if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
	{
		strTmp = UnknownFunction112(UnknownFunction112("`",strTmp),"`");
	}
	Class'UIAPI_TEXTBOX'.SetText("RecipeBuyManufactureWnd.txtName",UnknownFunction112(UnknownFunction112(ItemName," "),strTmp));
	nTmp = Class'UIDATA_RECIPE'.GetRecipeMpConsume(RecipeID);
	Class'UIAPI_TEXTBOX'.SetText("RecipeBuyManufactureWnd.txtMPConsume",UnknownFunction112("",string(nTmp)));
	Class'UIAPI_TEXTBOX'.SetText("RecipeBuyManufactureWnd.txtSuccessRate",UnknownFunction112(string(m_SuccessRate),"%"));
	ProductNum = Class'UIDATA_RECIPE'.GetRecipeProductNum(RecipeID);
	Class'UIAPI_TEXTBOX'.SetText("RecipeBuyManufactureWnd.txtResultValue",UnknownFunction112("",string(ProductNum)));
	SetMPBar(currentMP);
	Class'UIAPI_TEXTBOX'.SetText("RecipeBuyManufactureWnd.txtCountValue",UnknownFunction112("",string(GetInventoryItemCount(ProductID))));
	strTmp = "";
	if ( UnknownFunction154(MakingResult,0) )
	{
		strTmp = MakeFullSystemMsg(GetSystemMessage(960),ItemName,"");
	} else {
		if ( UnknownFunction154(MakingResult,1) )
		{
			strTmp = MakeFullSystemMsg(GetSystemMessage(959),ItemName,UnknownFunction112("",string(ProductNum)));
		}
	}
	Class'UIAPI_TEXTBOX'.SetText("RecipeBuyManufactureWnd.txtMsg",strTmp);
	L2jBRVar1 = Class'UIDATA_RECIPE'.GetRecipeMaterialItem(RecipeID);
	nTmp = L2jBRVar1.GetInt();
	i = 0;
	if ( UnknownFunction150(i,nTmp) )
	{
		L2jBRVar3.ClassID = L2jBRVar1.GetInt();
		L2jBRVar3.Reserved = L2jBRVar1.GetInt();
		L2jBRVar3.Name = Class'UIDATA_ITEM'.GetItemName(L2jBRVar3.ClassID);
		L2jBRVar3.AdditionalName = Class'UIDATA_ITEM'.GetItemAdditionalName(L2jBRVar3.ClassID);
		L2jBRVar3.IconName = Class'UIDATA_ITEM'.GetItemTextureName(L2jBRVar3.ClassID);
		L2jBRVar3.Description = Class'UIDATA_ITEM'.GetItemDescription(L2jBRVar3.ClassID);
		L2jBRVar3.ItemNum = GetInventoryItemCount(L2jBRVar3.ClassID);
		if ( UnknownFunction151(L2jBRVar3.Reserved,L2jBRVar3.ItemNum) )
		{
			L2jBRVar3.bDisabled = True;
		} else {
			L2jBRVar3.bDisabled = False;
		}
		Class'UIAPI_ITEMWINDOW'.AddItem("RecipeBuyManufactureWnd.ItemWnd",L2jBRVar3);
		UnknownFunction165(i);
		goto JL03C4;
	}
}

function SetMPBar (int currentMP)
{
	local int nTmp;
	local int nMPWidth;

	nTmp = UnknownFunction144(165,currentMP);
	nMPWidth = UnknownFunction145(nTmp,m_MaxMP);
	if ( UnknownFunction177(nMPWidth,165.0) )
	{
		nMPWidth = 165;
	}
	Class'UIAPI_WINDOW'.SetWindowSize("RecipeBuyManufactureWnd.texMPBar",nMPWidth,12);
}

function HandleInventoryItem (string L2jBRVar1)
{
	local int ClassID;
	local int L2jBRVar2;
	local ItemInfo L2jBRVar3;

	if ( ParseInt(L2jBRVar1,"classID",ClassID) )
	{
		L2jBRVar2 = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("RecipeBuyManufactureWnd.ItemWnd",ClassID);
		if ( UnknownFunction151(L2jBRVar2,-1) )
		{
			Class'UIAPI_ITEMWINDOW'.GetItem("RecipeBuyManufactureWnd.ItemWnd",L2jBRVar2,L2jBRVar3);
			L2jBRVar3.ItemNum = GetInventoryItemCount(L2jBRVar3.ClassID);
			if ( UnknownFunction151(L2jBRVar3.Reserved,L2jBRVar3.ItemNum) )
			{
				L2jBRVar3.bDisabled = True;
			} else {
				L2jBRVar3.bDisabled = False;
			}
			Class'UIAPI_ITEMWINDOW'.SetItem("RecipeBuyManufactureWnd.ItemWnd",L2jBRVar2,L2jBRVar3);
		}
	}
}

