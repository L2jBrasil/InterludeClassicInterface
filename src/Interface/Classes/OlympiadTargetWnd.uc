//================================================================================
// OlympiadTargetWnd.
//================================================================================

class OlympiadTargetWnd extends UIScript;

var int m_PlayerNum;
var int m_id;
var string m_Name;
var int L2jBRVar153;
var int m_MaxHP;
var int m_CurHP;
var int m_MaxCP;
var int m_CurCP;

function OnLoad ()
{
	RegisterEvent(900);
	RegisterEvent(920);
	RegisterEvent(910);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,900) )
	{
		Clear();
		ParseInt(L2jBRVar1,"PlayerNum",m_PlayerNum);
		Class'UIAPI_WINDOW'.ShowWindow("OlympiadTargetWnd");
	} else {
		if ( UnknownFunction154(Event_ID,920) )
		{
			HandleUserInfo(L2jBRVar1);
			UpdateStatus();
		} else {
			if ( UnknownFunction154(Event_ID,910) )
			{
				Clear();
			}
		}
	}
}

function OnEnterState (name a_PreStateName)
{
	Clear();
}

function Clear ()
{
	m_PlayerNum = 0;
	m_id = 0;
	m_Name = "";
	L2jBRVar153 = 0;
	m_MaxHP = 0;
	m_CurHP = 0;
	m_MaxCP = 0;
	m_CurCP = 0;
	UpdateStatus();
}

function HandleUserInfo (string L2jBRVar1)
{
	local int IsPlayer;
	local int PlayerNum;

	ParseInt(L2jBRVar1,"IsPlayer",IsPlayer);
	if ( UnknownFunction155(IsPlayer,0) )
	{
		return;
	}
	ParseInt(L2jBRVar1,"PlayerNum",PlayerNum);
	if ( UnknownFunction132(UnknownFunction155(m_PlayerNum,PlayerNum),UnknownFunction150(PlayerNum,1)) )
	{
		return;
	}
	ParseInt(L2jBRVar1,"ID",m_id);
	ParseString(L2jBRVar1,"Name",m_Name);
	ParseInt(L2jBRVar1,"ClassID",L2jBRVar153);
	ParseInt(L2jBRVar1,"MaxHP",m_MaxHP);
	ParseInt(L2jBRVar1,"CurHP",m_CurHP);
	ParseInt(L2jBRVar1,"MaxCP",m_MaxCP);
	ParseInt(L2jBRVar1,"CurCP",m_CurCP);
}

function UpdateStatus ()
{
	Class'UIAPI_TEXTBOX'.SetText("OlympiadTargetWnd.txtName",m_Name);
	if ( UnknownFunction151(m_MaxCP,0) )
	{
		Class'UIAPI_WINDOW'.SetWindowSize("OlympiadTargetWnd.texCP",UnknownFunction145(UnknownFunction144(150,m_CurCP),m_MaxCP),6);
	} else {
		Class'UIAPI_WINDOW'.SetWindowSize("OlympiadTargetWnd.texCP",0,6);
	}
	if ( UnknownFunction151(m_MaxHP,0) )
	{
		Class'UIAPI_WINDOW'.SetWindowSize("OlympiadTargetWnd.texHP",UnknownFunction145(UnknownFunction144(150,m_CurHP),m_MaxHP),6);
	} else {
		Class'UIAPI_WINDOW'.SetWindowSize("OlympiadTargetWnd.texHP",0,6);
	}
}

