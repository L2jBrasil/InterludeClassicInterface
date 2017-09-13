//================================================================================
// PartyWndCompact.
//================================================================================

class PartyWndCompact extends UICommonAPI;

var bool m_bCompact;
var bool m_bBuff;
var bool m_partyleader;
var int L2jBRVar41[8];
var int m_CurCount;
var int m_CurBf;
var int m_MasterID;
var WindowHandle L2jBRVar103;
var WindowHandle m_PartyOption;
var WindowHandle m_PartyStatus[8];
var TextureHandle L2jBRVar92[8];
var StatusIconHandle L2jBRVar42[8];
var StatusIconHandle 
L2jBRVar43[8];
var BarHandle m_BarCP[8];
var BarHandle m_BarHP[8];
var BarHandle m_BarMP[8];
var ButtonHandle BtnBuff;
const NPARTYSTATUS_MAXCOUNT= 8;
const NPARTYSTATUS_HEIGHT= 26;
const L2jBRVar10 = 12;

function OnLoad ()
{
	local int L2jBRVar2;

	RegisterEvent(1000);
	RegisterEvent(1140);
	RegisterEvent(1150);
	RegisterEvent(1160);
	RegisterEvent(1170);
	RegisterEvent(1180);
	RegisterEvent(40);
	m_bCompact = False;
	m_bBuff = False;
	m_CurBf = 0;
	m_MasterID = 0;
	L2jBRVar103 = GetHandle("PartyWndCompact");
	m_PartyOption = GetHandle("PartyWndOption");
	L2jBRVar2 = 0;
	if ( UnknownFunction150(L2jBRVar2,8) )
	{
		m_PartyStatus[L2jBRVar2] = GetHandle(UnknownFunction112("PartyWndCompact.PartyStatusWnd",string(L2jBRVar2)));
		L2jBRVar92[L2jBRVar2] = TextureHandle(GetHandle(UnknownFunction112(UnknownFunction112("PartyWndCompact.PartyStatusWnd",string(L2jBRVar2)),".ClassIcon")));
		L2jBRVar42[L2jBRVar2] = StatusIconHandle(GetHandle(UnknownFunction112(UnknownFunction112("PartyWndCompact.PartyStatusWnd",string(L2jBRVar2)),".StatusIconBuff")));
		
		
		L2jBRVar43[L2jBRVar2] = StatusIconHandle(GetHandle(UnknownFunction112(UnknownFunction112("PartyWndCompact.PartyStatusWnd",string(L2jBRVar2)),".StatusIconDebuff")));
		m_BarCP[L2jBRVar2] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("PartyWndCompact.PartyStatusWnd",string(L2jBRVar2)),".barCP")));
		m_BarHP[L2jBRVar2] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("PartyWndCompact.PartyStatusWnd",string(L2jBRVar2)),".barHP")));
		m_BarMP[L2jBRVar2] = BarHandle(GetHandle(UnknownFunction112(UnknownFunction112("PartyWndCompact.PartyStatusWnd",string(L2jBRVar2)),".barMP")));
		UnknownFunction165(L2jBRVar2);
		goto JL00A8;
	}
	BtnBuff = ButtonHandle(GetHandle("PartyWndCompact.btnBuff"));
	L2jBRVar2 = 0;
	if ( UnknownFunction150(L2jBRVar2,8) )
	{
		L2jBRVar42[L2jBRVar2].SetAnchor(UnknownFunction112("PartyWndCompact.PartyStatusWnd",string(L2jBRVar2)),"TopRight","TopLeft",1,3);
		
		
		L2jBRVar43[L2jBRVar2].SetAnchor(UnknownFunction112("PartyWndCompact.PartyStatusWnd",string(L2jBRVar2)),"TopRight","TopLeft",1,3);
		UnknownFunction165(L2jBRVar2);
		goto JL02FE;
	}
	L2jBRVar92[0].Move(0,7);
	m_PartyOption.HideWindow();
}

function OnShow ()
{
	SetBuffButtonTooltip();
}

function OnEnterState (name a_PreStateName)
{
	m_bCompact = False;
	m_bBuff = False;
	m_CurBf = 0;
	ResizeWnd();
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,1140) )
	{
		HandlePartyAddParty(L2jBRVar1);
	} else {
		if ( UnknownFunction154(Event_ID,1150) )
		{
		L2jBRFunction53(L2jBRVar1);
		} else {
			if ( UnknownFunction154(Event_ID,1160) )
			{
				HandlePartyDeleteParty(L2jBRVar1);
			} else {
				if ( UnknownFunction154(Event_ID,1170) )
				{
					HandlePartyDeleteAllParty();
				} else {
					if ( UnknownFunction154(Event_ID,1180) )
					{
						L2jBRFunction54(L2jBRVar1);
					} else {
						if ( UnknownFunction154(Event_ID,1000) )
						{
							HandleShowBuffIcon(L2jBRVar1);
						} else {
							if ( UnknownFunction154(Event_ID,40) )
							{
								L2jBRFunction4();
							}
						}
					}
				}
			}
		}
	}
}

