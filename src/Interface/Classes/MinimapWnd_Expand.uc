//================================================================================
// MinimapWnd_Expand.
//================================================================================

class MinimapWnd_Expand extends UICommonAPI;

var int m_PartyMemberCount;
var int m_PartyLocIndex;
var bool m_AdjustCursedLoc;
var int m_SSQStatus;
var bool m_bShowSSQType;
var bool m_bShowCurrentLocation;
var bool m_bShowGameTime;
var array<ResolutionInfo> ResolutionList;
var WindowHandle m_hMinimapWnd;
var WindowHandle MiniMapCtrl;
const N_BUTTON_HEAD_AREA_BUFFER= 90;
const N_MAX_MINI_MAP_RES_Y= 1024;
const N_MAX_MINI_MAP_RES_X= 1024;

function OnLoad ()
{
	m_PartyLocIndex = -1;
	m_PartyMemberCount = GetPartyMemberCount();
	RegisterEvent(520);
	RegisterEvent(1790);
	RegisterEvent(1800);
	RegisterEvent(1810);
	RegisterEvent(1820);
	RegisterEvent(1830);
	RegisterEvent(1840);
	RegisterEvent(1850);
	RegisterEvent(1860);
	RegisterEvent(2900);
	RegisterEvent(2420);
	RegisterEvent(1870);
	RegisterEvent(1880);
	RegisterEvent(1890);
	m_AdjustCursedLoc = False;
	GetResolutionList(ResolutionList);
	MiniMapCtrl = GetHandle("MinimapWnd_Expand.Minimap");
	m_hMinimapWnd = GetHandle("MinimapWnd_Expand");
	m_bShowSSQType = True;
	m_bShowCurrentLocation = True;
	m_bShowGameTime = True;
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 520:
		HandlePartyMemberChanged(_L2jBRVar17_);
		break;
		case 1790:
		HandleMinimapAddTarget(_L2jBRVar17_);
		break;
		case 1800:
		HandleMinimapDeleteTarget(_L2jBRVar17_);
		break;
		case 1810:
		HandleMinimapDeleteAllTarget();
		break;
		case 1820:
		HandleMinimapShowQuest();
		break;
		case 1830:
		HandleMinimapHideQuest();
		break;
		case 1840:
		AdjustMapToPlayerPosition(True);
		break;
		case 1850:
		if ( UnknownFunction129(IsShowWindow("MinimapWnd_Expand")) )
		{
			return;
		}
		HandleCursedWeaponList(_L2jBRVar17_);
		break;
		case 1860:
		if ( UnknownFunction129(IsShowWindow("MinimapWnd_Expand")) )
		{
			return;
		}
		HandleCursedWeaponLoctaion(_L2jBRVar17_);
		break;
		case 2420:
		SetCurrentLocation();
		break;
		case 1870:
		Class'UIAPI_WINDOW'.ShowWindow("MinimapWnd_Expand.btnReduce");
		break;
		case 1880:
		Class'UIAPI_WINDOW'.HideWindow("MinimapWnd_Expand.btnReduce");
		break;
		case 1890:
		if ( m_bShowGameTime )
		{
			HandleUpdateGameTime(_L2jBRVar17_);
		}
		break;
		case 2900:
		HandleResolutionChanged(_L2jBRVar17_);
		break;
		default:
	}
}

function OnShow ()
{
	AdjustMapToPlayerPosition(True);
	Class'AudioAPI'.PlaySound("interfacesound.Interface.map_open_01");
	SetSSQTypeText();
	SetCurrentLocation();
	CheckResolution();
	Class'MiniMapAPI'.RequestCursedWeaponList();
	Class'MiniMapAPI'.RequestCursedWeaponLocation();
}

function HandleResolutionChanged (string aParam)
{
	local int NewWidth;
	local int NewHeight;

	ParseInt(aParam,"NewWidth",NewWidth);
	ParseInt(aParam,"NewHeight",NewHeight);
	ResetMiniMapSize(NewWidth,NewHeight);
}

