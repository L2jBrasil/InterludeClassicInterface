//================================================================================
// GMClanWnd.
//================================================================================

class GMClanWnd extends ClanWnd;

var bool bShow;

function RegisterEvents ()
{
	local GMClanWnd script1;

	script1 = GMClanWnd(GetScript("GMClanWnd"));
	RegisterEvent(2380);
	RegisterEvent(2390);
	RegisterEvent(2400);
	bShow = False;
	Class'UIAPI_WINDOW'.DisableWindow("GMClanWnd.ClanMemInfoBtn");
	Class'UIAPI_WINDOW'.DisableWindow("GMClanWnd.ClanMemAuthBtn");
	Class'UIAPI_WINDOW'.DisableWindow("GMClanWnd.ClanBoardBtn");
	Class'UIAPI_WINDOW'.DisableWindow("GMClanWnd.ClanInfoBtn");
	Class'UIAPI_WINDOW'.DisableWindow("GMClanWnd.ClanPenaltyBtn");
	Class'UIAPI_WINDOW'.DisableWindow("GMClanWnd.ClanQuitBtn");
	Class'UIAPI_WINDOW'.DisableWindow("GMClanWnd.ClanWarInfoBtn");
	Class'UIAPI_WINDOW'.DisableWindow("GMClanWnd.ClanWarDeclareBtn");
	Class'UIAPI_WINDOW'.DisableWindow("GMClanWnd.ClanWarCancleBtn");
	Class'UIAPI_WINDOW'.DisableWindow("GMClanWnd.ClanAskJoinBtn");
	Class'UIAPI_WINDOW'.DisableWindow("GMClanWnd.ClanAuthEditBtn");
	Class'UIAPI_WINDOW'.DisableWindow("GMClanWnd.ClanTitleManageBtn");
}

function OnShow ()
{
	SetFocus();
}

function OnHide ()
{
}

function ShowClan (string _L2jBRVar17_)
{
	if ( UnknownFunction122(_L2jBRVar17_,"") )
	{
		return;
	}
	if ( bShow )
	{
		Clear();
		m_hOwnerWnd.HideWindow();
		bShow = False;
	} else {
		HandleGMObservingClan("");
		Class'GMAPI'.RequestGMCommand(2,_L2jBRVar17_);
		bShow = True;
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2380:
		HandleGMObservingClan(_L2jBRVar17_);
		break;
		case 2390:
		HandleGMObservingClanMemberStart();
		break;
		case 2400:
		HandleGMObservingClanMember(_L2jBRVar17_);
		break;
		default:
	}
}

function HandleGMObservingClan (string _L2jBRVar17_)
{
	m_hOwnerWnd.ShowWindow();
	m_hOwnerWnd.SetFocus();
	Clear();
	HandleClanInfo(_L2jBRVar17_);
}

function HandleGMObservingClanMemberStart ()
{
}

function HandleGMObservingClanMember (string _L2jBRVar17_)
{
	HandleAddClanMember(_L2jBRVar17_);
	SetFocus();
}

function OnClickButton (string Name)
{
	switch (Name)
	{
		case "BtnClose":
		Class'UIAPI_WINDOW'.HideWindow("GMClanWnd");
		break;
		default:
	}
}

function SetFocus ()
{
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.title0");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.title1");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.title2");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.title3");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanNameText");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanMasterNameText");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanMasterNameText");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanAgitText");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanStatusText");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanLevelText");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanCurrentNum");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ComboboxMainClanWnd");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanMemberList");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanMemInfoBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.HeroBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanMemAuthBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanBoardBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanInfoBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanPenaltyBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanQuitBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanWarInfoBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanWarDeclareBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanWarCancleBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanAskJoinBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanAuthEditBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.ClanTitleManageBtn");
	Class'UIAPI_WINDOW'.SetFocus("GMClanWnd.BtnClose");
}

defaultproperties
{
    L2jBRVar13="GMClanWnd.InnerWnd"

}
