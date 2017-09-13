//================================================================================
// GuideWnd.
//================================================================================

class GuideWnd extends UIScript;

struct RAIDRECORD
{
	var int A;
	var int B;
	var int C;
};

var bool bLock;
var array<RAIDRECORD> RaidRecordList;
var ListCtrlHandle m_hQuestListCtrl;
var ListCtrlHandle m_hHuntingZoneListCtrl;
var ListCtrlHandle m_hRaidListCtrl;
var ListCtrlHandle m_hAreaInfoListCtrl;
var TabHandle m_hTabCtrl;
var ComboBoxHandle m_hQuestComboBox;
const ANTARASMONID3= 29068;
const ANTARASMONID2= 29067;
const ANTARASMONID1= 29066;
const HUNTING_ZONE_ETCERA= 7;
const HUNTING_ZONE_COLOSSEUM= 6;
const HUNTING_ZONE_AZIT= 5;
const HUNTING_ZONE_HARBOR= 4;
const HUNTING_ZONE_CASTLEVILLE= 3;
const HUNTING_ZONE_DUNGEON= 2;
const HUNTING_ZONE_FIELDHUTINGZONE= 1;
const HUNTING_ZONE_TYPE= 0;
const TIMER_DELAY=5000;
const TIMER_ID=1;
const MAX_RAID_NUM=2000;
const MAX_HUNTINGZONE_NUM=500;
const MAX_QUEST_NUM=2000;

function OnLoad ()
{
	RegisterEvent(120);
	RegisterEvent(130);
	m_hQuestListCtrl = ListCtrlHandle(GetHandle("QuestListCtrl"));
	m_hHuntingZoneListCtrl = ListCtrlHandle(GetHandle("HuntingZoneListCtrl"));
	m_hRaidListCtrl = ListCtrlHandle(GetHandle("RaidListCtrl"));
	m_hAreaInfoListCtrl = ListCtrlHandle(GetHandle("AreaInfoListCtrl"));
	m_hTabCtrl = TabHandle(GetHandle("TabCtrl"));
	m_hQuestComboBox = ComboBoxHandle(GetHandle("QuestComboBox"));
}

function OnShow ()
{
	bLock = False;
	m_hHuntingZoneListCtrl.DeleteAllItem();
	m_hRaidListCtrl.DeleteAllItem();
	m_hAreaInfoListCtrl.DeleteAllItem();
	m_hTabCtrl.InitTabCtrl();
	LoadQuestList();
	m_hOwnerWnd.SetTimer(1,5000);
}

function OnHide ()
{
	Class'UIAPI_WINDOW'.KillUITimer("GuideWnd.RaidTab",1);
	bLock = False;
}

function OnTimer (int TimerID)
{
	if ( UnknownFunction154(TimerID,1) )
	{
		bLock = False;
	}
}

function OnClickButton (string Id)
{
	local int QuestComboCurrentData;
	local int QuestComboCurrentReservedData;
	local int HuntingZoneComboboxCurrentData;
	local int HuntingZoneComboboxCurrentReservedData;
	local int RaidCurrentComboboxCurrentReservedData;
	local int AreaInfoComboBoxCurrentData;
	local int AreaInfoComboBoxCurrentReservedData;

	if ( UnknownFunction122(Id,"TabCtrl0") )
	{
		LoadQuestList();
		m_hQuestComboBox.SetSelectedNum(0);
	} else {
		if ( UnknownFunction122(Id,"TabCtrl1") )
		{
			LoadHuntingZoneList();
			Class'UIAPI_COMBOBOX'.SetSelectedNum("GuideWnd.HuntingZoneComboBox",0);
		} else {
			if ( UnknownFunction122(Id,"TabCtrl2") )
			{
				if ( UnknownFunction242(bLock,False) )
				{
					bLock = True;
					RequestRaidRecord();
				}
			}
		}
	}
	if ( UnknownFunction122(Id,"TabCtrl3") )
	{
		LoadAreaInfoList();
		Class'UIAPI_COMBOBOX'.SetSelectedNum("GuideWnd.AreaInfoComboBox",0);
	}
	if ( UnknownFunction122(Id,"btn_search1") )
	{
		QuestComboCurrentData = m_hQuestComboBox.GetSelectedNum();
		QuestComboCurrentReservedData = m_hQuestComboBox.GetReserved(QuestComboCurrentData);
		LoadQuestSearchResult(QuestComboCurrentReservedData);
	}
	if ( UnknownFunction122(Id,"btn_search2") )
	{
		HuntingZoneComboboxCurrentData = Class'UIAPI_COMBOBOX'.GetSelectedNum("GuideWnd.HuntingZoneComboBox");
		HuntingZoneComboboxCurrentReservedData = Class'UIAPI_COMBOBOX'.GetReserved("GuideWnd.HuntingZoneComboBox",HuntingZoneComboboxCurrentData);
		LoadHuntingZoneListSearchResult(HuntingZoneComboboxCurrentReservedData);
	}
	if ( UnknownFunction122(Id,"btn_search3") )
	{
		LoadRaidSearchResult(RaidCurrentComboboxCurrentReservedData);
	}
	if ( UnknownFunction122(Id,"btn_search4") )
	{
		AreaInfoComboBoxCurrentData = Class'UIAPI_COMBOBOX'.GetSelectedNum("GuideWnd.AreaInfoComboBox");
		AreaInfoComboBoxCurrentReservedData = Class'UIAPI_COMBOBOX'.GetReserved("GuideWnd.AreaInfoComboBox",AreaInfoComboBoxCurrentData);
		LoadAreaInfoListSearchResult(AreaInfoComboBoxCurrentReservedData);
	}
	if ( UnknownFunction122(Id,"QuestComboBox") )
	{
		QuestComboCurrentData = m_hQuestComboBox.GetSelectedNum();
		QuestComboCurrentReservedData = m_hQuestComboBox.GetReserved(QuestComboCurrentData);
		LoadQuestSearchResult(QuestComboCurrentReservedData);
	}
	if ( UnknownFunction122(Id,"HuntingZoneComboBox") )
	{
		HuntingZoneComboboxCurrentData = Class'UIAPI_COMBOBOX'.GetSelectedNum("GuideWnd.HuntingZoneComboBox");
		HuntingZoneComboboxCurrentReservedData = Class'UIAPI_COMBOBOX'.GetReserved("GuideWnd.HuntingZoneComboBox",HuntingZoneComboboxCurrentData);
		LoadHuntingZoneListSearchResult(HuntingZoneComboboxCurrentReservedData);
	}
	if ( UnknownFunction122(Id,"CloseButton") )
	{
		Class'UIAPI_WINDOW'.HideWindow("MinimapWnd.GuideWnd");
	}
}

