//================================================================================
// RecipeTreeWnd.
//================================================================================

class RecipeTreeWnd extends UICommonAPI;

function OnLoad ()
{
	RegisterEvent(810);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local int RecipeID;
	local int SuccessRate;

	if ( UnknownFunction154(Event_ID,810) )
	{
		ParseInt(L2jBRVar1,"RecipeID",RecipeID);
		ParseInt(L2jBRVar1,"SuccessRate",SuccessRate);
		StartRecipeTreeWnd(RecipeID,SuccessRate);
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnClose":
		CloseWindow();
		break;
		default:
	}
}

function CloseWindow ()
{
	Clear();
	Class'UIAPI_WINDOW'.HideWindow("RecipeTreeWnd");
	PlayConsoleSound(6);
}

function Clear ()
{
	Class'UIAPI_TREECTRL'.Clear("RecipeTreeWnd.MainTree");
}

function StartRecipeTreeWnd (int RecipeID, int SuccessRate)
{
	Class'UIAPI_WINDOW'.ShowWindow("RecipeTreeWnd");
	Class'UIAPI_WINDOW'.SetFocus("RecipeTreeWnd");
	Clear();
	SetRecipeInfo(RecipeID,SuccessRate);
}

function SetRecipeInfo (int RecipeID, int SuccessRate)
{
	local string strTmp;
	local string strTmp2;
	local int nTmp;
	local XMLTreeNodeInfo infNode;
	local int ProductID;

	strTmp = Class'UIDATA_RECIPE'.GetRecipeIconName(RecipeID);
	if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
	{
		Class'UIAPI_TEXTURECTRL'.SetTexture("RecipeTreeWnd.texIcon",strTmp);
	} else {
		Class'UIAPI_TEXTURECTRL'.SetTexture("RecipeTreeWnd.texIcon","Default.BlackTexture");
	}
	ProductID = Class'UIDATA_RECIPE'.GetRecipeProductID(RecipeID);
	strTmp = MakeFullItemName(ProductID);
	nTmp = Class'UIDATA_RECIPE'.GetRecipeCrystalType(RecipeID);
	strTmp2 = GetItemGradeString(nTmp);
	if ( UnknownFunction151(UnknownFunction125(strTmp2),0) )
	{
		strTmp2 = UnknownFunction112(UnknownFunction112("`",strTmp2),"`");
	}
	Class'UIAPI_TEXTBOX'.SetText("RecipeTreeWnd.txtName",UnknownFunction112(UnknownFunction112(strTmp," "),strTmp2));
	nTmp = Class'UIDATA_RECIPE'.GetRecipeMpConsume(RecipeID);
	Class'UIAPI_TEXTBOX'.SetText("RecipeTreeWnd.txtMPConsume",UnknownFunction112("",string(nTmp)));
	Class'UIAPI_TEXTBOX'.SetText("RecipeTreeWnd.txtSuccessRate",UnknownFunction112(string(SuccessRate),"%"));
	nTmp = Class'UIDATA_RECIPE'.GetRecipeLevel(RecipeID);
	Class'UIAPI_TEXTBOX'.SetText("RecipeTreeWnd.txtLevel",UnknownFunction112("Lv.",string(nTmp)));
	infNode.strName = "root";
	infNode.nOffSetX = 1;
	infNode.nOffSetY = 5;
	strTmp = Class'UIAPI_TREECTRL'.InsertNode("RecipeTreeWnd.MainTree","",infNode);
	if ( UnknownFunction150(UnknownFunction125(strTmp),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert root node. Name: ",infNode.strName));
		return;
	}
	AddRecipeItem(ProductID,SuccessRate,0,"root");
}

function AddRecipeItem (int ProductID, int SuccessRate, int NeedCount, string NodeName)
{
	local int i;
	local ParamStack L2jBRVar1;
	local int nTmp;
	local string strTmp;
	local string strTmp2;
	local int nMax;
	local bool bIamRoot;
	local array<int> arrMatID;
	local array<int> arrMatRate;
	local array<int> arrMatNeedCount;
	local XMLTreeNodeInfo infNode;
	local XMLTreeNodeItemInfo infNodeItem;
	local XMLTreeNodeInfo infNodeClear;
	local XMLTreeNodeItemInfo infNodeItemClear;
	local string strRetName;

	strTmp = Class'UIDATA_RECIPE'.GetRecipeNameBy2Condition(ProductID,SuccessRate);
	if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
	{
		if ( UnknownFunction122(NodeName,"root") )
		{
			bIamRoot = True;
		} else {
			bIamRoot = False;
		}
		infNode = infNodeClear;
		infNode.strName = UnknownFunction112(UnknownFunction112(UnknownFunction112("",string(ProductID)),"_"),string(SuccessRate));
		infNode.ToolTip = MakeTooltipSimpleText(strTmp);
		infNode.bFollowCursor = True;
		if ( UnknownFunction129(bIamRoot) )
		{
			infNode.nOffSetX = 16;
		}
		infNode.bShowButton = 1;
		infNode.nTexBtnWidth = 12;
		infNode.nTexBtnHeight = 12;
		infNode.nTexBtnOffSetY = 10;
		infNode.strTexBtnExpand = "L2UI.RecipeWnd.TreePlus";
		infNode.strTexBtnCollapse = "L2UI.RecipeWnd.TreeMinus";
		strRetName = Class'UIAPI_TREECTRL'.InsertNode("RecipeTreeWnd.MainTree",NodeName,infNode);
		if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
		{
			UnknownFunction231(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
			return;
		}
		strTmp2 = Class'UIDATA_RECIPE'.GetRecipeIconNameBy2Condition(ProductID,SuccessRate);
		if ( UnknownFunction150(UnknownFunction125(strTmp2),1) )
		{
			strTmp2 = "Default.BlackTexture";
		}
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.nOffSetX = 2;
		infNodeItem.nOffSetY = 0;
		infNodeItem.u_nTextureWidth = 32;
		infNodeItem.u_nTextureHeight = 32;
		infNodeItem.u_strTexture = strTmp2;
		Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeTreeWnd.MainTree",strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.nOffSetX = -32;
		infNodeItem.nOffSetY = 0;
		infNodeItem.u_nTextureWidth = 32;
		infNodeItem.u_nTextureHeight = 32;
		infNodeItem.u_strTexture = "L2UI.RecipeWnd.RecipeTreeIconBack";
		infNodeItem.u_strTextureExpanded = "L2UI.RecipeWnd.RecipeTreeIconBack_click";
		Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeTreeWnd.MainTree",strRetName,infNodeItem);
		if ( UnknownFunction129(bIamRoot) )
		{
			nTmp = GetInventoryItemCount(ProductID);
			if ( UnknownFunction150(nTmp,NeedCount) )
			{
				infNodeItem = infNodeItemClear;
				infNodeItem.eType = 2;
				infNodeItem.nOffSetX = -32;
				infNodeItem.nOffSetY = 0;
				infNodeItem.u_nTextureWidth = 32;
				infNodeItem.u_nTextureHeight = 32;
				infNodeItem.u_strTexture = "Default.ChatBack";
				Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeTreeWnd.MainTree",strRetName,infNodeItem);
			}
		}
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = strTmp;
		infNodeItem.t_bDrawOneLine = True;
		infNodeItem.nOffSetX = 5;
		infNodeItem.nOffSetY = 4;
		Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeTreeWnd.MainTree",strRetName,infNodeItem);
		if ( UnknownFunction129(bIamRoot) )
		{
			infNodeItem = infNodeItemClear;
			infNodeItem.eType = 1;
			infNodeItem.t_strText = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(nTmp)),"/"),string(NeedCount)),")");
			infNodeItem.bLineBreak = True;
			infNodeItem.nOffSetX = 51;
			infNodeItem.nOffSetY = -14;
			Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeTreeWnd.MainTree",strRetName,infNodeItem);
		}
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 0;
		infNodeItem.bStopMouseFocus = True;
		infNodeItem.b_nHeight = 6;
		Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeTreeWnd.MainTree",strRetName,infNodeItem);
		L2jBRVar1 = Class'UIDATA_RECIPE'.GetRecipeMaterialItemBy2Condition(ProductID,SuccessRate);
		nMax = L2jBRVar1.GetInt();
		arrMatID.Length = nMax;
		arrMatRate.Length = nMax;
		arrMatNeedCount.Length = nMax;
		i = 0;
		if ( UnknownFunction150(i,nMax) )
		{
			arrMatID[i] = L2jBRVar1.GetInt();
			arrMatRate[i] = L2jBRVar1.GetInt();
			arrMatNeedCount[i] = L2jBRVar1.GetInt();
			UnknownFunction165(i);
			goto JL0611;
		}
		i = 0;
		if ( UnknownFunction150(i,nMax) )
		{
			AddRecipeItem(arrMatID[i],arrMatRate[i],arrMatNeedCount[i],strRetName);
			UnknownFunction165(i);
			goto JL0682;
		}
	} else {
		strTmp = Class'UIDATA_ITEM'.GetItemName(ProductID);
		infNode = infNodeClear;
		infNode.strName = UnknownFunction112(UnknownFunction112(UnknownFunction112("",string(ProductID)),"_"),string(SuccessRate));
		infNode.nOffSetX = 30;
		infNode.ToolTip = MakeTooltipSimpleText(strTmp);
		infNode.bFollowCursor = True;
		infNode.bShowButton = 0;
		strRetName = Class'UIAPI_TREECTRL'.InsertNode("RecipeTreeWnd.MainTree",NodeName,infNode);
		if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
		{
			UnknownFunction231(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
			return;
		}
		strTmp2 = Class'UIDATA_ITEM'.GetItemTextureName(ProductID);
		if ( UnknownFunction150(UnknownFunction125(strTmp2),1) )
		{
			strTmp2 = "Default.BlackTexture";
		}
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.nOffSetX = 0;
		infNodeItem.nOffSetY = 0;
		infNodeItem.u_nTextureWidth = 32;
		infNodeItem.u_nTextureHeight = 32;
		infNodeItem.u_strTexture = strTmp2;
		Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeTreeWnd.MainTree",strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.nOffSetX = -32;
		infNodeItem.nOffSetY = 0;
		infNodeItem.u_nTextureWidth = 32;
		infNodeItem.u_nTextureHeight = 32;
		infNodeItem.u_strTexture = "L2UI.RecipeWnd.RecipeTreeIconDisableBack";
		Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeTreeWnd.MainTree",strRetName,infNodeItem);
		nTmp = GetInventoryItemCount(ProductID);
		if ( UnknownFunction150(nTmp,NeedCount) )
		{
			infNodeItem = infNodeItemClear;
			infNodeItem.eType = 2;
			infNodeItem.nOffSetX = -32;
			infNodeItem.nOffSetY = 0;
			infNodeItem.u_nTextureWidth = 32;
			infNodeItem.u_nTextureHeight = 32;
			infNodeItem.u_strTexture = "Default.ChatBack";
			Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeTreeWnd.MainTree",strRetName,infNodeItem);
		}
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = strTmp;
		infNodeItem.t_bDrawOneLine = True;
		infNodeItem.nOffSetX = 5;
		infNodeItem.nOffSetY = 3;
		Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeTreeWnd.MainTree",strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(nTmp)),"/"),string(NeedCount)),")");
		infNodeItem.bLineBreak = True;
		infNodeItem.nOffSetX = 37;
		infNodeItem.nOffSetY = -14;
		Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeTreeWnd.MainTree",strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 0;
		infNodeItem.bStopMouseFocus = True;
		infNodeItem.b_nHeight = 4;
		Class'UIAPI_TREECTRL'.InsertNodeItem("RecipeTreeWnd.MainTree",strRetName,infNodeItem);
	}
}