function L2jBRFunction4 ()
{
	Clear();
}

function Clear ()
{
	local int L2jBRVar2;

	L2jBRVar2 = 0;
	if ( UnknownFunction150(L2jBRVar2,8) )
	{
		L2jBRFunction30(L2jBRVar2);
		UnknownFunction165(L2jBRVar2);
		goto JL0007;
	}
	m_CurCount = 0;
	ResizeWnd();
}

function L2jBRFunction30 (int L2jBRVar2)
{
	L2jBRVar42[L2jBRVar2].Clear();


	L2jBRVar43[L2jBRVar2].Clear();
	L2jBRVar92[L2jBRVar2].SetTexture("");
	UpdateCPBar(L2jBRVar2,0,0);
	UpdateHPBar(L2jBRVar2,0,0);
	UpdateMPBar(L2jBRVar2,0,0);
	L2jBRVar41[L2jBRVar2] = 0;
}

function CopyStatus (int DesIndex, int SrcIndex)
{
	local int MaxValue;
	local int CurValue;
	local int row;
	local int Col;
	local int MaxRow;
	local int MaxCol;
	local StatusIconInfo Info;
	local CustomTooltip TooltipInfo;
	local CustomTooltip TooltipInfo2;

	L2jBRVar41[DesIndex] = L2jBRVar41[SrcIndex];
	m_PartyStatus[SrcIndex].GetTooltipCustomType(TooltipInfo);
	m_PartyStatus[DesIndex].SetTooltipCustomType(TooltipInfo);
	L2jBRVar92[DesIndex].SetTexture(L2jBRVar92[SrcIndex].GetTextureName());
	L2jBRVar92[SrcIndex].GetTooltipCustomType(TooltipInfo2);
	L2jBRVar92[DesIndex].SetTooltipCustomType(TooltipInfo2);
	m_BarCP[SrcIndex].GetValue(MaxValue,CurValue);
	m_BarCP[DesIndex].SetValue(MaxValue,CurValue);
	m_BarHP[SrcIndex].GetValue(MaxValue,CurValue);
	m_BarHP[DesIndex].SetValue(MaxValue,CurValue);
	m_BarMP[SrcIndex].GetValue(MaxValue,CurValue);
	m_BarMP[DesIndex].SetValue(MaxValue,CurValue);
	L2jBRVar42[DesIndex].Clear();
	MaxRow = L2jBRVar42[SrcIndex].GetRowCount();
	row = 0;
	if ( UnknownFunction150(row,MaxRow) )
	{
		L2jBRVar42[DesIndex].AddRow();
		MaxCol = L2jBRVar42[SrcIndex].GetColCount(row);
		Col = 0;
		if ( UnknownFunction150(Col,MaxCol) )
		{
			L2jBRVar42[SrcIndex].GetItem(row,Col,Info);
			L2jBRVar42[DesIndex].AddCol(row,Info);
JL019A:
			UnknownFunction165(Col);
			goto JL01E5;
		}
		UnknownFunction165(row);
		goto JL019A;
	}


	L2jBRVar43[DesIndex].Clear();
	MaxRow = L2jBRVar43[SrcIndex].GetRowCount();
	row = 0;
	if ( UnknownFunction150(row,MaxRow) )
	{
		
		
		L2jBRVar43[DesIndex].AddRow();
		MaxCol = 
		
		L2jBRVar43[SrcIndex].GetColCount(row);
		Col = 0;
		if ( UnknownFunction150(Col,MaxCol) )
		{
			
			
			L2jBRVar43[SrcIndex].GetItem(row,Col,Info);
			
			
			L2jBRVar43[DesIndex].AddCol(row,Info);
			UnknownFunction165(Col);
			goto JL02CD;
		}
		UnknownFunction165(row);
		goto JL0282;
	}
}

