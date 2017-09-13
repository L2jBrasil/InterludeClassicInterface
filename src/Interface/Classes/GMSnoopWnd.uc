//================================================================================
// GMSnoopWnd.
//================================================================================

class GMSnoopWnd extends UICommonAPI;

var int m_SnoopIDList[4];
var WindowHandle m_hSnoopWndList[4];
var TextListBoxHandle m_hSnoopChatWndList[4];
var ButtonHandle m_hCancelButtonList[4];
var CheckBoxHandle m_hCheckBox[28];
const MAX_GMSnoop= 4;

function OnLoad ()
{
	local int i;
	local int j;

	i = 0;
	if ( UnknownFunction150(i,4) )
	{
		m_hSnoopWndList[i] = GetHandle(UnknownFunction112("SnoopWnd",string(UnknownFunction146(i,1))));
		m_hSnoopChatWndList[i] = TextListBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112("SnoopWnd",string(UnknownFunction146(i,1))),".Chat")));
		m_hCancelButtonList[i] = ButtonHandle(GetHandle(UnknownFunction112(UnknownFunction112("SnoopWnd",string(UnknownFunction146(i,1))),".CancelButton")));
		j = 0;
		if ( UnknownFunction150(j,7) )
		{
			m_hCheckBox[UnknownFunction146(UnknownFunction144(i,7),j)] = CheckBoxHandle(GetHandle(UnknownFunction112(UnknownFunction112(UnknownFunction112("SnoopWnd",string(UnknownFunction146(i,1))),".CheckBox"),string(j))));
			UnknownFunction163(j);
			goto JL00B6;
		}
		UnknownFunction163(i);
		goto JL0007;
	}
	RegisterEvent(2410);
	ClearAllSnoop();
}

function OnShow ()
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,4) )
	{
		m_hSnoopWndList[i].HideWindow();
		UnknownFunction163(i);
		goto JL0007;
	}
}

function OnHide ()
{
}

function OnClickButtonWithHandle (ButtonHandle a_ButtonHandle)
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,4) )
	{
		if ( UnknownFunction114(a_ButtonHandle,m_hCancelButtonList[i]) )
		{
			Class'GMAPI'.RequestSnoopEnd(m_SnoopIDList[i]);
			ClearSnoop(i);
		}
		UnknownFunction163(i);
		goto JL0007;
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2410:
		HandleGMSnoop(_L2jBRVar17_);
		break;
		default:
	}
}

function HandleGMSnoop (string _L2jBRVar17_)
{
	local int SnoopID;
	local string SnoopName;
	local int CreatureID;
	local int L2jBRVar5;
	local int SnoopIndex;
	local string CharacterName;
	local string chatMessage;
	local WindowHandle hSnoopWnd;
	local TextListBoxHandle hSnoopChatWnd;

	ParseInt(_L2jBRVar17_,"SnoopID",SnoopID);
	ParseString(_L2jBRVar17_,"CharacterName",CharacterName);
	if ( UnknownFunction129(GetSnoopWnd(SnoopID,hSnoopWnd,hSnoopChatWnd,SnoopIndex,CharacterName)) )
	{
		DialogShow(1,GetSystemMessage(802));
		return;
	}
	ParseString(_L2jBRVar17_,"SnoopName",SnoopName);
	ParseInt(_L2jBRVar17_,"CreatureID",CreatureID);
	ParseInt(_L2jBRVar17_,"Type",L2jBRVar5);
	ParseString(_L2jBRVar17_,"ChatMessage",chatMessage);
	if ( UnknownFunction129(m_hOwnerWnd.IsShowWindow()) )
	{
		m_hOwnerWnd.ShowWindow();
	}
	hSnoopWnd.ShowWindow();
	if ( UnknownFunction129(IsFiltered(L2jBRVar5,SnoopIndex)) )
	{
		hSnoopChatWnd.AddString(UnknownFunction112(UnknownFunction112(CharacterName,": "),chatMessage),GetColorByType(L2jBRVar5));
	}
}

function ClearAllSnoop ()
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,4) )
	{
		ClearSnoop(i);
		UnknownFunction163(i);
		goto JL0007;
	}
}