function OnComboBoxItemSelected (string sName, int Index)
{
	local int QuestComboCurrentReservedData;
	local int HuntingZoneComboboxCurrentReservedData;
	local int AreaInfoComboBoxCurrentReservedData;

	if ( UnknownFunction122(sName,"QuestComboBox") )
	{
		QuestComboCurrentReservedData = m_hQuestComboBox.GetReserved(Index);
		LoadQuestSearchResult(QuestComboCurrentReservedData);
	}
	if ( UnknownFunction122(sName,"HuntingZoneComboBox") )
	{
		HuntingZoneComboboxCurrentReservedData = Class'UIAPI_COMBOBOX'.GetReserved("GuideWnd.HuntingZoneComboBox",Index);
		LoadHuntingZoneListSearchResult(HuntingZoneComboboxCurrentReservedData);
	}
	if ( UnknownFunction122(sName,"AreaInfoComboBox") )
	{
		AreaInfoComboBoxCurrentReservedData = Class'UIAPI_COMBOBOX'.GetReserved("GuideWnd.AreaInfoComboBox",Index);
		LoadAreaInfoListSearchResult(AreaInfoComboBoxCurrentReservedData);
	}
}

function OnClickListCtrlRecord (string Id)
{
	local LVDataRecord Record;
	local Vector Loc;

	if ( UnknownFunction122(Id,"QuestListCtrl") )
	{
		Record = m_hQuestListCtrl.GetSelectedRecord();
		Loc = Class'UIDATA_QUEST'.GetStartNPCLoc(Record.LVDataList[0].nReserved1,1);
		Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd.Minimap",Loc,False);
		Class'UIAPI_MINIMAPCTRL'.DeleteAllTarget("MinimapWnd.Minimap");
		Class'UIAPI_MINIMAPCTRL'.AddTarget("MinimapWnd.Minimap",Loc);
	}
	if ( UnknownFunction122(Id,"HuntingZoneListCtrl") )
	{
		Record = m_hHuntingZoneListCtrl.GetSelectedRecord();
		Loc = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneLoc(Record.LVDataList[0].nReserved1);
		Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd.Minimap",Loc,False);
		Class'UIAPI_MINIMAPCTRL'.DeleteAllTarget("MinimapWnd.Minimap");
		Class'UIAPI_MINIMAPCTRL'.AddTarget("MinimapWnd.Minimap",Loc);
	}
	if ( UnknownFunction122(Id,"RaidListCtrl") )
	{
		Record = m_hRaidListCtrl.GetSelectedRecord();
		Loc = Class'UIDATA_RAID'.GetRaidLoc(Record.LVDataList[0].nReserved1);
		Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd.Minimap",Loc,False);
		Class'UIAPI_MINIMAPCTRL'.DeleteAllTarget("MinimapWnd.Minimap");
		Class'UIAPI_MINIMAPCTRL'.AddTarget("MinimapWnd.Minimap",Loc);
	}
	if ( UnknownFunction122(Id,"AreaInfoListCtrl") )
	{
		Record = m_hAreaInfoListCtrl.GetSelectedRecord();
		Loc = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneLoc(Record.LVDataList[0].nReserved1);
		Class'UIAPI_MINIMAPCTRL'.AdjustMapView("MinimapWnd.Minimap",Loc,False);
		Class'UIAPI_MINIMAPCTRL'.DeleteAllTarget("MinimapWnd.Minimap");
		Class'UIAPI_MINIMAPCTRL'.AddTarget("MinimapWnd.Minimap",Loc);
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 130:
		m_hOwnerWnd.ShowWindow();
		break;
		case 120:
		LoadRaidList(_L2jBRVar17_);
		break;
		default:
		break;
	}
}