function ResizeWnd ()
{
	local int L2jBRVar2;
	local Rect rectWnd;
	local bool bOption;

	bOption = GetOptionBool("Game","SmallPartyWnd");
	if ( UnknownFunction151(m_CurCount,0) )
	{
		rectWnd = L2jBRVar103.GetRect();
		L2jBRVar103.SetWindowSize(rectWnd.nWidth,UnknownFunction144(26,m_CurCount));
		L2jBRVar103.SetResizeFrameSize(10,UnknownFunction144(26,m_CurCount));
		if ( bOption )
		{
			L2jBRVar103.ShowWindow();
		} else {
			L2jBRVar103.HideWindow();
		}
		L2jBRVar2 = 0;
		if ( UnknownFunction150(L2jBRVar2,8) )
		{
			if ( UnknownFunction152(L2jBRVar2,UnknownFunction147(m_CurCount,1)) )
			{
				m_PartyStatus[L2jBRVar2].ShowWindow();
			} else {
				m_PartyStatus[L2jBRVar2].HideWindow();
			}
			UnknownFunction165(L2jBRVar2);
			goto JL00AF;
		}
	} else {
		L2jBRVar103.HideWindow();
	}
}

function int FindPartyID (int Id)
{
	local int L2jBRVar2;

	L2jBRVar2 = 0;
	if ( UnknownFunction150(L2jBRVar2,8) )
	{
		if ( UnknownFunction154(L2jBRVar41[L2jBRVar2],Id) )
		{
			return L2jBRVar2;
		}
		UnknownFunction165(L2jBRVar2);
		goto JL0007;
	}
	return -1;
}

function HandlePartyAddParty (string L2jBRVar1)
{
	local int Id;

	ParseInt(L2jBRVar1,"ID",Id);
	if ( UnknownFunction151(Id,0) )
	{
		UnknownFunction165(m_CurCount);
		ResizeWnd();
		L2jBRVar41[UnknownFunction147(m_CurCount,1)] = Id;
		UpdateStatus(UnknownFunction147(m_CurCount,1),L2jBRVar1);
	}
}

function L2jBRFunction53 (string L2jBRVar1)
{
	local int Id;
	local int L2jBRVar2;

	ParseInt(L2jBRVar1,"ID",Id);
	if ( UnknownFunction151(Id,0) )
	{
		L2jBRVar2 = FindPartyID(Id);
		UpdateStatus(L2jBRVar2,L2jBRVar1);
	}
}

function HandlePartyDeleteParty (string L2jBRVar1)
{
	local int Id;
	local int L2jBRVar2;
	local int i;

	ParseInt(L2jBRVar1,"ID",Id);
	if ( UnknownFunction151(Id,0) )
	{
		L2jBRVar2 = FindPartyID(Id);
		if ( UnknownFunction151(L2jBRVar2,-1) )
		{
			i = L2jBRVar2;
			if ( UnknownFunction150(i,UnknownFunction147(m_CurCount,1)) )
			{
				CopyStatus(i,UnknownFunction146(i,1));
				UnknownFunction165(i);
				goto JL004A;
			}
			L2jBRFunction30(m_CurCount);
			UnknownFunction166(m_CurCount);
			ResizeWnd();
		}
	}
}

function HandlePartyDeleteAllParty ()
{
	Clear();
}

