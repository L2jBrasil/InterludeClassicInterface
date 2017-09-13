//================================================================================
// RecipeBuyListWnd.
//================================================================================

class RecipeBuyListWnd extends UIScript;

var int m_merchantID;
var int m_MaxMP;
const RECIPEWND_MAX_MP_WIDTH= 165.0f;

function OnLoad ()
{
	RegisterEvent(780);
	RegisterEvent(790);
	RegisterEvent(210);
	Class'UIAPI_TEXTBOX'.SetText("RecipeBuyListWnd.txtAdena","0");
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local Rect rectWnd;
	local int ServerID;
	local int MPValue;
	local int currentMP;
	local int maxMP;
	local int Adena;
	local int RecipeID;
	local int CanbeMade;
	local int MakingFee;

	if ( UnknownFunction154(Event_ID,780) )
	{
		Clear();
		rectWnd = Class'UIAPI_WINDOW'.GetRect("RecipeBuyManufactureWnd");
		Class'UIAPI_WINDOW'.MoveTo("RecipeBuyListWnd",rectWnd.nX,rectWnd.nY);
		ParseInt(L2jBRVar1,"ServerID",ServerID);
		ParseInt(L2jBRVar1,"CurrentMP",currentMP);
		ParseInt(L2jBRVar1,"MaxMP",maxMP);
		ParseInt(L2jBRVar1,"Adena",Adena);
		ReceiveRecipeShopSellList(ServerID,currentMP,maxMP,Adena);
		Class'UIAPI_WINDOW'.ShowWindow("RecipeBuyListWnd");
		Class'UIAPI_WINDOW'.SetFocus("RecipeBuyListWnd");
	} else {
		if ( UnknownFunction154(Event_ID,790) )
		{
			ParseInt(L2jBRVar1,"RecipeID",RecipeID);
			ParseInt(L2jBRVar1,"CanbeMade",CanbeMade);
			ParseInt(L2jBRVar1,"MakingFee",MakingFee);
			AddRecipeShopSellItem(RecipeID,CanbeMade,MakingFee);
		} else {
			if ( UnknownFunction154(Event_ID,210) )
			{
				ParseInt(L2jBRVar1,"ServerID",ServerID);
				ParseInt(L2jBRVar1,"CurrentMP",MPValue);
				if ( UnknownFunction130(UnknownFunction154(m_merchantID,ServerID),UnknownFunction151(m_merchantID,0)) )
				{
					SetMPBar(MPValue);
				}
			}
		}
	}
}

function OnClickButton (string strID)
{
	local string strRecipeID;

	switch (strID)
	{
		case "btnClose":
		CloseWindow();
		break;
		default:
		strRecipeID = UnknownFunction127(strID,5);
		Class'RecipeAPI'.RequestRecipeShopMakeInfo(m_merchantID,int(strRecipeID));
		break;
	}
}

function CloseWindow ()
{
	Clear();
	Class'UIAPI_WINDOW'.HideWindow("RecipeBuyListWnd");
	PlayConsoleSound(6);
}

function Clear ()
{
	m_merchantID = 0;
	m_MaxMP = 0;
	Class'UIAPI_TREECTRL'.Clear("RecipeBuyListWnd.MainTree");
}