function SetSSQTypeText ()
{
	local string SSQText;
	local MinimapWnd MinimapWndScript;

	MinimapWndScript = MinimapWnd(GetScript("MinimapWnd"));
	switch (MinimapWndScript.m_SSQStatus)
	{
		case 0:
		SSQText = GetSystemString(973);
		break;
		case 1:
		SSQText = GetSystemString(974);
		break;
		case 2:
		SSQText = GetSystemString(975);
		break;
		case 3:
		SSQText = GetSystemString(976);
		break;
		default:
	}
	Class'UIAPI_TEXTBOX'.SetText("Minimapwnd_Expand.txtVarSSQType",SSQText);
}

function SetCurrentLocation ()
{
	local string ZoneName;

	ZoneName = GetCurrentZoneName();
	Class'UIAPI_TEXTBOX'.SetText("Minimapwnd_Expand.txtVarCurLoc",ZoneName);
}

function CheckResolution ()
{
	local int CurrentMaxWidth;
	local int CurrentMaxHeight;

	Debug("MinimapExpand - Checkresolution");
	GetCurrentResolution(CurrentMaxWidth,CurrentMaxHeight);
	Debug(UnknownFunction168("현재 해상도X:",string(CurrentMaxWidth)));
	Debug(UnknownFunction168("현재 해상도Y:",string(CurrentMaxHeight)));
	ResetMiniMapSize(CurrentMaxWidth,CurrentMaxHeight);
}

function ResetMiniMapSize (int CurrentWidth, int CurrentHeight)
{
	local int adjustedwidth;
	local int adjustedheight;
	local int MainMapWidth;
	local int MainMapHeight;

	Debug("MinimapExpandWnd - ResetMinimapSize");
	MainMapWidth = CurrentWidth;
	MainMapHeight = CurrentHeight;
	adjustedwidth = UnknownFunction147(CurrentWidth,UnknownFunction145(UnknownFunction144(CurrentWidth,3),100));
	adjustedheight = UnknownFunction147(CurrentHeight,90);
	if ( UnknownFunction151(CurrentWidth,1024) )
	{
		adjustedwidth = UnknownFunction147(1024,8);
		MainMapWidth = 1024;
	}
	if ( UnknownFunction151(CurrentHeight,1024) )
	{
		adjustedheight = UnknownFunction147(1024,90);
		MainMapHeight = 1024;
	}
	m_hMinimapWnd.SetWindowSize(MainMapWidth,MainMapHeight);
	MiniMapCtrl.SetWindowSize(adjustedwidth,adjustedheight);
	OnClickMyLocButton();
}

function OnHide ()
{
	Class'AudioAPI'.PlaySound("interfacesound.Interface.map_close_01");
}

function HandlePartyMemberChanged (string _L2jBRVar17_)
{
	ParseInt(_L2jBRVar17_,"PartyMemberCount",m_PartyMemberCount);
}

function HandleMinimapAddTarget (string _L2jBRVar17_)
{
	local Vector Loc;

	if ( UnknownFunction130(UnknownFunction130(ParseFloat(_L2jBRVar17_,"X",Loc.X),ParseFloat(_L2jBRVar17_,"Y",Loc.Y)),ParseFloat(_L2jBRVar17_,"Z",Loc.Z)) )
	{
		Class'UIAPI_MINIMAPCTRL'.AddTarget("MinimapWnd_Expand.Minimap",Loc);
		Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd_Expand.Minimap",Loc,False,False);
	}
}

function HandleMinimapDeleteTarget (string _L2jBRVar17_)
{
	local Vector Loc;
	local int LocX;
	local int LocY;
	local int LocZ;

	if ( UnknownFunction130(UnknownFunction130(ParseInt(_L2jBRVar17_,"X",LocX),ParseInt(_L2jBRVar17_,"Y",LocY)),ParseInt(_L2jBRVar17_,"Z",LocZ)) )
	{
		Loc.X = LocX;
		Loc.Y = LocY;
		Loc.Z = LocZ;
		Class'UIAPI_MINIMAPCTRL'.DeleteTarget("MinimapWnd_Expand.Minimap",Loc);
	}
}

function HandleMinimapDeleteAllTarget ()
{
	Class'UIAPI_MINIMAPCTRL'.DeleteAllTarget("MinimapWnd_Expand.Minimap");
}

