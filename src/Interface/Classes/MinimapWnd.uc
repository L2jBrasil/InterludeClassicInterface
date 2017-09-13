//================================================================================
// MinimapWnd.
//================================================================================

class MinimapWnd extends UICommonAPI;

var int m_PartyMemberCount;
var int m_PartyLocIndex;
var int b_IsShowGuideWnd;
var bool m_AdjustCursedLoc;
var int m_SSQStatus;
var bool m_bShowSSQType;
var bool m_bShowCurrentLocation;
var bool m_bShowGameTime;
var WindowHandle m_hExpandWnd;
var WindowHandle m_hGuideWnd;
var bool m_bExpandState;

function OnLoad ()
{
	m_PartyLocIndex = -1;
	m_PartyMemberCount = GetPartyMemberCount();
	RegisterEvent(1780);
	RegisterEvent(520);
	RegisterEvent(1790);
	RegisterEvent(1800);
	RegisterEvent(1810);
	RegisterEvent(1820);
	RegisterEvent(1830);
	RegisterEvent(1840);
	RegisterEvent(1850);
	RegisterEvent(1860);
	RegisterEvent(2420);
	RegisterEvent(1870);
	RegisterEvent(1880);
	RegisterEvent(1890);
	m_AdjustCursedLoc = False;
	m_bShowSSQType = True;
	m_bShowCurrentLocation = True;
	m_bShowGameTime = True;
	m_bExpandState = False;
	m_hExpandWnd = GetHandle("MinimapWnd_Expand");
	m_hGuideWnd = GetHandle("GuideWnd");
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 1780:
		HandleShowMinimap(_L2jBRVar17_);
		break;
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
		HandleCursedWeaponList(_L2jBRVar17_);
		break;
		case 1860:
		HandleCursedWeaponLoctaion(_L2jBRVar17_);
		break;
		case 2420:
		SetCurrentLocation();
		break;
		case 1870:
		ShowWindow("MinimapWnd.Container.btnReduce");
		break;
		case 1880:
		HideWindow("MinimapWnd.Container.btnReduce");
		break;
		case 1890:
		if ( m_bShowGameTime )
		{
			HandleUpdateGameTime(_L2jBRVar17_);
		}
		break;
		default:
	}
}

function OnShow ()
{
	Debug("MinimapWnd - OnShow");
	AdjustMapToPlayerPosition(True);
	Class'AudioAPI'.PlaySound("interfacesound.Interface.map_open_01");
	if ( UnknownFunction154(b_IsShowGuideWnd,1) )
	{
		m_hGuideWnd.ShowWindow();
	}
	b_IsShowGuideWnd = 0;
	SetSSQTypeText();
	SetCurrentLocation();
	SetFocus();
}

function SetSSQTypeText ()
{
	local string SSQText;

	switch (m_SSQStatus)
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
	Class'UIAPI_TEXTBOX'.SetText("Minimapwnd.txtVarSSQType",SSQText);
}

function SetCurrentLocation ()
{
	local string ZoneName;

	ZoneName = GetCurrentZoneName();
	Class'UIAPI_TEXTBOX'.SetText("Minimapwnd.txtVarCurLoc",ZoneName);
}

function OnHide ()
{
	if ( m_hGuideWnd.IsShowWindow() )
	{
		b_IsShowGuideWnd = 1;
	}
	Class'AudioAPI'.PlaySound("interfacesound.Interface.map_close_01");
}

function HandlePartyMemberChanged (string _L2jBRVar17_)
{
	ParseInt(_L2jBRVar17_,"PartyMemberCount",m_PartyMemberCount);
}

function SetExpandState (bool bExpandState)
{
	m_bExpandState = bExpandState;
}

function bool IsExpandState ()
{
	return m_bExpandState;
}

function HandleShowMinimap (string _L2jBRVar17_)
{
	local int SSQStatus;

	Debug("HandleShowMiniap");
	if ( ParseInt(_L2jBRVar17_,"SSQStatus",SSQStatus) )
	{
		Class'UIAPI_MINIMAPCTRL'.SetSSQStatus("MinimapWnd.Minimap",SSQStatus);
		m_SSQStatus = SSQStatus;
	}
	if ( IsExpandState() )
	{
		if ( IsShowWindow("MinimapWnd_Expand") )
		{
			HideWindow("MinimapWnd_Expand");
		} else {
			HideWindow("MinimapWnd");
			ShowWindowWithFocus("MinimapWnd_Expand");
		}
	} else {
		if ( IsShowWindow("MinimapWnd") )
		{
			HideWindow("MinimapWnd");
		} else {
			HideWindow("MinimapWnd_Expand");
			ShowWindowWithFocus("MinimapWnd");
		}
	}
	if ( UnknownFunction132(IsShowWindow("MinimapWnd"),IsShowWindow("MinimapWnd_Expand")) )
	{
		Class'MiniMapAPI'.RequestCursedWeaponList();
		Class'MiniMapAPI'.RequestCursedWeaponLocation();
	}
}