function ReceiveRecipeShopSellList (int ServerID, int currentMP, int maxMP, int Adena)
{
	local string strTmp;
	local XMLTreeNodeInfo infNode;

	m_merchantID = ServerID;
	m_MaxMP = maxMP;
	strTmp = UnknownFunction112(UnknownFunction112(GetSystemString(663)," - "),Class'UIDATA_USER'.GetUserName(ServerID));
	Class'UIAPI_WINDOW'.SetWindowTitleByText("RecipeBuyListWnd",strTmp);
	SetMPBar(currentMP);
	Class'UIAPI_TEXTBOX'.SetText("RecipeBuyListWnd.txtAdena",MakeCostString(UnknownFunction112("",string(Adena))));
	Class'UIAPI_TEXTBOX'.SetTooltipString("RecipeBuyListWnd.txtAdena",ConvertNumToText(UnknownFunction112("",string(Adena))));
	infNode.strName = "root";
	infNode.nOffSetX = 7;
	infNode.nOffSetY = 7;
	strTmp = Class'UIAPI_TREECTRL'.InsertNode("RecipeBuyListWnd.MainTree","",infNode);
	if ( UnknownFunction150(UnknownFunction125(strTmp),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert root node. Name: ",infNode.strName));
		return;
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
	Class'UIAPI_WINDOW'.SetWindowSize("RecipeBuyListWnd.texMPBar",nMPWidth,12);
}

function AddRecipeShopSellItem (int RecipeID, int CanbeMade, int MakingFee)
{
	local string strTmp;
	local XMLTreeNodeInfo infNode;
	local XMLTreeNodeItemInfo infNodeItem;
	local XMLTreeNodeInfo infNodeClear;
	local XMLTreeNodeItemInfo infNodeItemClear;
	local string strRetName;
	local int ProductID;
	local string AdenaComma;
	local string strName;
	local string strDescription;

	ProductID = Class'UIDATA_RECIPE'.GetRecipeProductID(RecipeID);
	strName = Class'UIDATA_ITEM'.GetItemName(ProductID);
	strDescription = Class'UIDATA_ITEM'.GetItemDescription(ProductID);
	infNode = infNodeClear;
	infNode.strName = UnknownFunction112("",string(RecipeID));
	infNode.bShowButton = 0;
	infNode.ToolTip = L2jBRFunction29(strName,strDescription,MakingFee);
	infNode.bFollowCursor = True;
	infNode.nTexExpandedOffSetX = -7;
	infNode.nTexExpandedOffSetY = -3;
	infNode.nTexExpandedHeight = 46;
	infNode.nTexExpandedRightWidth = 0;
	infNode.nTexExpandedLeftUWidth = 32;
	infNode.nTexExpandedLeftUHeight = 40;
	infNode.strTexExpandedLeft = "L2UI_CH3.etc.IconSelect2";
	strRetName = Class'UIAPI_TREECTRL'.InsertNode("RecipeBuyListWnd.MainTree","root",infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		UnknownFunction231(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
		return;
	}
	infNode.ToolTip.DrawList.Remove (0,infNode.ToolTip.DrawList.Length);
	strTmp = Class'UIDATA_ITEM'.GetItemTextureName(ProductID);
	if ( UnknownFunction150(UnknownFunction125(strTmp),1) )
	{
		strTmp = "Default.BlackTexture";
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 2;
	infNodeItem.nOffSetX = 0;
	infNodeItem.nOffSetY = 4;
	infNodeItem.u_nTextureWidth = 32;
	infNodeItem.u_nTextureHeight = 32;
	infNodeItem.u_strTexture = strTmp;
	Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeBuyListWnd.MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = strName;
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 10;
	infNodeItem.nOffSetY = 0;
	Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeBuyListWnd.MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSystemString(641);
	infNodeItem.bLineBreak = True;
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 42;
	infNodeItem.nOffSetY = -22;
	infNodeItem.t_color.R = 168;
	infNodeItem.t_color.G = 168;
	infNodeItem.t_color.B = 168;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeBuyListWnd.MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = " : ";
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 0;
	infNodeItem.nOffSetY = -22;
	Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeBuyListWnd.MainTree",strRetName,infNodeItem);
	AdenaComma = MakeCostString(UnknownFunction112("",string(MakingFee)));
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = AdenaComma;
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 0;
	infNodeItem.nOffSetY = -22;
	infNodeItem.t_color = GetNumericColor(AdenaComma);
	Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeBuyListWnd.MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSystemString(469);
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 5;
	infNodeItem.nOffSetY = -22;
	infNodeItem.t_color.R = 255;
	infNodeItem.t_color.G = 255;
	infNodeItem.t_color.B = 0;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeBuyListWnd.MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSystemString(642);
	infNodeItem.bLineBreak = True;
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 42;
	infNodeItem.nOffSetY = -8;
	infNodeItem.t_color.R = 168;
	infNodeItem.t_color.G = 168;
	infNodeItem.t_color.B = 168;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeBuyListWnd.MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = " : ";
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 0;
	infNodeItem.nOffSetY = -8;
	Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeBuyListWnd.MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = UnknownFunction112(string(Class'UIDATA_RECIPE'.GetRecipeSuccessRate(RecipeID)),"%");
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 0;
	infNodeItem.nOffSetY = -8;
	infNodeItem.t_color.R = 176;
	infNodeItem.t_color.G = 155;
	infNodeItem.t_color.B = 121;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeBuyListWnd.MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 0;
	infNodeItem.bStopMouseFocus = True;
	infNodeItem.b_nHeight = 10;
	Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeBuyListWnd.MainTree",strRetName,infNodeItem);
}

function CustomTooltip L2jBRFunction29 (string Name, string Description, int MakingFee)
{
	local CustomTooltip ToolTip;
	local DrawItemInfo Info;
	local DrawItemInfo infoClear;
	local string AdenaComma;

	AdenaComma = MakeCostString(UnknownFunction112("",string(MakingFee)));
	ToolTip.DrawList.Length = 4;
	Info = infoClear;
	Info.eType = 1;
	Info.t_bDrawOneLine = True;
	Info.t_strText = Name;
	ToolTip.DrawList[0] = Info;
	Info = infoClear;
	Info.eType = 1;
	Info.nOffSetY = 6;
	Info.bLineBreak = True;
	Info.t_bDrawOneLine = True;
	Info.t_color.R = 163;
	Info.t_color.G = 163;
	Info.t_color.B = 163;
	Info.t_color.A = 255;
	Info.t_strText = UnknownFunction112(GetSystemString(322)," : ");
	ToolTip.DrawList[1] = Info;
	Info = infoClear;
	Info.eType = 1;
	Info.nOffSetY = 6;
	Info.t_bDrawOneLine = True;
	Info.t_color = GetNumericColor(AdenaComma);
	Info.t_strText = UnknownFunction112(UnknownFunction112(AdenaComma," "),GetSystemString(469));
	ToolTip.DrawList[2] = Info;
	Info = infoClear;
	Info.eType = 1;
	Info.nOffSetY = 6;
	Info.bLineBreak = True;
	Info.t_bDrawOneLine = True;
	Info.t_color = GetNumericColor(AdenaComma);
	Info.t_strText = UnknownFunction112(UnknownFunction112("(",ConvertNumToText(string(MakingFee))),")");
	ToolTip.DrawList[3] = Info;
	return ToolTip;
}

