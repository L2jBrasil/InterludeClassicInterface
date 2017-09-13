//================================================================================
// SkillTrainListWnd.
//================================================================================

class SkillTrainListWnd extends UICommonAPI;

var int m_iType;
var int m_iState;
var int m_iRootNameLength;
var WindowHandle m_SkillTrainListWnd;
const OFFSET_Y_SECONDLINE= -14;
const OFFSET_Y_ICON_TEXTURE=4;
const OFFSET_X_ICON_TEXTURE=0;
const ENCHANT_SKILL=3;
const CLAN_SKILL=2;
const FISHING_SKILL=1;
const NORMAL_SKILL=0;

function OnLoad ()
{
	RegisterEvent(2010);
	RegisterEvent(2020);
	RegisterEvent(2030);
	m_SkillTrainListWnd = GetHandle("SkillTrainListWnd.SkillTrainListTree");
}

function OnClickButton (string strItemID)
{
	local string strID_Level;
	local string strID;
	local string strLevel;
	local int iID;
	local int iLevel;
	local int iIdxComma;
	local int iLength;

	strID_Level = UnknownFunction127(strItemID,UnknownFunction146(m_iRootNameLength,1));
	iLength = UnknownFunction125(strID_Level);
	iIdxComma = UnknownFunction126(strID_Level,",");
	strID = UnknownFunction128(strID_Level,iIdxComma);
	strLevel = UnknownFunction234(strID_Level,UnknownFunction147(UnknownFunction147(iLength,iIdxComma),1));
	iID = int(strID);
	iLevel = int(strLevel);
	switch (m_iType)
	{
		case 0:
		case 1:
		case 2:
		RequestAcquireSkillInfo(iID,iLevel,m_iType);
		break;
		case 3:
		RequestExEnchantSkillInfo(iID,iLevel);
		break;
		default:
	}
	HideWindow("SkillTrainListWnd");
	m_SkillTrainListWnd.SetScrollPosition(0);
}

function Clear ()
{
	Class'UIAPI_TREECTRL'.Clear("SkillTrainListWnd.SkillTrainListTree");
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local int iType;
	local string strIconName;
	local string strName;
	local int iID;
	local int iLevel;
	local int iSPConsume;
	local string strEnchantName;

	switch (Event_ID)
	{
		case 2010:
		ParseInt(L2jBRVar1,"Type",iType);
		Clear();
		m_iType = iType;
		if ( IsShowWindow("SkillTrainInfoWnd") )
		{
			HideWindow("SkillTrainInfoWnd");
		}
		ShowSkillTrainListWnd(iType);
		break;
		case 2030:
		ParseString(L2jBRVar1,"strIconName",strIconName);
		ParseString(L2jBRVar1,"strName",strName);
		ParseInt(L2jBRVar1,"iID",iID);
		ParseInt(L2jBRVar1,"iLevel",iLevel);
		ParseInt(L2jBRVar1,"iSPConsume",iSPConsume);
		ParseString(L2jBRVar1,"strEnchantName",strEnchantName);
		AddSkillTrainListItem(strIconName,strName,iID,iLevel,iSPConsume,strEnchantName);
		break;
		case 2020:
		if ( IsShowWindow("SkillTrainListWnd") )
		{
			HideWindow("SkillTrainListWnd");
		}
		break;
		default:
	}
}

function OnShow ()
{
	if ( UnknownFunction154(m_iType,3) )
	{
		HideWindow("SkillTrainListWnd.txtSPString");
		HideWindow("SkillTrainListWnd.txtSP");
	} else {
		ShowWindow("SkillTrainListWnd.txtSPString");
		ShowWindow("SkillTrainListWnd.txtSP");
	}
}

