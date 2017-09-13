//================================================================================
// OlympiadControlWnd.
//================================================================================

class OlympiadControlWnd extends UIScript;

function OnLoad ()
{
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnStop":
		Class'OlympiadAPI'.RequestOlympiadObserverEnd();
		break;
		case "btnOtherGame":
		Class'OlympiadAPI'.RequestOlympiadMatchList();
		break;
		default:
	}
}

