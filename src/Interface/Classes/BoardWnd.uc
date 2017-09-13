//================================================================================
// BoardWnd.
//================================================================================

class BoardWnd extends UIScript;

var bool m_bShow;
var bool m_bBtnLock;
var string m_Command[8];

function OnLoad ()
{
	RegisterEvent(1190);
	RegisterEvent(1200);
	m_bShow = False;
	m_bBtnLock = False;
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
	if ( UnknownFunction154(Event_ID,1190) )
	{
		HandleShowBBS(L2jBRVar1);
	} else {
		if ( UnknownFunction154(Event_ID,1200) )
		{
			HandleShowBoardPacket(L2jBRVar1);
		}
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnBookmark":
		OnClickBookmark();
		break;
		default:
	}
	if ( UnknownFunction122(UnknownFunction128(strID,7),"TabCtrl") )
	{
		strID = UnknownFunction127(strID,7);
		if ( UnknownFunction129(Class'UIAPI_WINDOW'.IsMinimizedWindow("BoardWnd")) )
		{
			ShowBBSTab(int(strID));
		}
	}
}

function Clear ()
{
}

function HandleShowBBS (string L2jBRVar1)
{
	local int Index;
	local int Init;

	ParseInt(L2jBRVar1,"Index",Index);
	ParseInt(L2jBRVar1,"Init",Init);
	if ( UnknownFunction151(Init,0) )
	{
		if ( m_bShow )
		{
			PlayConsoleSound(6);
			Class'UIAPI_WINDOW'.HideWindow("BoardWnd");
			return;
		} else {
			if ( UnknownFunction129(Class'UIAPI_HTMLCTRL'.IsPageLock("BoardWnd.HtmlViewer")) )
			{
				Class'UIAPI_HTMLCTRL'.SetPageLock("BoardWnd.HtmlViewer",True);
				Class'UIAPI_TABCTRL'.SetTopOrder("BoardWnd.TabCtrl",0,False);
				Class'UIAPI_HTMLCTRL'.Clear("BoardWnd.HtmlViewer");
				RequestBBSBoard();
			}
		}
	} else {
		Class'UIAPI_TABCTRL'.SetTopOrder("BoardWnd.TabCtrl",Index,False);
		Class'UIAPI_HTMLCTRL'.Clear("BoardWnd.HtmlViewer");
		ShowBBSTab(Index);
	}
}

function HandleShowBoardPacket (string L2jBRVar1)
{
	local int L2jBRVar2;
	local int OK;
	local string Address;

	ParseInt(L2jBRVar1,"OK",OK);
	if ( UnknownFunction150(OK,1) )
	{
		Class'UIAPI_WINDOW'.HideWindow("BoardWnd");
		return;
	}
JL0041:
	L2jBRVar2 = 0;
	if ( UnknownFunction150(L2jBRVar2,8) )
	{
		m_Command[L2jBRVar2] = "";
		UnknownFunction165(L2jBRVar2);
		goto JL0041;
	}
	ParseString(L2jBRVar1,"Command1",m_Command[0]);
	ParseString(L2jBRVar1,"Command2",m_Command[1]);
	ParseString(L2jBRVar1,"Command3",m_Command[2]);
	ParseString(L2jBRVar1,"Command4",m_Command[3]);
	ParseString(L2jBRVar1,"Command5",m_Command[4]);
	ParseString(L2jBRVar1,"Command6",m_Command[5]);
	ParseString(L2jBRVar1,"Command7",m_Command[6]);
	ParseString(L2jBRVar1,"Command8",m_Command[7]);
	m_bBtnLock = False;
	ParseString(L2jBRVar1,"Address",Address);
	Class'UIAPI_HTMLCTRL'.SetHtmlBuffData("BoardWnd.HtmlViewer",Address);
	if ( UnknownFunction129(m_bShow) )
	{
		PlayConsoleSound(5);
		Class'UIAPI_WINDOW'.ShowWindow("BoardWnd");
		Class'UIAPI_WINDOW'.SetFocus("BoardWnd");
	}
}

function ShowBBSTab (int Index)
{
	local string strBypass;
	local EControlReturnType Ret;

	switch (Index)
	{
		case 0:
		strBypass = "bypass _bbshome";
		break;
		case 1:
		strBypass = "bypass _bbsgetfav";
		break;
		case 2:
		strBypass = "bypass _bbsloc";
		break;
		case 3:
		strBypass = "bypass _bbsclan";
		break;
		case 4:
		strBypass = "bypass _bbsmemo";
		break;
		case 5:
		strBypass = "bypass _maillist_0_1_0_";
		break;
		case 6:
		strBypass = "bypass _friendlist_0_";
		break;
		default:
	}
	if ( UnknownFunction151(UnknownFunction125(strBypass),0) )
	{
		Ret = Class'UIAPI_HTMLCTRL'.ControllerExecution("BoardWnd.HtmlViewer",strBypass);
		if ( UnknownFunction154(Ret,1) )
		{
			m_bBtnLock = True;
		}
	}
}

function OnClickBookmark ()
{
	local EControlReturnType Ret;

	if ( UnknownFunction130(UnknownFunction151(UnknownFunction125(m_Command[7]),0),UnknownFunction129(m_bBtnLock)) )
	{
		Ret = Class'UIAPI_HTMLCTRL'.ControllerExecution("BoardWnd.HtmlViewer",m_Command[7]);
		if ( UnknownFunction154(Ret,1) )
		{
			m_bBtnLock = True;
		}
	}
}