function HandleMinimapShowQuest ()
{
	Debug("MinimapWnd_Expand.HandleMinimapShowQuest");
	Class'UIAPI_MINIMAPCTRL'.SetShowQuest("MinimapWnd_Expand.Minimap",True);
}

function HandleMinimapHideQuest ()
{
	Debug("MinimapWnd_Expand.HandleMinimapHideQuest");
	Class'UIAPI_MINIMAPCTRL'.SetShowQuest("MinimapWnd_Expand.Minimap",False);
}

function RequestCursedWeaponLocation ()
{
	Debug("MinimapWnd_Expand.RequestCursedweaponLocation");
}

function OnComboBoxItemSelected (string sName, int Index)
{
	local int CursedweaponComboBoxCurrentReservedData;

	if ( UnknownFunction122(sName,"CursedComboBox") )
	{
		CursedweaponComboBoxCurrentReservedData = Class'UIAPI_COMBOBOX'.GetReserved("MinimapWnd_Expand.CursedComboBox",Index);
	}
}

function OnClickButton (string a_ButtonID)
{
	switch (a_ButtonID)
	{
		case "TargetButton":
		OnClickTargetButton();
		break;
		case "MyLocButton":
		OnClickMyLocButton();
		break;
		case "PartyLocButton":
		OnClickPartyLocButton();
		break;
		case "Pursuit":
		m_AdjustCursedLoc = True;
		Class'MiniMapAPI'.RequestCursedWeaponLocation();
		break;
		case "CollapseButton":
		OnClickCollapseButton();
		break;
		case "btnReduce":
		Class'UIAPI_MINIMAPCTRL'.RequestReduceBtn("MinimapWnd_Expand.Minimap");
		Class'UIAPI_WINDOW'.HideWindow("MinimapWnd_Expand.btnReduce");
		break;
		default:
	}
}

function OnClickCollapseButton ()
{
	local MinimapWnd MinimapWndScript;

	MinimapWndScript = MinimapWnd(GetScript("MinimapWnd"));
	MinimapWndScript.SetExpandState(False);
	m_hMinimapWnd.HideWindow();
	ShowWindowWithFocus("MinimapWnd");
}

function OnClickTargetButton ()
{
	local Vector QuestLocation;

	if ( GetQuestLocation(QuestLocation) )
	{
		Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd_Expand.Minimap",QuestLocation);
	}
}

function OnClickMyLocButton ()
{
	AdjustMapToPlayerPosition(True);
}

function AdjustMapToPlayerPosition (bool a_ZoomToTownMap)
{
	local Vector PlayerPosition;

	PlayerPosition = GetPlayerPosition();
	Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd_Expand.Minimap",PlayerPosition,a_ZoomToTownMap);
}

function OnClickPartyLocButton ()
{
	local Vector PartyMemberLocation;

	m_PartyMemberCount = GetPartyMemberCount();
	if ( UnknownFunction154(0,m_PartyMemberCount) )
	{
		return;
	}
	m_PartyLocIndex = int(UnknownFunction173(UnknownFunction146(m_PartyLocIndex,1),m_PartyMemberCount));
	if ( GetPartyMemberLocation(m_PartyLocIndex,PartyMemberLocation) )
	{
		Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd_Expand.Minimap",PartyMemberLocation,False);
	}
}

function HandleCursedWeaponList (string L2jBRVar1)
{
	local int Num;
	local int L2jBRVar39;
	local int i;
	local string cursedName;

	ParseInt(L2jBRVar1,"NUM",Num);
	Class'UIAPI_COMBOBOX'.Clear("MinimapWnd_Expand.CursedComboBox");
	i = 0;
	if ( UnknownFunction150(i,UnknownFunction146(Num,1)) )
	{
		if ( UnknownFunction154(i,0) )
		{
			Class'UIAPI_COMBOBOX'.AddStringWithReserved("MinimapWnd_Expand.CursedComboBox",GetSystemString(1463),0);
		}
		ParseInt(L2jBRVar1,UnknownFunction112("ID",string(UnknownFunction147(i,1))),L2jBRVar39);
		ParseString(L2jBRVar1,UnknownFunction112("NAME",string(UnknownFunction147(i,1))),cursedName);
		Class'UIAPI_COMBOBOX'.AddStringWithReserved("MinimapWnd_Expand.CursedComboBox",cursedName,L2jBRVar39);
		Class'UIAPI_COMBOBOX'.SetSelectedNum("MinimapWnd_Expand.CursedComboBox",0);
		UnknownFunction163(i);
		goto JL004D;
	}
	Class'UIAPI_MINIMAPCTRL'.DeleteAllTarget("MinimapWnd_Expand.Minimap");
}

