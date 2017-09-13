//================================================================================
// ManorSeedInfoSettingWnd.
//================================================================================

class ManorSeedInfoSettingWnd extends UICommonAPI;

const DIALOG_ID_SETTODAY=666;
const DIALOG_ID_STOP=555;
const COLUMN_CNT=10;
const REWARD_TYPE_2=9;
const REWARD_TYPE_1=8;
const SEED_LEVEL=7;
const MAXIMUM_CROP_PRICE=6;
const MINIMUM_CROP_PRICE=5;
const TOMORROW_PRICE=4;
const TOMORROW_VOLUME_OF_SALES=3;
const TODAY_PRICE=2;
const TODAY_VOLUME_OF_SALES=1;
const SEED_NAME=0;
var int m_ManorID;
var int m_SumOfDefaultPrice;

function OnLoad ()
{
	RegisterEvent(2656);
	RegisterEvent(2657);
	RegisterEvent(2658);
	RegisterEvent(2659);
	RegisterEvent(1710);
	m_ManorID = -1;
	m_SumOfDefaultPrice = 0;
}

function OnEvent (int Event_ID, string _L2jBRVar17_)
{
	switch (Event_ID)
	{
		case 2656:
		HandleShow(_L2jBRVar17_);
		break;
		case 2657:
		HandleAddItem(_L2jBRVar17_);
		break;
		case 2658:
		CalculateSumOfDefaultPrice();
		ShowWindowWithFocus("ManorSeedInfoSettingWnd");
		break;
		case 2659:
		HandleChangeValue(_L2jBRVar17_);
		break;
		case 1710:
		HandleDialogOK();
		break;
		default:
	}
}

function HandleDialogOK ()
{
	local int dialogID;

	if ( UnknownFunction129(DialogIsMine()) )
	{
		return;
	}
	dialogID = DialogGetID();
	switch (dialogID)
	{
		case 555:
		HandleStop();
		break;
		case 666:
		HandleSetToday();
		break;
		default:
	}
}

function HandleStop ()
{
	local int i;
	local int RecordCnt;
	local LVDataRecord Record;
	local LVDataRecord recordClear;

	RecordCnt = Class'UIAPI_LISTCTRL'.GetRecordCount("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");
	Debug(UnknownFunction112("Ä«¿îÆ®:",string(RecordCnt)));
	i = 0;
	if ( UnknownFunction150(i,RecordCnt) )
	{
		Record = recordClear;
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl",i);
		Record.LVDataList[3].szData = "0";
		Record.LVDataList[4].szData = "0";
		Class'UIAPI_LISTCTRL'.ModifyRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl",i,Record);
		UnknownFunction163(i);
		goto JL006A;
	}
	CalculateSumOfDefaultPrice();
}

function HandleSetToday ()
{
	local int i;
	local int RecordCnt;
	local LVDataRecord Record;
	local LVDataRecord recordClear;

	RecordCnt = Class'UIAPI_LISTCTRL'.GetRecordCount("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");
	i = 0;
	if ( UnknownFunction150(i,RecordCnt) )
	{
		Record = recordClear;
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl",i);
		Record.LVDataList[3].szData = Record.LVDataList[1].szData;
		Record.LVDataList[4].szData = Record.LVDataList[2].szData;
		Class'UIAPI_LISTCTRL'.ModifyRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl",i,Record);
		UnknownFunction163(i);
		goto JL0052;
	}
	CalculateSumOfDefaultPrice();
}

function HandleShow (string _L2jBRVar17_)
{
	local int ManorID;
	local string ManorName;

	ParseInt(_L2jBRVar17_,"ManorID",ManorID);
	ParseString(_L2jBRVar17_,"ManorName",ManorName);
	m_ManorID = ManorID;
	Class'UIAPI_TEXTBOX'.SetText("ManorSeedInfoSettingWnd.txtManorName",ManorName);
	DeleteAll();
}

function HandleChangeValue (string _L2jBRVar17_)
{
	local int TomorrowSalesVolume;
	local int TomorrowPrice;
	local LVDataRecord Record;
	local int SelectedIndex;

	ParseInt(_L2jBRVar17_,"TomorrowSalesVolume",TomorrowSalesVolume);
	ParseInt(_L2jBRVar17_,"TomorrowPrice",TomorrowPrice);
	SelectedIndex = Class'UIAPI_LISTCTRL'.GetSelectedIndex("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");
	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");
	Record.LVDataList[3].szData = string(TomorrowSalesVolume);
	Record.LVDataList[4].szData = string(TomorrowPrice);
	Class'UIAPI_LISTCTRL'.ModifyRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl",SelectedIndex,Record);
	CalculateSumOfDefaultPrice();
}

function DeleteAll ()
{
	Class'UIAPI_LISTCTRL'.DeleteAllItem("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");
}

function OnDBClickListCtrlRecord (string strID)
{
	switch (strID)
	{
		case "ManorSeedInfoSettingListCtrl":
		OnChangeBtn();
		break;
		default:
	}
}

function OnClickButton (string strID)
{
	Debug(UnknownFunction112(" ",strID));
	switch (strID)
	{
		case "btnChangeSell":
		OnChangeBtn();
		break;
		case "btnSetToday":
		DialogSetID(666);
		DialogShow(4,GetSystemMessage(1601));
		break;
		case "btnStop":
		DialogSetID(555);
		DialogShow(4,GetSystemMessage(1600));
		break;
		case "btnOk":
		OnOk();
		break;
		case "btnCancel":
		HideWindow("ManorSeedInfoSettingWnd");
		break;
		default:
	}
}

