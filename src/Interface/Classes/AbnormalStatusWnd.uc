//================================================================================
// AbnormalStatusWnd.
//================================================================================

class AbnormalStatusWnd extends UICommonAPI;

var string L2jBRVar6;
var int L2jBRVar7;
var int L2jBRVar98;
var int L2jBRVar8;
var int _L2jBRVar9;
var int 
L2jBRVar99;
var bool L2jBRVar97;
var WindowHandle L2jBRVar12;
var StatusIconHandle L2jBRVar11;
const L2jBRVar102 = "L2UI_CH3.Debuff";
const L2jBRVar100 = "L2UI.EtcWndBack.AbnormalBack";
const L2jBRVar10 = 12;
const L2jBRVar101= 12;

function OnLoad ()
{
	RegisterEvent(950);
	RegisterEvent(960);
	RegisterEvent(970);
	RegisterEvent(40);
	RegisterEvent(50);
	RegisterEvent(310);
	RegisterEvent(1900);
	L2jBRVar7 = -1;
	L2jBRVar98 = -1;
	L2jBRVar8 = -1;
	_L2jBRVar9 = -1;

	L2jBRVar99 = -1;
	L2jBRVar97 = False;
	L2jBRFunction2();
}

function L2jBRFunction2 ()
{
	L2jBRVar12 = GetHandle("AbnormalStatusWnd");
	L2jBRVar11 = StatusIconHandle(GetHandle("AbnormalStatusWnd.StatusIcon"));
	L2jBRVar6 = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRFunction21(25)),""),L2jBRFunction25(3)),""),L2jBRFunction25(9)),""),L2jBRFunction25(10)),""),L2jBRFunction25(16)),""),L2jBRFunction25(4)),""),L2jBRFunction25(9)),""),L2jBRFunction25(25)),"");
}

function OnEnterState (name a_PreStateName)
{
	L2jBRVar97 = True;
	UpdateWindowSize();
}

function OnExitState (name a_NextStateName)
{
	L2jBRVar97 = False;
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,950) )
	{
		L2jBRFunction79(L2jBRVar1);
	} else {
		if ( UnknownFunction154(Event_ID,960) )
		{
			L2jBRFunction52(L2jBRVar1);
		} else {
			if ( UnknownFunction154(Event_ID,970) )
			{
				L2jBRFunction78(L2jBRVar1);
			} else {
				if ( UnknownFunction154(Event_ID,40) )
				{
					L2jBRFunction4();
				} else {
					if ( UnknownFunction154(Event_ID,50) )
					{
						L2jBRFunction76();
					} else {
						if ( UnknownFunction154(Event_ID,310) )
						{
							L2jBRFunction77();
						} else {
							if ( UnknownFunction154(Event_ID,1900) )
							{
								__L2jBRFunction1();
							}
						}
					}
				}
			}
		}
	}
}

function int L2jBRFunction3 (int L2jBRVar40)
{
	local int L2jBRVar158;

	switch (L2jBRVar40)
	{
		case 0:
		L2jBRVar158 = 24;
		break;
		case 1:
		L2jBRVar158 = 20;
		break;
		case 2:
		L2jBRVar158 = 16;
		break;
		default:
	}
	return L2jBRVar158;
}

function L2jBRFunction4 ()
{
	L2jBRFunction5();
}

function L2jBRFunction76 ()
{
	L2jBRFunction30(False,False);
	L2jBRFunction30(False,True);
}

function L2jBRFunction77()
{
	L2jBRVar12.HideWindow();
}

function OnShow ()
{
	local int L2jBRVar94;

	L2jBRVar94 = L2jBRVar11.GetRowCount();
	if ( UnknownFunction150(L2jBRVar94,1) )
	{
		L2jBRVar12.HideWindow();
	}
}

