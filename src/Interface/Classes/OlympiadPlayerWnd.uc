//================================================================================
// OlympiadPlayerWnd.
//================================================================================

class OlympiadPlayerWnd extends UIScript;

var int m_PlayerNum;
var string L2jBRVar13;
var string m_BuffWindowName;
var bool m_Expand;
var int m_id;
var string m_Name;
var int m_something; //It was blank, may need fix
var int m_MaxHP;
var int m_CurHP;
var int m_MaxCP;
var int m_CurCP;
var string m_Msg[5];
var int m_MsgStartLine;
const MAX_OLYMPIAD_SKILL_MSG= 5;

function SetPlayerNum (int PlayerNum)
{
	m_PlayerNum = PlayerNum;
	L2jBRVar13 = UnknownFunction112(UnknownFunction112("OlympiadPlayer",string(PlayerNum)),"Wnd");
	m_BuffWindowName = UnknownFunction112(UnknownFunction112("OlympiadBuff",string(PlayerNum)),"Wnd");
}

function OnLoad ()
{
	RegisterEvent(920);
	RegisterEvent(910);
	RegisterEvent(290);
	RegisterEvent(280);
	SetExpandMode(False);
}

function OnEnterState (name a_PreStateName)
{
	Clear();
	SetExpandMode(m_Expand);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,920) )
	{
		HandleUserInfo(L2jBRVar1);
		UpdateStatus();
	} else {
		if ( UnknownFunction154(Event_ID,290) )
		{
			HandleMagicSkillUse(L2jBRVar1);
		} else {
			if ( UnknownFunction154(Event_ID,280) )
			{
				HandleAttack(L2jBRVar1);
			} else {
				if ( UnknownFunction154(Event_ID,910) )
				{
					Clear();
				}
			}
		}
	}
}

function Clear ()
{
	local int i;

	m_id = 0;
	m_Name = "";
	L2jBRVar153 = 0;
	m_MaxHP = 0;
	m_CurHP = 0;
	m_MaxCP = 0;
	m_CurCP = 0;
JL0039:
	i = 0;
	if ( UnknownFunction150(i,5) )
	{
		m_Msg[i] = "";
		UnknownFunction165(i);
		goto JL0039;
	}
	UpdateStatus();
	UpdateMsg("");
}

function HandleUserInfo (string L2jBRVar1)
{
	local int IsPlayer;
	local int PlayerNum;
	local int PlayerID;
	local string strParam;

	ParseInt(L2jBRVar1,"IsPlayer",IsPlayer);
	if ( UnknownFunction155(IsPlayer,1) )
	{
		return;
	}
	ParseInt(L2jBRVar1,"PlayerNum",PlayerNum);
	if ( UnknownFunction132(UnknownFunction155(m_PlayerNum,PlayerNum),UnknownFunction150(PlayerNum,1)) )
	{
		return;
	}
	ParseInt(L2jBRVar1,"ID",PlayerID);
	ParseString(L2jBRVar1,"Name",m_Name);
	ParseInt(L2jBRVar1,"ClassID",L2jBRVar153);
	ParseInt(L2jBRVar1,"MaxHP",m_MaxHP);
	ParseInt(L2jBRVar1,"CurHP",m_CurHP);
	ParseInt(L2jBRVar1,"MaxCP",m_MaxCP);
	ParseInt(L2jBRVar1,"CurCP",m_CurCP);
	if ( UnknownFunction155(m_id,PlayerID) )
	{
		m_id = PlayerID;
		ParamAdd(strParam,"PlayerNum",string(m_PlayerNum));
		ParamAdd(strParam,"PlayerID",string(PlayerID));
		ExecuteEvent(930,strParam);
	}
}

function HandleMagicSkillUse (string L2jBRVar1)
{
	local int Id;
	local int SkillID;
	local string paramsend;
	local string strMsg;

	ParseInt(L2jBRVar1,"AttackerID",Id);
	if ( UnknownFunction132(UnknownFunction150(Id,1),UnknownFunction155(Id,m_id)) )
	{
		return;
	}
	ParseInt(L2jBRVar1,"SkillID",SkillID);
	if ( UnknownFunction132(UnknownFunction151(0,SkillID),UnknownFunction150(1999,SkillID)) )
	{
		return;
	}
	ParamAdd(paramsend,"Type",string(4));
	ParamAdd(paramsend,"param1",string(SkillID));
	ParamAdd(paramsend,"param2","1");
	AddSystemMessageParam(paramsend);
	strMsg = EndSystemMessageParam(46,True);
	UpdateMsg(strMsg);
}

