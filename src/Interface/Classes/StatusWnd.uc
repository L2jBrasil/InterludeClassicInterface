//================================================================================
// StatusWnd.
//================================================================================

class StatusWnd extends UIScript;

var int L2jBRVar30;
var bool m_bReceivedUserInfo;

function OnLoad ()
{
	RegisterEvent(70);
	RegisterEvent(180);
	RegisterEvent(190);
	RegisterEvent(200);
	RegisterEvent(210);
	RegisterEvent(220);
	RegisterEvent(230);
	RegisterEvent(240);
}

function OnEnterState (name a_PreStateName)
{
	m_bReceivedUserInfo = False;
	UpdateUserInfo();
}

function UpdateUserInfo ()
{
	local UserInfo UserInfo;

	if ( GetPlayerInfo(UserInfo) )
	{
		m_bReceivedUserInfo = True;
		L2jBRVar30 = UserInfo.nID;
		Class'UIAPI_STATUSBARCTRL'.SetPoint("StatusWnd.CPBar",UserInfo.nCurCP,UserInfo.nMaxCP);
		Class'UIAPI_STATUSBARCTRL'.SetPoint("StatusWnd.HPBar",UserInfo.nCurHP,UserInfo.nMaxHP);
		Class'UIAPI_STATUSBARCTRL'.SetPoint("StatusWnd.MPBar",UserInfo.nCurMP,UserInfo.nMaxMP);
		Class'UIAPI_STATUSBARCTRL'.SetPointExp("StatusWnd.EXPBar",UserInfo.nCurExp,UserInfo.nLevel);
		Class'UIAPI_NAMECTRL'.SetName("StatusWnd.UserName",UserInfo.Name,0,1);
		Class'UIAPI_TEXTBOX'.SetInt("StatusWnd.StatusWnd_LevelTextBox",UserInfo.nLevel);
	}
}

function OnLButtonDown (WindowHandle L2jBRVar20, int X, int Y)
{
	local Rect rectWnd;

	rectWnd = Class'UIAPI_WINDOW'.GetRect("StatusWnd");
	if ( UnknownFunction130(UnknownFunction151(X,UnknownFunction146(rectWnd.nX,13)),UnknownFunction150(X,UnknownFunction147(UnknownFunction146(rectWnd.nX,rectWnd.nWidth),10))) )
	{
		RequestSelfTarget();
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.NPHRN_Bumper");
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 180:
		UpdateUserInfo();
		break;
		case 200:
		HandleUpdateInfo(_L2jBRVar17_);
		break;
		case 210:
		HandleUpdateInfo(_L2jBRVar17_);
		break;
		case 220:
		HandleUpdateInfo(_L2jBRVar17_);
		break;
		case 230:
		HandleUpdateInfo(_L2jBRVar17_);
		break;
		case 240:
		HandleUpdateInfo(_L2jBRVar17_);
		break;
		case 70:
		HandleRegenStatus(_L2jBRVar17_);
		break;
		default:
		break;
	}
}

function HandleUpdateInfo (string L2jBRVar1)
{
	local int ServerID;

	ParseInt(L2jBRVar1,"ServerID",ServerID);
	if ( UnknownFunction132(UnknownFunction154(L2jBRVar30,ServerID),UnknownFunction129(m_bReceivedUserInfo)) )
	{
		UpdateUserInfo();
	}
}

function HandleRegenStatus (string _L2jBRVar17_)
{
	local int L2jBRVar5;
	local int Duration;
	local int ticks;
	local float Amount;

	ParseInt(_L2jBRVar17_,"Type",L2jBRVar5);
	if ( UnknownFunction154(L2jBRVar5,1) )
	{
		ParseInt(_L2jBRVar17_,"Duration",Duration);
		ParseInt(_L2jBRVar17_,"Ticks",ticks);
		ParseFloat(_L2jBRVar17_,"Amount",Amount);
		Class'UIAPI_STATUSBARCTRL'.SetRegenInfo("StatusWnd.HPBar",Duration,ticks,Amount);
	}
}