function ShowSkillTrainListWnd (int iType)
{
	local XMLTreeNodeInfo infNode;
	local string strTmp;
	local int iWindowTitle;
	local int iSPIdx;
	local UserInfo infoPlayer;
	local int iPlayerSP;

	GetPlayerInfo(infoPlayer);
	switch (m_iType)
	{
		case 0:
		case 1:
		case 3:
		iWindowTitle = 477;
		iSPIdx = 92;
		iPlayerSP = infoPlayer.nSP;
		break;
		case 2:
		iWindowTitle = 1436;
		iSPIdx = 1372;
		iPlayerSP = GetClanNameValue(infoPlayer.nClanID);
		break;
		default:
	}
	Class'UIAPI_WINDOW'.SetWindowTitle("SkillTrainListWnd",iWindowTitle);
	if ( UnknownFunction155(m_iType,3) )
	{
		Class'UIAPI_TEXTBOX'.SetText("SkillTrainListWnd.txtSPString",GetSystemString(iSPIdx));
		Class'UIAPI_TEXTBOX'.SetInt("SkillTrainListWnd.txtSP",iPlayerSP);
	}
	infNode.strName = "SkillTrainListRoot";
	infNode.nOffSetX = 7;
	infNode.nOffSetY = 0;
	strTmp = Class'UIAPI_TREECTRL'.InsertNode("SkillTrainListWnd.SkillTrainListTree","",infNode);
	if ( UnknownFunction150(UnknownFunction125(strTmp),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert root node. Name: ",infNode.strName));
		return;
	}
	m_iRootNameLength = UnknownFunction125(infNode.strName);
	Class'UIAPI_WINDOW'.ShowWindow("SkillTrainListWnd");
	Class'UIAPI_WINDOW'.SetFocus("SkillTrainListWnd");
}

function AddSkillTrainListItem (string strIconName, string strName, int iID, int iLevel, int iSPConsume, string strEnchantName)
{
	local XMLTreeNodeInfo infNode;
	local XMLTreeNodeItemInfo infNodeItem;
	local XMLTreeNodeInfo infNodeClear;
	local XMLTreeNodeItemInfo infNodeItemClear;
	local string strRetName;

	infNode = infNodeClear;
	infNode.strName = UnknownFunction112(UnknownFunction112(UnknownFunction112("",string(iID)),","),string(iLevel));
	infNode.bShowButton = 0;
	infNode.nTexExpandedOffSetX = -7;
	infNode.nTexExpandedOffSetY = 2;
	infNode.nTexExpandedHeight = 38;
	infNode.nTexExpandedRightWidth = 0;
	infNode.nTexExpandedLeftUWidth = 32;
	infNode.nTexExpandedLeftUHeight = 38;
	infNode.strTexExpandedLeft = "L2UI_CH3.etc.IconSelect2";
	strRetName = Class'UIAPI_TREECTRL'.InsertNode("SkillTrainListWnd.SkillTrainListTree","SkillTrainListRoot",infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
		return;
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 2;
	infNodeItem.nOffSetX = 0;
	infNodeItem.nOffSetY = 4;
	infNodeItem.u_nTextureWidth = 34;
	infNodeItem.u_nTextureHeight = 34;
	infNodeItem.u_strTexture = "l2ui_ch3.InventoryWnd.Inventory_OutLine";
	InsertNodeItem(strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 2;
	infNodeItem.nOffSetX = -33;
	infNodeItem.nOffSetY = 4;
	infNodeItem.u_nTextureWidth = 35;
	infNodeItem.u_nTextureHeight = 35;
	infNodeItem.u_strTexture = "l2ui_ch3.InventoryWnd.Inventory_OutLine";
	InsertNodeItem(strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 2;
	infNodeItem.nOffSetX = -35;
	infNodeItem.nOffSetY = UnknownFunction146(4,1);
	infNodeItem.u_nTextureWidth = 32;
	infNodeItem.u_nTextureHeight = 32;
	infNodeItem.u_strTexture = strIconName;
	InsertNodeItem(strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = strName;
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 3;
	infNodeItem.nOffSetY = 10;
	InsertNodeItem(strRetName,infNodeItem);
	switch (m_iType)
	{
		case 0:
		case 1:
		case 2:
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = GetSystemString(88);
		infNodeItem.bLineBreak = True;
		infNodeItem.t_bDrawOneLine = True;
		infNodeItem.nOffSetX = 37;
		infNodeItem.nOffSetY = -14;
		infNodeItem.t_color.R = 163;
		infNodeItem.t_color.G = 163;
		infNodeItem.t_color.B = 163;
		infNodeItem.t_color.A = 255;
		InsertNodeItem(strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = string(iLevel);
		infNodeItem.nOffSetX = 2;
		infNodeItem.nOffSetY = -14;
		infNodeItem.t_color.R = 176;
		infNodeItem.t_color.G = 155;
		infNodeItem.t_color.B = 121;
		infNodeItem.t_color.A = 255;
		InsertNodeItem(strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		switch (m_iType)
		{
			case 0:
			case 1:
			infNodeItem.t_strText = UnknownFunction112(GetSystemString(365)," : ");
			break;
			case 2:
			infNodeItem.t_strText = UnknownFunction112(GetSystemString(1437)," : ");
			break;
			default:
		}
		infNodeItem.bLineBreak = True;
		infNodeItem.nOffSetX = 77;
		infNodeItem.nOffSetY = -14;
		infNodeItem.t_color.R = 163;
		infNodeItem.t_color.G = 163;
		infNodeItem.t_color.B = 163;
		infNodeItem.t_color.A = 255;
		InsertNodeItem(strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = string(iSPConsume);
		infNodeItem.nOffSetX = 0;
		infNodeItem.nOffSetY = -14;
		infNodeItem.t_color.R = 176;
		infNodeItem.t_color.G = 155;
		infNodeItem.t_color.B = 121;
		infNodeItem.t_color.A = 255;
		InsertNodeItem(strRetName,infNodeItem);
		break;
		case 3:
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.bLineBreak = True;
		infNodeItem.t_bDrawOneLine = True;
		infNodeItem.t_strText = strEnchantName;
		infNodeItem.nOffSetX = 37;
		infNodeItem.nOffSetY = -14;
		infNodeItem.t_color.R = 176;
		infNodeItem.t_color.G = 155;
		infNodeItem.t_color.B = 121;
		infNodeItem.t_color.A = 255;
		InsertNodeItem(strRetName,infNodeItem);
		break;
		default:
	}
}

function InsertNodeItem (string strNodeName, XMLTreeNodeItemInfo infNodeItemName)
{
	Class'UIAPI_TREECTRL'.InsertNodeItem("SkillTrainListWnd.SkillTrainListTree",strNodeName,infNodeItemName);
}

