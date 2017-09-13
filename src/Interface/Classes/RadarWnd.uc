//================================================================================
// RadarWnd.
//================================================================================

class RadarWnd extends UIScript;

var bool onshowstat1;
var bool onshowstat2;
var int globalAlphavalue1;
var int globalyloc;
var float numberstrange;
var int global_move_val;

function SetRadarColor (Color a_RadarColor, float a_Seconds)
{
	Class'UIAPI_RADAR'.SetRadarColor("RadarContainerWnd.Radar",a_RadarColor,a_Seconds);
}

function OnLoad ()
{
	RegisterEvent(110);
	onshowstat1 = False;
	onshowstat2 = False;
	globalAlphavalue1 = 0;
	globalyloc = 0;
	numberstrange = 0.0;
	global_move_val = 0;
	Class'UIAPI_WINDOW'.HideWindow("movingtext");
	HideAllIcons();
	init_textboxmove();
}

function OnShow ()
{
	HideAllIcons();
}

function OnTick ()
{
	if ( UnknownFunction242(onshowstat2,True) )
	{
		FadeIn();
	}
	if ( UnknownFunction242(onshowstat1,True) )
	{
		FadeOut();
	}
}

function FadeIn ()
{
	globalAlphavalue1 = UnknownFunction146(globalAlphavalue1,3);
	if ( UnknownFunction150(globalAlphavalue1,255) )
	{
		Class'UIAPI_WINDOW'.SetAlpha("movingtext",globalAlphavalue1);
	} else {
		Class'UIAPI_WINDOW'.SetAlpha("movingtext",255);
		onshowstat1 = True;
		onshowstat2 = False;
	}
}

function FadeOut ()
{
	globalAlphavalue1 = UnknownFunction147(globalAlphavalue1,2);
	globalyloc = UnknownFunction146(globalyloc,1);
	if ( UnknownFunction151(globalAlphavalue1,1) )
	{
		Class'UIAPI_WINDOW'.SetAlpha("movingtext",globalAlphavalue1);
	} else {
		Class'UIAPI_WINDOW'.SetAlpha("movingtext",0);
		Class'UIAPI_WINDOW'.HideWindow("movingtext");
		globalyloc = 0;
		global_move_val = 0;
		Debug(UnknownFunction112("thisisrunningright:",string(UnknownFunction145(globalyloc,2))));
		globalAlphavalue1 = 0;
		onshowstat1 = False;
		onshowstat2 = False;
	}
}

function int move_value ()
{
	local int movevalue;

	numberstrange = UnknownFunction174(numberstrange,0.5);
	if ( UnknownFunction176(numberstrange,1) )
	{
		movevalue = 0;
		return movevalue;
	}
	if ( UnknownFunction180(numberstrange,1) )
	{
		movevalue = -1;
		numberstrange = 0.0;
		return movevalue;
	}
}

function resetanimloc ()
{
	onshowstat1 = False;
	onshowstat2 = False;
	globalyloc = 0;
	global_move_val = 0;
	globalAlphavalue1 = 0;
}

function HideAllIcons ()
{
	Class'UIAPI_WINDOW'.HideWindow("RadarWnd.icon1");
	Class'UIAPI_WINDOW'.HideWindow("RadarWnd.icon2");
	Class'UIAPI_WINDOW'.HideWindow("RadarWnd.icon3");
	Class'UIAPI_WINDOW'.HideWindow("RadarWnd.icon4");
	Class'UIAPI_WINDOW'.HideWindow("RadarWnd.icon5");
	Class'UIAPI_WINDOW'.HideWindow("RadarWnd.icon6");
	Class'UIAPI_WINDOW'.HideWindow("RadarWnd.icon7");
	Class'UIAPI_WINDOW'.HideWindow("RadarWnd.icon8");
	Class'UIAPI_WINDOW'.HideWindow("RadarWnd.icon9");
	Class'UIAPI_WINDOW'.HideWindow("RadarWnd");
}

function OnEvent (int Event_ID, string _L2jBRVar17_)
{
	local int L2jBRVar5;
	local Color Red;
	local Color Blue;
	local Color Grey;
	local Color Orange;
	local Color Green;

	Red.R = 50;
	Red.G = 0;
	Red.B = 0;
	Blue.R = 0;
	Blue.G = 0;
	Blue.B = 50;
	Grey.R = 30;
	Grey.G = 30;
	Grey.B = 30;
	Orange.R = 60;
	Orange.G = 30;
	Orange.B = 0;
	Green.R = 0;
	Green.G = 50;
	Green.B = 0;
	if ( UnknownFunction154(Event_ID,110) )
	{
		ParseInt(_L2jBRVar17_,"ZoneCode",L2jBRVar5);
		resetanimloc();
		onshowstat2 = True;
		Class'UIAPI_WINDOW'.SetAlpha("movingtext",0);
		Class'UIAPI_WINDOW'.ShowWindow("movingtext");
		switch (L2jBRVar5)
		{
			case 15:
			HideAllIcons();
			Class'UIAPI_TEXTBOX'.SetText("movingtext.textboxmove",GetSystemString(1284));
			SetRadarColor(Grey,2.0);
			break;
			case 12:
			HideAllIcons();
			Class'UIAPI_TEXTBOX'.SetText("movingtext.textboxmove",GetSystemString(1285));
			SetRadarColor(Blue,2.0);
			break;
			case 11:
			HideAllIcons();
			Class'UIAPI_TEXTBOX'.SetText("movingtext.textboxmove",GetSystemString(1286));
			SetRadarColor(Orange,2.0);
			break;
			case 9:
			HideAllIcons();
			Class'UIAPI_TEXTBOX'.SetText("movingtext.textboxmove",GetSystemString(1287));
			SetRadarColor(Red,2.0);
			break;
			case 8:
			HideAllIcons();
			Class'UIAPI_TEXTBOX'.SetText("movingtext.textboxmove",GetSystemString(1288));
			SetRadarColor(Red,2.0);
			break;
			case 13:
			HideAllIcons();
			Class'UIAPI_WINDOW'.ShowWindow("RadarWnd");
			Class'UIAPI_WINDOW'.ShowWindow("RadarWnd.icon6");
			Class'UIAPI_TEXTBOX'.SetText("movingtext.textboxmove",GetSystemString(1289));
			SetRadarColor(Grey,2.0);
			break;
			case 14:
			HideAllIcons();
			Class'UIAPI_TEXTBOX'.SetText("movingtext.textboxmove",GetSystemString(1290));
			SetRadarColor(Green,2.0);
			break;
			default:
		}
	}
}

function init_textboxmove ()
{
	Class'UIAPI_TEXTBOX'.SetText("movingtext.textboxmove","");
}

