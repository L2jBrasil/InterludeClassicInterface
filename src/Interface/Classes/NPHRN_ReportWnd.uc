//================================================================================
// NPHRN_ReportWnd.
//================================================================================

class NPHRN_ReportWnd extends UICommonAPI;

var WindowHandle L2jBRVar12;
var int L2jBRVar48;
var int L2jBRVar126;
var int L2jBRVar127;
var TextBoxHandle L2jBRVar49;
var TextBoxHandle L2jBRVar128;
var TextBoxHandle L2jBRVar50;
var TextBoxHandle L2jBRVar51;
var ButtonHandle L2jBRVar52;
var TextureHandle L2jBRVar53;

function L2jBRFunction32	 ()
{
	L2jBRVar12 = GetHandle("NPHRN_ReportWnd");
	L2jBRVar52 = ButtonHandle(GetHandle("NPHRN_ReportWnd.BtnExecute"));
	L2jBRVar49 = TextBoxHandle(GetHandle("NPHRN_ReportWnd.ExpValue"));
	L2jBRVar128 = TextBoxHandle(GetHandle("NPHRN_ReportWnd.AdenaValue"));
	L2jBRVar50 = TextBoxHandle(GetHandle("NPHRN_ReportWnd.Title"));
	L2jBRVar51 = TextBoxHandle(GetHandle("NPHRN_ReportWnd.TitleExecute"));
	L2jBRVar53 = TextureHandle(GetHandle("NPHRN_ReportWnd.TexExecute"));
}

function OnLoad ()
{
	if ( UnknownFunction242(GetOptionBool("Unload","ReportWnd"),True) )
	{
		Class'UIAPI_WINDOW'.HideWindow("NPHRN_ReportWnd");
		return;
	}
	RegisterEvent(2930);
	RegisterEvent(2940);
	RegisterEvent(580);
	L2jBRFunction32	();
}

function OnShow ()
{
	L2jBRVar12.SetFocus();
}

function OnEnterState (name a_PreStateName)
{
	Reset();
}

function OnExitState (name a_PreStateName)
{
	Reset();
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 580:
		L2jBRFunction34(_L2jBRVar17_);
		break;
		case 2930:
		case 2940:
	L2jBRVar130 = L2jBRVar16;
		L2jBRFunction58(L2jBRVar16);
		L2jBRVar12.ShowWindow();
		break;
		default:
	}
}

function Reset ()
{
	L2jBRVar129 = 0;
	L2jBRVar127 = 0;
	L2jBRVar49.SetText(UnknownFunction112(MakeCostString(string(L2jBRVar126))," Exp"));
	L2jBRVar128.SetText(UnknownFunction112(MakeCostString(string(L2jBRVar127))," Adena"));
}

function L2jBRFunction58 (int L2jBRVar16)
{
	if ( UnknownFunction154(L2jBRVar16,2930) )
	{
		L2jBRVar50.SetText(GetSystemString(147));
		L2jBRVar51.SetText(GetSystemString(147));
		L2jBRVar53.SetTexture("Interface.Symbol_Restart");
	} else {
		if ( UnknownFunction154(L2jBRVar16,2940) )
		{
			L2jBRVar50.SetText(GetSystemString(148));
			L2jBRVar51.SetText(GetSystemString(148));
			L2jBRVar53.SetTexture("Interface.Symbol_Exit");
		}
	}
}

function L2jBRFunction33 ()
{
	if ( UnknownFunction154(L2jBRVar48,2930) )
	{
		ExecRestart();
	} else {
		if ( UnknownFunction154(L2jBRVar48,2940) )
		{
			ExecQuit();
		}
	}
}

function OnClickButton (string Name)
{
	switch (Name)
	{
		case "BtnClose":
		case "BtnCancel":
		L2jBRVar12.HideWindow();
		break;
		case "BtnExecute":
		L2jBRFunction33();
		break;
		case "BtnInit":
		Reset();
		break;
		default:
	}
}

function L2jBRFunction34 (string _L2jBRVar17_)
{
	local int L2jBRVar124;
	local int L2jBRVar125;

	ParseInt(_L2jBRVar17_,"Index",L2jBRVar124);
	switch (L2jBRVar124)
	{
		case 45:
		case 95:
		ParseInt(_L2jBRVar17_,"Param1",L2jBRVar125);
		UnknownFunction161(L2jBRVar126,L2jBRVar125);
		L2jBRVar49.SetText(UnknownFunction112(MakeCostString(string(L2jBRVar126))," Exp"));
		break;
		case 28:
		case 52:
		ParseInt(_L2jBRVar17_,"Param1",L2jBRVar125);
		UnknownFunction161(L2jBRVar127,L2jBRVar125);
		L2jBRVar128.SetText(UnknownFunction112(MakeCostString(string(L2jBRVar127))," Adena"));
		break;
		default:
	}
}