function HandleCursedWeaponLoctaion (string L2jBRVar1)
{
	local int Num;
	local int L2jBRVar39;
	local int itemID1;
	local int itemID2;
	local int isowndedo;
	local int isownded1;
	local int isownded2;
	local int X;
	local int Y;
	local int Z;
	local int i;
	local Vector CursedWeaponLoc1;
	local Vector CursedWeaponLoc2;
	local int CursedWeaponComboCurrentData;
	local string combocursedName;
	local string cursedName;
	local string cursedName1;
	local string cursedName2;
	local Vector cursedWeaponLocation;
	local bool combined;

	ParseInt(L2jBRVar1,"NUM",Num);
	if ( UnknownFunction154(Num,0) )
	{
		if ( m_AdjustCursedLoc )
		{
			Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd_Expand.Minimap",GetPlayerPosition());
		}
		Class'UIAPI_MINIMAPCTRL'.DeleteAllCursedWeaponIcon("MinimapWnd_Expand.Minimap");
		return;
	} else {
		i = 0;
		if ( UnknownFunction150(i,Num) )
		{
			ParseInt(L2jBRVar1,UnknownFunction112("ID",string(i)),L2jBRVar39);
			ParseString(L2jBRVar1,UnknownFunction112("NAME",string(i)),cursedName);
			ParseInt(L2jBRVar1,UnknownFunction112("ISOWNED",string(i)),isowndedo);
			ParseInt(L2jBRVar1,UnknownFunction112("X",string(i)),X);
			ParseInt(L2jBRVar1,UnknownFunction112("Y",string(i)),Y);
			ParseInt(L2jBRVar1,UnknownFunction112("Z",string(i)),Z);
			cursedWeaponLocation.X = X;
			cursedWeaponLocation.Y = Y;
			cursedWeaponLocation.Z = Z;
			UnknownFunction226(cursedWeaponLocation);
			switch (i)
			{
				case 0:
				itemID1 = L2jBRVar39;
				cursedName1 = cursedName;
				isownded1 = isowndedo;
				CursedWeaponLoc1.X = cursedWeaponLocation.X;
				CursedWeaponLoc1.Y = cursedWeaponLocation.Y;
				CursedWeaponLoc1.Z = cursedWeaponLocation.Z;
				UnknownFunction226(CursedWeaponLoc1);
				break;
				case 1:
				itemID2 = L2jBRVar39;
				cursedName2 = cursedName;
				isownded2 = isowndedo;
				CursedWeaponLoc2.X = cursedWeaponLocation.X;
				CursedWeaponLoc2.Y = cursedWeaponLocation.Y;
				CursedWeaponLoc2.Z = cursedWeaponLocation.Z;
				UnknownFunction226(CursedWeaponLoc2);
				break;
				default:
			}
			UnknownFunction163(i);
			goto JL008F;
		}
	}
	if ( m_AdjustCursedLoc )
	{
		m_AdjustCursedLoc = False;
		CursedWeaponComboCurrentData = Class'UIAPI_COMBOBOX'.GetSelectedNum("MinimapWnd_Expand.CursedComboBox");
		combocursedName = Class'UIAPI_COMBOBOX'.GetString("MinimapWnd_Expand.CursedComboBox",CursedWeaponComboCurrentData);
		if ( UnknownFunction122(combocursedName,cursedName1) )
		{
			Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd_Expand.Minimap",CursedWeaponLoc1,False);
		} else {
			if ( UnknownFunction122(combocursedName,cursedName2) )
			{
				Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd_Expand.Minimap",CursedWeaponLoc2,False);
			} else {
				AdjustMapToPlayerPosition(True);
			}
		}
	} else {
		if ( UnknownFunction154(Num,1) )
		{
			DrawCursedWeapon("MinimapWnd_Expand.Minimap",itemID1,cursedName1,CursedWeaponLoc1,UnknownFunction154(isownded1,0),True);
		} else {
			if ( UnknownFunction154(Num,2) )
			{
				combined = Class'UIAPI_MINIMAPCTRL'.IsOverlapped("MinimapWnd_Expand.Minimap",int(CursedWeaponLoc1.X),int(CursedWeaponLoc1.Y),int(CursedWeaponLoc2.X),int(CursedWeaponLoc2.Y));
				if ( combined )
				{
					Class'UIAPI_MINIMAPCTRL'.DrawGridIcon("MinimapWnd_Expand.Minimap","L2UI_CH3.MiniMap.cursedmapicon00","L2UI_CH3.MiniMap.cursedmapicon00",CursedWeaponLoc1,True,0,-12,UnknownFunction112(UnknownFunction112(cursedName1,"\n"),cursedName2));
				} else {
					Debug(UnknownFunction168(UnknownFunction168("ownded:",string(isownded1)),string(isownded2)));
					DrawCursedWeapon("MinimapWnd_Expand.Minimap",itemID1,cursedName1,CursedWeaponLoc1,UnknownFunction154(isownded1,0),True);
					DrawCursedWeapon("MinimapWnd_Expand.Minimap",itemID2,cursedName2,CursedWeaponLoc2,UnknownFunction154(isownded2,0),False);
				}
			}
		}
	}
}