function L2jBRFunction30 (bool bEtcItem, bool bShortItem)
{
	local int i;
	local int j;
	local int L2jBRVar94;
	local int L2jBRVar95;
	local int L2jBRVar96;
	local StatusIconInfo Info;

	if ( UnknownFunction130(UnknownFunction242(bEtcItem,False),UnknownFunction242(bShortItem,False)) )
	{
		L2jBRVar7 = -1;
		L2jBRVar98 = -1;
		L2jBRVar8 = -1;
	}
	if ( UnknownFunction130(UnknownFunction242(bEtcItem,True),UnknownFunction242(bShortItem,False)) )
	{
		_L2jBRVar9 = -1;
	}
	if ( UnknownFunction130(UnknownFunction242(bEtcItem,False),UnknownFunction242(bShortItem,True)) )
	{
		
		L2jBRVar99 = -1;
	}
	L2jBRVar94 = L2jBRVar11.GetRowCount();
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar94) )
	{
		L2jBRVar96 = L2jBRVar11.GetColCount(i);
		j = 0;
		if ( UnknownFunction150(j,L2jBRVar96) )
		{
			L2jBRVar11.GetItem(i,j,Info);
			if ( UnknownFunction151(Info.ClassID,0) )
			{
				if ( UnknownFunction130(UnknownFunction242(Info.bEtcItem,bEtcItem),UnknownFunction242(Info.bShortItem,bShortItem)) )
				{
					L2jBRVar11.DelItem(i,j);
					UnknownFunction166(j);
					UnknownFunction166(L2jBRVar96);
					L2jBRVar95 = L2jBRVar11.GetRowCount();
					if ( UnknownFunction155(L2jBRVar95,L2jBRVar94) )
					{
						UnknownFunction166(i);
						UnknownFunction166(L2jBRVar94);
					}
				}
			}
			UnknownFunction165(j);
			goto JL00D1;
		}
		UnknownFunction165(i);
		goto JL00A1;
	}
}

function L2jBRFunction5 ()
{
	L2jBRFunction30(False,False);
	L2jBRFunction30(True,False);
	L2jBRFunction30(False,True);
}

function L2jBRFunction79 (string L2jBRVar1)
{
	local int i;
	local int L2jBRVar29;
	local int L2jBRVar93;
	local StatusIconInfo Info;

	L2jBRFunction30(False,False);
	Info.Size = L2jBRFunction3(GetOptionInt(L2jBRVar6,"AbnormalSize"));
	Info.bShow = True;
	Info.bEtcItem = False;
	Info.bShortItem = False;
	L2jBRVar93 = 0;
	ParseInt(L2jBRVar1,"Max",L2jBRVar29);
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar29) )
	{
		ParseInt(L2jBRVar1,UnknownFunction112("SkillID_",string(i)),Info.ClassID);
		ParseInt(L2jBRVar1,UnknownFunction112("SkillLevel_",string(i)),Info.Level);
		ParseInt(L2jBRVar1,UnknownFunction112("RemainTime_",string(i)),Info.RemainTime);
		ParseString(L2jBRVar1,UnknownFunction112("Name_",string(i)),Info.Name);
		ParseString(L2jBRVar1,UnknownFunction112("IconName_",string(i)),Info.IconName);
		ParseString(L2jBRVar1,UnknownFunction112("Description_",string(i)),Info.Description);
		if ( UnknownFunction151(Info.ClassID,0) )
		{
			if ( L2jBRFunction19(Info.ClassID) )
			{
				Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
				if ( UnknownFunction154(L2jBRVar98,-1) )
				{
					L2jBRVar98 = UnknownFunction146(L2jBRVar7,1);
					L2jBRVar11.InsertRow(L2jBRVar98);
					if ( UnknownFunction151(L2jBRVar8,-1) )
					{
						UnknownFunction165(L2jBRVar8);
					}
				}
				L2jBRVar11.AddCol(L2jBRVar98,Info);
			} else {
				if ( L2jBRFunction20(Info.ClassID) )
				{
					if ( L2jBRFunction51(Info.ClassID) )
					{
						Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
					} else {
						Info.BackTex = "L2UI_CH3.Debuff";
					}
					L2jBRFunction50();
					L2jBRVar11.AddCol(L2jBRVar8,Info);
				} else {
					Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
					if ( UnknownFunction180(UnknownFunction173(L2jBRVar93,12),0) )
					{
						UnknownFunction165(L2jBRVar7);
						L2jBRVar11.InsertRow(L2jBRVar7);
						if ( UnknownFunction151(L2jBRVar98,-1) )
						{
							UnknownFunction165(L2jBRVar98);
						}
						if ( UnknownFunction151(L2jBRVar8,-1) )
						{
							UnknownFunction165(L2jBRVar8);
						}
					}
					L2jBRVar11.AddCol(L2jBRVar7,Info);
					UnknownFunction165(L2jBRVar93);
				}
			}
		}
		UnknownFunction165(i);
		goto JL007C;
	}
	if ( UnknownFunction151(_L2jBRVar9,-1) )
	{
		_L2jBRVar9 = UnknownFunction146(L2jBRVar7,1);
		if ( UnknownFunction151(L2jBRVar98,-1) )
		{
			_L2jBRVar9 = UnknownFunction146(L2jBRVar98,1);
		}
		if ( UnknownFunction151(L2jBRVar8,-1) )
		{
			_L2jBRVar9 = UnknownFunction146(L2jBRVar8,1);
		}
	}
	if ( UnknownFunction151(
	L2jBRVar99,-1) )
	{
		
		L2jBRVar99 = UnknownFunction146(L2jBRVar7,1);
		if ( UnknownFunction151(L2jBRVar98,-1) )
		{
			
			L2jBRVar99 = UnknownFunction146(L2jBRVar98,1);
		}
		if ( UnknownFunction151(L2jBRVar8,-1) )
		{
			
			L2jBRVar99 = UnknownFunction146(L2jBRVar8,1);
		}
	}
	UpdateWindowSize();
}