function LoadHuntingZoneList ()
{
	local string HuntingZoneName;
	local int MinLevel;
	local int MaxLevel;
	local string LevelLimit;
	local int FieldType;
	local string FieldType_Name;
	local int Zone;
	local LVDataRecord Record;
	local LVData data1;
	local LVData data2;
	local LVData data3;
	local LVData data4;
	local int i;

	m_hHuntingZoneListCtrl.DeleteAllItem();
	comboxFiller("HuntingZoneComboBox");
	Class'UIAPI_COMBOBOX'.SetSelectedNum("GuideWnd.HuntingZoneComboBox",0);
	i = 0;
	if ( UnknownFunction150(i,500) )
	{
		if ( Class'UIDATA_HUNTINGZONE'.IsValidData(i) )
		{
			FieldType = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneType(i);
			if ( UnknownFunction132(UnknownFunction154(FieldType,1),UnknownFunction154(FieldType,2)) )
			{
				HuntingZoneName = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneName(i);
				MinLevel = Class'UIDATA_HUNTINGZONE'.GetMinLevel(i);
				MaxLevel = Class'UIDATA_HUNTINGZONE'.GetMaxLevel(i);
				Zone = Class'UIDATA_HUNTINGZONE'.GetHuntingZone(i);
				if ( UnknownFunction130(UnknownFunction151(MinLevel,0),UnknownFunction151(MaxLevel,0)) )
				{
					LevelLimit = UnknownFunction112(UnknownFunction112(string(MinLevel),"~"),string(MaxLevel));
				} else {
					if ( UnknownFunction151(MinLevel,0) )
					{
						LevelLimit = UnknownFunction112(UnknownFunction112(string(MinLevel)," "),GetSystemString(859));
					} else {
						LevelLimit = GetSystemString(866);
					}
				}
				FieldType_Name = conv_zoneType(FieldType);
				data1.nReserved1 = i;
				data1.szData = HuntingZoneName;
				Record.LVDataList[0] = data1;
				data2.szData = FieldType_Name;
				Record.LVDataList[1] = data2;
				data3.szData = conv_zoneName(Zone);
				Record.LVDataList[2] = data3;
				data4.szData = LevelLimit;
				Record.LVDataList[3] = data4;
				m_hHuntingZoneListCtrl.InsertRecord(Record);
			}
		}
		UnknownFunction165(i);
		goto JL005F;
	}
}

function LoadHuntingZoneListSearchResult (int SearchZone)
{
	local string HuntingZoneName;
	local int MinLevel;
	local int MaxLevel;
	local string LevelLimit;
	local int FieldType;
	local string FieldType_Name;
	local int Zone;
	local string Description;
	local LVDataRecord Record;
	local LVData data1;
	local LVData data2;
	local LVData data3;
	local LVData data4;
	local int i;

	if ( UnknownFunction154(SearchZone,9999) )
	{
		LoadHuntingZoneList();
	} else {
		m_hHuntingZoneListCtrl.DeleteAllItem();
		i = 0;
		if ( UnknownFunction150(i,500) )
		{
			if ( Class'UIDATA_HUNTINGZONE'.IsValidData(i) )
			{
				if ( UnknownFunction154(Class'UIDATA_HUNTINGZONE'.GetHuntingZone(i),SearchZone) )
				{
					FieldType = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneType(i);
					if ( UnknownFunction132(UnknownFunction154(FieldType,1),UnknownFunction154(FieldType,2)) )
					{
						HuntingZoneName = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneName(i);
						MinLevel = Class'UIDATA_HUNTINGZONE'.GetMinLevel(i);
						MaxLevel = Class'UIDATA_HUNTINGZONE'.GetMaxLevel(i);
						Zone = Class'UIDATA_HUNTINGZONE'.GetHuntingZone(i);
						Description = Class'UIDATA_HUNTINGZONE'.GetHuntingDescription(i);
						if ( UnknownFunction130(UnknownFunction151(MinLevel,0),UnknownFunction151(MaxLevel,0)) )
						{
							LevelLimit = UnknownFunction112(UnknownFunction112(string(MinLevel),"~"),string(MaxLevel));
						} else {
							if ( UnknownFunction151(MinLevel,0) )
							{
								LevelLimit = UnknownFunction112(UnknownFunction112(string(MinLevel)," "),GetSystemString(859));
							} else {
								LevelLimit = GetSystemString(866);
							}
						}
						FieldType_Name = conv_zoneType(FieldType);
						data1.nReserved1 = i;
						data1.szData = HuntingZoneName;
						Record.LVDataList[0] = data1;
						data2.szData = FieldType_Name;
						Record.LVDataList[1] = data2;
						data3.szData = conv_zoneName(Zone);
						Record.LVDataList[2] = data3;
						data4.szData = LevelLimit;
						Record.LVDataList[3] = data4;
						m_hHuntingZoneListCtrl.InsertRecord(Record);
					}
				}
			}
			UnknownFunction165(i);
			goto JL002E;
		}
	}
}

