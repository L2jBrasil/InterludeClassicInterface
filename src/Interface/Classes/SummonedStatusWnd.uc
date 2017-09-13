//================================================================================
// SummonedStatusWnd.
//================================================================================

class SummonedStatusWnd extends UIScript;

var bool m_bBuff;
var bool m_bShow;
var int m_PetID;
var bool m_bSummonedStarted;
const L2jBRVar10 = 10;

function OnLoad ()
{
	RegisterEvent(250);
	RegisterEvent(1000);
	RegisterEvent(1100);
	RegisterEvent(1110);
	RegisterEvent(1120);
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
	if ( UnknownFunction132(UnknownFunction150(PetID,0),UnknownFunction155(IsPetOrSummoned,1)) )
	{
		Debug(UnknownFunction112(UnknownFunction112(UnknownFunction112("Hide ",string(IsPetOrSummoned))," "),string(PetID)));
		Class'UIAPI_WINDOW'.HideWindow("SummonedStatusWnd");
	} else {
		m_bShow = True;
		Class'UIAPI_WINDOW'.ShowWindow("SummonedStatusWnd");
	}
}

function OnHide ()
{
	m_bShow = False;
}

function OnEnterState (name a_PreStateName)
{
	m_bBuff = False;
	OnShow();
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,250) )
	{
		HandlePetInfoUpdate();
	} else {
		if ( UnknownFunction154(Event_ID,1130) )
		{
			HandlePetSummonedStatusClose();
		} else {
			if ( UnknownFunction154(Event_ID,1100) )
			{
				HandleSummonedStatusShow();
			} else {
				if ( UnknownFunction154(Event_ID,1000) )
				{
					HandleShowBuffIcon(L2jBRVar1);
				} else {
					if ( UnknownFunction154(Event_ID,1110) )
					{
						HandleSummonedStatusSpelledList(L2jBRVar1);
					} else {
						if ( UnknownFunction154(Event_ID,1120) )
						{
							HandleSummonedStatusRemainTime(L2jBRVar1);
						}
					}
				}
			}
		}
	}
}

function Clear ()
{
	ClearBuff();
	Class'UIAPI_NAMECTRL'.SetName("SummonedStatusWnd.PetName","",0,2);
	UpdateHPBar(0,0);
	UpdateMPBar(0,0);
}

function ClearBuff ()
{
	Class'UIAPI_STATUSICONCTRL'.Clear("SummonedStatusWnd.StatusIcon");
}

function HandleSummonedStatusRemainTime (string L2jBRVar1)
{
	local int RemainTime;
	local int MaxTime;

	ParseInt(L2jBRVar1,"RemainTime",RemainTime);
	ParseInt(L2jBRVar1,"MaxTime",MaxTime);
	if ( m_bSummonedStarted )
	{
		Class'UIAPI_PROGRESSCTRL'.SetPos("SummonedStatusWnd.progFATIGUE",RemainTime);
	} else {
		ClearBuff();
		Class'UIAPI_PROGRESSCTRL'.SetProgressTime("SummonedStatusWnd.progFATIGUE",MaxTime);
		Class'UIAPI_PROGRESSCTRL'.Start("SummonedStatusWnd.progFATIGUE");
		m_bSummonedStarted = True;
	}
}

function HandlePetSummonedStatusClose ()
{
	InitFATIGUEBar();
	Class'UIAPI_WINDOW'.HideWindow("SummonedStatusWnd");
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
	Class'UIAPI_NAMECTRL'.SetName("SummonedStatusWnd.PetName",Name,0,2);
	UpdateHPBar(HP,maxHP);
	UpdateMPBar(MP,maxMP);
}

function HandleSummonedStatusShow ()
{
	Clear();
	Class'UIAPI_WINDOW'.ShowWindow("SummonedStatusWnd");
	Class'UIAPI_WINDOW'.SetFocus("SummonedStatusWnd");
	Debug("HandleSummonedStatusShow");
}

function HandleSummonedStatusSpelledList (string L2jBRVar1)
{
	local int i;
	local int L2jBRVar29;
	local int L2jBRVar93;
	local int L2jBRVar47;
	local StatusIconInfo Info;


	L2jBRVar47 = -1;
	Class'UIAPI_STATUSICONCTRL'.Clear("SummonedStatusWnd.StatusIcon");
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
				Class'UIAPI_STATUSICONCTRL'.AddRow("SummonedStatusWnd.StatusIcon");
			}
			Class'UIAPI_STATUSICONCTRL'.AddCol("SummonedStatusWnd.StatusIcon",L2jBRVar47,Info);
			UnknownFunction165(L2jBRVar93);
		}
		UnknownFunction165(i);
		goto JL006E;
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

	rectWnd = Class'UIAPI_WINDOW'.GetRect("SummonedStatusWnd");
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
		Class'UIAPI_WINDOW'.ShowWindow("SummonedStatusWnd.StatusIcon");
	} else {
		Class'UIAPI_WINDOW'.HideWindow("SummonedStatusWnd.StatusIcon");
	}
	m_bBuff = bShow;
}

function UpdateHPBar (int Value, int MaxValue)
{
	Class'UIAPI_BARCTRL'.SetValue("SummonedStatusWnd.barHP",MaxValue,Value);
}

function UpdateMPBar (int Value, int MaxValue)
{
	Class'UIAPI_BARCTRL'.SetValue("SummonedStatusWnd.barMP",MaxValue,Value);
}

function InitFATIGUEBar ()
{
	Class'UIAPI_PROGRESSCTRL'.Stop("SummonedStatusWnd.progFATIGUE");
	Class'UIAPI_PROGRESSCTRL'.Reset("SummonedStatusWnd.progFATIGUE");
	m_bSummonedStarted = False;
}

