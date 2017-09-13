//================================================================================
// TutorialBtnWnd.
//================================================================================

class TutorialBtnWnd extends UICommonAPI;

function OnLoad ()
{
	RegisterEvent(1510);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local int iEffectNumber;

	ParseInt(L2jBRVar1,"QuestionID",iEffectNumber);
	switch (Event_ID)
	{
		case 1510:
		ShowWindowWithFocus("TutorialBtnWnd");
		Class'UIAPI_EFFECTBUTTON'.BeginEffect("TutorialBtnWnd.btnTutorial",iEffectNumber);
		break;
		default:
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnTutorial":
		HideWindow("TutorialBtnWnd");
		break;
		default:
	}
}

