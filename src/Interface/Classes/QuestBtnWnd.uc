//================================================================================
// QuestBtnWnd.
//================================================================================

class QuestBtnWnd extends UICommonAPI;

function OnLoad ()
{
	RegisterEvent(1520);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local int iEffectNumber;

	ParseInt(L2jBRVar1,"QuestID",iEffectNumber);
	switch (Event_ID)
	{
		case 1520:
		ShowWindowWithFocus("QuestBtnWnd");
		Class'UIAPI_WINDOW'.ShowWindow("QuestBtnWnd.btnQuest");
		Class'UIAPI_EFFECTBUTTON'.BeginEffect("QuestBtnWnd.btnQuest",iEffectNumber);
		break;
		default:
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnQuest":
		HideWindow("QuestBtnWnd");
		break;
		default:
	}
}