function LoadRaidRanking ()
{
}

function LoadRaidList (string _L2jBRVar17_)
{
	local int i;
	local int j;
	local int RaidMonsterID;
	local int RaidMonsterLevel;
	local int RaidMonsterZone;
	local string RaidPointStr;
	local string RaidMonsterPrefferedLevel;
	local string RaidMonsterName;
	local string RaidDescription;
	local LVDataRecord Record;
	local LVData data1;
	local LVData data2;
	local LVData data3;
	local LVData data4;
	local int RaidRanking;
	local int RaidSeasonPoint;
	local int RaidNum;
	local int ClearRaidMonsterID;
	local int ClearSeasonPoint;
	local int ClearTotalPoint;
	local int AntarasPoint;
	local string SeasonTotalString;

	m_hRaidListCtrl.DeleteAllItem();
	AntarasPoint = 0;
	ParseInt(_L2jBRVar17_,"RaidRank",RaidRanking);
	ParseInt(_L2jBRVar17_,"SeasonPoint",RaidSeasonPoint);
	if ( UnknownFunction154(RaidRanking,0) )
	{
		Class'UIAPI_TEXTBOX'.SetText("GuideWnd.Ranking",GetSystemString(1454));
	} else {
		Class'UIAPI_TEXTBOX'.SetInt("GuideWnd.Ranking",RaidRanking);
	}
	SeasonTotalString = UnknownFunction168(UnknownFunction112("",string(RaidSeasonPoint)),GetSystemString(1442));
	Class'UIAPI_TEXTBOX'.SetText("GuideWnd.SeasonTotalPoint",SeasonTotalString);
	ParseInt(_L2jBRVar17_,"Count",RaidNum);
	RaidRecordList.Remove (0,RaidRecordList.Length);
	byte(RaidRecordList)
	0
	RaidNum
	i = 0;
	if ( UnknownFunction150(i,RaidNum) )
	{
		ParseInt(_L2jBRVar17_,UnknownFunction112("MonsterID",string(i)),ClearRaidMonsterID);
		ParseInt(_L2jBRVar17_,UnknownFunction112("CurrentPoint",string(i)),ClearSeasonPoint);
		ParseInt(_L2jBRVar17_,UnknownFunction112("TotalPoint",string(i)),ClearTotalPoint);
		RaidRecordList[i].A = ClearRaidMonsterID;
		RaidRecordList[i].B = ClearSeasonPoint;
		RaidRecordList[i].C = ClearTotalPoint;
		UnknownFunction165(i);
		goto JL0131;
	}
	i = 0;
	if ( UnknownFunction150(i,2000) )
	{
		if ( Class'UIDATA_RAID'.IsValidData(i) )
		{
			RaidMonsterID = Class'UIDATA_RAID'.GetRaidMonsterID(i);
			RaidMonsterLevel = Class'UIDATA_RAID'.GetRaidMonsterLevel(i);
			RaidMonsterZone = Class'UIDATA_RAID'.GetRaidMonsterZone(i);
			RaidDescription = Class'UIDATA_RAID'.GetRaidDescription(i);
			RaidMonsterName = Class'UIDATA_NPC'.GetNPCName(RaidMonsterID);
			if ( UnknownFunction154(RaidMonsterID,29066) )
			{
				Debug("안타라스 1");
			} else {
				if ( UnknownFunction154(RaidMonsterID,29067) )
				{
					Debug("안타라스 2");
				} else {
					if ( UnknownFunction154(RaidMonsterID,29068) )
					{
						Debug("안타라스 3");
						if ( UnknownFunction151(RaidMonsterLevel,0) )
						{
							RaidMonsterPrefferedLevel = UnknownFunction112(UnknownFunction112(GetSystemString(537)," "),string(RaidMonsterLevel));
						} else {
							RaidMonsterPrefferedLevel = GetSystemString(1415);
						}
						data1.nReserved1 = i;
						data1.szData = RaidMonsterName;
						Record.LVDataList[0] = data1;
						data2.szData = RaidMonsterPrefferedLevel;
						Record.LVDataList[1] = data2;
						data3.szData = conv_zoneName(RaidMonsterZone);
						Record.LVDataList[2] = data3;
						RaidPointStr = "0";
						j = 0;
						if ( UnknownFunction150(j,RaidNum) )
						{
							if ( UnknownFunction154(RaidRecordList[j].A,RaidMonsterID) )
							{
								RaidPointStr = UnknownFunction112(string(RaidRecordList[j].B),"");
							}
							UnknownFunction165(j);
							goto JL03DF;
						}
						AntarasPoint = UnknownFunction146(int(RaidPointStr),AntarasPoint);
						data4.szData = string(AntarasPoint);
						Record.LVDataList[3] = data4;
						Record.szReserved = RaidDescription;
						m_hRaidListCtrl.InsertRecord(Record);
					} else {
						if ( UnknownFunction151(RaidMonsterLevel,0) )
						{
							RaidMonsterPrefferedLevel = UnknownFunction112(UnknownFunction112(GetSystemString(537)," "),string(RaidMonsterLevel));
						} else {
							RaidMonsterPrefferedLevel = GetSystemString(1415);
						}
						data1.nReserved1 = i;
						data1.szData = RaidMonsterName;
						Record.LVDataList[0] = data1;
						data2.szData = RaidMonsterPrefferedLevel;
						Record.LVDataList[1] = data2;
						data3.szData = conv_zoneName(RaidMonsterZone);
						Record.LVDataList[2] = data3;
						RaidPointStr = "0";
						j = 0;
						if ( UnknownFunction150(j,RaidNum) )
						{
							if ( UnknownFunction154(RaidRecordList[j].A,RaidMonsterID) )
							{
								RaidPointStr = UnknownFunction112(string(RaidRecordList[j].B),"");
							}
							UnknownFunction165(j);
							goto JL0559;
						}
						data4.szData = RaidPointStr;
						Record.LVDataList[3] = data4;
						Record.szReserved = RaidDescription;
						m_hRaidListCtrl.InsertRecord(Record);
					}
				}
			}
		}
		UnknownFunction165(i);
		goto JL0203;
	}
}

