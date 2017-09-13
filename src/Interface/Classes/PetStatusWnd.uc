//================================================================================
// PetStatusWnd.
//================================================================================

class PetStatusWnd extends UIScript;

var bool m_bBuff;
var bool m_bShow;
var int m_PetID;
const L2jBRVar10 = 10;

function OnLoad ()
{
	RegisterEvent(250);
	RegisterEvent(1000);
	RegisterEvent(1040);
	RegisterEvent(1050);
	RegisterEvent(1130);
	m_bShow = False;
	m_bBuff = False;
}

function OnShow ()
{
	local int PetID;
	local int IsPetOrSummoned;

	PetID = Class'UIDATA_PET'.GetPetID();
	IsPetOrSummoned = Class'UIDATA_PET'.GetIsPetOrSummoned();
	if ( UnknownFunction132(UnknownFunction150(PetID,0),UnknownFunction155(IsPetOrSummoned,2)) )
	{
		Class'UIAPI_WINDOW'.HideWindow("PetStatusWnd");
	} else {
		m_bShow = True;
	}
}

function OnHide ()
{
	m_bShow = False;
}

function OnEnterState (name a_PreStateName)
{
	m_bBuff = False;
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,250) )
	{
		HandlePetInfoUpdate();
	} else {
		if ( UnknownFunction154(Event_ID,1130) )
		{
			HandlePetStatusClose();
		} else {
			if ( UnknownFunction154(Event_ID,1040) )
			{
				HandlePetStatusShow();
			} else {
				if ( UnknownFunction154(Event_ID,1000) )
				{
					HandleShowBuffIcon(L2jBRVar1);
				} else {
					if ( UnknownFunction154(Event_ID,1050) )
					{
						HandlePetStatusSpelledList(L2jBRVar1);
					}
				}
			}
		}
	}
}

function Clear ()
{
	Class'UIAPI_STATUSICONCTRL'.Clear("PetStatusWnd.StatusIcon");
	Class'UIAPI_NAMECTRL'.SetName("PetStatusWnd.PetName","",0,2);
	UpdateHPBar(0,0);
	UpdateMPBar(0,0);
	UpdateFatigueBar(0,0);
}

function HandlePetStatusClose ()
{
	Class'UIAPI_WINDOW'.HideWindow("PetStatusWnd");
	PlayConsoleSound(6);
}

function HandlePetInfoUpdate ()
{
	local string Name;
	local int HP;
	local int maxHP;
	local int MP;
	local int maxMP;
	local int Fatigue;
	local int MaxFatigue;
	local PetInfo Info;

	m_PetID = 0;
	if ( GetPetInfo(Info) )
	{
		m_PetID = Info.nID;
		Name = Info.Name;
		HP = Info.nCurHP;
		MP = Info.nCurMP;
		Fatigue = Info.nFatigue;
		maxHP = Info.nMaxHP;
		maxMP = Info.nMaxMP;
		MaxFatigue = Info.nMaxFatigue;
	}
	Class'UIAPI_NAMECTRL'.SetName("PetStatusWnd.PetName",Name,0,2);
	UpdateHPBar(HP,maxHP);
	UpdateMPBar(MP,maxMP);
	UpdateFatigueBar(Fatigue,MaxFatigue);
}

function HandlePetStatusShow ()
{
	Clear();
	Class'UIAPI_WINDOW'.ShowWindow("PetStatusWnd");
	Class'UIAPI_WINDOW'.SetFocus("PetStatusWnd");
}

function HandlePetStatusSpelledList (string L2jBRVar1)
{
	local int i;
	local int L2jBRVar29;
	local int L2jBRVar93;
	local int L2jBRVar47;
	local StatusIconInfo Info;


	L2jBRVar47 = -1;
	Class'UIAPI_STATUSICONCTRL'.Clear("PetStatusWnd.StatusIcon");
	Info.Size = 16;
	Info.bShow = True;
	ParseInt(L2jBRVar1,"Max",L2jBRVar29);
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar29) )
	{
		ParseInt(L2jBRVar1,UnknownFunction112("SkillID_",string(i)),Info.ClassID);
		if ( UnknownFunction151(Info.ClassID,0) )
		{
			Info.IconName = Class'UIDATA_SKILL'.GetIconName(Info.ClassID,1);
			if ( UnknownFunction180(UnknownFunction173(L2jBRVar93,10),0) )
			{
				UnknownFunction165(L2jBRVar47);
				Class'UIAPI_STATUSICONCTRL'.AddRow("PetStatusWnd.StatusIcon");
			}
			Class'UIAPI_STATUSICONCTRL'.AddCol("PetStatusWnd.StatusIcon",L2jBRVar47,Info);
			UnknownFunction165(L2jBRVar93);
		}
		UnknownFunction165(i);
		goto JL0069;
	}
	UpdateBuff(m_bBuff);
}

function HandleShowBuffIcon (string L2jBRVar1)
{
	local int nShow;

	ParseInt(L2jBRVar1,"Show",nShow);
	if ( UnknownFunction154(nShow,1) )
	{
		UpdateBuff(True);
	} else {
		UpdateBuff(False);
	}
}

function OnLButtonDown (WindowHandle L2jBRVar20, int X, int Y)
{
	local Rect rectWnd;
	local UserInfo UserInfo;

	rectWnd = Class'UIAPI_WINDOW'.GetRect("PetStatusWnd");
	if ( UnknownFunction130(UnknownFunction151(X,UnknownFunction146(rectWnd.nX,13)),UnknownFunction150(X,UnknownFunction147(UnknownFunction146(rectWnd.nX,rectWnd.nWidth),10))) )
	{
		if ( GetPlayerInfo(UserInfo) )
		{
			RequestAction(m_PetID,UserInfo.Loc);
		}
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnBuff":
		OnBuffButton();
		break;
		default:
	}
}

function OnBuffButton ()
{
	UpdateBuff(UnknownFunction129(m_bBuff));
}

function UpdateBuff (bool bShow)
{
	if ( bShow )
	{
		Class'UIAPI_WINDOW'.ShowWindow("PetStatusWnd.StatusIcon");
	} else {
		Class'UIAPI_WINDOW'.HideWindow("PetStatusWnd.StatusIcon");
	}
	m_bBuff = bShow;
}

function UpdateHPBar (int Value, int MaxValue)
{
	Class'UIAPI_BARCTRL'.SetValue("PetStatusWnd.barHP",MaxValue,Value);
}

function UpdateMPBar (int Value, int MaxValue)
{
	Class'UIAPI_BARCTRL'.SetValue("PetStatusWnd.barMP",MaxValue,Value);
}

function UpdateFatigueBar (int Value, int MaxValue)
{
	Class'UIAPI_BARCTRL'.SetValue("PetStatusWnd.barFatigue",MaxValue,Value);
}

