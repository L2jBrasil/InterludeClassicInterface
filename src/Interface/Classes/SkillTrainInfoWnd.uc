//================================================================================
// SkillTrainInfoWnd.
//================================================================================

class SkillTrainInfoWnd extends UICommonAPI;

var int m_iType;
var int m_iID;
var int m_iLevel;
const OFFSET_Y_SP=120;
const OFFSET_Y_CASTRANGE=0;
const OFFSET_Y_MPCONSUME=3;
const OFFSET_Y_SECONDLINE= -14;
const OFFSET_Y_ICON_TEXTURE=4;
const OFFSET_X_ICON_TEXTURE=0;
const ENCHANT_SKILL=3;
const CLAN_SKILL=2;
const FISHING_SKILL=1;
const NORMAL_SKILL=0;

function OnLoad ()
{
	RegisterEvent(2040);
	RegisterEvent(2050);
	RegisterEvent(2060);
}

function OnClickButton (string strBtnID)
{
	switch (strBtnID)
	{
		case "btnLearn":
		OnLearn();
		break;
		case "btnGoBackList":
		HideWindow("SkillTrainInfoWnd");
		ShowWindowWithFocus("SkillTrainListWnd");
		break;
		default:
	}
}

function OnLearn ()
{
	switch (m_iType)
	{
		case 0:
		case 1:
		case 2:
		RequestAcquireSkill(m_iID,m_iLevel,m_iType);
		break;
		case 3:
		RequestExEnchantSkill(m_iID,m_iLevel);
		break;
		default:
	}
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local int iType;
	local string strIconName;
	local string strName;
	local int iID;
	local int iLevel;
	local int iSPConsume;
	local INT64 iEXPConsume;
	local string strDescription;
	local string strOperateType;
	local int iMPConsume;
	local int iCastRange;
	local int iNumOfItem;
	local string strEnchantName;
	local string strEnchantDesc;
	local int iPercent;

	switch (Event_ID)
	{
		case 2040:
		ParseInt(L2jBRVar1,"Type",iType);
		ParseString(L2jBRVar1,"strIconName",strIconName);
		ParseString(L2jBRVar1,"strName",strName);
		ParseInt(L2jBRVar1,"iID",iID);
		ParseInt(L2jBRVar1,"iLevel",iLevel);
		ParseString(L2jBRVar1,"strOperateType",strOperateType);
		ParseInt(L2jBRVar1,"iMPConsume",iMPConsume);
		ParseInt(L2jBRVar1,"iCastRange",iCastRange);
		ParseInt(L2jBRVar1,"iSPConsume",iSPConsume);
		ParseString(L2jBRVar1,"strDescription",strDescription);
		ParseInt64(L2jBRVar1,"iEXPConsume",iEXPConsume);
		ParseString(L2jBRVar1,"strEnchantName",strEnchantName);
		ParseString(L2jBRVar1,"strEnchantDesc",strEnchantDesc);
		ParseInt(L2jBRVar1,"iPercent",iPercent);
		m_iType = iType;
		m_iID = iID;
		m_iLevel = iLevel;
		ShowSkillTrainInfoWnd();
		AddSkillTrainInfo(strIconName,strName,iID,iLevel,strOperateType,iMPConsume,iCastRange,strDescription,iSPConsume,iEXPConsume,strEnchantName,strEnchantDesc,iPercent);
		break;
		case 2060:
		ParseString(L2jBRVar1,"strIconName",strIconName);
		ParseString(L2jBRVar1,"strName",strName);
		ParseInt(L2jBRVar1,"iNumOfItem",iNumOfItem);
		AddSkillTrainInfoExtend(strIconName,strName,iNumOfItem);
		ShowNeedItems();
		break;
		case 2050:
		if ( IsShowWindow("SkillTrainInfoWnd") )
		{
			HideWindow("SkillTrainInfoWnd");
		}
		break;
		default:
	}
}

function ShowSkillTrainInfoWnd ()
{
	local int iWindowTitle;
	local int iSPIdx;
	local UserInfo infoPlayer;
	local int iPlayerSP;
	local INT64 iPlayerEXP;
	local INT64 iLevelEXP;
	local INT64 iResultEXP;
	local string strEXP;

	GetPlayerInfo(infoPlayer);
	switch (m_iType)
	{
		case 0:
		case 1:
		case 3:
		iWindowTitle = 477;
		iSPIdx = 92;
		iPlayerSP = infoPlayer.nSP;
		iPlayerEXP = infoPlayer.nCurExp;
		break;
		case 2:
		iWindowTitle = 1436;
		iSPIdx = 1372;
		iPlayerSP = GetClanNameValue(infoPlayer.nClanID);
		break;
		default:
	}
	Class'UIAPI_WINDOW'.SetWindowTitle("SkillTrainInfoWnd",iWindowTitle);
	if ( UnknownFunction154(m_iType,3) )
	{
		SetBackTex("L2UI_CH3.SkillTrainWnd.skillenchant_back");
		iLevelEXP = GetExpByPlayerLevel(infoPlayer.nLevel);
		iResultEXP = Int64SubtractBfromA(iPlayerEXP,iLevelEXP);
		strEXP = Int64ToString(iResultEXP);
		Class'UIAPI_TEXTBOX'.SetText("SkillTrainInfoWnd.SubWndEnchant.txtEXP",strEXP);
	} else {
		SetBackTex("L2UI_CH3.SkillTrainWnd.SkillTrain2");
		Class'UIAPI_TEXTBOX'.SetText("SkillTrainInfoWnd.SubWndNormal.txtSPString",GetSystemString(iSPIdx));
	}
	Class'UIAPI_TEXTBOX'.SetInt("SkillTrainInfoWnd.txtSP",iPlayerSP);
	ShowWindowWithFocus("SkillTrainInfoWnd");
}