function LoadRaidList2 ()
{
	local int i;
	local int RaidMonsterID;
	local int RaidMonsterLevel;
	local int RaidMonsterZone;
	local string RaidPointStr;
	local string RaidMonsterPrefferedLevel;
	local string RaidMonsterName;
	local string RaidDescription;
	local LVDataRecord Record;
	local LVData data1;
	local LVData data2;
	local LVData data3;
	local LVData data4;
	local int RaidNum;
	local int RaidCount;

JL0016:
	m_hRaidListCtrl.DeleteAllItem();
	i = 0;
	if ( UnknownFunction150(i,2000) )
	{
		if ( Class'UIDATA_RAID'.IsValidData(i) )
		{
			RaidMonsterID = Class'UIDATA_RAID'.GetRaidMonsterID(i);
			RaidMonsterLevel = Class'UIDATA_RAID'.GetRaidMonsterLevel(i);
			RaidMonsterZone = Class'UIDATA_RAID'.GetRaidMonsterZone(i);
			RaidDescription = Class'UIDATA_RAID'.GetRaidDescription(i);
			RaidMonsterName = Class'UIDATA_NPC'.GetNPCName(RaidMonsterID);
			if ( UnknownFunction151(RaidMonsterLevel,0) )
			{
				RaidMonsterPrefferedLevel = UnknownFunction112(UnknownFunction112(GetSystemString(537)," "),string(RaidMonsterLevel));
			} else {
				RaidMonsterPrefferedLevel = GetSystemString(1415);
			}
			data1.nReserved1 = i;
			data1.szData = RaidMonsterName;
			Record.LVDataList[0] = data1;
			data2.szData = RaidMonsterPrefferedLevel;
			Record.LVDataList[1] = data2;
			data3.szData = conv_zoneName(RaidMonsterZone);
			Record.LVDataList[2] = data3;
			RaidPointStr = "0";
			if ( UnknownFunction150(RaidCount,RaidNum) )
			{
				if ( UnknownFunction154(RaidRecordList[RaidCount].A,RaidMonsterID) )
				{
					RaidPointStr = UnknownFunction112(string(RaidRecordList[UnknownFunction165(RaidCount)].B),"");
				}
			}
			data4.szData = RaidPointStr;
			Record.LVDataList[3] = data4;
			Record.szReserved = RaidDescription;
			m_hRaidListCtrl.InsertRecord(Record);
		}
		UnknownFunction165(i);
		goto JL0016;
	}
}

