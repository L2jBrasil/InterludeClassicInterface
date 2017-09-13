//================================================================================
// NPHRN_MagicSkillWnd.
//================================================================================

class NPHRN_MagicSkillWnd extends UICommonAPI;

var WindowHandle L2jBRVar12;
var MagicSkillWnd L2jBRVar21;
var string L2jBRVar81;
var array<int> 	L2jBRVar151;
var array<int> L2jBRVar186;
var int L2jBRVar187;
var int L2jBRVar188;
var int L2jBRVar150;
var int L2jBRVar80;
var bool L2jBRVar189;

function OnLoad ()
{
	OnRegisterEvent();
	L2jBRVar12 = GetHandle("NPHRN_MagicSkillWnd");
	L2jBRVar21 = MagicSkillWnd(GetScript("MagicSkillWnd"));
}

function OnRegisterEvent ()
{
	RegisterEvent(150);
	RegisterEvent(40);
	RegisterEvent(950);
	RegisterEvent(50);
	RegisterEvent(1440);
	RegisterEvent(580);
}

function OnEvent (int EventID, string L2jBRVar1)
{
	switch (EventID)
	{
		case 150:
		L2jBRFunction35();
		break;
		case 40:
		break;
		case 950:
		
		L2jBRVar81 = L2jBRVar1;
		if ( UnknownFunction129(L2jBRFunction60(L2jBRVar150,L2jBRVar80)) )
		{
			L2jBRFunction79();
		}
		break;
		case 50:
		L2jBRVar189 = True;
		L2jBRFunction62();
		break;
		case 1440:
		L2jBRVar189 = False;
		break;
		case 580:
		L2jBRFunction34(L2jBRVar1);
		break;
		default:
	}
}

function OnTimer (int TimerID)
{
	if ( UnknownFunction154(TimerID,1) )
	{
		L2jBRVar12.KillTimer(1);
		L2jBRFunction55();
	}
}

function bool L2jBRFunction60 (int i, int j)
{
	local bool L2jBRVar141;

	if ( UnknownFunction130(UnknownFunction154(i,0),UnknownFunction154(j,0)) )
	{
		L2jBRVar141 = True;
	}
	return L2jBRVar141;
}

function L2jBRFunction35 ()
{
	L2jBRFunction61();
	L2jBRFunction62();
}

function L2jBRFunction79()
{
	L2jBRVar12.SetTimer(1,250);
}

function L2jBRFunction55 ()
{
	local int i;
	local int j;
	local int L2jBRVar29;
	local StatusIconInfo Info;

	if ( UnknownFunction132(L2jBRVar189,L2jBRFunction60(L2jBRVar150,L2jBRVar80)) )
	{
		return;
	}
	L2jBRFunction62();
	ParseInt(
	L2jBRVar81,"Max",L2jBRVar29);
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar29) )
	{
		ParseInt(
		L2jBRVar81,UnknownFunction112("SkillID_",string(i)),Info.ClassID);
		if ( UnknownFunction151(Info.ClassID,0) )
		{
			j = 0;
			if ( UnknownFunction150(j,	L2jBRVar151.Length) )
			{
				if ( UnknownFunction154(Info.ClassID,	L2jBRVar151[j]) )
				{
					
					L2jBRFunction73(Info.ClassID);
				}
				UnknownFunction165(j);
				goto JL0090;
			}
		}
		UnknownFunction165(i);
		goto JL0042;
	}
	if ( UnknownFunction154(L2jBRVar80,L2jBRVar150) )
	{
		L2jBRVar12.KillTimer(1);
		return;
	} else {
		L2jBRFunction96();
	}
}

function L2jBRFunction96 ()
{
	local int i;
	local int j;
	local bool L2jBRVar4;

	i = 0;
	if ( UnknownFunction150(i,	L2jBRVar151.Length) )
	{
		if ( UnknownFunction151(	L2jBRVar151
		ˆ[i],-1) )
		{
			L2jBRVar4 = False;
			j = 0;
			if ( UnknownFunction150(j,L2jBRVar186.Length) )
			{
				if ( UnknownFunction154(	L2jBRVar151
				ˆ[i],L2jBRVar186[j]) )
				{
					L2jBRVar4 = True;
				} else {
					UnknownFunction165(j);
					goto JL003B;
				}
			}
			if ( UnknownFunction243(L2jBRVar4,True) )
			{
				if ( L2jBRFunction16(	L2jBRVar151
				ˆ[i]) )
				{
					RequestSelfTarget();
				}
			}
		}
		UnknownFunction165(i);
		goto JL0007;
	}
	L2jBRVar12.SetTimer(1,2500);
}

