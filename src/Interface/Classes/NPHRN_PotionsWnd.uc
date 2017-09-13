//================================================================================
// NPHRN_PotionsWnd.
//================================================================================

class NPHRN_PotionsWnd extends UICommonAPI;

const L2jBRVar54 = 1000;
const L2jBRVar131 = 100;
const L2jBRVar132 = 200;
const L2jBRVar133 = 1000;
const L2jBRVar135 = 14000;
const L2jBRVar134 = 500;
const L2jBRVar136 = 728;
var int L2jBRVar55;
var WindowHandle m_hOptWnd;
var WindowHandle L2jBRVar12;
var ItemWindowHandle L2jBRVar56;
var ItemWindowHandle L2jBRVar57;
var ItemWindowHandle L2jBRVar58;
var ItemWindowHandle L2jBRVar191;
var ItemInfo L2jBRVar59;
var ItemInfo L2jBRVar60;
var ItemInfo L2jBRVar61;
var bool L2jBRVar193;
var bool L2jBRVar194;
var bool L2jBRVar62;
var bool L2jBRVar63;
var bool L2jBRVar192;
var TextureHandle L2jBRVar64;
var TextureHandle L2jBRVar65;
var TextureHandle L2jBRVar66;
var TextBoxHandle L2jBRVar67;
var TextBoxHandle L2jBRVar75;
var TextBoxHandle L2jBRVar68;
var bool L2jBRVar195;
var bool L2jBRVar196;
var bool L2jBRVar69;
var bool L2jBRVar198;
const L2jBRVar197 = 1061;
const L2jBRVar70 = 1539;
const L2jBRVar71 = 5592;
const L2jBRVar72 = 1500;
const L2jBRVar200 = 10210;
const L2jBRVar73 = 10202;
const L2jBRVar74 = 10201;
const L2jBRVar199 = 10200;

function OnLoad ()
{
	if ( UnknownFunction242(GetOptionBool("Unload","PotionsWnd"),True) )
	{
		Class'UIAPI_WINDOW'.HideWindow("NPHRN_PotionsWnd");
		return;
	}
	OnRegisterEvent();
	L2jBRFunction2();
	L2jBRVar63 = False;
	L2jBRVar64.HideWindow();
	L2jBRVar65.HideWindow();
	L2jBRVar66.HideWindow();
	L2jBRVar67.HideWindow();
	L2jBRVar75.HideWindow();
	L2jBRVar68.HideWindow();
}

function OnDefaultPosition ()
{
	Class'UIAPI_WINDOW'.SetAnchor("NPHRN_PotionsWnd","MenuWnd","TopCenter","TopCenter",8,-29);
}

function OnRegisterEvent ()
{
	RegisterEvent(150);
	RegisterEvent(230);
	RegisterEvent(190);
	RegisterEvent(210);
}

function L2jBRFunction2 ()
{
	L2jBRVar12 = GetHandle("NPHRN_PotionsWnd");
	L2jBRVar56 = ItemWindowHandle(GetHandle("InventoryWnd.InventoryItem"));
	L2jBRVar57 = ItemWindowHandle(GetHandle("NPHRN_PotionsWnd.BoxCP"));
	_L2jBRVar58 = ItemWindowHandle(GetHandle("NPHRN_PotionsWnd.BoxHP"));
	L2jBRVar191 = ItemWindowHandle(GetHandle("NPHRN_PotionsWnd.BoxMP"));
	L2jBRVar64 = TextureHandle(GetHandle("NPHRN_PotionsWnd.ToggleCP"));
	L2jBRVar65 = TextureHandle(GetHandle("NPHRN_PotionsWnd.ToggleHP"));
	L2jBRVar66 = TextureHandle(GetHandle("NPHRN_PotionsWnd.ToggleMP"));
	L2jBRVar67 = TextBoxHandle(GetHandle("NPHRN_PotionsWnd.CountCP"));
	L2jBRVar75 = TextBoxHandle(GetHandle("NPHRN_PotionsWnd.CountHP"));
	L2jBRVar68 = TextBoxHandle(GetHandle("NPHRN_PotionsWnd.CountMP"));
}