function LoadRaidSearchResult (int SearchZone)
{
	local int i;
	local int RaidMonsterID;
	local int RaidMonsterLevel;
	local int RaidMonsterZone;
	local string RaidPointStr;
	local string RaidMonsterPrefferedLevel;
	local string RaidMonsterName;
	local string RaidDescription;
	local LVDataRecord Record;
	local LVData data1;
	local LVData data2;
	local LVData data3;
	local LVData data4;
	local int RaidNum;
	local int RaidCount;

	if ( UnknownFunction154(SearchZone,9999) )
	{
		LoadRaidList2();
	} else {
		m_hRaidListCtrl.DeleteAllItem();
		RaidNum = RaidRecordList.Length;
		RaidCount = 0;
		i = 0;
		if ( UnknownFunction150(i,2000) )
		{
			if ( Class'UIDATA_RAID'.IsValidData(i) )
			{
				RaidMonsterZone = Class'UIDATA_RAID'.GetRaidMonsterZone(i);
				if ( UnknownFunction154(SearchZone,RaidMonsterZone) )
				{
					RaidMonsterID = Class'UIDATA_RAID'.GetRaidMonsterID(i);
					RaidMonsterLevel = Class'UIDATA_RAID'.GetRaidMonsterLevel(i);
					RaidDescription = Class'UIDATA_RAID'.GetRaidDescription(i);
					RaidMonsterName = Class'UIDATA_NPC'.GetNPCName(RaidMonsterID);
					if ( UnknownFunction151(RaidMonsterLevel,0) )
					{
						RaidMonsterPrefferedLevel = UnknownFunction112(UnknownFunction112(GetSystemString(537)," "),string(RaidMonsterLevel));
					} else {
						RaidMonsterPrefferedLevel = "-";
					}
					data1.nReserved1 = i;
					data1.szData = RaidMonsterName;
					Record.LVDataList[0] = data1;
					data2.szData = RaidMonsterPrefferedLevel;
					Record.LVDataList[1] = data2;
					data3.szData = conv_zoneName(RaidMonsterZone);
					Record.LVDataList[2] = data3;
					RaidPointStr = "0";
					if ( UnknownFunction150(RaidCount,RaidNum) )
					{
						if ( UnknownFunction154(RaidRecordList[RaidCount].A,RaidMonsterID) )
						{
							RaidPointStr = UnknownFunction112(string(RaidRecordList[UnknownFunction165(RaidCount)].B),"");
						}
					}
					data4.szData = RaidPointStr;
					Record.LVDataList[3] = data4;
					Record.szReserved = RaidDescription;
					Record.nReserved1 = RaidMonsterZone;
					m_hRaidListCtrl.InsertRecord(Record);
				}
			}
			UnknownFunction165(i);
			goto JL0041;
		}
	}
}

function LoadQuestList ()
{
	local string QuestName;
	local int MinLevel;
	local int MaxLevel;
	local int L2jBRVar5;
	local int NPC;
	local string LevelLimit;
	local string NPCname;
	local int Id;
	local LVDataRecord Record;
	local LVData data1;
	local LVData data2;
	local LVData data3;
	local LVData data4;
	local string TypeText[5];

	m_hQuestListCtrl.DeleteAllItem();
	comboxFiller("QuestComboBox");
	m_hQuestComboBox.SetSelectedNum(0);
	TypeText[0] = GetSystemString(861);
	TypeText[1] = GetSystemString(862);
	TypeText[2] = GetSystemString(861);
	TypeText[3] = GetSystemString(862);
	TypeText[4] = GetSystemString(861);
	Id = Class'UIDATA_QUEST'.GetFirstID();
	if ( UnknownFunction155(-1,Id) )
	{
		QuestName = Class'UIDATA_QUEST'.GetQuestName(Id);
		MinLevel = Class'UIDATA_QUEST'.GetMinLevel(Id,1);
		MaxLevel = Class'UIDATA_QUEST'.GetMaxLevel(Id,1);
		L2jBRVar5 = Class'UIDATA_QUEST'.GetQuestType(Id,1);
		NPC = Class'UIDATA_QUEST'.GetStartNPCID(Id,1);
		NPCname = Class'UIDATA_NPC'.GetNPCName(NPC);
		if ( UnknownFunction130(UnknownFunction151(MinLevel,0),UnknownFunction151(MaxLevel,0)) )
		{
			LevelLimit = UnknownFunction112(UnknownFunction112(string(MinLevel),"~"),string(MaxLevel));
		} else {
			if ( UnknownFunction151(MinLevel,0) )
			{
				LevelLimit = UnknownFunction112(UnknownFunction112(string(MinLevel)," "),GetSystemString(859));
			} else {
				LevelLimit = GetSystemString(866);
			}
		}
		data1.nReserved1 = Id;
		data1.szData = QuestName;
		Record.LVDataList[0] = data1;
		if ( UnknownFunction130(UnknownFunction152(0,L2jBRVar5),UnknownFunction152(L2jBRVar5,4)) )
		{
			data2.szData = TypeText[L2jBRVar5];
		}
		Record.LVDataList[1] = data2;
		data3.szData = NPCname;
		Record.LVDataList[2] = data3;
		data4.szData = LevelLimit;
		Record.LVDataList[3] = data4;
		m_hQuestListCtrl.InsertRecord(Record);
		Id = Class'UIDATA_QUEST'.GetNextID();
		goto JL00AB;
	}
}

