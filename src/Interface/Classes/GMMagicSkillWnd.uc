//================================================================================
// GMMagicSkillWnd.
//================================================================================

class GMMagicSkillWnd extends MagicSkillWnd;

var bool bShow;

function OnLoad ()
{
	RegisterEvent(2300);
	RegisterEvent(2310);
	bShow = False;
}

function OnShow ()
{
	SetFocus();
}

function OnHide ()
{
}

function ShowMagicSkill (string _L2jBRVar17_)
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
		Class'GMAPI'.RequestGMCommand(3,_L2jBRVar17_);
		bShow = True;
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2300:
		HadleGMObservingSkillListStart();
		break;
		case 2310:
		HadleGMObservingSkillList(_L2jBRVar17_);
		break;
		default:
	}
}

function HadleGMObservingSkillListStart ()
{
	Clear();
	m_hOwnerWnd.ShowWindow();
	m_hOwnerWnd.SetFocus();
}

function HadleGMObservingSkillList (string _L2jBRVar17_)
{
	L2jBRFunction71(_L2jBRVar17_);
	SetFocus();
}

function OnClickItem (string strID, int Index)
{
}

function OnClickButton (string Name)
{
	switch (Name)
	{
		case "BtnClose":
		Class'UIAPI_WINDOW'.HideWindow("GMMagicSkillWnd");
		break;
		default:
	}
}

function SetFocus ()
{
	Class'UIAPI_WINDOW'.SetFocus("GMMagicSkillWnd.SkillItem");
	Class'UIAPI_WINDOW'.SetFocus("GMMagicSkillWnd.PItemWnd");
	Class'UIAPI_WINDOW'.SetFocus("GMMagicSkillWnd.TabCtrl");
}

defaultproperties
{
    L2jBRVar13="GMMagicSkillWnd.InnerWnd"

}
