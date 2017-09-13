//================================================================================
// RestartMenuWnd.
//================================================================================

class RestartMenuWnd extends UICommonAPI;

var bool m_bShow;
var bool m_bRestartON;
var bool m_bVillage;
var bool m_bAgit;
var bool m_bCastle;
var bool m_bBattleCamp;
var bool m_bOriginal;
var WindowHandle L2jBRVar103;
var ButtonHandle m_btnVillage;
var ButtonHandle m_btnAgit;
var ButtonHandle m_btnCastle;
var ButtonHandle m_btnBattleCamp;
var ButtonHandle m_btnOriginal;

function OnLoad ()
{
	RegisterEvent(50);
	RegisterEvent(40);
	RegisterEvent(1430);
	RegisterEvent(1440);
	m_bShow = False;
	m_bRestartON = False;
	L2jBRVar103 = GetHandle("RestartMenuWnd");
	m_btnVillage = ButtonHandle(GetHandle("RestartMenuWnd.btnVillage"));
	m_btnAgit = ButtonHandle(GetHandle("RestartMenuWnd.btnAgit"));
	m_btnCastle = ButtonHandle(GetHandle("RestartMenuWnd.btnCastle"));
	m_btnBattleCamp = ButtonHandle(GetHandle("RestartMenuWnd.btnBattleCamp"));
	m_btnOriginal = ButtonHandle(GetHandle("RestartMenuWnd.btnOriginal"));
}

function OnShow ()
{
	m_bShow = True;
}

function OnHide ()
{
	m_bShow = False;
}

function OnEnterState (name a_PreStateName)
{
	if ( m_bRestartON )
	{
		ShowMe();
	} else {
		HideMe();
	}
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,50) )
	{
		L2jBRFunction76(L2jBRVar1);
	} else {
		if ( UnknownFunction154(Event_ID,40) )
		{
			L2jBRFunction4();
		} else {
			if ( UnknownFunction154(Event_ID,1430) )
			{
				HandleRestartMenuShow();
			} else {
				if ( UnknownFunction154(Event_ID,1440) )
				{
					HandleRestartMenuHide();
				}
			}
		}
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnVillage":
		OnVillageClick();
		break;
		case "btnAgit":
		OnAgitClick();
		break;
		case "btnCastle":
		OnCastleClick();
		break;
		case "btnBattleCamp":
		OnBattleCampClick();
		break;
		case "btnOriginal":
		OnOriginalClick();
		break;
		default:
	}
}

function OnVillageClick ()
{
	RequestRestartPoint(0);
	HideMe();
}

function OnAgitClick ()
{
	RequestRestartPoint(1);
	HideMe();
}

function OnCastleClick ()
{
	RequestRestartPoint(2);
	HideMe();
}

function OnBattleCampClick ()
{
	RequestRestartPoint(3);
	HideMe();
}

function OnOriginalClick ()
{
	RequestRestartPoint(4);
	HideMe();
}

function L2jBRFunction76 (string L2jBRVar1)
{
	local int Village;
	local int Agit;
	local int Castle;
	local int BattleCamp;
	local int Original;

	ParseInt(L2jBRVar1,"Village",Village);
	ParseInt(L2jBRVar1,"Agit",Agit);
	ParseInt(L2jBRVar1,"Castle",Castle);
	ParseInt(L2jBRVar1,"BattleCamp",BattleCamp);
	ParseInt(L2jBRVar1,"Original",Original);
	m_bVillage = False;
	m_bAgit = False;
	m_bCastle = False;
	m_bBattleCamp = False;
	m_bOriginal = False;
	if ( UnknownFunction151(Village,0) )
	{
		m_bVillage = True;
	}
	if ( UnknownFunction151(Agit,0) )
	{
		m_bAgit = True;
	}
	if ( UnknownFunction151(Castle,0) )
	{
		m_bCastle = True;
	}
	if ( UnknownFunction151(BattleCamp,0) )
	{
		m_bBattleCamp = True;
	}
	if ( UnknownFunction151(Original,0) )
	{
		m_bOriginal = True;
	}
}

function HandleRestartMenuShow ()
{
	ShowMe();
}

function HandleRestartMenuHide ()
{
	HideMe();
}

function L2jBRFunction4 ()
{
	HideMe();
}

function ShowMe ()
{
	m_bRestartON = True;
	L2jBRVar103.ShowWindow();
	if ( m_bVillage )
	{
		m_btnVillage.ShowWindow();
	} else {
		m_btnVillage.HideWindow();
	}
	if ( m_bAgit )
	{
		m_btnAgit.ShowWindow();
	} else {
		m_btnAgit.HideWindow();
	}
	if ( m_bCastle )
	{
		m_btnCastle.ShowWindow();
	} else {
		m_btnCastle.HideWindow();
	}
	if ( m_bBattleCamp )
	{
		m_btnBattleCamp.ShowWindow();
	} else {
		m_btnBattleCamp.HideWindow();
	}
	if ( m_bOriginal )
	{
		m_btnOriginal.ShowWindow();
	} else {
		m_btnOriginal.HideWindow();
	}
}

function HideMe ()
{
	m_bRestartON = False;
	L2jBRVar103.HideWindow();
}