function DrawCursedWeapon (string WindowName, int L2jBRVar39, string cursedName, Vector vecLoc, bool bDropped, bool bRefresh)
{
	local string itemIconName;

	if ( UnknownFunction154(L2jBRVar39,8190) )
	{
		itemIconName = "L2UI_CH3.MiniMap.cursedmapicon01";
	} else {
		if ( UnknownFunction154(L2jBRVar39,8689) )
		{
			itemIconName = "L2UI_CH3.MiniMap.cursedmapicon02";
		}
	}
	if ( bDropped )
	{
		itemIconName = UnknownFunction112(itemIconName,"_drop");
	}
	Class'UIAPI_MINIMAPCTRL'.DrawGridIcon(WindowName,itemIconName,"L2UI_CH3.MiniMap.cursedmapicon00",vecLoc,bRefresh,0,-12,cursedName);
}

function HandleUpdateGameTime (string _L2jBRVar17_)
{
	local int GameHour;
	local int GameMinute;
	local string GameTimeString;

	ParseInt(_L2jBRVar17_,"GameHour",GameHour);
	ParseInt(_L2jBRVar17_,"GameMinute",GameMinute);
	SelectSunOrMoon(GameHour);
	if ( UnknownFunction153(GameHour,12) )
	{
		GameTimeString = "PM ";
		UnknownFunction162(GameHour,12);
	} else {
		GameTimeString = "AM ";
	}
	if ( UnknownFunction154(GameHour,0) )
	{
		GameHour = 12;
	}
	if ( UnknownFunction150(GameHour,10) )
	{
		GameTimeString = UnknownFunction112(UnknownFunction112(UnknownFunction112(GameTimeString,"0"),string(GameHour))," : ");
	} else {
		GameTimeString = UnknownFunction112(UnknownFunction112(GameTimeString,string(GameHour))," : ");
	}
	if ( UnknownFunction150(GameMinute,10) )
	{
		GameTimeString = UnknownFunction112(UnknownFunction112(GameTimeString,"0"),string(GameMinute));
	} else {
		GameTimeString = UnknownFunction112(GameTimeString,string(GameMinute));
	}
	Class'UIAPI_TEXTBOX'.SetText("MinimapWnd_Expand.txtGameTime",GameTimeString);
}

function SelectSunOrMoon (int GameHour)
{
	if ( UnknownFunction130(UnknownFunction153(GameHour,6),UnknownFunction152(GameHour,24)) )
	{
		Class'UIAPI_WINDOW'.ShowWindow("MinimapWnd_Expand.texSun");
		Class'UIAPI_WINDOW'.HideWindow("MinimapWnd_Expand.texMoon");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("MinimapWnd_Expand.texMoon");
		Class'UIAPI_WINDOW'.HideWindow("MinimapWnd_Expand.texSun");
	}
}

