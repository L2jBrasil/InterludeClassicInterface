//================================================================================
// NPHRN_DopingWnd.
//================================================================================

class NPHRN_DopingWnd extends UICommonAPI;

var WindowHandle L2jBRVar12;
var ItemWindowHandle L2jBRVar56;
var NPHRN_MagicSkillWnd L2jBRVar21;
var StatusIconHandle L2jBRVar11;
var ItemInfo L2jBRVar118;
var ItemInfo L2jBRVar117;
var ItemInfo L2jBRVar116;
var bool L2jBRVar115 ;
const L2jBRVar119 = 400;
const L2jBRVar120 = 500;
const L2jBRVar114 = 1000;
const L2jBRVar113 = 3;
const L2jBRVar121= 1;
const L2jBRVar112 = "Greater Haste Potion";
const L2jBRVar122 = "Greater Swift Attack Potion";
const L2jBRVar111 = "Greater Magic Haste Potion";
const L2jBRVar110 = 1374;
const L2jBRVar109 = 1375;
const L2jBRVar123 = 6036;

function OnLoad ()
{
	L2jBRVar12 = GetHandle("NPHRN_DopingWnd");
	L2jBRVar56 = ItemWindowHandle(GetHandle("InventoryWnd.InventoryItem"));
	L2jBRVar21 = NPHRN_MagicSkillWnd(GetScript("NPHRN_MagicSkillWnd"));
	L2jBRVar11 = StatusIconHandle(GetHandle("AbnormalStatusWnd.StatusIcon"));
	OnRegisterEvent();
}

function OnRegisterEvent ()
{
	RegisterEvent(150);
	RegisterEvent(950);
	RegisterEvent(580);
	RegisterEvent(2600);
	RegisterEvent(2610);
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 150:
		L2jBRFunction35();
		break;
		case 950:
		if ( UnknownFunction242(GetOptionBool("Neophron","UseDoping"),True) )
		{
			L2jBRVar12.SetTimer(3,400);
		} else {
			case 580:
			L2jBRFunction34(_L2jBRVar17_);
			goto JL0089;
			case 2600:
			case 2610:
			L2jBRFunction56();
JL0089:
			goto JL0089;
			default:
		}
	}
}

function OnTimer (int TimerID)
{
	switch (TimerID)
	{
		case 1:
		L2jBRVar12.KillTimer(1);
		L2jBRFunction57();
		break;
		case 3:
		L2jBRVar12.KillTimer(3);
		L2jBRFunction55();
		break;
		default:
	}
}

function L2jBRFunction35 ()
{
	L2jBRVar12.SetTimer(1,500);
}

function L2jBRFunction57 ()
{
	local UserInfo L2jBRVar107;

	GetPlayerInfo(L2jBRVar107);
	L2jBRVar115  = L2jBRFunction88(L2jBRVar107.nSubClass);
}

function bool L2jBRFunction88 (int _L2jBRVar17_)
{
	local bool L2jBRVar108;

	switch (_L2jBRVar17_)
	{
		case 10:
		case 11:
		case 12:
		case 13:
		case 14:
		case 15:
		case 16:
		case 17:
		case 25:
		case 26:
		case 27:
		case 28:
		case 29:
		case 38:
		case 39:
		case 40:
		case 41:
		case 42:
		case 43:
		case 49:
		case 50:
		case 51:
		case 52:
		case 94:
		case 95:
		case 96:
		case 97:
		case 98:
		case 103:
		case 104:
		case 105:
		case 110:
		case 111:
		case 112:
		case 115:
		case 116:
		L2jBRVar108 = True;
		break;
		default:
	}
	return L2jBRVar108;
}

function L2jBRFunction56 ()
{
	if ( L2jBRVar115  )
	{
		L2jBRFunction89(6036,L2jBRVar118);
	} else {
		L2jBRFunction89(1375,L2jBRVar117);
	}
	L2jBRFunction89(1374,L2jBRVar116);
}

function L2jBRFunction89 (int L2jBRVar39, out ItemInfo L2jBRVar28)
{
	local int Index;
	local ItemInfo L2jBRVar167;

	Index = L2jBRVar56.FindItemWithClassID(L2jBRVar39);
	if ( L2jBRVar56.GetItem(Index,L2jBRVar167) )
	{
		L2jBRVar28 = L2jBRVar167;
	}
}

function L2jBRFunction55 ()
{
	local int i;
	local int L2jBRVar29;
	local StatusIconInfo L2jBRVar28;
	local bool L2jBRVar168;
	local bool L2jBRVar169;
	local bool L2jBRVar170;

	ParseInt(L2jBRVar21.
	L2jBRVar81,"Max",L2jBRVar29);
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar29) )
	{
		ParseInt(L2jBRVar21.
		L2jBRVar81,UnknownFunction112("SkillID_",string(i)),L2jBRVar28.ClassID);
		if ( L2jBRFunction91(L2jBRVar28.ClassID) )
		{
			return;
		}
		if ( L2jBRFunction92(L2jBRVar28.ClassID) )
		{
			L2jBRVar168 = True;
		}
		if (L2jBRFunction93(L2jBRVar28.ClassID) )
		{
			L2jBRVar169 = True;
		}
		if ( L2jBRFunction94(L2jBRVar28.ClassID) )
		{
			L2jBRVar170 = True;
		}
		UnknownFunction165(i);
		goto JL0025;
	}
	if ( L2jBRVar115  )
	{
		if (! UnknownFunction129(L2jBRVar168) ) goto JL00E9;
	} else {
		if (! UnknownFunction129(L2jBRVar169) ) goto JL00F7;
	}
	if (! UnknownFunction129(L2jBRVar170) ) goto JL0102;
}

function bool L2jBRFunction91 (int L2jBRVar24)
{
	local bool L2jBRVar171;

	switch (L2jBRVar24)
	{
		case 1361:
		case 1358:
		case 1359:
		case 1360:
		case 1418:
		case 1427:
		case 443:
		case 442:
		case 1170:
		case 4063:
		case 4064:
		case 5172:
		L2jBRVar171 = True;
		break;
		default:
	}
	return L2jBRVar171;
}

function bool L2jBRFunction92 (int L2jBRVar24)
{
	local bool L2jBRVar168;

	switch (L2jBRVar24)
	{
		case 1085:
		case 1004:
		case 1002:
		case 2169:
		L2jBRVar168 = True;
		break;
		default:
	}
	return L2jBRVar168;
}

function bool L2jBRFunction93 (int L2jBRVar24)
{
	local bool L2jBRVar169;

	switch (L2jBRVar24)
	{
		case 1086:
		case 1251:
		case 2035:
		L2jBRVar169 = True;
		break;
		default:
	}
	return L2jBRVar169;
}

function bool L2jBRFunction94 (int L2jBRVar24)
{
	local bool L2jBRVar170;

	switch (L2jBRVar24)
	{
		case 1204:
		case 1282:
		case 230:
		case 2034:
		L2jBRVar170 = True;
		break;
		default:
	}
	return L2jBRVar170;
}

function L2jBRFunction34 (string _L2jBRVar17_)
{
	local int L2jBRVar124;

	ParseInt(_L2jBRVar17_,"Index",L2jBRVar124);
	switch (L2jBRVar124)
	{
		case 1270:
		L2jBRFunction57();
		break;
		default:
	}
}