function L2jBRFunction50 ()
{
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar8,-1),UnknownFunction154(L2jBRVar98,-1)) )
	{
		L2jBRVar8 = UnknownFunction146(L2jBRVar7,1);
		L2jBRVar11.InsertRow(L2jBRVar8);
	} else {
		if ( UnknownFunction130(UnknownFunction154(L2jBRVar8,-1),UnknownFunction151(L2jBRVar98,-1)) )
		{
			L2jBRVar8 = UnknownFunction146(L2jBRVar98,1);
			L2jBRVar11.InsertRow(L2jBRVar8);
		}
	}
}

function L2jBRFunction52 (string L2jBRVar1)
{
	local int i;
	local int L2jBRVar29;
	local int L2jBRVar93;
	local int L2jBRVar47;
	local bool L2jBRVar159;
	local StatusIconInfo Info;

	L2jBRFunction30(True,False);
	Info.Size = L2jBRFunction3(GetOptionInt(L2jBRVar6,"AbnormalSize"));
	Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
	Info.bShow = True;
	Info.bEtcItem = True;
	Info.bShortItem = False;
	if ( UnknownFunction151(
	L2jBRVar99,-1) )
	{
		L2jBRVar159 = False;
		
		L2jBRVar47 = L2jBRVar99;
	} else {
		L2jBRVar159 = True;
		
		L2jBRVar47 = L2jBRVar7;
		if ( UnknownFunction151(L2jBRVar98,-1) )
		{
			L2jBRVar47 = L2jBRVar98;
		}
		if ( UnknownFunction151(L2jBRVar8,-1) )
		{
			L2jBRVar47 = L2jBRVar8;
		}
	}
	L2jBRVar93 = 0;
	ParseInt(L2jBRVar1,"Max",L2jBRVar29);
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar29) )
	{
		ParseInt(L2jBRVar1,UnknownFunction112("SkillID_",string(i)),Info.ClassID);
		ParseInt(L2jBRVar1,UnknownFunction112("SkillLevel_",string(i)),Info.Level);
		ParseInt(L2jBRVar1,UnknownFunction112("RemainTime_",string(i)),Info.RemainTime);
		ParseString(L2jBRVar1,UnknownFunction112("Name_",string(i)),Info.Name);
		ParseString(L2jBRVar1,UnknownFunction112("IconName_",string(i)),Info.IconName);
		ParseString(L2jBRVar1,UnknownFunction112("Description_",string(i)),Info.Description);
		if ( UnknownFunction151(Info.ClassID,0) )
		{
			if ( L2jBRVar159 )
			{
				L2jBRVar159 = UnknownFunction129(L2jBRVar159);
				UnknownFunction165(L2jBRVar47);
				L2jBRVar11.InsertRow(L2jBRVar47);
			}
			L2jBRVar11.AddCol(L2jBRVar47,Info);
			_L2jBRVar9 = L2jBRVar47;
			UnknownFunction165(L2jBRVar93);
		}
		UnknownFunction165(i);
		goto JL0111;
	}
	UpdateWindowSize();
}