function HandleMinimapAddTarget (string _L2jBRVar17_)
{
	local Vector Loc;

	Debug(UnknownFunction112("~~~MinimapWnd - HandleMiniampAddTarget~~~~~~",_L2jBRVar17_));
	if ( UnknownFunction130(UnknownFunction130(ParseFloat(_L2jBRVar17_,"X",Loc.X),ParseFloat(_L2jBRVar17_,"Y",Loc.Y)),ParseFloat(_L2jBRVar17_,"Z",Loc.Z)) )
	{
		Class'UIAPI_MINIMAPCTRL'.AddTarget("MinimapWnd.Minimap",Loc);
		Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd.Minimap",Loc,False,False);
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
		Class'UIAPI_MINIMAPCTRL'.DeleteTarget("MinimapWnd.Minimap",Loc);
	}
}

function HandleMinimapDeleteAllTarget ()
{
	Class'UIAPI_MINIMAPCTRL'.DeleteAllTarget("MinimapWnd.Minimap");
}

function HandleMinimapShowQuest ()
{
	Debug("MinimapWnd.HandleMinimapShowQuest");
	Class'UIAPI_MINIMAPCTRL'.SetShowQuest("MinimapWnd.Minimap",True);
}

function HandleMinimapHideQuest ()
{
	Debug("MinimapWnd.HandleMinimapHideQuest");
	Class'UIAPI_MINIMAPCTRL'.SetShowQuest("MinimapWnd.Minimap",False);
}

function OnComboBoxItemSelected (string sName, int Index)
{
	local int CursedweaponComboBoxCurrentReservedData;

	if ( UnknownFunction122(sName,"CursedComboBox") )
	{
		CursedweaponComboBoxCurrentReservedData = Class'UIAPI_COMBOBOX'.GetReserved("MinimapWnd.Container.CursedComboBox",Index);
	}
}

function OnClickButton (string a_ButtonID)
{
	Debug(a_ButtonID);
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
		case "OpenGuideWnd":
		if ( m_hGuideWnd.IsShowWindow() )
		{
			m_hGuideWnd.HideWindow();
		} else {
			m_hGuideWnd.ShowWindow();
		}
		break;
		case "Pursuit":
		m_AdjustCursedLoc = True;
		Class'MiniMapAPI'.RequestCursedWeaponLocation();
		break;
		case "ExpandButton":
		SetExpandState(True);
		ShowWindowWithFocus("MinimapWnd_Expand");
		HideWindow("MinimapWnd");
		break;
		case "btnReduce":
		Class'UIAPI_MINIMAPCTRL'.RequestReduceBtn("MinimapWnd.Minimap");
		HideWindow("MinimapWnd.Container.btnReduce");
		break;
		case "BtnClose":
		Class'UIAPI_WINDOW'.HideWindow("MinimapWnd");
		default:
	}
}

function OnClickTargetButton ()
{
	local Vector QuestLocation;

	if ( GetQuestLocation(QuestLocation) )
	{
		Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd.Minimap",QuestLocation);
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
	Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd.Minimap",PlayerPosition,a_ZoomToTownMap);
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
		Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd.Minimap",PartyMemberLocation,False);
	}
}

