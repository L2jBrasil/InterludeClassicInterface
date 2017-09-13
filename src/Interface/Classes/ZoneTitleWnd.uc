//================================================================================
// ZoneTitleWnd.
//================================================================================

class ZoneTitleWnd extends UICommonAPI;

var int A;
const TIMER_DELAY=4000;
const TIMER_ID=0;
const StartZoneNameY=80;
const StartZoneNameX=100;

function OnLoad ()
{
	RegisterEvent(2420);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local string ZoneName;
	local string SubZoneName1;
	local string SubZoneName2;

	switch (Event_ID)
	{
		case 2420:
		if ( UnknownFunction129(IsShowWindow("OnScreenMessageWnd2")) )
		{
			ParseString(L2jBRVar1,"ZoneName",ZoneName);
			ParseString(L2jBRVar1,"SubZoneName1",SubZoneName1);
			ParseString(L2jBRVar1,"SubZoneName2",SubZoneName2);
			BeginShowZoneName(ZoneName,SubZoneName1,SubZoneName2);
		} 
		default:
	}
}

function BeginShowZoneName (string ZoneName, string SubZoneName1, string SubZoneName2)
{
	local int TextWidth;
	local int TextHeight;
	local int ScreenWidth;
	local int ScreenHeight;

	Class'UIAPI_TEXTBOX'.SetText("textZoneNameBack",ZoneName);
	Class'UIAPI_TEXTBOX'.SetText("textZoneNameFront",ZoneName);
	GetZoneNameTextSize(ZoneName,TextWidth,TextHeight);
	GetCurrentResolution(ScreenWidth,ScreenHeight);
	Class'UIAPI_WINDOW'.SetWindowSize("ZoneTitleWnd",UnknownFunction146(TextWidth,100),200);
	Class'UIAPI_WINDOW'.MoveTo("ZoneTitleWnd",UnknownFunction147(UnknownFunction147(UnknownFunction145(ScreenWidth,2),UnknownFunction145(TextWidth,2)),100),UnknownFunction147(UnknownFunction145(ScreenHeight,5),80));
	ShowWindow("ZoneTitleWnd");
	Class'UIAPI_WINDOW'.SetUITimer("ZoneTitleWnd",0,4000);
}

function OnTimer (int TimerID)
{
	Class'UIAPI_WINDOW'.KillUITimer("ZoneTitleWnd",TimerID);
	HideWindow("ZoneTitleWnd");
}