function UpdateStatus (int L2jBRVar2, string L2jBRVar1)
{
	local string Name;
	local int Id;
	local int CP;
	local int maxCP;
	local int HP;
	local int maxHP;
	local int MP;
	local int maxMP;
	local int ClassID;
	local int MasterID;
	local CustomTooltip TooltipInfo;
	local CustomTooltip TooltipInfo2;

	if ( UnknownFunction132(UnknownFunction150(L2jBRVar2,0),UnknownFunction153(L2jBRVar2,8)) )
	{
		return;
	}
	ParseString(L2jBRVar1,"Name",Name);
	ParseInt(L2jBRVar1,"ID",Id);
	ParseInt(L2jBRVar1,"CurCP",CP);
	ParseInt(L2jBRVar1,"MaxCP",maxCP);
	ParseInt(L2jBRVar1,"CurHP",HP);
	ParseInt(L2jBRVar1,"MaxHP",maxHP);
	ParseInt(L2jBRVar1,"CurMP",MP);
	ParseInt(L2jBRVar1,"MaxMP",maxMP);
	ParseInt(L2jBRVar1,"ClassID",ClassID);
	if ( ParseInt(L2jBRVar1,"MasterID",MasterID) )
	{
		m_MasterID = MasterID;
	}
	TooltipInfo.DrawList.Length = 1;
	TooltipInfo.DrawList[0].eType = 1;
	TooltipInfo.DrawList[0].t_bDrawOneLine = True;
	if ( UnknownFunction130(UnknownFunction151(m_MasterID,0),UnknownFunction154(m_MasterID,Id)) )
	{
		TooltipInfo.DrawList[0].t_strText = UnknownFunction112(UnknownFunction112(UnknownFunction112(Name,"("),GetSystemString(408)),")");
	} else {
		TooltipInfo.DrawList[0].t_strText = Name;
	}
	m_PartyStatus[L2jBRVar2].SetTooltipCustomType(TooltipInfo);
	L2jBRVar92[L2jBRVar2].SetTexture(GetClassIconName(ClassID));
	TooltipInfo2.DrawList.Length = 2;
	TooltipInfo2.DrawList[0].eType = 1;
	TooltipInfo2.DrawList[0].t_bDrawOneLine = True;
	if ( UnknownFunction130(UnknownFunction151(m_MasterID,0),UnknownFunction154(m_MasterID,Id)) )
	{
		TooltipInfo2.DrawList[0].t_strText = UnknownFunction112(UnknownFunction112(UnknownFunction112(Name,"("),GetSystemString(408)),")");
	} else {
		TooltipInfo2.DrawList[0].t_strText = Name;
	}
	TooltipInfo2.DrawList[1].eType = 1;
	TooltipInfo2.DrawList[1].nOffSetY = 2;
	TooltipInfo2.DrawList[1].t_bDrawOneLine = True;
	TooltipInfo2.DrawList[1].bLineBreak = True;
	TooltipInfo2.DrawList[1].t_strText = UnknownFunction112(UnknownFunction112(GetClassStr(ClassID)," - "),GetClassType(ClassID));
	TooltipInfo2.DrawList[1].t_color.R = 128;
	TooltipInfo2.DrawList[1].t_color.G = 128;
	TooltipInfo2.DrawList[1].t_color.B = 128;
	TooltipInfo2.DrawList[1].t_color.A = 255;
	L2jBRVar92[L2jBRVar2].SetTooltipCustomType(TooltipInfo2);
	UpdateCPBar(L2jBRVar2,CP,maxCP);
	UpdateHPBar(L2jBRVar2,HP,maxHP);
	UpdateMPBar(L2jBRVar2,MP,maxMP);
}

function L2jBRFunction54 (string L2jBRVar1)
{
	local int i;
	local int L2jBRVar2;
	local int Id;
	local int L2jBRVar29;
	local int L2jBRVar93;
	local int L2jBRVar44;
	local int L2jBRVar45;
	local int L2jBRVar46;
	local StatusIconInfo Info;
	
	L2jBRVar46 = -1;
	L2jBRVar44 = -1;
	ParseInt(L2jBRVar1,"ID",Id);
	if ( UnknownFunction150(Id,1) )
	{
		return;
	}
	L2jBRVar2 = FindPartyID(Id);
	if ( UnknownFunction150(L2jBRVar2,0) )
	{
		return;
	}
	L2jBRVar42[L2jBRVar2].Clear();


	L2jBRVar43[L2jBRVar2].Clear();
	Info.Size = 10;
	Info.bShow = True;
	ParseInt(L2jBRVar1,"Max",L2jBRVar29);
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar29) )
	{
		ParseInt(L2jBRVar1,UnknownFunction112("SkillID_",string(i)),Info.ClassID);
		ParseInt(L2jBRVar1,UnknownFunction112("Level_",string(i)),Info.Level);
		if ( UnknownFunction151(Info.ClassID,0) )
		{
			Info.IconName = Class'UIDATA_SKILL'.GetIconName(Info.ClassID,Info.Level);
			if ( UnknownFunction242(IsDebuff(Info.ClassID,Info.Level),True) )
			{
				if ( UnknownFunction180(UnknownFunction173(L2jBRVar45,12),0) )
				{
					UnknownFunction165(
					
					L2jBRVar46);
					
					
					L2jBRVar43[L2jBRVar2].AddRow();
				}
				
				
				L2jBRVar43[L2jBRVar2].AddCol(
				
				L2jBRVar46,Info);
				UnknownFunction165(L2jBRVar45);
			} else {
				if ( UnknownFunction180(UnknownFunction173(L2jBRVar93,12),0) )
				{
					UnknownFunction165(L2jBRVar44);
					L2jBRVar42[L2jBRVar2].AddRow();
				}
				L2jBRVar42[L2jBRVar2].AddCol(L2jBRVar44,Info);
				UnknownFunction165(L2jBRVar93);
			}
		}
		UnknownFunction165(i);
		goto JL00B5;
	}
	UpdateBuff();
}

function HandleShowBuffIcon (string L2jBRVar1)
{
	local int nShow;

	ParseInt(L2jBRVar1,"Show",nShow);
	m_CurBf = UnknownFunction146(m_CurBf,1);
	if ( UnknownFunction151(m_CurBf,2) )
	{
		m_CurBf = 0;
	}
	SetBuffButtonTooltip();
	switch (m_CurBf)
	{
		case 1:
		UpdateBuff();
		break;
		case 2:
		UpdateBuff();
		break;
		case 0:
		m_CurBf = 0;
		UpdateBuff();
		default:
	}
}

