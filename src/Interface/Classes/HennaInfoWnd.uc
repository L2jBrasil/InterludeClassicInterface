//================================================================================
// HennaInfoWnd.
//================================================================================

class HennaInfoWnd extends UIScript;

var int m_iState;
var int m_iHennaID;
const HENNA_UNEQUIP=2;
const HENNA_EQUIP=1;

function OnLoad ()
{
	RegisterEvent(1660);
	RegisterEvent(1690);
}

function OnClickButton (string strID)
{
	Class'UIAPI_WINDOW'.HideWindow("HennaInfoWnd");
	switch (strID)
	{
		case "btnPrev":
		if ( UnknownFunction154(m_iState,1) )
		{
			RequestHennaItemList();
		} else {
			if ( UnknownFunction154(m_iState,2) )
			{
				RequestHennaUnEquipList();
			}
		}
		break;
		case "btnOK":
		if ( UnknownFunction154(m_iState,1) )
		{
			RequestHennaEquip(m_iHennaID);
		} else {
			if ( UnknownFunction154(m_iState,2) )
			{
				RequestHennaUnEquip(m_iHennaID);
			}
		}
		break;
		default:
	}
}

function OnShow ()
{
	if ( UnknownFunction154(m_iState,1) )
	{
		Class'UIAPI_WINDOW'.SetWindowTitleByText("HennaInfoWnd",GetSystemString(651));
		Class'UIAPI_WINDOW'.HideWindow("HennaInfoWnd.HennaInfoWndUnEquip");
		Class'UIAPI_WINDOW'.ShowWindow("HennaInfoWnd.HennaInfoWndEquip");
	} else {
		if ( UnknownFunction154(m_iState,2) )
		{
			Class'UIAPI_WINDOW'.SetWindowTitleByText("HennaInfoWnd",GetSystemString(652));
			Class'UIAPI_WINDOW'.HideWindow("HennaInfoWnd.HennaInfoWndEquip");
			Class'UIAPI_WINDOW'.ShowWindow("HennaInfoWnd.HennaInfoWndUnEquip");
		} else {
			Debug("에러에러 이상이상~~");
		}
	}
}

function OnEvent (int Event_ID, string L2jBRVar152)
{
	switch (Event_ID)
	{
		case 1660:
		m_iState = 1;
		ShowHennaInfoWnd(L2jBRVar152);
		break;
		case 1690:
		m_iState = 2;
		ShowHennaInfoWnd(L2jBRVar152);
		break;
		default:
	}
}