function L2jBRFunction90 ()
{
	L2jBRFunction89(5592,L2jBRVar59);
	if ( UnknownFunction153(L2jBRVar59.ItemNum,1) )
	{
		L2jBRFunction101(L2jBRVar59);
	}
	if ( UnknownFunction154(GetOptionInt("Potions","Type_HP"),1539) )
	{
		L2jBRVar55 = 1539;
	} else {
		L2jBRVar55 = 1061;
	}
	L2jBRFunction89(L2jBRVar55,L2jBRVar60);
	if ( UnknownFunction153(L2jBRVar60.ItemNum,1) )
	{
		L2jBRFunction37(L2jBRVar60);
	}
	L2jBRFunction89(728,L2jBRVar61);
	if ( UnknownFunction153(L2jBRVar61.ItemNum,1) )
	{
		L2jBRFunction38(L2jBRVar61);
	}
}

function L2jBRFunction89 (int L2jBRVar39, out ItemInfo Info)
{
	local int Index;
	local ItemInfo 	L2jBRVar201;

	Index = L2jBRVar56.FindItemWithClassID(L2jBRVar39);
	if ( L2jBRVar56.GetItem(Index,	L2jBRVar201) )
	{
		Info = 	L2jBRVar201;
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "BtnSetting":
		if ( L2jBRVar198 )
		{
			if ( UnknownFunction151(L2jBRVar57.GetItemNum(),0) )
			{
				L2jBRFunction102(L2jBRVar57);
			}
			if ( UnknownFunction151(_L2jBRVar58.GetItemNum(),0) )
			{
				L2jBRFunction102(_L2jBRVar58);
			}
			if ( UnknownFunction151(L2jBRVar191.GetItemNum(),0) )
			{
				L2jBRFunction102(L2jBRVar191);
			}
			_‘
			L2jBRVar198 = False;
		} else {
			if ( UnknownFunction151(L2jBRVar57.GetItemNum(),0) )
			{
				
				L2jBRFunction99(L2jBRVar57);
			}
			if ( UnknownFunction151(_L2jBRVar58.GetItemNum(),0) )
			{
				
				L2jBRFunction99(_L2jBRVar58);
			}
			if ( UnknownFunction151(L2jBRVar191.GetItemNum(),0) )
			{
				
				L2jBRFunction99(L2jBRVar191);
			}
			L2jBRVar198 = True;
		}
		default:
	}
}

function OnTimer (int TimerID)
{
	if ( UnknownFunction154(TimerID,10200) )
	{
		L2jBRVar12.KillTimer(10200);
		L2jBRFunction103(L2jBRVar67,L2jBRVar57,5592);
		L2jBRFunction39(230);
	}
	if ( UnknownFunction154(TimerID,10201) )
	{
		L2jBRVar12.KillTimer(10201);
		L2jBRFunction103(L2jBRVar75,_L2jBRVar58,L2jBRVar55);
		L2jBRFunction39(190);
	}
	if ( UnknownFunction154(TimerID,10202) )
	{
		L2jBRVar12.KillTimer(10202);
		L2jBRFunction103(L2jBRVar68,L2jBRVar191,728);
		L2jBRFunction39(210);
	}
	if ( UnknownFunction154(TimerID,10210) )
	{
		L2jBRVar12.KillTimer(10210);
		L2jBRFunction90();
	}
}

function L2jBRFunction100 ()
{
	L2jBRVar12.KillTimer(10200);
	L2jBRVar12.KillTimer(10201);
	L2jBRVar12.KillTimer(10202);
	L2jBRVar195 = False;
	L2jBRVar196 = False;
	L2jBRVar69 = False;
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 150:
		L2jBRFunction35();
		break;
		case 50:
		L2jBRFunction100();
		break;
		case 230:
		if ( L2jBRVar193 )
		{
			if ( UnknownFunction129(L2jBRVar195) )
			{
				L2jBRFunction39(L2jBRVar16);
			}
		}
		break;
		case 190:
		if ( L2jBRVar194 )
		{
			if ( UnknownFunction129(L2jBRVar196) )
			{
				L2jBRFunction39(L2jBRVar16);
			}
		}
		break;
		case 210:
		if ( L2jBRVar62 )
		{
			if ( UnknownFunction129(L2jBRVar69) )
			{
				L2jBRFunction39(L2jBRVar16);
			}
		}
		break;
		default:
	}
}

function L2jBRFunction35 ()
{
	L2jBRFunction100();
	L2jBRVar12.SetTimer(10210,1500);
}

