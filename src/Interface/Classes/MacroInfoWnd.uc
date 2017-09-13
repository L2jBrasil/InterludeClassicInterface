//================================================================================
// MacroInfoWnd.
//================================================================================

class MacroInfoWnd extends UICommonAPI;

var bool m_bShow;
var string m_strInfo;

function OnLoad ()
{
	m_bShow = False;
	m_strInfo = "";
}

function OnShow ()
{
	m_bShow = True;
}

function OnHide ()
{
	m_bShow = False;
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnOk":
		OnClickOk();
		break;
		case "btnCancel":
		OnClickCancel();
		break;
		default:
	}
}

function SetInfoText (string strInfo)
{
	m_strInfo = strInfo;
	Class'UIAPI_MULTIEDITBOX'.SetString("MacroInfoWnd.txtInfo",strInfo);
}

function string GetInfoText ()
{
	m_strInfo = Class'UIAPI_MULTIEDITBOX'.GetString("MacroInfoWnd.txtInfo");
	return m_strInfo;
}

function OnClickOk ()
{
	local string tempStr;

	tempStr = Class'UIAPI_MULTIEDITBOX'.GetString("MacroInfoWnd.txtInfo");
	if ( UnknownFunction151(UnknownFunction125(tempStr),32) )
	{
		Class'UIAPI_MULTIEDITBOX'.SetString("MacroInfoWnd.txtInfo",UnknownFunction128(tempStr,32));
		tempStr = GetSystemMessage(837);
		DialogShow(5,tempStr);
		return;
	}
	Class'UIAPI_WINDOW'.HideWindow("MacroInfoWnd");
}

function OnClickCancel ()
{
	Class'UIAPI_MULTIEDITBOX'.SetString("MacroInfoWnd.txtInfo",m_strInfo);
	Class'UIAPI_WINDOW'.HideWindow("MacroInfoWnd");
}

function Clear ()
{
	m_strInfo = "";
	Class'UIAPI_MULTIEDITBOX'.SetString("MacroInfoWnd.txtInfo","");
}