function LoadQuestSearchResult (int SearchZone)
{
	local string QuestName;
	local string Condition;
	local int MinLevel;
	local int MaxLevel;
	local int L2jBRVar5;
	local int Zone;
	local int NPC;
	local string Description;
	local string LevelLimit;
	local string NPCname;
	local int i;
	local LVDataRecord Record;
	local LVData data1;
	local LVData data2;
	local LVData data3;
	local LVData data4;
	local string TypeText;

	if ( UnknownFunction154(SearchZone,9999) )
	{
		LoadQuestList();
	} else {
		m_hQuestListCtrl.DeleteAllItem();
		i = 0;
		if ( UnknownFunction150(i,2000) )
		{
			if ( Class'UIDATA_QUEST'.IsValidData(i) )
			{
				if ( UnknownFunction154(Class'UIDATA_QUEST'.GetQuestZone(i,1),SearchZone) )
				{
					QuestName = Class'UIDATA_QUEST'.GetQuestName(i);
					Condition = Class'UIDATA_QUEST'.GetRequirement(i,1);
					MinLevel = Class'UIDATA_QUEST'.GetMinLevel(i,1);
					MaxLevel = Class'UIDATA_QUEST'.GetMaxLevel(i,1);
					L2jBRVar5 = Class'UIDATA_QUEST'.GetQuestType(i,1);
					Zone = Class'UIDATA_QUEST'.GetQuestZone(i,1);
					Description = Class'UIDATA_QUEST'.GetIntro(i,1);
					NPC = Class'UIDATA_QUEST'.GetStartNPCID(i,1);
					NPCname = Class'UIDATA_NPC'.GetNPCName(NPC);
					if ( UnknownFunction130(UnknownFunction151(MinLevel,0),UnknownFunction151(MaxLevel,0)) )
					{
						LevelLimit = UnknownFunction112(UnknownFunction112(string(MinLevel),"~"),string(MaxLevel));
					} else {
						if ( UnknownFunction151(MinLevel,0) )
						{
							LevelLimit = UnknownFunction112(UnknownFunction112(string(MinLevel)," "),GetSystemString(859));
						} else {
							LevelLimit = GetSystemString(866);
						}
					}
					switch (L2jBRVar5)
					{
						case 0:
						TypeText = GetSystemString(861);
						break;
						case 1:
						TypeText = GetSystemString(862);
						break;
						case 2:
						TypeText = GetSystemString(861);
						break;
						case 3:
						TypeText = GetSystemString(862);
						break;
						case 4:
						TypeText = GetSystemString(861);
						break;
						default:
					}
					data1.nReserved1 = i;
					data1.szData = QuestName;
					Record.LVDataList[0] = data1;
					data2.szData = TypeText;
					Record.LVDataList[1] = data2;
					data3.szData = NPCname;
					Record.LVDataList[2] = data3;
					data4.szData = LevelLimit;
					Record.LVDataList[3] = data4;
					m_hQuestListCtrl.InsertRecord(Record);
				}
			}
			UnknownFunction165(i);
			goto JL002E;
		}
	}
}

function LoadAreaInfoList ()
{
	local string AreaName;
	local int L2jBRVar5;
	local int Zone;
	local string ZoneName;
	local string ZoneType;
	local string Description;
	local int i;
	local LVDataRecord Record;
	local LVData data1;
	local LVData data2;
	local LVData data3;

	m_hAreaInfoListCtrl.DeleteAllItem();
	comboxFiller("AreaInfoComboBox");
	Class'UIAPI_COMBOBOX'.SetSelectedNum("GuideWnd.AreaInfoComboBox",0);
	i = 0;
	if ( UnknownFunction150(i,500) )
	{
		if ( Class'UIDATA_HUNTINGZONE'.IsValidData(i) )
		{
			L2jBRVar5 = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneType(i);
			if ( UnknownFunction151(L2jBRVar5,2) )
			{
				AreaName = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneName(i);
				Zone = Class'UIDATA_HUNTINGZONE'.GetHuntingZone(i);
				Description = Class'UIDATA_HUNTINGZONE'.GetHuntingDescription(i);
				ZoneName = conv_dom(Zone);
				ZoneType = conv_zoneType(L2jBRVar5);
				data1.nReserved1 = i;
				data1.szData = AreaName;
				Record.LVDataList[0] = data1;
				data2.szData = ZoneType;
				Record.LVDataList[1] = data2;
				data3.szData = ZoneName;
				Record.LVDataList[2] = data3;
				Record.nReserved1 = Zone;
				Record.szReserved = Description;
				m_hAreaInfoListCtrl.InsertRecord(Record);
			}
		}
		UnknownFunction165(i);
		goto JL0059;
	}
}