function L2jBRFunction97 (int L2jBRVar24)
{
	UnknownFunction165(L2jBRVar187);
	UnknownFunction161(L2jBRVar150,L2jBRVar24);
	L2jBRVar151[L2jBRVar187] = L2jBRVar24;
}

function L2jBRFunction72 (int L2jBRVar24)
{
	local int i;

	UnknownFunction162(L2jBRVar150,L2jBRVar24);
	i = 0;
	if ( UnknownFunction150(i,	L2jBRVar151.Length) )
	{
		if ( UnknownFunction154(	L2jBRVar151
		ˆ[i],L2jBRVar24) )
		{
				L2jBRVar151
			ˆ[i] = -1;
		}
		UnknownFunction165(i);
		goto JL0013;
	}
}

function L2jBRFunction73 (int L2jBRVar24)
{
	UnknownFunction165(L2jBRVar188);
	UnknownFunction161(L2jBRVar80,L2jBRVar24);
	L2jBRVar186[L2jBRVar188] = L2jBRVar24;
}

function L2jBRFunction62 ()
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,L2jBRVar186.Length) )
	{
		L2jBRVar186[i] = -1;
		UnknownFunction165(i);
		goto JL0007;
	}
	L2jBRVar186.Length = -1;
	L2jBRVar188 = -1;
	L2jBRVar80 = 0;
}

function L2jBRFunction61 ()
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,	L2jBRVar151.Length) )
	{
			L2jBRVar151[i] = -1;
		UnknownFunction165(i);
		goto JL0007;
	}
		L2jBRVar151.Length = -1;
	L2jBRVar187 = -1;
	L2jBRVar150 = 0;
}

function L2jBRFunction34 (string _L2jBRVar17_)
{
	local int L2jBRVar124;
	local string Text;

	ParseInt(_L2jBRVar17_,"Index",L2jBRVar124);
	switch (L2jBRVar124)
	{
		case 113:
		ParseString(_L2jBRVar17_,"Param1",Text);
		L2jBRFunction98(Text);
		break;
		case 1270:
		L2jBRFunction61();
		L2jBRFunction62();
		break;
		default:
	}
}

function L2jBRFunction98 (string Text)
{
	local int L2jBRVar24;
	local int i;

	if ( UnknownFunction122(Text,"Polearm Accuracy") )
	{
		L2jBRVar24 = 422;
	}
	if ( UnknownFunction122(Text,"Fell Swoop") )
	{
		L2jBRVar24 = 421;
	}
	if ( UnknownFunction122(Text,"Shield Fortress") )
	{
		L2jBRVar24 = 322;
	}
	if ( UnknownFunction122(Text,"Vengeance") )
	{
		L2jBRVar24 = 368;
	}
	if ( UnknownFunction122(Text,"Soul of Sagittarius") )
	{
		L2jBRVar24 = 303;
	}
	if ( UnknownFunction122(Text,"Snipe") )
	{
		L2jBRVar24 = 313;
	}
	if ( UnknownFunction122(Text,"Magical Mirror") )
	{
		L2jBRVar24 = 351;
	}
	if ( UnknownFunction151(L2jBRVar24,0) )
	{
		i = 0;
		if ( UnknownFunction150(i,	L2jBRVar151.Length) )
		{
			if ( UnknownFunction154(L2jBRVar24,	L2jBRVar151[i]) )
			{
				L2jBRFunction72(L2jBRVar24);
				L2jBRVar21.RequestSkillList();
				L2jBRVar21.L2jBRFunction71(L2jBRVar81);
				AddSystemMessage(MakeFullSystemMsg(GetSystemMessage(1434),Text),L2jBRFunction10("System"));
			}
			UnknownFunction165(i);
			goto JL010B;
		}
	}
}

