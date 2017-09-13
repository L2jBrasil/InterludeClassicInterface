//================================================================================
// HennaListWnd.
//================================================================================

class HennaListWnd extends UICommonAPI;

var int m_iState;
var int m_iRootNameLength;
const HENNA_UNEQUIP=2;
const HENNA_EQUIP=1;
const FEE_OFFSET_Y_UNEQUIP= -12;
const FEE_OFFSET_Y_EQUIP= -13;

function OnLoad ()
{
	RegisterEvent(1640);
	RegisterEvent(1650);
	RegisterEvent(1670);
	RegisterEvent(1680);
}

function OnClickButton (string strID)
{
	local string strHennaID;

	switch (strID)
	{
		default:
	}
	strHennaID = UnknownFunction127(strID,UnknownFunction146(m_iRootNameLength,1));
	if ( UnknownFunction154(m_iState,1) )
	{
		RequestHennaItemInfo(int(strHennaID));
	} else {
		if ( UnknownFunction154(m_iState,2) )
		{
			RequestHennaUnEquipInfo(int(strHennaID));
		}
	}
	goto JL0056;
}

function Clear ()
{
	Class'UIAPI_TREECTRL'.Clear("HennaListWnd.HennaListTree");
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local int iAdena;
	local string strName;
	local string strIconName;
	local string strDescription;
	local int iHennaID;
	local int iClassID;
	local int iNum;
	local int iFee;

	switch (Event_ID)
	{
		case 1640:
		m_iState = 1;
		Clear();
		ParseInt(L2jBRVar1,"Adena",iAdena);
		ShowHennaListWnd(iAdena);
		break;
		case 1650:
		case 1680:
		ParseString(L2jBRVar1,"Name",strName);
		ParseString(L2jBRVar1,"Description",strDescription);
		ParseString(L2jBRVar1,"IconName",strIconName);
		ParseInt(L2jBRVar1,"HennaID",iHennaID);
		ParseInt(L2jBRVar1,"ClassID",iClassID);
		ParseInt(L2jBRVar1,"NumOfItem",iNum);
		ParseInt(L2jBRVar1,"Fee",iFee);
		AddHennaListItem(strName,strIconName,strDescription,iFee,iHennaID);
		break;
		case 1670:
		m_iState = 2;
		Clear();
		ParseInt(L2jBRVar1,"Adena",iAdena);
		ShowHennaListWnd(iAdena);
		break;
		default:
	}
}

