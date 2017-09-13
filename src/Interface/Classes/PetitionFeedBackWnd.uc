//================================================================================
// PetitionFeedBackWnd.
//================================================================================

class PetitionFeedBackWnd extends UICommonAPI;

const FEEBACKRATE_VeryBad= 4;
const FEEBACKRATE_Bad= 3;
const FEEBACKRATE_Normal= 2;
const FEEBACKRATE_Good= 1;
const FEEBACKRATE_VeryGood= 0;
const MAX_FEEDBACK_STRING_LENGTH= 512;

function OnLoad ()
{
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
}

function OnHide ()
{
	ExecuteEvent(1940,"Enable=0");
}

function OnClickButton (string a_ControlID)
{
	switch (a_ControlID)
	{
		case "OKButton":
		OnClickOKButton();
		break;
		default:
	}
}

function OnClickOKButton ()
{
	local string SelectedRadioButtonName;
	local int FeedbackRate;
	local string FeedbackMessage;
	local Color TextColor;

	SelectedRadioButtonName = Class'UIAPI_WINDOW'.GetSelectedRadioButtonName("PetitionFeedBackWnd",1);
	switch (SelectedRadioButtonName)
	{
		case "VeryGood":
		FeedbackRate = 0;
		break;
		case "Good":
		FeedbackRate = 1;
		break;
		case "Normal":
		FeedbackRate = 2;
		break;
		case "Bad":
		FeedbackRate = 3;
		break;
		case "VeryBad":
		FeedbackRate = 4;
		break;
		default:
	}
	TextColor.R = 176;
	TextColor.G = 155;
	TextColor.B = 121;
	TextColor.A = 255;
	FeedbackMessage = Class'UIAPI_MULTIEDITBOX'.GetString("PetitionFeedBackWnd.MultiEdit");
	if ( UnknownFunction151(UnknownFunction125(FeedbackMessage),512) )
	{
		AddSystemMessage(FeedbackMessage,TextColor);
	}
	Class'PetitionAPI'.RequestPetitionFeedBack(FeedbackRate,FeedbackMessage);
	HideWindow("PetitionFeedBackWnd");
}

