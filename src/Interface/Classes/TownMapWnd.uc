//================================================================================
// TownMapWnd.
//================================================================================

class TownMapWnd extends UIScript;

function OnLoad ()
{
	RegisterEvent(1770);
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 1770:
		HandleShowTownMap(_L2jBRVar17_);
		break;
		default:
	}
}

function HandleShowTownMap (string _L2jBRVar17_)
{
	local string strTownMapName;
	local int UserPosX;
	local int UserPosY;

	if ( ParseString(_L2jBRVar17_,"TownMapName",strTownMapName) )
	{
		Class'UIAPI_TEXTURECTRL'.SetTexture("TownMapWnd.TownMapTex",strTownMapName);
		Class'UIAPI_TEXTURECTRL'.SetUV("TownMapWnd.TownMapTex",0,0);
	}
	if ( UnknownFunction130(ParseInt(_L2jBRVar17_,"UserPosX",UserPosX),ParseInt(_L2jBRVar17_,"UserPosY",UserPosY)) )
	{
		Class'UIAPI_WINDOW'.SetAnchor("TownMapWnd.UserTex","TownMapWnd.TownMapTex","TopLeft","TopLeft",UserPosX,UserPosY);
	}
	Class'UIAPI_WINDOW'.ShowWindow("TownMapWnd");
}

