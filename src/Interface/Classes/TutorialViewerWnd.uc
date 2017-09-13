//================================================================================
// TutorialViewerWnd.
//================================================================================

class TutorialViewerWnd extends UICommonAPI;

function OnLoad ()
{
	RegisterEvent(2430);
	RegisterEvent(2440);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local string HtmlString;
	local Rect Rect;
	local int HtmlHeight;

	switch (Event_ID)
	{
		case 2430:
		ParseString(L2jBRVar1,"HtmlString",HtmlString);
		Class'UIAPI_HTMLCTRL'.LoadHtmlFromString("TutorialViewerWnd.HtmlTutorialViewer",HtmlString);
		Rect = Class'UIAPI_WINDOW'.GetRect("TutorialViewerWnd");
		HtmlHeight = Class'UIAPI_HTMLCTRL'.GetFrameMaxHeight("TutorialViewerWnd.HtmlTutorialViewer");
		if ( UnknownFunction150(HtmlHeight,256) )
		{
			HtmlHeight = 256;
		} else {
			if ( UnknownFunction151(HtmlHeight,UnknownFunction147(680,8)) )
			{
				HtmlHeight = UnknownFunction147(680,8);
			}
		}
		Rect.nHeight = UnknownFunction146(UnknownFunction146(HtmlHeight,32),8);
		Class'UIAPI_WINDOW'.SetWindowSize("TutorialViewerWnd",Rect.nWidth,Rect.nHeight);
		Class'UIAPI_WINDOW'.SetWindowSize("TutorialViewerWnd.texTutorialViewerBack2",Rect.nWidth,UnknownFunction147(UnknownFunction147(Rect.nHeight,32),9));
		Class'UIAPI_WINDOW'.MoveTo("TutorialViewerWnd.texTutorialViewerBack3",Rect.nX,UnknownFunction147(UnknownFunction146(Rect.nY,Rect.nHeight),9));
		Class'UIAPI_WINDOW'.SetWindowSize("TutorialViewerWnd.HtmlTutorialViewer",UnknownFunction147(Rect.nWidth,15),UnknownFunction147(UnknownFunction147(Rect.nHeight,32),9));
		ShowWindowWithFocus("TutorialViewerWnd");
		break;
		case 2440:
		HideWindow("TutorialViewerWnd");
		break;
		default:
	}
}

