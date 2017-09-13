//================================================================================
// MailBtnWnd.
//================================================================================

class MailBtnWnd extends UICommonAPI;

function OnLoad ()
{
	RegisterEvent(1530);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local int iEffectNumber;

	ParseInt(L2jBRVar1,"IdxMail",iEffectNumber);
	switch (Event_ID)
	{
		case 1530:
		ShowWindowWithFocus("MailBtnWnd");
		Class'UIAPI_EFFECTBUTTON'.BeginEffect("MailBtnWnd.btnMail",iEffectNumber);
		break;
		default:
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnMail":
		HideWindow("MailBtnWnd");
		break;
		default:
	}
}

