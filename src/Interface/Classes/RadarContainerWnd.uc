//================================================================================
// RadarContainerWnd.
//================================================================================

class RadarContainerWnd extends UIScript;

function OnLoad ()
{
	RegisterEvent(1730);
	RegisterEvent(1740);
	RegisterEvent(1750);
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 1730:
		HandleRadarAddTarget(_L2jBRVar17_);
		break;
		case 1740:
		HandleRadarDeleteTarget(_L2jBRVar17_);
		break;
		case 1750:
		HandleRadarDeleteAllTarget();
		break;
		default:
	}
}

function HandleRadarAddTarget (string _L2jBRVar17_)
{
	local int X;
	local int Y;
	local int Z;

	if ( UnknownFunction130(UnknownFunction130(ParseInt(_L2jBRVar17_,"X",X),ParseInt(_L2jBRVar17_,"Y",Y)),ParseInt(_L2jBRVar17_,"Z",Z)) )
	{
		Class'UIAPI_RADAR'.AddTarget("RadarContainterWnd.Radar",X,Y,Z);
	}
}

function HandleRadarDeleteTarget (string _L2jBRVar17_)
{
	local int X;
	local int Y;
	local int Z;

	if ( UnknownFunction130(UnknownFunction130(ParseInt(_L2jBRVar17_,"X",X),ParseInt(_L2jBRVar17_,"Y",Y)),ParseInt(_L2jBRVar17_,"Z",Z)) )
	{
		Class'UIAPI_RADAR'.DeleteTarget("RadarContainterWnd.Radar",X,Y,Z);
	}
}

function HandleRadarDeleteAllTarget ()
{
	Class'UIAPI_RADAR'.DeleteAllTarget("RadarContainterWnd.Radar");
}

function OnClickButton (string strID)
{
	if ( UnknownFunction122(strID,"BtnSupport") )
	{
		if ( Class'UIAPI_WINDOW'.IsShowWindow("Some") )
		{
			Class'UIAPI_WINDOW'.HideWindow("Some");
		} else {
			Class'UIAPI_WINDOW'.ShowWindow("Some");
		}
	}
}

