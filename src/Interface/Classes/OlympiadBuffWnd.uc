//================================================================================
// OlympiadBuffWnd.
//================================================================================

class OlympiadBuffWnd extends UIScript;

var int m_PlayerNum;
var int m_PlayerID;
var string L2jBRVar13;
const L2jBRVar10 = 12;
const L2jBRVar101 = 12;

function SetPlayerNum (int PlayerNum)
{
	m_PlayerNum = PlayerNum;
	L2jBRVar13 = UnknownFunction112(UnknownFunction112("OlympiadBuff",string(PlayerNum)),"Wnd");
}

function OnLoad ()
{
	RegisterEvent(930);
	RegisterEvent(940);
	RegisterEvent(910);
}

function OnEnterState (name a_PreStateName)
{
	Clear();
	m_PlayerID = 0;
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,930) )
	{
		HandleBuffShow(L2jBRVar1);
	} else {
		if ( UnknownFunction154(Event_ID,940) )
		{
			HandleBuffInfo(L2jBRVar1);
		} else {
			if ( UnknownFunction154(Event_ID,910) )
			{
				Clear();
				m_PlayerID = 0;
			}
		}
	}
}

function Clear ()
{
	Class'UIAPI_STATUSICONCTRL'.Clear(UnknownFunction112(L2jBRVar13,".StatusIcon"));
	Class'UIAPI_WINDOW'.HideWindow(L2jBRVar13);
}

function HandleBuffShow (string L2jBRVar1)
{
	local int PlayerNum;

	ParseInt(L2jBRVar1,"PlayerNum",PlayerNum);
	if ( UnknownFunction132(UnknownFunction155(m_PlayerNum,PlayerNum),UnknownFunction150(PlayerNum,1)) )
	{
		return;
	}
	ParseInt(L2jBRVar1,"PlayerID",m_PlayerID);
}

function HandleBuffInfo (string L2jBRVar1)
{
	local int PlayerID;
	local int i;
	local int L2jBRVar29;
	local int L2jBRVar47;
	local StatusIconInfo Info;
	local Rect rectWnd;

	ParseInt(L2jBRVar1,"PlayerID",PlayerID);
	if ( UnknownFunction132(UnknownFunction155(m_PlayerID,PlayerID),UnknownFunction150(PlayerID,1)) )
	{
		return;
	}
	Clear();

	L2jBRVar47 = -1;
	ParseInt(L2jBRVar1,"Max",L2jBRVar29);
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar29) )
	{
		if ( UnknownFunction180(UnknownFunction173(i,12),0) )
		{
			Class'UIAPI_STATUSICONCTRL'.AddRow(UnknownFunction112(L2jBRVar13,".StatusIcon"));
			UnknownFunction165(L2jBRVar47);
		}
		ParseInt(L2jBRVar1,UnknownFunction112("SkillID_",string(i)),Info.ClassID);
		ParseInt(L2jBRVar1,UnknownFunction112("SkillLevel_",string(i)),Info.Level);
		ParseInt(L2jBRVar1,UnknownFunction112("RemainTime_",string(i)),Info.RemainTime);
		ParseString(L2jBRVar1,UnknownFunction112("Name_",string(i)),Info.Name);
		ParseString(L2jBRVar1,UnknownFunction112("IconName_",string(i)),Info.IconName);
		ParseString(L2jBRVar1,UnknownFunction112("Description_",string(i)),Info.Description);
		Info.Size = 24;
		Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
		Info.bShow = True;
		Class'UIAPI_STATUSICONCTRL'.AddCol(UnknownFunction112(L2jBRVar13,".StatusIcon"),
		L2jBRVar47,Info);
		UnknownFunction165(i);
		goto JL0065;
	}
	if ( UnknownFunction151(L2jBRVar29,0) )
	{
		Class'UIAPI_WINDOW'.ShowWindow(L2jBRVar13);
		rectWnd = Class'UIAPI_WINDOW'.GetRect(UnknownFunction112(L2jBRVar13,".StatusIcon"));
		Class'UIAPI_WINDOW'.SetWindowSize(L2jBRVar13,UnknownFunction146(rectWnd.nWidth,12),rectWnd.nHeight);
		Class'UIAPI_WINDOW'.SetFrameSize(L2jBRVar13,12,rectWnd.nHeight);
	}
}

