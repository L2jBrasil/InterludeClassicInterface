//================================================================================
// ObserverWnd.
//================================================================================

class ObserverWnd extends UICommonAPI;

var bool m_bObserverMode;

function OnLoad ()
{
	m_bObserverMode = False;
	RegisterEvent(2450);
	RegisterEvent(2460);
	RegisterEvent(150);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 2450:
		m_bObserverMode = True;
		ShowWindow("ObserverWnd");
		break;
		case 2460:
		m_bObserverMode = False;
		HideWindow("ObserverWnd");
		break;
		case 150:
		if ( m_bObserverMode )
		{
			ShowWindow("ObserverWnd");
		}
		break;
		default:
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "BtnEnd":
		RequestObserverModeEnd();
		break;
		default:
	}
}