function ClearSnoop (int a_SnoopIndex)
{
	local int i;
	local bool AllHidden;

	if ( UnknownFunction151(0,a_SnoopIndex) )
	{
		return;
	}
	if ( UnknownFunction152(4,a_SnoopIndex) )
	{
		return;
	}
	m_SnoopIDList[a_SnoopIndex] = -1;
	m_hSnoopWndList[a_SnoopIndex].HideWindow();
	m_hSnoopChatWndList[a_SnoopIndex].HideWindow();
	AllHidden = True;
	i = 0;
	if ( UnknownFunction150(i,4) )
	{
		if ( UnknownFunction155(-1,m_SnoopIDList[a_SnoopIndex]) )
		{
			AllHidden = False;
		} else {
			UnknownFunction163(i);
			goto JL0065;
		}
	}
	if ( AllHidden )
	{
		m_hOwnerWnd.HideWindow();
	}
}

function bool GetSnoopWnd (int a_SnoopID, out WindowHandle a_hSnoopWnd, out TextListBoxHandle a_hSnoopChatWnd, out int a_SnoopIndex, string a_CharacterName)
{
	local int SnoopIndex;

	SnoopIndex = GetSnoopIndexByID(a_SnoopID);
	if ( UnknownFunction155(-1,SnoopIndex) )
	{
		a_hSnoopWnd = m_hSnoopWndList[SnoopIndex];
		a_hSnoopChatWnd = m_hSnoopChatWndList[SnoopIndex];
		a_SnoopIndex = SnoopIndex;
		return True;
	}
	SnoopIndex = GetSnoopIndexByID(-1);
	if ( UnknownFunction155(-1,SnoopIndex) )
	{
		m_SnoopIDList[SnoopIndex] = a_SnoopID;
		a_hSnoopWnd = m_hSnoopWndList[SnoopIndex];
		a_hSnoopChatWnd = m_hSnoopChatWndList[SnoopIndex];
		a_SnoopIndex = SnoopIndex;
		a_hSnoopWnd.SetWindowTitle(UnknownFunction112(UnknownFunction112(GetSystemString(693)," - "),a_CharacterName));
		return True;
	}
	return False;
}

function int GetSnoopIndexByID (int a_SnoopID)
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,4) )
	{
		if ( UnknownFunction154(a_SnoopID,m_SnoopIDList[i]) )
		{
			return i;
		}
		UnknownFunction163(i);
		goto JL0007;
	}
	return -1;
}

function Color GetColorByType (EChatType a_Type)
{
	local Color ResultColor;

	ResultColor.A = 255;
	switch (a_Type)
	{
		case 1:
		ResultColor.R = 255;
		ResultColor.G = 114;
		ResultColor.B = 0;
		break;
		case 3:
		ResultColor.R = 0;
		ResultColor.G = 255;
		ResultColor.B = 0;
		break;
		case 4:
		ResultColor.R = 125;
		ResultColor.G = 119;
		ResultColor.B = 255;
		break;
		case 2:
		ResultColor.R = 255;
		ResultColor.G = 0;
		ResultColor.B = 255;
		break;
		case 8:
		ResultColor.R = 234;
		ResultColor.G = 165;
		ResultColor.B = 245;
		break;
		case 9:
		ResultColor.R = 119;
		ResultColor.G = 255;
		ResultColor.B = 153;
		break;
		case 0:
		ResultColor.R = 220;
		ResultColor.G = 220;
		ResultColor.B = 220;
		break;
		default:
	}
	return ResultColor;
}

function bool IsFiltered (EChatType a_Type, int a_SnoopIndex)
{
	switch (a_Type)
	{
		case 8:
		if ( m_hCheckBox[UnknownFunction144(a_SnoopIndex,7)].IsChecked() )
		{
			return False;
		}
		break;
		case 4:
		if ( m_hCheckBox[UnknownFunction146(UnknownFunction144(a_SnoopIndex,7),1)].IsChecked() )
		{
			return False;
		}
		break;
		case 3:
		if ( m_hCheckBox[UnknownFunction146(UnknownFunction144(a_SnoopIndex,7),2)].IsChecked() )
		{
			return False;
		}
		break;
		case 1:
		if ( m_hCheckBox[UnknownFunction146(UnknownFunction144(a_SnoopIndex,7),3)].IsChecked() )
		{
			return False;
		}
		break;
		case 2:
		if ( m_hCheckBox[UnknownFunction146(UnknownFunction144(a_SnoopIndex,7),4)].IsChecked() )
		{
			return False;
		}
		break;
		case 0:
		if ( m_hCheckBox[UnknownFunction146(UnknownFunction144(a_SnoopIndex,7),5)].IsChecked() )
		{
			return False;
		}
		break;
		case 9:
		if ( m_hCheckBox[UnknownFunction146(UnknownFunction144(a_SnoopIndex,7),6)].IsChecked() )
		{
			return False;
		}
		break;
		default:
	}
	return True;
}

