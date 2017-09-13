//================================================================================
// GMDetailStatusWnd.
//================================================================================

class GMDetailStatusWnd extends DetailStatusWnd;

var string temp1;
var bool bShow;
var UserInfo m_ObservingUserInfo;

function OnLoad ()
{
	temp1 = "Water/Air/Ground";
	RegisterEvent(2290);
	RegisterEvent(2404);
	bShow = False;
}

function OnShow ()
{
	SetFocus();
}

function OnHide ()
{
}

function ShowStatus (string _L2jBRVar17_)
{
	if ( UnknownFunction122(_L2jBRVar17_,"") )
	{
		return;
	}
	if ( bShow )
	{
		m_hOwnerWnd.HideWindow();
		bShow = False;
	} else {
		Class'GMAPI'.RequestGMCommand(1,_L2jBRVar17_);
		bShow = True;
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2290:
		if ( HandleGMObservingUserInfoUpdate() )
		{
			m_hOwnerWnd.ShowWindow();
			m_hOwnerWnd.SetFocus();
			SetFocus();
		}
		break;
		case 2404:
		HandleGMUpdateHennaInfo(_L2jBRVar17_);
		break;
		default:
	}
}

function bool HandleGMObservingUserInfoUpdate ()
{
	local UserInfo ObservingUserInfo;

	if ( Class'GMAPI'.GetObservingUserInfo(ObservingUserInfo) )
	{
		HandleUpdateUserInfo();
		Class'UIAPI_TEXTBOX'.SetText("GMDetailStatusWnd.txtClass",UnknownFunction112("",string(ObservingUserInfo.nSubClass)));
		Class'UIAPI_TEXTBOX'.SetText("GMDetailStatusWnd.txtLvl",UnknownFunction112("",string(ObservingUserInfo.nLevel)));
		return True;
	} else {
		return False;
	}
}

function HandleGMUpdateHennaInfo (string _L2jBRVar17_)
{
	HandleUpdateHennaInfo(_L2jBRVar17_);
	HandleGMObservingUserInfoUpdate();
}

function bool GetMyUserInfo (out UserInfo a_MyUserInfo)
{
	local bool Result;

	Result = Class'GMAPI'.GetObservingUserInfo(m_ObservingUserInfo);
	if ( Result )
	{
		a_MyUserInfo = m_ObservingUserInfo;
		return True;
	} else {
		return False;
	}
}

function string GetMovingSpeed (UserInfo a_UserInfo)
{
	local int WaterMaxSpeed;
	local int WaterMinSpeed;
	local int AirMaxSpeed;
	local int AirMinSpeed;
	local int GroundMaxSpeed;
	local int GroundMinSpeed;
	local string MovingSpeed;

	WaterMaxSpeed = int(UnknownFunction171(a_UserInfo.nWaterMaxSpeed,a_UserInfo.fNonAttackSpeedModifier));
	WaterMinSpeed = int(UnknownFunction171(a_UserInfo.nWaterMinSpeed,a_UserInfo.fNonAttackSpeedModifier));
	AirMaxSpeed = int(UnknownFunction171(a_UserInfo.nAirMaxSpeed,a_UserInfo.fNonAttackSpeedModifier));
	AirMinSpeed = int(UnknownFunction171(a_UserInfo.nAirMinSpeed,a_UserInfo.fNonAttackSpeedModifier));
	GroundMaxSpeed = int(UnknownFunction171(a_UserInfo.nGroundMaxSpeed,a_UserInfo.fNonAttackSpeedModifier));
	GroundMinSpeed = int(UnknownFunction171(a_UserInfo.nGroundMinSpeed,a_UserInfo.fNonAttackSpeedModifier));
	MovingSpeed = UnknownFunction112(UnknownFunction112(string(WaterMaxSpeed),","),string(WaterMinSpeed));
	MovingSpeed = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(MovingSpeed,"/"),string(AirMaxSpeed)),","),string(AirMinSpeed));
	MovingSpeed = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(MovingSpeed,"/"),string(GroundMaxSpeed)),","),string(GroundMinSpeed));
	return MovingSpeed;
}

function float GetMyExpRate ()
{
	return UnknownFunction171(GetExpRate(m_ObservingUserInfo.nCurExp,m_ObservingUserInfo.nLevel),100.0);
}

function OnClickButton (string Name)
{
	switch (Name)
	{
		case "BtnClose":
		Class'UIAPI_WINDOW'.HideWindow("GMDetailStatusWnd");
		break;
		default:
	}
}

function SetFocus ()
{
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtName1");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtName2");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadPledge");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.texPledgeCrest");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtPledge");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.texHero");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtLvHead");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtLvName");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadRank");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtRank");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.texHP");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.texMP");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.texExp");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.texCP");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.texWeight");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHP");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtMP");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtExp");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtCP");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtWeight");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtSP");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadFight");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadPhysicalAttack");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadPhysicalDefense");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadHitRate");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadCriticalRate");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadPhysicalAttackSpeed");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadMagicalAttack");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadMagicDefense");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadPhysicalAvoid");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadMovingSpeed");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadMagicCastingSpeed");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadBasic");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadSTR");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadDEX");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadCON");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadINT");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadWIT");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadMEN");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadSocial");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadCriminalRate");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadPVP");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadSociality");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHeadRemainSulffrage");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtPhysicalAttack");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtPhysicalDefense");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtHitRate");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtCriticalRate");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtPhysicalAttackSpeed");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtMagicalAttack");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtMagicDefense");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtPhysicalAvoid");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtGmMoving");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtMovingSpeed");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtMagicCastingSpeed");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtSTR");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtDEX");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtCON");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtINT");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtWIT");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtMEN");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtCriminalRate");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtPVP");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtSociality");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtRemainSulffrage");
	Class'UIAPI_WINDOW'.SetFocus("GMDetailStatusWnd.txtClass");
}

defaultproperties
{
    L2jBRVar13="GMDetailStatusWnd.InnerWnd"

}