function OnDropItem (string L2jBRVar18, ItemInfo L2jBRVar19, int X, int Y)
{
	switch (L2jBRVar18)
	{
		case "BoxCP":
		L2jBRFunction101(L2jBRVar19);
		break;
		case "BoxHP":
		L2jBRFunction37(L2jBRVar19);
		break;
		case "BoxMP":
		L2jBRFunction38(L2jBRVar19);
		break;
		default:
	}
}

function L2jBRFunction101 (ItemInfo L2jBRVar19)
{
	if ( UnknownFunction155(L2jBRVar19.ClassID,5592) )
	{
		AddSystemMessage(L2jBRFunction36("Remain",L2jBRVar59),L2jBRFunction10("System"));
		return;
	}
	L2jBRVar195 = False;
	L2jBRVar57.Clear();
	L2jBRVar59 = L2jBRVar19;
	L2jBRVar57.AddItem(L2jBRVar19);
	L2jBRVar67.ShowWindow();
	L2jBRFunction103(L2jBRVar67,L2jBRVar57,5592);
}

function L2jBRFunction37 (ItemInfo L2jBRVar19)
{
	if ( UnknownFunction130(UnknownFunction155(L2jBRVar19.ClassID,1539),UnknownFunction155(L2jBRVar19.ClassID,1061)) )
	{
		AddSystemMessage(L2jBRFunction36("Remain",L2jBRVar60),L2jBRFunction10("System"));
		return;
	}
	L2jBRVar196 = False;
	_L2jBRVar58.Clear();
	L2jBRVar60 = L2jBRVar19;
	_L2jBRVar58.AddItem(L2jBRVar19);
	L2jBRVar75.ShowWindow();
	SetOptionInt("Potions","Type_HP",L2jBRVar60.ClassID);
	L2jBRFunction103(L2jBRVar75,_L2jBRVar58,L2jBRVar60.ClassID);
}

function L2jBRFunction38 (ItemInfo L2jBRVar19)
{
	if ( UnknownFunction155(L2jBRVar19.ClassID,728) )
	{
		AddSystemMessage(L2jBRFunction36("Remain",L2jBRVar61),L2jBRFunction10("System"));
		return;
	}
	L2jBRVar69 = False;
	L2jBRVar191.Clear();
	L2jBRVar61 = L2jBRVar19;
	L2jBRVar191.AddItem(L2jBRVar19);
	L2jBRVar68.ShowWindow();
	L2jBRFunction103(L2jBRVar68,L2jBRVar191,728);
}

function L2jBRFunction103 (TextBoxHandle L2jBRVar203, ItemWindowHandle L2jBRVar204, int L2jBRVar202)
{
	local int Index;
	local ItemInfo L2jBRVar19;

	Index = L2jBRVar56.FindItemWithClassID(L2jBRVar202);
	L2jBRVar56.GetItem(Index,L2jBRVar19);
	if ( UnknownFunction155(Index,-1) )
	{
		if ( UnknownFunction151(L2jBRVar19.ItemNum,99) )
		{
			
			L2jBRVar203.SetText("99+");
		} else {
			
			L2jBRVar203.SetText(UnknownFunction112("",string(L2jBRVar19.ItemNum)));
		}
	} else {
		
		L2jBRVar203.SetText("");
		L2jBRVar204.Clear();
		L2jBRFunction102(L2jBRVar204);
	}
}

function OnClickItem (string strID, int Index)
{
	if ( UnknownFunction130(UnknownFunction122(strID,"BoxCP"),UnknownFunction151(Index,-1)) )
	{
		if ( UnknownFunction129(L2jBRVar193) )
		{
			
			L2jBRFunction99(L2jBRVar57);
		} else {
			L2jBRFunction102(L2jBRVar57);
		}
	}
	if ( UnknownFunction130(UnknownFunction122(strID,"BoxHP"),UnknownFunction151(Index,-1)) )
	{
		if ( UnknownFunction129(L2jBRVar194) )
		{
			
			L2jBRFunction99(_L2jBRVar58);
		} else {
			L2jBRFunction102(_L2jBRVar58);
		}
	}
	if ( UnknownFunction130(UnknownFunction122(strID,"BoxMP"),UnknownFunction151(Index,-1)) )
	{
		if ( UnknownFunction129(L2jBRVar62) )
		{
			L2jBRFunction99(L2jBRVar191);
		} else {
			L2jBRFunction102(L2jBRVar191);
		}
	}
}