function OnClickButton (string strID)
{
	local PartyWnd L2jBRVar21;

	L2jBRVar21 = PartyWnd(GetScript("PartyWnd"));
	switch (strID)
	{
		case "btnBuff":
		OnBuffButton();
		L2jBRVar21.OnBuffButton();
		break;
		case "btnOption":
		OnOpenPartyWndOption();
		default:
	}
}

function OnOpenPartyWndOption ()
{
	local PartyWndOption L2jBRVar21;

	L2jBRVar21 = PartyWndOption(GetScript("PartyWndOption"));
	L2jBRVar21.ShowPartyWndOption();
	m_PartyOption.SetAnchor("PartyWndCompact.PartyStatusWnd0","TopRight","TopLeft",5,5);
}

function OnBuffButton ()
{
	m_CurBf = UnknownFunction146(m_CurBf,1);
	if ( UnknownFunction151(m_CurBf,2) )
	{
		m_CurBf = 0;
	}
	SetBuffButtonTooltip();
	UpdateBuff();
}

function UpdateBuff ()
{
	local int L2jBRVar2;

	if ( UnknownFunction154(m_CurBf,1) )
	{
		L2jBRVar2 = 0;
		if ( UnknownFunction150(L2jBRVar2,8) )
		{
			L2jBRVar42[L2jBRVar2].ShowWindow();
			
			
			L2jBRVar43[L2jBRVar2].HideWindow();
			UnknownFunction165(L2jBRVar2);
			goto JL0012;
		}
	} else {
		if ( UnknownFunction154(m_CurBf,2) )
		{
			L2jBRVar2 = 0;
			if ( UnknownFunction150(L2jBRVar2,8) )
			{
				L2jBRVar42[L2jBRVar2].HideWindow();
				
				
				L2jBRVar43[L2jBRVar2].ShowWindow();
				UnknownFunction165(L2jBRVar2);
				goto JL0068;
			}
		} else {
			L2jBRVar2 = 0;
			if ( UnknownFunction150(L2jBRVar2,8) )
			{
				L2jBRVar42[L2jBRVar2].HideWindow();
JL00B2:
				
				
				L2jBRVar43[L2jBRVar2].HideWindow();
				UnknownFunction165(L2jBRVar2);
				goto JL00B2;
			}
		}
	}
}

function UpdateCPBar (int L2jBRVar2, int Value, int MaxValue)
{
	m_BarCP[L2jBRVar2].SetValue(MaxValue,Value);
}

function UpdateHPBar (int L2jBRVar2, int Value, int MaxValue)
{
	m_BarHP[L2jBRVar2].SetValue(MaxValue,Value);
}

function UpdateMPBar (int L2jBRVar2, int Value, int MaxValue)
{
	m_BarMP[L2jBRVar2].SetValue(MaxValue,Value);
}

function OnLButtonDown (WindowHandle L2jBRVar20, int X, int Y)
{
	local Rect rectWnd;
	local int L2jBRVar2;

	rectWnd = L2jBRVar103.GetRect();
	if ( UnknownFunction151(X,UnknownFunction146(rectWnd.nX,30)) )
	{
		L2jBRVar2 = UnknownFunction145(UnknownFunction147(Y,rectWnd.nY),26);
		RequestTargetUser(L2jBRVar41[L2jBRVar2]);
	}
}

function OnRButtonUp (int X, int Y)
{
	local Rect rectWnd;
	local UserInfo UserInfo;
	local int L2jBRVar2;

	rectWnd = L2jBRVar103.GetRect();
	if ( UnknownFunction151(X,UnknownFunction146(rectWnd.nX,30)) )
	{
		if ( GetPlayerInfo(UserInfo) )
		{
			L2jBRVar2 = UnknownFunction145(UnknownFunction147(Y,rectWnd.nY),26);
			RequestAssist(L2jBRVar41[L2jBRVar2],UserInfo.Loc);
		}
	}
}

function SetBuffButtonTooltip ()
{
	local int L2jBRVar2;

	switch (m_CurBf)
	{
		case 0:
		L2jBRVar2 = 1496;
		break;
		case 1:
		L2jBRVar2 = 1497;
		break;
		case 2:
		L2jBRVar2 = 1498;
		break;
		default:
	}
	BtnBuff.SetTooltipCustomType(MakeTooltipSimpleText(GetSystemString(L2jBRVar2)));
}

