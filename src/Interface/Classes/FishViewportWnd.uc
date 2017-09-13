//================================================================================
// FishViewportWnd.
//================================================================================

class FishViewportWnd extends UICommonAPI;

function OnLoad ()
{
	RegisterEvent(2470);
	RegisterEvent(2480);
	RegisterEvent(2510);
	RegisterEvent(2520);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 2470:
		ShowWindowWithFocus("FishViewportWnd");
		break;
		case 2480:
		HideWindow("FishViewportWnd");
		break;
		case 2510:
		ShowWindow("FishViewportWnd.btnRanking");
		break;
		case 2520:
		HideWindow("FishViewportWnd.btnRanking");
		break;
		default:
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnRanking":
		RequestFishRanking();
		break;
		default:
	}
}

