//================================================================================
// NPHRN_EventWnd.
//================================================================================

class NPHRN_EventWnd extends UICommonAPI;

const Sometimer2= 2;
const Sometimer1= 1;
var WindowHandle L2jBRVar12;
var WindowHandle L2jBRVar173;
var WindowHandle L2jBRVar172;
var bool L2jBRVar174;

function OnRegisterEvent ()
{
	RegisterEvent(580);
}

function OnLoad ()
{
	OnRegisterEvent();
	L2jBRFunction32	();
	L2jBRVar174 = GetOptionBool("Neophron","ShowEvent");
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,580) )
	{
		if ( L2jBRVar174 )
		{
			L2jBRFunction34(L2jBRVar1);
		}
	}
}

function L2jBRFunction32	 ()
{
	L2jBRVar12 = GetHandle("NPHRN_EventWnd");
	L2jBRVar173 = GetHandle("NPHRN_EventWnd.EventBox_Critical");
	L2jBRVar172 = GetHandle("NPHRN_EventWnd.EventBox_Resisted");
}

function L2jBRFunction34 (string _L2jBRVar17_)
{
	local int L2jBRVar124;

	ParseInt(_L2jBRVar17_,"Index",L2jBRVar124);
	switch (L2jBRVar124)
	{
		case 44:
		case 1280:
		if ( Class'UIAPI_WINDOW'.IsShowWindow("EventBox_Resisted") )
		{
			return;
		}
		L2jBRVar173.ShowWindow();
		L2jBRVar173.SetAlpha(0,2.0);
		L2jBRVar12.SetTimer(1,2000);
		break;
		case 139:
		L2jBRVar172.ShowWindow();
		L2jBRVar172.SetAlpha(0,2.0);
		L2jBRVar12.SetTimer(2,2000);
		break;
		default:
	}
}

function OnTimer (int TimerID)
{
	if ( UnknownFunction154(TimerID,1) )
	{
		L2jBRVar12.KillTimer(1);
		L2jBRVar173.HideWindow();
		L2jBRVar173.SetAlpha(255);
	}
	if ( UnknownFunction154(TimerID,2) )
	{
		L2jBRVar12.KillTimer(2);
		L2jBRVar172.HideWindow();
		L2jBRVar172.SetAlpha(255);
	}
}

