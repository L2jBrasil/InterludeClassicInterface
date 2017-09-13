//================================================================================
// PetitionWnd.
//================================================================================

class PetitionWnd extends UICommonAPI;

function OnLoad ()
{
	RegisterEvent(1920);
	RegisterEvent(1930);
	RegisterEvent(1940);
	SetFeedBackEnable(False);
}

function OnHide ()
{
	SetFeedBackEnable(False);
}

function SetFeedBackEnable (bool a_IsEnabled)
{
	if ( a_IsEnabled )
	{
		Class'UIAPI_BUTTON'.EnableWindow("PetitionWnd.FeedBackButton");
	} else {
		Class'UIAPI_BUTTON'.DisableWindow("PetitionWnd.FeedBackButton");
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 1920:
		HandleShowPetitionWnd();
		break;
		case 1930:
		HandlePetitionChatMessage(_L2jBRVar17_);
		break;
		case 1940:
		HandleEnablePetitionFeedback(_L2jBRVar17_);
		break;
		default:
	}
}

function OnCompleteEditBox (string strID)
{
	local string Message;

	switch (strID)
	{
		case "PetitionChatEditBox":
		Message = Class'UIAPI_EDITBOX'.GetString("PetitionWnd.PetitionChatEditBox");
		ProcessPetitionChatMessage(Message);
		break;
		default:
	}
	Class'UIAPI_EDITBOX'.Clear("PetitionWnd.PetitionChatEditBox");
}

function HandleShowPetitionWnd ()
{
	if ( m_hOwnerWnd.IsMinimizedWindow() )
	{
		m_hOwnerWnd.NotifyAlarm();
	} else {
		ShowWindow("PetitionWnd");
		m_hOwnerWnd.SetFocus();
	}
}

function HandlePetitionChatMessage (string _L2jBRVar17_)
{
	local string chatMessage;
	local Color ChatColor;
	local int ColorR;
	local int ColorG;
	local int ColorB;
	local int ColorA;

	if ( UnknownFunction130(UnknownFunction130(UnknownFunction130(UnknownFunction130(ParseString(_L2jBRVar17_,"Message",chatMessage),ParseInt(_L2jBRVar17_,"ColorR",ColorR)),ParseInt(_L2jBRVar17_,"ColorG",ColorG)),ParseInt(_L2jBRVar17_,"ColorB",ColorB)),ParseInt(_L2jBRVar17_,"ColorA",ColorA)) )
	{
		ChatColor.R = ColorR;
		ChatColor.G = ColorG;
		ChatColor.B = ColorB;
		ChatColor.A = ColorA;
		Class'UIAPI_TEXTLISTBOX'.AddString("PetitionWnd.PetitionChatWindow",chatMessage,ChatColor);
	}
}

function HandleEnablePetitionFeedback (string _L2jBRVar17_)
{
	local int Enable;

	if ( ParseInt(_L2jBRVar17_,"Enable",Enable) )
	{
		if ( UnknownFunction154(1,Enable) )
		{
			SetFeedBackEnable(True);
		} else {
			SetFeedBackEnable(False);
		}
	}
}

function OnClickButton (string a_ControlID)
{
	switch (a_ControlID)
	{
		case "FeedBackButton":
		OnClickFeedBackButton();
		break;
		case "CancelButton":
		OnClickCancelButton();
		break;
		default:
	}
}

function OnClickFeedBackButton ()
{
	Class'UIAPI_WINDOW'.ShowWindow("PetitionFeedBackWnd");
}

function OnClickCancelButton ()
{
	SetFeedBackEnable(False);
	Class'PetitionAPI'.RequestPetitionCancel();
}

function Clear ()
{
	Class'UIAPI_TEXTLISTBOX'.Clear("PetitionWnd.PetitionChatWindow");
}

