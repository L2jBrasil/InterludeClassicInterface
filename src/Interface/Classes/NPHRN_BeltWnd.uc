//================================================================================
// NPHRN_BeltWnd.
//================================================================================

class NPHRN_BeltWnd extends UICommonAPI;

var string L2jBRVar13;
var WindowHandle L2jBRVar12;
var WindowHandle L2jBRVar146;
var TextBoxHandle L2jBRVar143;
var TextBoxHandle L2jBRVar145;
var TextBoxHandle L2jBRVar163;
var TextBoxHandle L2jBRVar164;
var int CurKarma;
var int MaxKarma;
var bool L2jBRVar144;
const L2jBRVar142= 15;

function OnRegisterEvent ()
{
	RegisterEvent(180);
	RegisterEvent(2900);
}

function OnLoad ()
{
	OnRegisterEvent();
	L2jBRFunction2();
	L2jBRVar144 = GetOptionBool("Neophron","DisplayAdena");
}

function OnShow ()
{
	ExecuteEvent(410);
	L2jBRFunction87();
	L2jBRFunction29();
}

function L2jBRFunction29 ()
{
	L2jBRVar165.SetTooltipString("Clan");
	L2jBRVar163.SetTooltipString("Party Matching");
	L2jBRVar147.SetTooltipString("Inventory");
}

function L2jBRFunction2 ()
{
	L2jBRVar12 = GetHandle("NPHRN_BeltWnd");
	L2jBRVar146 = GetHandle("PartyMatchWnd");
	L2jBRVar143 = TextBoxHandle(GetHandle("NPHRN_BeltWnd.AdenaText"));
	L2jBRVar147 = TextBoxHandle(GetHandle("NPHRN_BeltWnd.WeightText"));
	L2jBRVar163 = TextBoxHandle(GetHandle("NPHRN_BeltWnd.PartyText"));
	L2jBRVar165 = TextBoxHandle(GetHandle("NPHRN_BeltWnd.StaffText"));
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 180:
		UpdateUserInfo();
		L2jBRFunction42();
		break;
		case 2900:
		L2jBRFunction87();
		break;
		default:
	}
}

function L2jBRFunction6 ()
{
	ShowWindow(L2jBRVar13);
	Class'UIAPI_WINDOW'.SetFocus(L2jBRVar13);
}

function 
L2jBRFunction63 ()
{
	HideWindow(L2jBRVar13);
}

function UpdateUserInfo ()
{
	local string L2jBRVar14;
	local UserInfo L2jBRVar28;

	L2jBRVar14 = string(GetAdena());
	if ( GetPlayerInfo(L2jBRVar28) )
	{
		if ( UnknownFunction151(L2jBRVar28.nCriminalRate,0) )
		{
			Class'UIAPI_WINDOW'.HideWindow("NPHRN_BeltWnd.ExpBar");
			Class'UIAPI_WINDOW'.ShowWindow("NPHRN_BeltWnd.KarmaBar");
			if ( UnknownFunction151(L2jBRVar28.nCriminalRate,MaxKarma) )
			{
				MaxKarma = L2jBRVar28.nCriminalRate;
			}
			CurKarma = L2jBRVar28.nCriminalRate;
			Class'UIAPI_STATUSBARCTRL'.SetPointPercent("NPHRN_BeltWnd.KarmaBar",Int2Int64(CurKarma),Int2Int64(0),Int2Int64(MaxKarma));
			Class'UIAPI_TEXTBOX'.SetText("NPHRN_BeltWnd.XP","Karma");
		} else {
			Class'UIAPI_WINDOW'.HideWindow("NPHRN_BeltWnd.KarmaBar");
			Class'UIAPI_WINDOW'.ShowWindow("NPHRN_BeltWnd.ExpBar");
			Class'UIAPI_TEXTBOX'.SetText("NPHRN_BeltWnd.XP","XP");
			Class'UIAPI_STATUSBARCTRL'.SetPointExp("NPHRN_BeltWnd.EXPBar",L2jBRVar28.nCurExp,L2jBRVar28.nLevel);
		}
	}
	L2jBRFunction86();
}

function L2jBRFunction42()
{
	local int L2jBRVar148;
	local int L2jBRVar15_;
	local InventoryWnd L2jBRVar21;

	L2jBRVar21 = InventoryWnd(GetScript("InventoryWnd"));
	L2jBRVar15_ = UnknownFunction146(UnknownFunction146(L2jBRVar21.m_invenItem.GetItemNum(),L2jBRVar21.m_questItem.GetItemNum()),L2jBRVar21.EquipItemGetItemNum());
	L2jBRVar148 = L2jBRVar21.GetMyInventoryLimit();
	L2jBRVar147.SetText(UnknownFunction112(UnknownFunction112(string(L2jBRVar15_),"/"),string(L2jBRVar148)));
}

function L2jBRFunction64 ()
{
	if ( IsShowWindow("InventoryWnd") )
	{
		HideWindow("InventoryWnd");
		PlaySound("InterfaceSound.inventory_close_01");
	} else {
		ExecuteEvent(2631);
		PlaySound("InterfaceSound.inventory_open_01");
	}
}

function L2jBRFunction22 ()
{
	if ( L2jBRVar146.IsShowWindow() )
	{
		L2jBRVar146.HideWindow();
		PlaySound("InterfaceSound.charstat_close_01");
		L2jBRVar163.SetText("OFF");
	} else {
		L2jBRVar146.ShowWindow();
		L2jBRVar146.SetFocus();
		PlaySound("InterfaceSound.charstat_open_01");
		L2jBRVar163.SetText("ON");
	}
}