function AddSkillTrainInfo (string strIconName, string strName, int iID, int iLevel, string strOperateType, int iMPConsume, int iCastRange, string strDescription, int iSPConsume, INT64 iEXPConsume, string strEnchantName, string strEnchantDesc, int iPercent)
{
	local string strEXPConsume;

	Class'UIAPI_TEXTURECTRL'.SetTexture("SkillTrainInfoWnd.texIcon",strIconName);
	Class'UIAPI_TEXTBOX'.SetText("SkillTrainInfoWnd.txtName",strName);
	if ( UnknownFunction154(m_iType,3) )
	{
		Class'UIAPI_TEXTBOX'.SetText("SkillTrainInfoWnd.SubWndEnchant.txtEnchantName",strEnchantName);
		Class'UIAPI_TEXTBOX'.SetText("SkillTrainInfoWnd.SubWndEnchant.txtDescription",strEnchantDesc);
		Class'UIAPI_TEXTBOX'.SetInt("SkillTrainInfoWnd.SubWndEnchant.txtProbabilityOfSuccess",iPercent);
		strEXPConsume = Int64ToString(iEXPConsume);
		Class'UIAPI_TEXTBOX'.SetText("SkillTrainInfoWnd.SubWndEnchant.txtNeedEXP",strEXPConsume);
		Class'UIAPI_TEXTBOX'.SetInt("SkillTrainInfoWnd.SubWndEnchant.txtNeedSP",iSPConsume);
	} else {
		Class'UIAPI_TEXTBOX'.SetInt("SkillTrainInfoWnd.txtLevel",iLevel);
		Class'UIAPI_TEXTBOX'.SetText("SkillTrainInfoWnd.txtOperateType",strOperateType);
		Class'UIAPI_TEXTBOX'.SetInt("SkillTrainInfoWnd.txtMP",iMPConsume);
		Class'UIAPI_TEXTBOX'.SetText("SkillTrainInfoWnd.SubWndNormal.txtDescription",strDescription);
		switch (m_iType)
		{
			case 0:
			case 1:
			Class'UIAPI_TEXTBOX'.SetText("SkillTrainInfoWnd.SubWndNormal.txtNeedSPString",GetSystemString(365));
			break;
			case 2:
			Class'UIAPI_TEXTBOX'.SetText("SkillTrainInfoWnd.SubWndNormal.txtNeedSPString",GetSystemString(1437));
			break;
			default:
		}
		Class'UIAPI_TEXTBOX'.SetInt("SkillTrainInfoWnd.SubWndNormal.txtNeedSP",iSPConsume);
	}
	if ( UnknownFunction153(iCastRange,0) )
	{
		ShowWindow("SkillTrainInfoWnd.txtCastRangeString");
		ShowWindow("SkillTrainInfoWnd.txtColoneCastRange");
		Class'UIAPI_TEXTBOX'.SetInt("SkillTrainInfoWnd.txtCastRange",iCastRange);
	} else {
		HideWindow("SkillTrainInfoWnd.txtCastRangeString");
		HideWindow("SkillTrainInfoWnd.txtColoneCastRange");
		HideWindow("SkillTrainInfoWnd.txtCastRange");
	}
}

function AddSkillTrainInfoExtend (string strIconName, string strName, int iNumOfItem)
{
	if ( UnknownFunction154(m_iType,3) )
	{
		Class'UIAPI_TEXTURECTRL'.SetTexture("SkillTrainInfoWnd.SubWndEnchant.texNeedItemIcon",strIconName);
		Class'UIAPI_TEXTBOX'.SetText("SkillTrainInfoWnd.SubWndEnchant.txtNeedItemName",UnknownFunction112(UnknownFunction112(strName," X "),string(iNumOfItem)));
	} else {
		Class'UIAPI_TEXTURECTRL'.SetTexture("SkillTrainInfoWnd.SubWndNormal.texNeedItemIcon",strIconName);
		Class'UIAPI_TEXTBOX'.SetText("SkillTrainInfoWnd.SubWndNormal.txtNeedItemName",UnknownFunction112(UnknownFunction112(strName," X "),string(iNumOfItem)));
	}
}

function OnShow ()
{
	switch (m_iType)
	{
		case 0:
		case 1:
		case 2:
		HideWindow("SkillTrainInfoWnd.SubWndEnchant");
		ShowWindow("SkillTrainInfoWnd.SubWndNormal");
		HideWindow("SkillTrainInfoWnd.SubWndNormal.texNeedItemIcon");
		HideWindow("SkillTrainInfoWnd.SubWndNormal.txtNeedItemName");
		break;
		case 3:
		HideWindow("SkillTrainInfoWnd.SubWndNormal");
		ShowWindow("SkillTrainInfoWnd.SubWndEnchant");
		HideWindow("SkillTrainInfoWnd.SubWndEnchant.texNeedItemIcon");
		HideWindow("SkillTrainInfoWnd.SubWndEnchant.txtNeedItemName");
		break;
		default:
	}
}

function ShowNeedItems ()
{
	if ( UnknownFunction154(m_iType,3) )
	{
		ShowWindow("SkillTrainInfoWnd.SubWndEnchant.texNeedItemIcon");
		ShowWindow("SkillTrainInfoWnd.SubWndEnchant.txtNeedItemName");
	} else {
		ShowWindow("SkillTrainInfoWnd.SubWndNormal.texNeedItemIcon");
		ShowWindow("SkillTrainInfoWnd.SubWndNormal.txtNeedItemName");
	}
}

function SetBackTex (string strFile)
{
	Class'UIAPI_TEXTURECTRL'.SetTexture("SkillTrainInfoWnd.texBack",strFile);
}

