//================================================================================
// NPHRN_LoginWnd.
//================================================================================

class NPHRN_LoginWnd extends UICommonAPI;

function OnLoad ()
{
	Class'UIAPI_TEXTURECTRL'.SetTexture("NPHRN_LoginWnd.Autograph","Interface.NeophronLogo");
	L2jBRFunction41();
	Class'UIAPI_WINDOW'.HideWindow("RadarContainterWnd.BtnSupport");
}

