//================================================================================
// UserPetitionWnd.
//================================================================================

class UserPetitionWnd extends UICommonAPI;

var int PetitionCategoryCount;
var int PetitionCategoryTitle[32];
var string PetitionCategoryLink[32];
const MAX_PetitionCategory= 32;

function OnLoad ()
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,PetitionCategoryCount) )
	{
		Class'UIAPI_COMBOBOX'.SYS_AddString("UserPetitionWnd.PetitionTypeComboBox",PetitionCategoryTitle[i]);
		UnknownFunction163(i);
		goto JL0007;
	}
	RegisterEvent(1921);
	RegisterEvent(1221);
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 1921:
		HandleShowUserPetitionWnd(_L2jBRVar17_);
		break;
		case 1221:
		HandleLoadPetitionHtml(_L2jBRVar17_);
		break;
		default:
	}
}

function HandleShowUserPetitionWnd (string _L2jBRVar17_)
{
	local string Message;

	m_hOwnerWnd.ShowWindow();
	m_hOwnerWnd.SetFocus();
	if ( ParseString(_L2jBRVar17_,"Message",Message) )
	{
		Class'UIAPI_MULTIEDITBOX'.SetString("UserPetitionWnd.PetitionMultiEdit",Message);
	}
}

function HandleLoadPetitionHtml (string _L2jBRVar17_)
{
	local string HtmlString;

	ParseString(_L2jBRVar17_,"HtmlString",HtmlString);
	if ( UnknownFunction151(UnknownFunction125(HtmlString),0) )
	{
		Class'UIAPI_HTMLCTRL'.LoadHtmlFromString("UserPetitionWnd.HelpHtmlCtrl",HtmlString);
	}
}

function OnComboBoxItemSelected (string a_ControlID, int a_SelectedIndex)
{
	if ( UnknownFunction122(a_ControlID,"PetitionTypeComboBox") )
	{
		if ( UnknownFunction153(a_SelectedIndex,1) )
		{
			Class'UIAPI_HTMLCTRL'.LoadHtml("UserPetitionWnd.HelpHtmlCtrl",
				UnknownFunction112(
					"..\/L2text\/",
					PetitionCategoryLink[UnknownFunction147(a_SelectedIndex,1)]
				)
			);
		}
	}
}

function OnClickButton (string a_ControlID)
{
	switch (a_ControlID)
	{
		case "OKButton":
		OnClickOKButton();
		break;
		case "CancelButton":
		OnClickCancelButton();
		break;
		default:
	}
}

function OnClickOKButton ()
{
	local string PetitionMessage;
	local int PetitionMessageLen;
	local int PetitionType;
	local string L2jBRVar1;
	local PetitionWnd PetitionWndScript;

	PetitionType = Class'UIAPI_COMBOBOX'.GetSelectedNum("UserPetitionWnd.PetitionTypeComboBox");
	PetitionMessage = Class'UIAPI_MULTIEDITBOX'.GetString("UserPetitionWnd.PetitionMultiEdit");
	PetitionMessageLen = UnknownFunction125(PetitionMessage);
	if ( UnknownFunction154(0,PetitionType) )
	{
		DialogShow(1,GetSystemMessage(804));
	} else {
		if ( UnknownFunction151(5,PetitionMessageLen) )
		{
			DialogShow(1,GetSystemMessage(386));
		} else {
			if ( UnknownFunction152(255,PetitionMessageLen) )
			{
				DialogShow(1,GetSystemMessage(971));
			} else {
				Class'PetitionAPI'.RequestPetition(PetitionMessage,PetitionType);
				Clear();
				HideWindow("UserPetitionWnd");
				PetitionWndScript = PetitionWnd(GetScript("PetitionWnd"));
				if ( UnknownFunction119(None,PetitionWndScript) )
				{
					PetitionWndScript.Clear();
					ParamAdd(L2jBRVar1,"Message",UnknownFunction112(UnknownFunction112(GetSystemString(708)," : "),PetitionMessage));
					ParamAdd(L2jBRVar1,"ColorR","220");
					ParamAdd(L2jBRVar1,"ColorG","220");
					ParamAdd(L2jBRVar1,"ColorB","220");
					ParamAdd(L2jBRVar1,"ColorA","255");
					PetitionWndScript.HandlePetitionChatMessage(L2jBRVar1);
				}
			}
		}
	}
}

function OnClickCancelButton ()
{
	Class'PetitionAPI'.RequestPetitionCancel();
	Clear();
	HideWindow("UserPetitionWnd");
}

function Clear ()
{
	Class'UIAPI_COMBOBOX'.SetSelectedNum("UserPetitionWnd.PetitionTypeComboBox",0);
	Class'UIAPI_MULTIEDITBOX'.SetString("UserPetitionWnd.PetitionMultiEdit","");
	Class'UIAPI_HTMLCTRL'.Clear("UserPetitionWnd.HelpHtmlCtrl");
}

defaultproperties
{
    PetitionCategoryCount=9

    PetitionCategoryTitle(0)=696

    PetitionCategoryTitle(1)=697

    PetitionCategoryTitle(2)=698

    PetitionCategoryTitle(3)=699

    PetitionCategoryTitle(4)=700

    PetitionCategoryTitle(5)=701

    PetitionCategoryTitle(6)=702

    PetitionCategoryTitle(7)=703

    PetitionCategoryTitle(8)=704

    PetitionCategoryLink(0)="pet_help_move.htm"

    PetitionCategoryLink(1)="pet_help_recover.htm"

    PetitionCategoryLink(2)="pet_help_bug.htm"

    PetitionCategoryLink(3)="pet_help_quest.htm"

    PetitionCategoryLink(4)="pet_help_report.htm"

    PetitionCategoryLink(5)="pet_help_suggest.htm"

    PetitionCategoryLink(6)="pet_help_game.htm"

    PetitionCategoryLink(7)="pet_help_oprn.htm"

    PetitionCategoryLink(8)="pet_help_etc.htm"

}