function ShowHennaInfoWnd (string L2jBRVar152)
{
	local string strAdenaComma;
	local int iAdena;
	local string strDyeName;
	local string strDyeIconName;
	local int iHennaID;
	local int iClassID;
	local int iNum;
	local int iFee;
	local string strTattooName;
	local string strTattooAddName;
	local string strTattooIconName;
	local int iINTnow;
	local int iINTchange;
	local int iSTRnow;
	local int iSTRchange;
	local int iCONnow;
	local int iCONchange;
	local int iMENnow;
	local int iMENchange;
	local int iDEXnow;
	local int iDEXchange;
	local int iWITnow;
	local int iWITchange;
	local Color Col;

	ParseInt(L2jBRVar152,"Adena",iAdena);
	ParseString(L2jBRVar152,"DyeIconName",strDyeIconName);
	ParseString(L2jBRVar152,"DyeName",strDyeName);
	ParseInt(L2jBRVar152,"HennaID",iHennaID);
	ParseInt(L2jBRVar152,"ClassID",iClassID);
	ParseInt(L2jBRVar152,"NumOfItem",iNum);
	ParseInt(L2jBRVar152,"Fee",iFee);
	ParseString(L2jBRVar152,"TattooIconName",strTattooIconName);
	ParseString(L2jBRVar152,"TattooName",strTattooName);
	ParseString(L2jBRVar152,"TattooAddName",strTattooAddName);
	ParseInt(L2jBRVar152,"INTnow",iINTnow);
	ParseInt(L2jBRVar152,"INTchange",iINTchange);
	ParseInt(L2jBRVar152,"STRnow",iSTRnow);
	ParseInt(L2jBRVar152,"STRchange",iSTRchange);
	ParseInt(L2jBRVar152,"CONnow",iCONnow);
	ParseInt(L2jBRVar152,"CONchange",iCONchange);
	ParseInt(L2jBRVar152,"MENnow",iMENnow);
	ParseInt(L2jBRVar152,"MENchange",iMENchange);
	ParseInt(L2jBRVar152,"DEXnow",iDEXnow);
	ParseInt(L2jBRVar152,"DEXchange",iDEXchange);
	ParseInt(L2jBRVar152,"WITnow",iWITnow);
	ParseInt(L2jBRVar152,"WITchange",iWITchange);
	m_iHennaID = iHennaID;
	if ( UnknownFunction154(m_iState,1) )
	{
		Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtDyeInfo",GetSystemString(638));
		Class'UIAPI_TEXTURECTRL'.SetTexture("HennaInfoWnd.textureDyeIconName",strDyeIconName);
		Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtDyeName",strDyeName);
		Col.R = 168;
		Col.G = 168;
		Col.B = 168;
		Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtFee",UnknownFunction112(GetSystemString(637)," : "));
		Class'UIAPI_TEXTBOX'.SetTextColor("HennaInfoWnd.txtFee",Col);
		strAdenaComma = MakeCostString(UnknownFunction112("",string(iFee)));
		Col = GetNumericColor(strAdenaComma);
		Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtAdena",strAdenaComma);
		Class'UIAPI_TEXTBOX'.SetTextColor("HennaInfoWnd.txtAdena",Col);
		Col.R = 255;
		Col.G = 255;
		Col.B = 0;
		Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtAdenaString",GetSystemString(469));
		Class'UIAPI_TEXTBOX'.SetTextColor("HennaInfoWnd.txtAdenaString",Col);
		Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtTattooInfo",GetSystemString(639));
		Class'UIAPI_TEXTURECTRL'.SetTexture("HennaInfoWnd.textureTattooIconName",strTattooIconName);
		Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtTattooName",strTattooName);
		Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtTattooAddName",strTattooAddName);
	} else {
		if ( UnknownFunction154(m_iState,2) )
		{
			Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtTattooInfoUnEquip",GetSystemString(639));
			Class'UIAPI_TEXTURECTRL'.SetTexture("HennaInfoWnd.textureTattooIconNameUnEquip",strTattooIconName);
			Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtTattooNameUnEquip",UnknownFunction112(UnknownFunction112(GetSystemString(652),":"),strTattooName));
			Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtTattooAddNameUnEquip",strTattooAddName);
			Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtDyeInfoUnEquip",GetSystemString(638));
			Class'UIAPI_TEXTURECTRL'.SetTexture("HennaInfoWnd.textureDyeIconNameUnEquip",strDyeIconName);
			Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtDyeNameUnEquip",strDyeName);
			Col.R = 168;
			Col.G = 168;
			Col.B = 168;
			Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtFeeUnEquip",UnknownFunction112(GetSystemString(637)," : "));
			Class'UIAPI_TEXTBOX'.SetTextColor("HennaInfoWnd.txtFeeUnEquip",Col);
			strAdenaComma = MakeCostString(UnknownFunction112("",string(iFee)));
			Col = GetNumericColor(strAdenaComma);
			Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtAdenaUnEquip",strAdenaComma);
			Class'UIAPI_TEXTBOX'.SetTextColor("HennaInfoWnd.txtAdenaUnEquip",Col);
			Col.R = 255;
			Col.G = 255;
			Col.B = 0;
			Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtAdenaStringUnEquip",GetSystemString(469));
			Class'UIAPI_TEXTBOX'.SetTextColor("HennaInfoWnd.txtAdenaStringUnEquip",Col);
		}
	}
	Class'UIAPI_TEXTBOX'.SetInt("HennaInfoWnd.txtSTRBefore",iSTRnow);
	Class'UIAPI_TEXTBOX'.SetInt("HennaInfoWnd.txtSTRAfter",iSTRchange);
	Class'UIAPI_TEXTBOX'.SetInt("HennaInfoWnd.txtDEXBefore",iDEXnow);
	Class'UIAPI_TEXTBOX'.SetInt("HennaInfoWnd.txtDEXAfter",iDEXchange);
	Class'UIAPI_TEXTBOX'.SetInt("HennaInfoWnd.txtCONBefore",iCONnow);
	Class'UIAPI_TEXTBOX'.SetInt("HennaInfoWnd.txtCONAfter",iCONchange);
	Class'UIAPI_TEXTBOX'.SetInt("HennaInfoWnd.txtINTBefore",iINTnow);
	Class'UIAPI_TEXTBOX'.SetInt("HennaInfoWnd.txtINTAfter",iINTchange);
	Class'UIAPI_TEXTBOX'.SetInt("HennaInfoWnd.txtWITBefore",iWITnow);
	Class'UIAPI_TEXTBOX'.SetInt("HennaInfoWnd.txtWITAfter",iWITchange);
	Class'UIAPI_TEXTBOX'.SetInt("HennaInfoWnd.txtMENBefore",iMENnow);
	Class'UIAPI_TEXTBOX'.SetInt("HennaInfoWnd.txtMENAfter",iMENchange);
	strAdenaComma = MakeCostString(UnknownFunction112("",string(iAdena)));
	Col = GetNumericColor(strAdenaComma);
	Class'UIAPI_TEXTBOX'.SetText("HennaInfoWnd.txtHaveAdena",strAdenaComma);
	Class'UIAPI_TEXTBOX'.SetTooltipString("HennaInfoWnd.txtHaveAdena",ConvertNumToText(UnknownFunction112("",string(iAdena))));
	Class'UIAPI_WINDOW'.HideWindow("HennaListWnd");
	Class'UIAPI_WINDOW'.ShowWindow("HennaInfoWnd");
	Class'UIAPI_WINDOW'.SetFocus("HennaInfoWnd");
}