function ShowHennaListWnd (int iAdena)
{
	local XMLTreeNodeInfo infNode;
	local string strTmp;

	if ( UnknownFunction154(m_iState,1) )
	{
		Class'UIAPI_WINDOW'.SetWindowTitleByText("HennaListWnd",GetSystemString(651));
		Class'UIAPI_TEXTBOX'.SetText("HennaListWnd.txtList",GetSystemString(659));
	} else {
		if ( UnknownFunction154(m_iState,2) )
		{
			Class'UIAPI_WINDOW'.SetWindowTitleByText("HennaListWnd",GetSystemString(652));
			Class'UIAPI_TEXTBOX'.SetText("HennaListWnd.txtList",GetSystemString(660));
		}
	}
	Class'UIAPI_TEXTBOX'.SetText("HennaListWnd.txtAdena",MakeCostString(UnknownFunction112("",string(iAdena))));
	Class'UIAPI_TEXTBOX'.SetTooltipString("HennaListWnd.txtAdena",ConvertNumToText(UnknownFunction112("",string(iAdena))));
	infNode.strName = "HennaListRoot";
	infNode.nOffSetX = 7;
	infNode.nOffSetY = -3;
	strTmp = Class'UIAPI_TREECTRL'.InsertNode("HennaListWnd.HennaListTree","",infNode);
	if ( UnknownFunction150(UnknownFunction125(strTmp),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert root node. Name: ",infNode.strName));
		return;
	}
	m_iRootNameLength = UnknownFunction125(infNode.strName);
	ShowWindow("HennaListWnd");
	Class'UIAPI_WINDOW'.SetFocus("HennaListWnd");
}

function AddHennaListItem (string strName, string strIconName, string strDescription, int iFee, int iHennaID)
{
	local XMLTreeNodeInfo infNode;
	local XMLTreeNodeItemInfo infNodeItem;
	local XMLTreeNodeInfo infNodeClear;
	local XMLTreeNodeItemInfo infNodeItemClear;
	local string strRetName;
	local string strAdenaComma;

	infNode = infNodeClear;
	infNode.strName = UnknownFunction112("",string(iHennaID));
	infNode.bShowButton = 0;
	infNode.nTexExpandedOffSetX = -7;
	infNode.nTexExpandedOffSetY = 8;
	infNode.nTexExpandedHeight = 46;
	infNode.nTexExpandedRightWidth = 0;
	infNode.nTexExpandedLeftUWidth = 32;
	infNode.nTexExpandedLeftUHeight = 40;
	infNode.strTexExpandedLeft = "L2UI_CH3.etc.IconSelect2";
	strRetName = Class'UIAPI_TREECTRL'.InsertNode("HennaListWnd.HennaListTree","HennaListRoot",infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
		return;
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 2;
	infNodeItem.nOffSetX = 0;
	infNodeItem.nOffSetY = 15;
	infNodeItem.u_nTextureWidth = 32;
	infNodeItem.u_nTextureHeight = 32;
	infNodeItem.u_strTexture = strIconName;
	Class'UIAPI_TREECTRL'.InsertNodeItem("HennaListWnd.HennaListTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = strName;
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 5;
	if ( UnknownFunction154(m_iState,1) )
	{
		infNodeItem.nOffSetY = 17;
	} else {
		if ( UnknownFunction154(m_iState,2) )
		{
			infNodeItem.nOffSetY = 10;
		}
	}
	Class'UIAPI_TREECTRL'.InsertNodeItem("HennaListWnd.HennaListTree",strRetName,infNodeItem);
	if ( UnknownFunction154(m_iState,2) )
	{
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = strDescription;
		infNodeItem.bLineBreak = True;
		infNodeItem.t_bDrawOneLine = True;
		infNodeItem.nOffSetX = 37;
		infNodeItem.nOffSetY = -24;
		Class'UIAPI_TREECTRL'.InsertNodeItem("HennaListWnd.HennaListTree",strRetName,infNodeItem);
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = UnknownFunction112(GetSystemString(637)," : ");
	infNodeItem.bLineBreak = True;
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 37;
	if ( UnknownFunction154(m_iState,1) )
	{
		infNodeItem.nOffSetY = -13;
	} else {
		if ( UnknownFunction154(m_iState,2) )
		{
			infNodeItem.nOffSetY = -12;
		}
	}
	infNodeItem.t_color.R = 168;
	infNodeItem.t_color.G = 168;
	infNodeItem.t_color.B = 168;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("HennaListWnd.HennaListTree",strRetName,infNodeItem);
	strAdenaComma = MakeCostString(UnknownFunction112("",string(iFee)));
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = strAdenaComma;
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 0;
	if ( UnknownFunction154(m_iState,1) )
	{
		infNodeItem.nOffSetY = -13;
	} else {
		if ( UnknownFunction154(m_iState,2) )
		{
			infNodeItem.nOffSetY = -12;
		}
	}
	infNodeItem.t_color = GetNumericColor(strAdenaComma);
	Class'UIAPI_TREECTRL'.InsertNodeItem("HennaListWnd.HennaListTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSystemString(469);
	infNodeItem.t_bDrawOneLine = True;
	infNodeItem.nOffSetX = 5;
	if ( UnknownFunction154(m_iState,1) )
	{
		infNodeItem.nOffSetY = -13;
	} else {
		if ( UnknownFunction154(m_iState,2) )
		{
			infNodeItem.nOffSetY = -12;
		}
	}
	infNodeItem.t_color.R = 255;
	infNodeItem.t_color.G = 255;
	infNodeItem.t_color.B = 0;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("HennaListWnd.HennaListTree",strRetName,infNodeItem);
}