function L2jBRFunction102 (ItemWindowHandle L2jBRVar203)
{
	switch (
	L2jBRVar203)
	{
		case L2jBRVar57:
		L2jBRVar12.KillTimer(10200);
		L2jBRVar64.HideWindow();
		L2jBRVar193 = False;
		L2jBRVar195 = False;
		AddSystemMessage(L2jBRFunction36("Deactivate",L2jBRVar59),L2jBRFunction10("System"));
		break;
		case _L2jBRVar58:
		L2jBRVar12.KillTimer(10201);
		L2jBRVar65.HideWindow();
		L2jBRVar194 = False;
		L2jBRVar196 = False;
		AddSystemMessage(L2jBRFunction36("Deactivate",L2jBRVar60),L2jBRFunction10("System"));
		break;
		case L2jBRVar191:
		L2jBRVar12.KillTimer(10202);
		L2jBRVar66.HideWindow();
		L2jBRVar62 = False;
		L2jBRVar69 = False;
		AddSystemMessage(L2jBRFunction36("Deactivate",L2jBRVar61),L2jBRFunction10("System"));
		break;
		default:
	}
}

function 
L2jBRFunction99 (ItemWindowHandle L2jBRVar203)
{
	switch (
	L2jBRVar203)
	{
		case L2jBRVar57:
		L2jBRVar64.ShowWindow();
		L2jBRVar193 = True;
		ExecuteEvent(230);
		AddSystemMessage(L2jBRFunction36("Activate",L2jBRVar59),L2jBRFunction10("System"));
		break;
		case _L2jBRVar58:
		L2jBRVar65.ShowWindow();
		L2jBRVar194 = True;
		ExecuteEvent(190);
		AddSystemMessage(L2jBRFunction36("Activate",L2jBRVar60),L2jBRFunction10("System"));
		break;
		case L2jBRVar191:
		L2jBRVar66.ShowWindow();
		L2jBRVar62 = True;
		ExecuteEvent(210);
		AddSystemMessage(L2jBRFunction36("Activate",L2jBRVar61),L2jBRFunction10("System"));
		break;
		default:
	}
}

function string L2jBRFunction36 (string L2jBRVar5, ItemInfo L2jBRVar19)
{
	local string Text;

	switch (L2jBRVar5)
	{
		case "Remain":
		Text = UnknownFunction112(UnknownFunction112("This slot for ",L2jBRVar19.Name),"");
		PlaySound("ItemSound3.Sys_Impossible");
		break;
		case "Activate":
		Text = MakeFullSystemMsg(GetSystemMessage(1433),L2jBRVar19.Name);
		break;
		case "Deactivate":
		Text = MakeFullSystemMsg(GetSystemMessage(1434),L2jBRVar19.Name);
		break;
		default:
	}
	return Text;
}

function L2jBRFunction39 (int L2jBRVar16)
{
	local UserInfo UserInfo;

	GetPlayerInfo(UserInfo);
	switch (L2jBRVar16)
	{
		case 230:
		if ( L2jBRVar193 )
		{
			if ( UnknownFunction130(UnknownFunction150(UserInfo.nCurCP,UnknownFunction147(UserInfo.nMaxCP,200)),UnknownFunction155(UserInfo.nCurHP,0)) )
			{
				L2jBRVar195 = True;
				L2jBRVar12.SetTimer(10200,500);
				RequestUseItem(L2jBRVar59.ServerID);
			} else {
				L2jBRVar195 = False;
			}
		}
		break;
		case 190:
		if ( L2jBRVar194 )
		{
			if ( UnknownFunction130(UnknownFunction150(UserInfo.nCurHP,UnknownFunction147(UserInfo.nMaxHP,100)),UnknownFunction155(UserInfo.nCurHP,0)) )
			{
				L2jBRVar196 = True;
				L2jBRVar12.SetTimer(10201,14000);
				RequestUseItem(L2jBRVar60.ServerID);
			} else {
				L2jBRVar196 = False;
			}
		}
		break;
		case 210:
		if ( L2jBRVar62 )
		{
			if ( UnknownFunction130(UnknownFunction150(UserInfo.nCurMP,UnknownFunction147(UserInfo.nMaxMP,1000)),UnknownFunction155(UserInfo.nCurHP,0)) )
			{
				L2jBRVar69 = True;
				L2jBRVar12.SetTimer(10202,1000);
				RequestUseItem(L2jBRVar61.ServerID);
			} else {
				L2jBRVar69 = False;
			}
		}
		break;
		default:
	}
}

