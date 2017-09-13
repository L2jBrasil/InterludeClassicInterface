//================================================================================
// SystemMsgWnd.
//================================================================================

class SystemMsgWnd extends UIScript;

function OnLoad ()
{
	RegisterEvent(150);
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 150:
		if ( GetOptionBool("Game","SystemMsgWnd") )
		{
			Class'UIAPI_WINDOW'.ShowWindow("SystemMsgWnd");
		} else {
			Class'UIAPI_WINDOW'.HideWindow("SystemMsgWnd");
		}
		break;
		default:
		break;
	}
}

function OnShow ()
{
	Class'UIAPI_WINDOW'.SetAnchor("ChatFilterWnd","SystemMsgWnd","TopLeft","BottomLeft",0,-5);
	ChangeAnchorEffectButton("SystemMsgWnd");
}

function OnHide ()
{
	Class'UIAPI_WINDOW'.SetAnchor("ChatFilterWnd","ChatWnd","TopLeft","BottomLeft",0,-5);
	ChangeAnchorEffectButton("ChatWnd");
}

function ChangeAnchorEffectButton (string strID)
{
	Class'UIAPI_WINDOW'.SetAnchor("TutorialBtnWnd",strID,"TopLeft","BottomLeft",5,-5);
	Class'UIAPI_WINDOW'.SetAnchor("QuestBtnWnd",strID,"TopLeft","BottomLeft",42,-5);
	Class'UIAPI_WINDOW'.SetAnchor("MailBtnWnd",strID,"TopLeft","BottomLeft",79,-5);
}

