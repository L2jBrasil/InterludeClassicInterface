//================================================================================
// MagicSkillWnd.
//================================================================================

class MagicSkillWnd extends UICommonAPI;

var bool m_bShow;
var string L2jBRVar13;
const Skill_MAX_COUNT= 24;

function OnLoad ()
{
	RegisterEvent(1280);
	RegisterEvent(1290);
	RegisterEvent(1900);
	m_bShow = False;
	Class'UIAPI_WINDOW'.HideWindow("MagicSkillWnd.BSkill");
	Class'UIAPI_WINDOW'.HideWindow("MagicSkillWnd.Container.Fore");
	Class'UIAPI_WINDOW'.HideWindow("MagicSkillWnd.Mark0");
	Class'UIAPI_WINDOW'.HideWindow("MagicSkillWnd.Head0");
}

function OnShow ()
{
	RequestSkillList();
	m_bShow = True;
	SetFocus();
}

function OnHide ()
{
	m_bShow = False;
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,1280) )
	{
		L2jBRFunction80();
	} else {
		if ( UnknownFunction154(Event_ID,1290) )
		{
			L2jBRFunction71(L2jBRVar1);
		} else {
			if ( UnknownFunction154(Event_ID,1900) )
			{
				L2jBRFunction1();
			}
		}
	}
}

function OnClickItem (string strID, int Index)
{
	local ItemInfo L2jBRVar3;

	if ( UnknownFunction130(UnknownFunction122(strID,"SkillItem"),UnknownFunction151(Index,-1)) )
	{
		if ( Class'UIAPI_ITEMWINDOW'.GetItem(UnknownFunction112(L2jBRVar13,".ASkill.SkillItem"),Index,L2jBRVar3) )
		{
			UseSkill(L2jBRVar3.ClassID);
		}
	}
}

function OnClickButton (string strID)
{
	if ( UnknownFunction122(strID,"BtnClose") )
	{
		HideWindow("MagicSkillWnd");
	}
}

function __L2jBRFunction1()
{
	RequestSkillList();
}

function L2jBRFunction80 ()
{
	Clear();
}

function Clear ()
{
	Class'UIAPI_ITEMWINDOW'.Clear(UnknownFunction112(L2jBRVar13,".ASkill.SkillItem"));
	Class'UIAPI_ITEMWINDOW'.Clear(UnknownFunction112(L2jBRVar13,".PSkill.PItemWnd"));
}

function L2jBRFunction71 (string L2jBRVar1)
{
	local string WndName;
	local int L2jBRVar4;
	local ESkillCategory L2jBRVar5;
	local int SkillID;
	local int SkillLevel;
	local int Lock;
	local string strIconName;
	local string strSkillName;
	local string strDescription;
	local string strEnchantName;
	local string strCommand;
	local ItemInfo L2jBRVar3;

	ParseInt(L2jBRVar1,"Type",L2jBRVar4);
	ParseInt(L2jBRVar1,"ClassID",SkillID);
	ParseInt(L2jBRVar1,"Level",SkillLevel);
	ParseInt(L2jBRVar1,"Lock",Lock);
	ParseString(L2jBRVar1,"Name",strSkillName);
	ParseString(L2jBRVar1,"IconName",strIconName);
	ParseString(L2jBRVar1,"Description",strDescription);
	ParseString(L2jBRVar1,"EnchantName",strEnchantName);
	ParseString(L2jBRVar1,"Command",strCommand);
	L2jBRVar3.ClassID = SkillID;
	L2jBRVar3.Level = SkillLevel;
	L2jBRVar3.Name = strSkillName;
	L2jBRVar3.AdditionalName = strEnchantName;
	L2jBRVar3.IconName = strIconName;
	L2jBRVar3.Description = strDescription;
	L2jBRVar3.ItemSubType = 2;
	L2jBRVar3.MacroCommand = strCommand;
	if ( UnknownFunction151(Lock,0) )
	{
		L2jBRVar3.bIsLock = True;
	} else {
		L2jBRVar3.bIsLock = False;
	}
	L2jBRVar5 = L2jBRVar4;
	if ( UnknownFunction154(L2jBRVar5,1) )
	{
		WndName = "PSkill.PItemWnd";
		if ( UnknownFunction151(Class'UIAPI_ITEMWINDOW'.GetItemNum("MagicSkillWnd.PSkill.PItemWnd"),70) )
		{
			Class'UIAPI_ITEMWINDOW'.ShowScrollBar("MagicSkillWnd.PSkill.PItemWnd",True);
		} else {
			Class'UIAPI_ITEMWINDOW'.ShowScrollBar("MagicSkillWnd.PSkill.PItemWnd",False);
		}
	} else {
		WndName = "ASkill.SkillItem";
		if ( UnknownFunction151(Class'UIAPI_ITEMWINDOW'.GetItemNum("MagicSkillWnd.ASkill.SkillItem"),70) )
		{
			Class'UIAPI_ITEMWINDOW'.ShowScrollBar("MagicSkillWnd.ASkill.SkillItem",True);
		} else {
			Class'UIAPI_ITEMWINDOW'.ShowScrollBar("MagicSkillWnd.ASkill.SkillItem",False);
		}
	}
	Class'UIAPI_ITEMWINDOW'.AddItem(UnknownFunction112(UnknownFunction112(L2jBRVar13,"."),WndName),L2jBRVar3);
}

function SetFocus ()
{
	Class'UIAPI_WINDOW'.SetFocus("MagicSkillWnd.SkillItem");
	Class'UIAPI_WINDOW'.SetFocus("MagicSkillWnd.PItemWnd");
	Class'UIAPI_WINDOW'.SetFocus("MagicSkillWnd.TabCtrl");
}

defaultproperties
{
    L2jBRVar13="MagicSkillWnd"

}
