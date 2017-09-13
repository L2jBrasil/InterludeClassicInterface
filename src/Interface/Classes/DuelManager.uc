//================================================================================
// DuelManager.
//================================================================================

class DuelManager extends UICommonAPI;

var int m_memberInfo[9];
var WindowHandle m_TopWnd;
var WindowHandle m_StatusWnd[9];
var NameCtrlHandle m_PlayerName[9];
var TextureHandle L2jBRVar92[9];
var BarHandle m_BarCP[9];
var BarHandle m_BarHP[9];
var BarHandle m_BarMP[9];
var bool m_bDuelState;
const NDUELSTATUS_HEIGHT= 46;
const MAX_PARTY_NUM= 9;
const DIALOG_ASK_START= 1111;

function OnLoad ()
{
	local int L2jBRVar2;

	RegisterEvent(2700);
	RegisterEvent(2710);
	RegisterEvent(2720);
	RegisterEvent(2730);
	RegisterEvent(2740);
	RegisterEvent(2750);
	RegisterEvent(1710);
	RegisterEvent(1720);
	m_TopWnd = GetHandle("DuelManager");
	L2jBRVar2 = 0;
	if ( UnknownFunction150(L2jBRVar2,9) )
	{
		JL0078:
			m_StatusWnd[L2jBRVar2] = GetHandle(UnknownFunction112("DuelManager.PartyStatusWnd",string(L2jBRVar2)));
			m_PlayerName[L2jBRVar2] = NameCtrlHandle(GetHandle(UnknownFunction112(UnknownFunction112("DuelManager.PartyStatusWnd",string(L2jBRVar2)),".PlayerName")));
			L2jBRVar92[L2jBRVar2] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("DuelManager.PartyStatusWnd",string(L2jBRVar2)),".ClassIcon")));
			m_BarCP[L2jBRVar2] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("DuelManager.PartyStatusWnd",string(L2jBRVar2)),".barCP")));
			m_BarHP[L2jBRVar2] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("DuelManager.PartyStatusWnd",string(L2jBRVar2)),".barHP")));
			m_BarMP[L2jBRVar2] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("DuelManager.PartyStatusWnd",string(L2jBRVar2)),".barMP")));
			UnknownFunction165(L2jBRVar2);
		goto JL0078;
	}
	Clear();
	m_bDuelState = False;
}

function OnEvent (int EventID, string L2jBRVar1)
{
	local Color White;

	White.R = 255;
	White.G = 255;
	White.B = 255;
	switch (EventID)
	{
		case 2700:
		HandleDuelAskStart(L2jBRVar1);
		break;
		case 2710:
		m_bDuelState = True;
		break;
		case 2720:
		break;
		case 2730:
		m_bDuelState = False;
		Clear();
		m_TopWnd.HideWindow();
		break;
		case 2740:
		HandleUpdateUserInfo(L2jBRVar1);
		break;
		case 2750:
		break;
		case 1710:
		HandleDialogOK();
		break;
		case 1720:
		HandleDialogCancel();
		break;
		default:
		break;
	}
}

function HandleDuelAskStart (string L2jBRVar1)
{
	local string sName;
	local int L2jBRVar5;
	local int messageNum;
	local bool bOption;

	bOption = GetOptionBool("Game","IsRejectingDuel");
	ParseString(L2jBRVar1,"userName",sName);
	ParseInt(L2jBRVar1,"type",L2jBRVar5);
	if ( UnknownFunction242(bOption,True) )
	{
		//What should happens here?
	}
}

function HandleDialogOK ()
{
	local int dialogID;
	local bool bOption;

	if ( DialogIsMine() )
	{
		dialogID = DialogGetID();
		if ( UnknownFunction154(dialogID,1111) )
		{
			bOption = GetOptionBool("Game","IsRejectingDuel");
		}
	}
}

function HandleDialogCancel ()
{
	local int dialogID;
	local bool bOption;

	if ( DialogIsMine() )
	{
		dialogID = DialogGetID();
		if ( UnknownFunction154(dialogID,1111) )
		{
			bOption = GetOptionBool("Game","IsRejectingDuel");
		}
	}
}

function HandleUpdateUserInfo (string L2jBRVar1)
{
	local string sName;
	local int Id;
	local int ClassID;
	local int Level;
	local int currentHP;
	local int maxHP;
	local int currentMP;
	local int maxMP;
	local int currentCP;
	local int maxCP;
	local int i;
	local bool bFound;

	if ( UnknownFunction129(m_bDuelState) )
	{
		return;
	}
	ParseString(L2jBRVar1,"userName",sName);
	ParseInt(L2jBRVar1,"ID",Id);
	ParseInt(L2jBRVar1,"class",ClassID);
	ParseInt(L2jBRVar1,"level",Level);
	ParseInt(L2jBRVar1,"currentHP",currentHP);
	ParseInt(L2jBRVar1,"maxHP",maxHP);
	ParseInt(L2jBRVar1,"currentMP",currentMP);
	ParseInt(L2jBRVar1,"maxMP",maxMP);
	ParseInt(L2jBRVar1,"currentCP",currentCP);
	ParseInt(L2jBRVar1,"maxCP",maxCP);
	bFound = False;
	i = 0;
	if ( UnknownFunction150(i,9) )
	{
		if ( UnknownFunction155(m_memberInfo[i],0) )
		{
			if ( UnknownFunction154(Id,m_memberInfo[i]) )
			{
				bFound = True;
			} else {
				goto JL0151;
				goto JL015B;
				UnknownFunction163(i);
				goto JL010E;
			}
		}
	}
	if ( UnknownFunction129(bFound) )
	{
		m_memberInfo[i] = Id;
		m_StatusWnd[i].ShowWindow();
		Resize(UnknownFunction146(i,1));
	}
	m_TopWnd.ShowWindow();
	m_PlayerName[i].SetName(sName,0,2);
	L2jBRVar92[i].SetTexture(GetClassIconName(ClassID));
	L2jBRVar92[i].SetTooltipCustomType(MakeTooltipSimpleText(UnknownFunction112(UnknownFunction112(GetClassStr(ClassID)," - "),GetClassType(ClassID))));
	m_BarCP[i].SetValue(maxCP,currentCP);
	m_BarHP[i].SetValue(maxHP,currentHP);
	m_BarMP[i].SetValue(maxMP,currentMP);
}

function Clear ()
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,9) )
	{
		m_StatusWnd[i].HideWindow();
		m_memberInfo[i] = 0;
		UnknownFunction163(i);
		goto JL0007;
	}
}

function Resize (int L2jBRVar15_)
{
	local Rect entireRect;
	local Rect statusWndRect;

	entireRect = m_TopWnd.GetRect();
	statusWndRect = m_StatusWnd[0].GetRect();
	m_TopWnd.SetWindowSize(entireRect.nWidth,UnknownFunction144(statusWndRect.nHeight,L2jBRVar15_));
	m_TopWnd.SetResizeFrameSize(10,UnknownFunction144(statusWndRect.nHeight,L2jBRVar15_));
}

function OnLButtonDown (WindowHandle L2jBRVar20, int X, int Y)
{
	local Rect rectWnd;
	local int L2jBRVar2;

	rectWnd = m_TopWnd.GetRect();
	if ( UnknownFunction151(X,UnknownFunction146(rectWnd.nX,13)))
	{
		L2jBRVar2 = UnknownFunction145(UnknownFunction147(Y,rectWnd.nY),46);
		RequestTargetUser(m_memberInfo[L2jBRVar2]);
	}
}