function LoadAreaInfoListSearchResult (int SearchZone)
{
	local string AreaName;
	local int L2jBRVar5;
	local int Zone;
	local string ZoneName;
	local string ZoneType;
	local string Description;
	local int i;
	local LVDataRecord Record;
	local LVData data1;
	local LVData data2;
	local LVData data3;

	if ( UnknownFunction154(SearchZone,9999) )
	{
		LoadAreaInfoList();
	} else {
		m_hAreaInfoListCtrl.DeleteAllItem();
		i = 0;
		if ( UnknownFunction150(i,2000) )
		{
			if ( Class'UIDATA_HUNTINGZONE'.IsValidData(i) )
			{
				if ( UnknownFunction154(Class'UIDATA_HUNTINGZONE'.GetHuntingZone(i),SearchZone) )
				{
					L2jBRVar5 = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneType(i);
					if ( UnknownFunction151(L2jBRVar5,2) )
					{
						AreaName = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneName(i);
						Zone = Class'UIDATA_HUNTINGZONE'.GetHuntingZone(i);
						Description = Class'UIDATA_HUNTINGZONE'.GetHuntingDescription(i);
						ZoneName = conv_dom(Zone);
						ZoneType = conv_zoneType(L2jBRVar5);
						data1.nReserved1 = i;
						data1.szData = AreaName;
						Record.LVDataList[0] = data1;
						data2.szData = ZoneType;
						Record.LVDataList[1] = data2;
						data3.szData = ZoneName;
						Record.LVDataList[2] = data3;
						m_hAreaInfoListCtrl.InsertRecord(Record);
					}
				}
			}
			UnknownFunction165(i);
			goto JL002E;
		}
	}
}

function comboxFiller (string ComboboxName)
{
	switch (ComboboxName)
	{
		case "QuestComboBox":
		proc_combox("QuestComboBox");
		break;
		case "HuntingZoneComboBox":
		proc_combox("HuntingZoneComboBox");
		break;
		case "AreaInfoComboBox":
		proc_combox("AreaInfoComboBox");
		break;
		default:
	}
}

function proc_combox (string ComboboxName)
{
	local string ComboboxNameFull;
	local string ZoneName;
	local int Zone;
	local int i;

	ComboboxNameFull = UnknownFunction112("GuideWnd.",ComboboxName);
	Class'UIAPI_COMBOBOX'.Clear(ComboboxNameFull);
	Class'UIAPI_COMBOBOX'.AddStringWithReserved(ComboboxNameFull,GetSystemString(144),9999);
	i = 0;
	if ( UnknownFunction150(i,500) )
	{
		if ( Class'UIDATA_HUNTINGZONE'.IsValidData(i) )
		{
			if ( UnknownFunction154(Class'UIDATA_HUNTINGZONE'.GetHuntingZoneType(i),0) )
			{
				ZoneName = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneName(i);
				Zone = Class'UIDATA_HUNTINGZONE'.GetHuntingZone(i);
				Class'UIAPI_COMBOBOX'.AddStringWithReserved(ComboboxNameFull,ZoneName,Zone);
			}
		}
		UnknownFunction165(i);
		goto JL0054;
	}
}

function string conv_dom (int ZoneNameNum)
{
	local string ZoneNameStr;
	local int i;

	i = 0;
	if ( UnknownFunction150(i,500) )
	{
		if ( Class'UIDATA_HUNTINGZONE'.IsValidData(i) )
		{
			if ( UnknownFunction154(Class'UIDATA_HUNTINGZONE'.GetHuntingZoneType(i),0) )
			{
				if ( UnknownFunction154(Class'UIDATA_HUNTINGZONE'.GetHuntingZone(i),ZoneNameNum) )
				{
					ZoneNameStr = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneName(i);
				}
			}
		}
		UnknownFunction165(i);
		goto JL0007;
	}
	return ZoneNameStr;
}

function string conv_zoneType (int ZoneTypeNum)
{
	local string ZoneTypeStr;

	switch (ZoneTypeNum)
	{
		case 1:
		ZoneTypeStr = GetSystemString(1313);
		break;
		case 2:
		ZoneTypeStr = GetSystemString(1314);
		break;
		case 3:
		ZoneTypeStr = GetSystemString(1315);
		break;
		case 4:
		ZoneTypeStr = GetSystemString(1316);
		break;
		case 5:
		ZoneTypeStr = GetSystemString(1317);
		break;
		case 6:
		ZoneTypeStr = GetSystemString(1318);
		break;
		case 7:
		ZoneTypeStr = GetSystemString(1319);
		break;
		default:
	}
	return ZoneTypeStr;
}

function string conv_zoneName (int search_zoneid)
{
	local string HuntingZoneName;
	local int i;

	i = 0;
	if ( UnknownFunction150(i,500) )
	{
		if ( Class'UIDATA_HUNTINGZONE'.IsValidData(i) )
		{
			if ( UnknownFunction154(Class'UIDATA_HUNTINGZONE'.GetHuntingZoneType(i),0) )
			{
				if ( UnknownFunction154(Class'UIDATA_HUNTINGZONE'.GetHuntingZone(i),search_zoneid) )
				{
					HuntingZoneName = Class'UIDATA_HUNTINGZONE'.GetHuntingZoneName(i);
				}
			}
		}
		UnknownFunction165(i);
		goto JL0007;
	}
	return HuntingZoneName;
}