function L2jBRFunction84 ()
{
	if ( UnknownFunction242(Class'UIAPI_WINDOW'.IsShowWindow("ClanWnd"),True) )
	{
		Class'UIAPI_WINDOW'.HideWindow("ClanWnd");
		PlaySound("InterfaceSound.Charstat_Close_01");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("ClanWnd");
		PlaySound("InterfaceSound.Charstat_Open_01");
	}
}

function L2jBRFunction86()
{
	local UserInfo L2jBRVar28;
	local string L2jBRVar14;

	GetPlayerInfo(L2jBRVar28);
	L2jBRVar14 = MakeCostString(string(GetAdena()));
	if ( L2jBRVar144 )
	{
		L2jBRVar143.SetText(L2jBRVar14);
		L2jBRVar143.SetTooltipString(ConvertNumToText(string(GetAdena())));
		SetOptionBool("Neophron","DisplayAdena",True);
	} else {
		if ( UnknownFunction155(GetOptionInt("Neophron","ShowCount"),0) )
		{
			L2jBRVar143.SetText(UnknownFunction112(UnknownFunction112(UnknownFunction112("PVP/PK: ",string(L2jBRVar28.nDualCount))," / "),string(L2jBRVar28.nPKCount)));
		} else {
			L2jBRVar143.SetText("Display Adena Info");
			L2jBRVar143.SetTooltipString(ConvertNumToText(string(GetAdena())));
		}
		SetOptionBool("Neophron","DisplayAdena",False);
	}
}

function OnLButtonUp (WindowHandle L2jBRVar20, int X, int Y)
{
	local string L2jBRVar14;

	switch (L2jBRVar20)
	{
		case L2jBRVar145:
		L2jBRFunction64();
		break;
		case L2jBRVar143:
		if ( L2jBRVar144 )
		{
			L2jBRVar144 = False;
		} else {
			L2jBRVar144 = True;
		}
		L2jBRFunction86();
		PlaySound("InterfaceSound.click_01");
		break;
		case L2jBRVar163:
		L2jBRFunction22();
		break;
		case L2jBRVar164:
		L2jBRFunction84();
		break;
		default:
	}
}

function L2jBRFunction87 ()
{
	local Rect Rect;

	Rect = Class'UIAPI_WINDOW'.GetRect("NPHRN_BeltWnd.Subdivide");
	Class'UIAPI_WINDOW'.MoveTo("NPHRN_BeltWnd.Subdivide.Divider1",Rect.nX,Rect.nY);
	Class'UIAPI_WINDOW'.MoveTo("NPHRN_BeltWnd.Subdivide.Divider2",Rect.nX,Rect.nY);
	Class'UIAPI_WINDOW'.MoveTo("NPHRN_BeltWnd.Subdivide.Divider3",Rect.nX,Rect.nY);
	Class'UIAPI_WINDOW'.MoveTo("NPHRN_BeltWnd.Subdivide.Divider4",Rect.nX,Rect.nY);
	Class'UIAPI_WINDOW'.MoveTo("NPHRN_BeltWnd.Subdivide.Divider5",Rect.nX,Rect.nY);
	Class'UIAPI_WINDOW'.MoveTo("NPHRN_BeltWnd.Subdivide.Divider6",Rect.nX,Rect.nY);
	Class'UIAPI_WINDOW'.MoveTo("NPHRN_BeltWnd.Subdivide.Divider7",Rect.nX,Rect.nY);
	Class'UIAPI_WINDOW'.MoveTo("NPHRN_BeltWnd.Subdivide.Divider8",Rect.nX,Rect.nY);
	Class'UIAPI_WINDOW'.Move("NPHRN_BeltWnd.Subdivide.Divider1",UnknownFunction145(Rect.nWidth,9),0);
	Class'UIAPI_WINDOW'.Move("NPHRN_BeltWnd.Subdivide.Divider2",UnknownFunction144(UnknownFunction145(Rect.nWidth,9),2),0);
	Class'UIAPI_WINDOW'.Move("NPHRN_BeltWnd.Subdivide.Divider3",UnknownFunction144(UnknownFunction145(Rect.nWidth,9),3),0);
	Class'UIAPI_WINDOW'.Move("NPHRN_BeltWnd.Subdivide.Divider4",UnknownFunction144(UnknownFunction145(Rect.nWidth,9),4),0);
	Class'UIAPI_WINDOW'.Move("NPHRN_BeltWnd.Subdivide.Divider5",UnknownFunction144(UnknownFunction145(Rect.nWidth,9),5),0);
	Class'UIAPI_WINDOW'.Move("NPHRN_BeltWnd.Subdivide.Divider6",UnknownFunction144(UnknownFunction145(Rect.nWidth,9),6),0);
	Class'UIAPI_WINDOW'.Move("NPHRN_BeltWnd.Subdivide.Divider7",UnknownFunction144(UnknownFunction145(Rect.nWidth,9),7),0);
	Class'UIAPI_WINDOW'.Move("NPHRN_BeltWnd.Subdivide.Divider8",UnknownFunction144(UnknownFunction145(Rect.nWidth,9),8),0);
}

defaultproperties
{
    L2jBRVar13="NPHRN_BeltWnd"

}