function OnOk ()
{
	local int RecordCount;
	local LVDataRecord Record;
	local LVDataRecord recordClear;
	local int i;
	local string L2jBRVar1;

	RecordCount = Class'UIAPI_LISTCTRL'.GetRecordCount("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");
	ParamAdd(L2jBRVar1,"ManorID",string(m_ManorID));
	ParamAdd(L2jBRVar1,"SeedCnt",string(RecordCount));
	i = 0;
	if ( UnknownFunction150(i,RecordCount) )
	{
		Record = recordClear;
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl",i);
		ParamAdd(L2jBRVar1,UnknownFunction112("SeedID",string(i)),string(Record.nReserved1));
		ParamAdd(L2jBRVar1,UnknownFunction112("TomorrowSalesVolume",string(i)),Record.LVDataList[3].szData);
		ParamAdd(L2jBRVar1,UnknownFunction112("TomorrowPrice",string(i)),Record.LVDataList[4].szData);
		UnknownFunction163(i);
		goto JL0088;
	}
	RequestSetSeed(L2jBRVar1);
	HideWindow("ManorSeedInfoSettingWnd");
}

function OnChangeBtn ()
{
	local LVDataRecord Record;
	local string L2jBRVar1;

	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");
	ParamAdd(L2jBRVar1,"SeedName",Record.LVDataList[0].szData);
	ParamAdd(L2jBRVar1,"TomorrowVolumeOfSales",Record.LVDataList[3].szData);
	ParamAdd(L2jBRVar1,"TomorrowLimit",string(Record.nReserved2));
	ParamAdd(L2jBRVar1,"TomorrowPrice",Record.LVDataList[4].szData);
	ParamAdd(L2jBRVar1,"MinCropPrice",Record.LVDataList[5].szData);
	ParamAdd(L2jBRVar1,"MaxCropPrice",Record.LVDataList[6].szData);
	ExecuteEvent(2660,L2jBRVar1);
}

function HandleAddItem (string _L2jBRVar17_)
{
	local LVDataRecord Record;
	local int SeedID;
	local string SeedName;
	local int TodaySeedTotalCnt;
	local int TodaySeedPrice;
	local int NextSeedTotalCnt;
	local int NextSeedPrice;
	local int MinCropPrice;
	local int MaxCropPrice;
	local int SeedLevel;
	local string RewardType1;
	local string RewardType2;
	local int MaxSeedTotalCnt;
	local int DefaultSeedPrice;

	ParseInt(_L2jBRVar17_,"SeedID",SeedID);
	ParseString(_L2jBRVar17_,"SeedName",SeedName);
	ParseInt(_L2jBRVar17_,"TodaySeedTotalCnt",TodaySeedTotalCnt);
	ParseInt(_L2jBRVar17_,"TodaySeedPrice",TodaySeedPrice);
	ParseInt(_L2jBRVar17_,"TodayNextSeedTotalCnt",NextSeedTotalCnt);
	ParseInt(_L2jBRVar17_,"NextSeedPrice",NextSeedPrice);
	ParseInt(_L2jBRVar17_,"MinCropPrice",MinCropPrice);
	ParseInt(_L2jBRVar17_,"MaxCropPrice",MaxCropPrice);
	ParseInt(_L2jBRVar17_,"SeedLevel",SeedLevel);
	ParseString(_L2jBRVar17_,"RewardType1",RewardType1);
	ParseString(_L2jBRVar17_,"RewardType2",RewardType2);
	ParseInt(_L2jBRVar17_,"MaxSeedTotalCnt",MaxSeedTotalCnt);
	ParseInt(_L2jBRVar17_,"DefaultSeedPrice",DefaultSeedPrice);
	Record.LVDataList.Length = 10;
	Record.LVDataList[0].szData = SeedName;
	Record.LVDataList[1].szData = string(TodaySeedTotalCnt);
	Record.LVDataList[2].szData = string(TodaySeedPrice);
	Record.LVDataList[3].szData = string(NextSeedTotalCnt);
	Record.LVDataList[4].szData = string(NextSeedPrice);
	Record.LVDataList[5].szData = string(MinCropPrice);
	Record.LVDataList[6].szData = string(MaxCropPrice);
	Record.LVDataList[7].szData = string(SeedLevel);
	Record.LVDataList[8].szData = RewardType1;
	Record.LVDataList[9].szData = RewardType2;
	Record.nReserved1 = SeedID;
	Record.nReserved2 = MaxSeedTotalCnt;
	Record.nReserved3 = DefaultSeedPrice;
	Class'UIAPI_LISTCTRL'.InsertRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl",Record);
}

function CalculateSumOfDefaultPrice ()
{
	local LVDataRecord Record;
	local LVDataRecord recordClear;
	local int ItemCnt;
	local int i;
	local int tmpMulti;
	local string L2jBRVar14;

	m_SumOfDefaultPrice = 0;
	ItemCnt = Class'UIAPI_LISTCTRL'.GetRecordCount("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl");
	i = 0;
	if ( UnknownFunction150(i,ItemCnt) )
	{
		Record = recordClear;
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ManorSeedInfoSettingWnd.ManorSeedInfoSettingListCtrl",i);
		tmpMulti = UnknownFunction144(Record.nReserved3,int(Record.LVDataList[3].szData));
		UnknownFunction161(m_SumOfDefaultPrice,tmpMulti);
		UnknownFunction163(i);
		goto JL0059;
	}
	L2jBRVar14 = MakeCostString(string(m_SumOfDefaultPrice));
	Class'UIAPI_TEXTBOX'.SetText("ManorSeedInfoSettingWnd.txtVarNextTotalExpense",L2jBRVar14);
}

