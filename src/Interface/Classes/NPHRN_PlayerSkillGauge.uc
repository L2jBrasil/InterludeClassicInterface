//================================================================================
// NPHRN_PlayerSkillGauge.
//================================================================================

class NPHRN_PlayerSkillGauge extends UICommonAPI;

var string L2jBRVar6;
var int L2jBRVar76;
var StatusWnd L2jBRVar21;
var WindowHandle L2jBRVar12;
var TextureHandle L2jBRVar77;
var TextBoxHandle L2jBRVar78;
var float L2jBRVar79;
var bool L2jBRVar4;

function OnLoad ()
{
	if ( UnknownFunction242(GetOptionBool("Unload","SkillCastingBox"),True) )
	{
		Class'UIAPI_WINDOW'.HideWindow("NPHRN_PlayerSkillGauge");
		Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_Tab.CB_SkillCastingBox",False);
		Class'UIAPI_CHECKBOX'.SetDisable("NPHRN_Tab.CB_SkillCastingBox",True);
		return;
	}
	L2jBRFunction32	();
	OnRegisterEvent();
}

function L2jBRFunction32	 ()
{
	L2jBRVar12 = GetHandle("NPHRN_PlayerSkillGauge");
	L2jBRVar77 = TextureHandle(GetHandle("NPHRN_PlayerSkillGauge.Slider.Substrate"));
	L2jBRVar78 = TextBoxHandle(GetHandle("NPHRN_PlayerSkillGauge.Slider.Title"));
	L2jBRVar21 = StatusWnd(GetScript("StatusWnd"));
	L2jBRVar6 = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRFunction21(25)),""),L2jBRFunction25(3)),""),L2jBRFunction25(9)),""),L2jBRFunction25(10)),""),L2jBRFunction25(16)),""),L2jBRFunction25(4)),""),L2jBRFunction25(9)),""),L2jBRFunction25(25)),"");
}

function OnRegisterEvent ()
{
	RegisterEvent(150);
	RegisterEvent(290);
	RegisterEvent(50);
	RegisterEvent(2960);
	RegisterEvent(580);
}

function OnEvent (int EventID, string L2jBRVar1)
{
	local int L2jBRVar190;
	local int L2jBRVar124;

	switch (EventID)
	{
		case 150:
		L2jBRVar12.SetTimer(1,1000);
		break;
		case 290:
		if ( UnknownFunction242(GetOptionBool(L2jBRVar6,"SkillCastingBox"),True) )
		{
			ParseInt(L2jBRVar1,"AttackerID",L2jBRVar190);
			if ( UnknownFunction154(L2jBRVar190,L2jBRVar76) )
			{
				L2jBRFunction69(L2jBRVar1);
			}
		}
		break;
		case 580:
		ParseInt(L2jBRVar1,"Index",L2jBRVar124);
		if ( UnknownFunction155(L2jBRVar124,27) )
		{
			return;
		}
		case 2960:
		case 50:
		L2jBRVar12.HideWindow();
		break;
		default:
	}
}

function L2jBRFunction69(string _L2jBRVar17_)
{
	local int L2jBRVar24;
	local SkillInfo L2jBRVar105;
	local UserInfo L2jBRVar107;
	local float L2jBRVar104;
	local float L2jBRVar106;

	ParseInt(_L2jBRVar17_,"SkillID",L2jBRVar24);
	if ( UnknownFunction132(L2jBRVar4,L2jBRFunction75(L2jBRVar24)) )
	{
		if ( L2jBRFunction74
		
		(L2jBRVar24) )
		{
			L2jBRVar79 = 0.1;
		}
		return;
	}
	if ( GetSkillInfo(L2jBRVar24,1,L2jBRVar105) )
	{
		L2jBRVar4 = True;
		L2jBRVar12.ShowWindow();
		L2jBRVar78.SetText(L2jBRVar105.SkillName);
		if ( GetPlayerInfo(L2jBRVar107) )
		{
			if ( UnknownFunction154(L2jBRVar105.IsMagic,1) )
			{
				L2jBRVar106 = UnknownFunction172(L2jBRVar107.nMagicCastingSpeed,1000);
				UnknownFunction184(L2jBRVar106,L2jBRVar79);
			} else {
				L2jBRVar106 = UnknownFunction172(L2jBRVar107.nPhysicalAttackSpeed,1000);
			}
			L2jBRVar79 = 0.0;
		}
		L2jBRVar104 = UnknownFunction175(L2jBRVar105.HitTime,UnknownFunction171(L2jBRVar106,UnknownFunction172(L2jBRVar105.HitTime,1.5)));
		if ( UnknownFunction176(L2jBRVar104,0.5) )
		{
			L2jBRVar104 = UnknownFunction172(L2jBRVar105.HitTime,6);
		}
		L2jBRVar77.Move(205,0,L2jBRVar104);
		L2jBRVar12.SetTimer(2,UnknownFunction146(int(UnknownFunction171(L2jBRVar104,1000)),300));
	}
}

function OnTimer (int TimerID)
{
	switch (TimerID)
	{
		case 2:
		L2jBRVar12.KillTimer(2);
		L2jBRFunction40();
		break;
		case 1:
		L2jBRVar12.KillTimer(1);
		L2jBRVar76 = L2jBRVar21.L2jBRVar76;
		break;
		default:
	}
}

function L2jBRFunction40 ()
{
	local Rect Rect;

	Rect = L2jBRVar12.GetRect();
	L2jBRVar77.MoveTo(UnknownFunction147(Rect.nX,24),Rect.nY);
	L2jBRVar12.HideWindow();
	L2jBRVar4 = False;
}