function HandleCursedWeaponList (string L2jBRVar1)
{
	local int Num;
	local int L2jBRVar39;
	local int i;
	local string cursedName;

	ParseInt(L2jBRVar1,"NUM",Num);
	Class'UIAPI_COMBOBOX'.Clear("MinimapWnd.Container.CursedComboBox");
	i = 0;
	if ( UnknownFunction150(i,UnknownFunction146(Num,1)) )
	{
		if ( UnknownFunction154(i,0) )
		{
			Class'UIAPI_COMBOBOX'.AddStringWithReserved("MinimapWnd.Container.CursedComboBox",GetSystemString(1463),0);
		} else {
			ParseInt(L2jBRVar1,UnknownFunction112("ID",string(UnknownFunction147(i,1))),L2jBRVar39);
			ParseString(L2jBRVar1,UnknownFunction112("NAME",string(UnknownFunction147(i,1))),cursedName);
			Class'UIAPI_COMBOBOX'.AddStringWithReserved("MinimapWnd.Container.CursedComboBox",cursedName,L2jBRVar39);
			Class'UIAPI_COMBOBOX'.SetSelectedNum("MinimapWnd.Container.CursedComboBox",0);
		}
		UnknownFunction163(i);
		goto JL0050;
	}
	Class'UIAPI_MINIMAPCTRL'.DeleteAllTarget("MinimapWnd.Minimap");
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
			Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd.Minimap",GetPlayerPosition());
		}
		Class'UIAPI_MINIMAPCTRL'.DeleteAllCursedWeaponIcon("MinimapWnd.Minimap");
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
				Debug(UnknownFunction168(UnknownFunction112(UnknownFunction112("무기1:",cursedName1),", 위치:"),string(CursedWeaponLoc1)));
				break;
				case 1:
				itemID2 = L2jBRVar39;
				cursedName2 = cursedName;
				isownded2 = isowndedo;
				CursedWeaponLoc2.X = cursedWeaponLocation.X;
				CursedWeaponLoc2.Y = cursedWeaponLocation.Y;
				CursedWeaponLoc2.Z = cursedWeaponLocation.Z;
				UnknownFunction226(CursedWeaponLoc2);
				Debug(UnknownFunction168(UnknownFunction112(UnknownFunction112("무기2:",cursedName2),", 위치:"),string(CursedWeaponLoc2)));
				break;
				default:
			}
			UnknownFunction163(i);
			goto JL0081;
		}
	}
	if ( m_AdjustCursedLoc )
	{
		m_AdjustCursedLoc = False;
		CursedWeaponComboCurrentData = Class'UIAPI_COMBOBOX'.GetSelectedNum("MinimapWnd.Container.CursedComboBox");
		combocursedName = Class'UIAPI_COMBOBOX'.GetString("MinimapWnd.Container.CursedComboBox",CursedWeaponComboCurrentData);
		if ( UnknownFunction122(combocursedName,cursedName1) )
		{
			Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd.Minimap",CursedWeaponLoc1,False);
		} else {
			if ( UnknownFunction122(combocursedName,cursedName2) )
			{
				Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd.Minimap",CursedWeaponLoc2,False);
			} else {
				AdjustMapToPlayerPosition(True);
			}
		}
	} else {
		if ( UnknownFunction154(Num,1) )
		{
			DrawCursedWeapon("MinimapWnd.Minimap",itemID1,cursedName1,CursedWeaponLoc1,UnknownFunction154(isownded1,0),True);
		} else {
			if ( UnknownFunction154(Num,2) )
			{
				combined = Class'UIAPI_MINIMAPCTRL'.IsOverlapped("MinimapWnd.Minimap",int(CursedWeaponLoc1.X),int(CursedWeaponLoc1.Y),int(CursedWeaponLoc2.X),int(CursedWeaponLoc2.Y));
				Debug(UnknownFunction168("컴바인",string(combined)));
				if ( combined )
				{
					Class'UIAPI_MINIMAPCTRL'.DrawGridIcon("MinimapWnd.Minimap","L2UI_CH3.MiniMap.cursedmapicon00","L2UI_CH3.MiniMap.cursedmapicon00",CursedWeaponLoc1,True,0,-12,UnknownFunction112(UnknownFunction112(cursedName1,"\n"),cursedName2));
				} else {
					Debug(UnknownFunction168(UnknownFunction168("ownded:",string(isownded1)),string(isownded2)));
					DrawCursedWeapon("MinimapWnd.Minimap",itemID1,cursedName1,CursedWeaponLoc1,UnknownFunction154(isownded1,0),True);
					DrawCursedWeapon("MinimapWnd.Minimap",itemID2,cursedName2,CursedWeaponLoc2,UnknownFunction154(isownded2,0),False);
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
	Class'UIAPI_TEXTBOX'.SetText("MinimapWnd.txtGameTime",GameTimeString);
}

function SelectSunOrMoon (int GameHour)
{
	if ( UnknownFunction130(UnknownFunction153(GameHour,6),UnknownFunction152(GameHour,24)) )
	{
		ShowWindow("MinimapWnd.texSun");
		HideWindow("MinimapWnd.texMoon");
	} else {
		ShowWindow("MinimapWnd.texMoon");
		HideWindow("MinimapWnd.texSun");
	}
}

function SetFocus ()
{
	Class'UIAPI_WINDOW'.SetFocus("MinimapWnd.PartyLocButton");
	Class'UIAPI_WINDOW'.SetFocus("MinimapWnd.MyLocButton");
	Class'UIAPI_WINDOW'.SetFocus("MinimapWnd.TargetButton");
	Class'UIAPI_WINDOW'.SetFocus("MinimapWnd.ExpandButton");
	Class'UIAPI_WINDOW'.SetFocus("MinimapWnd.Pursuit");
	Class'UIAPI_WINDOW'.SetFocus("MinimapWnd.OpenGuideWnd");
	Class'UIAPI_WINDOW'.SetFocus("MinimapWnd.CursedComboBox");
}