function L2jBRFunction78 (string L2jBRVar1)
{
	local int i;
	local int L2jBRVar29;
	local int L2jBRVar93;
	local int L2jBRVar47;
	local int L2jBRVar82;
	local bool L2jBRVar159;
	local StatusIconInfo Info;

	L2jBRFunction30(False,True);
	Info.Size = L2jBRFunction3(GetOptionInt(L2jBRVar6,"AbnormalSize"));
	Info.BackTex = "L2UI.EtcWndBack.AbnormalBack";
	Info.bShow = True;
	Info.bEtcItem = False;
	Info.bShortItem = True;
	L2jBRVar82 = -1;
	if ( UnknownFunction151(_L2jBRVar9,-1) )
	{
		L2jBRVar159 = False;
		L2jBRVar47 = _L2jBRVar9;
	} else {
		L2jBRVar159 = True;
		L2jBRVar47 = L2jBRVar7;
		if ( UnknownFunction151(L2jBRVar98,-1) )
		{
			L2jBRVar47 = L2jBRVar98;
		}
		if ( UnknownFunction151(L2jBRVar8,-1) )
		{
			L2jBRVar47 = L2jBRVar8;
		}
	}
	L2jBRVar93 = 0;
	ParseInt(L2jBRVar1,"Max",L2jBRVar29);
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar29) )
	{
		ParseInt(L2jBRVar1,UnknownFunction112("SkillID_",string(i)),Info.ClassID);
		ParseInt(L2jBRVar1,UnknownFunction112("SkillLevel_",string(i)),Info.Level);
		ParseInt(L2jBRVar1,UnknownFunction112("RemainTime_",string(i)),Info.RemainTime);
		ParseString(L2jBRVar1,UnknownFunction112("Name_",string(i)),Info.Name);
		ParseString(L2jBRVar1,UnknownFunction112("IconName_",string(i)),Info.IconName);
		ParseString(L2jBRVar1,UnknownFunction112("Description_",string(i)),Info.Description);
		if ( UnknownFunction151(Info.ClassID,0) )
		{
			if ( L2jBRVar159 )
			{
				L2jBRVar159 = UnknownFunction129(L2jBRVar159);
				UnknownFunction165(L2jBRVar47);
				L2jBRVar11.InsertRow(L2jBRVar47);
			}
			UnknownFunction165(L2jBRVar82);
			L2jBRVar11.InsertCol(L2jBRVar47,L2jBRVar82,Info);
			
			L2jBRVar99 = L2jBRVar47;
			UnknownFunction165(L2jBRVar93);
		}
		UnknownFunction165(i);
		goto JL011C;
	}
	UpdateWindowSize();
}

function UpdateWindowSize ()
{
	local int L2jBRVar94;
	local Rect rectWnd;

	L2jBRVar94 = L2jBRVar11.GetRowCount();
	if ( UnknownFunction151(L2jBRVar94,0) )
	{
		if (L2jBRVar97)
		{
			L2jBRVar12.ShowWindow();
		} else {
			L2jBRVar12.HideWindow();
		}
		rectWnd = L2jBRVar11.GetRect();
		L2jBRVar12.SetWindowSize(UnknownFunction146(rectWnd.nWidth,12),rectWnd.nHeight);
		L2jBRVar12.SetFrameSize(12,rectWnd.nHeight);
	} else {
		L2jBRVar12.HideWindow();
	}
}

function __L2jBRFunction1()
{
	local int i;
	local int j;
	local int L2jBRVar94;
	local int L2jBRVar96;
	local StatusIconInfo Info;

	L2jBRVar94 = L2jBRVar11.GetRowCount();
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar94) )
	{
		L2jBRVar96 = L2jBRVar11.GetColCount(i);
		j = 0;
JL004C:
		if ( UnknownFunction150(j,L2jBRVar96) )
		{
			L2jBRVar11.GetItem(i,j,Info);
			if ( UnknownFunction151(Info.ClassID,0) )
			{
				Info.Name = Class'UIDATA_SKILL'.GetName(Info.ClassID,Info.Level);
				Info.Description = Class'UIDATA_SKILL'.GetDescription(Info.ClassID,Info.Level);
				L2jBRVar11.SetItem(i,j,Info);
			}
			UnknownFunction165(j);
			goto JL004C;
		}
		UnknownFunction165(i);
		goto JL001C;
	}
}

function L2jBRFunction31 ()
{
	local int i;
	local int j;
	local int L2jBRVar94;
	local int L2jBRVar96;
	local int L2jBRVar95;
	local StatusIconInfo Info;

	L2jBRVar94 = L2jBRVar11.GetRowCount();
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar94) )
	{
		L2jBRVar96 = L2jBRVar11.GetColCount(i);
		j = 0;
JL004C:
		if ( UnknownFunction150(j,L2jBRVar96) )
		{
			L2jBRVar11.GetItem(i,j,Info);
			if ( L2jBRFunction51(Info.ClassID) )
			{
				L2jBRVar11.DelItem(i,j);
				UnknownFunction166(j);
				UnknownFunction166(L2jBRVar96);
				L2jBRVar95 = L2jBRVar11.GetRowCount();
				if ( UnknownFunction155(L2jBRVar95,L2jBRVar94) )
				{
					UnknownFunction166(i);
					UnknownFunction166(L2jBRVar94);
				}
				if ( UnknownFunction242(GetOptionBool(L2jBRVar6,"ShowNoble"),True) )
				{
					L2jBRVar8 = -1;
					L2jBRFunction50();
					L2jBRVar11.InsertCol(L2jBRVar8,0,Info);
				} else {
					L2jBRVar11.AddCol(L2jBRVar7,Info);
				}
			}
			UnknownFunction165(j);
			goto JL004C;
		}
		UnknownFunction165(i);
		goto JL001C;
	}
	UpdateWindowSize();
}