function HandleAttack (string L2jBRVar1)
{
	local int AttackerID;
	local string AttackerName;
	local int DefenderID;
	local int Critical;
	local int Miss;
	local int ShieldDefense;
	local string paramsend;
	local string strMsg;

	ParseInt(L2jBRVar1,"AttackerID",AttackerID);
	ParseString(L2jBRVar1,"AttackerName",AttackerName);
	ParseInt(L2jBRVar1,"DefenderID",DefenderID);
	ParseInt(L2jBRVar1,"Critical",Critical);
	ParseInt(L2jBRVar1,"Miss",Miss);
	ParseInt(L2jBRVar1,"ShieldDefense",ShieldDefense);
	if ( UnknownFunction130(UnknownFunction151(AttackerID,0),UnknownFunction154(AttackerID,m_id)) )
	{
		if ( UnknownFunction151(Critical,0) )
		{
			UpdateMsg(GetSystemMessage(44));
		}
	} else {
		if ( UnknownFunction130(UnknownFunction151(DefenderID,0),UnknownFunction154(DefenderID,m_id)) )
		{
			if ( UnknownFunction151(Miss,0) )
			{
				ParamAdd(paramsend,"Type",string(0));
				ParamAdd(paramsend,"param1",AttackerName);
				AddSystemMessageParam(paramsend);
				strMsg = EndSystemMessageParam(42,True);
				UpdateMsg(strMsg);
			} else {
				if ( UnknownFunction151(ShieldDefense,0) )
				{
					UpdateMsg(GetSystemMessage(111));
				}
			}
		}
	}
}

function UpdateMsg (string strMsg)
{
	local int i;
	local int CurPos;

	m_Msg[m_MsgStartLine] = strMsg;
	m_MsgStartLine = int(UnknownFunction173(UnknownFunction146(m_MsgStartLine,1),5));
	i = 0;
	if ( UnknownFunction150(i,5) )
	{
		CurPos = int(UnknownFunction173(UnknownFunction146(m_MsgStartLine,i),5));
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(UnknownFunction112(L2jBRVar13,".txtMsg"),string(UnknownFunction147(UnknownFunction147(5,1),i))),m_Msg[CurPos]);
		UnknownFunction165(i);
		goto JL0030;
	}
}

function UpdateStatus ()
{
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtName"),m_Name);
	if ( UnknownFunction151(m_MaxCP,0) )
	{
		Class'UIAPI_WINDOW'.SetWindowSize(UnknownFunction112(L2jBRVar13,".texCP"),UnknownFunction145(UnknownFunction144(326,m_CurCP),m_MaxCP),6);
	} else {
		Class'UIAPI_WINDOW'.SetWindowSize(UnknownFunction112(L2jBRVar13,".texCP"),0,6);
	}
	if ( UnknownFunction151(m_MaxHP,0) )
	{
		Class'UIAPI_WINDOW'.SetWindowSize(UnknownFunction112(L2jBRVar13,".texHP"),UnknownFunction145(UnknownFunction144(326,m_CurHP),m_MaxHP),6);
	} else {
		Class'UIAPI_WINDOW'.SetWindowSize(UnknownFunction112(L2jBRVar13,".texHP"),0,6);
	}
}

function OnFrameExpandClick (bool bIsExpand)
{
	SetExpandMode(bIsExpand);
	m_Expand = bIsExpand;
}

function SetExpandMode (bool bExpand)
{
	local Rect rectWnd;
	local Rect rectBuffWnd;

	if ( bExpand )
	{
		Class'UIAPI_WINDOW'.HideWindow(UnknownFunction112(L2jBRVar13,".BackTex"));
		Class'UIAPI_WINDOW'.ShowWindow(UnknownFunction112(L2jBRVar13,".BackExpTex"));
	} else {
		Class'UIAPI_WINDOW'.ShowWindow(UnknownFunction112(L2jBRVar13,".BackTex"));
		Class'UIAPI_WINDOW'.HideWindow(UnknownFunction112(L2jBRVar13,".BackExpTex"));
	}
	rectWnd = Class'UIAPI_WINDOW'.GetRect(L2jBRVar13);
	rectBuffWnd = Class'UIAPI_WINDOW'.GetRect(m_BuffWindowName);
	if ( bExpand )
	{
		if ( UnknownFunction132(UnknownFunction154(UnknownFunction146(rectWnd.nY,46),rectBuffWnd.nY),UnknownFunction154(UnknownFunction146(rectWnd.nY,47),rectBuffWnd.nY)) )
		{
			Class'UIAPI_WINDOW'.MoveEx(m_BuffWindowName,0,80);
		}
	} else {
		if ( UnknownFunction132(UnknownFunction154(UnknownFunction146(rectWnd.nY,126),rectBuffWnd.nY),UnknownFunction154(UnknownFunction146(rectWnd.nY,127),rectBuffWnd.nY)) )
		{
			Class'UIAPI_WINDOW'.MoveEx(m_BuffWindowName,0,-80);
		}
	}
}

