//================================================================================
// HelpHtmlWnd.
//================================================================================

class HelpHtmlWnd extends UIScript;

var bool m_bShow;

function OnLoad ()
{
	RegisterState("HelpHtmlWnd","GamingState");
	RegisterState("HelpHtmlWnd","LoginState");
	RegisterEvent(1210);
	RegisterEvent(1220);
	m_bShow = False;
}

function OnShow ()
{
	m_bShow = True;
}

function OnHide ()
{
	m_bShow = False;
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,1210) )
	{
		HandleShowHelp(L2jBRVar1);
	} else {
		if ( UnknownFunction154(Event_ID,1220) )
		{
			HandleLoadHelpHtml(L2jBRVar1);
		}
	}
}

function HandleShowHelp (string L2jBRVar1)
{
	local string strPath;

	if ( m_bShow )
	{
		PlayConsoleSound(6);
		Class'UIAPI_WINDOW'.HideWindow("HelpHtmlWnd");
	} else {
		ParseString(L2jBRVar1,"FilePath",strPath);
		if ( UnknownFunction151(UnknownFunction125(strPath),0) )
		{
			Class'UIAPI_HTMLCTRL'.LoadHtml("HelpHtmlWnd.HtmlViewer",strPath);
			PlayConsoleSound(5);
			Class'UIAPI_WINDOW'.ShowWindow("HelpHtmlWnd");
			Class'UIAPI_WINDOW'.SetFocus("HelpHtmlWnd");
		}
	}
}

function HandleLoadHelpHtml (string L2jBRVar1)
{
	local string strHtml;

	ParseString(L2jBRVar1,"HtmlString",strHtml);
	if ( UnknownFunction151(UnknownFunction125(strHtml),0) )
	{
		Class'UIAPI_HTMLCTRL'.LoadHtmlFromString("HelpHtmlWnd.HtmlViewer",strHtml);
	}
}

