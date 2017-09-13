//================================================================================
// ManorCropInfoSettingWnd.
//================================================================================

class ManorCropInfoSettingWnd extends UICommonAPI;

const DIALOG_ID_SETTODAY=888;
const DIALOG_ID_STOP=777;
const COLUMN_CNT=12;
const REWARD_TYPE_2=11;
const REWARD_TYPE_1=10;
const CROP_LELEL=9;
const MAX_CROP_PRICE=8;
const MIN_CROP_PRICE=7;
const NEXT_PROCURE_TYPE=6;
const NEXT_CROP_PRICE=5;
const NEXT_CROP_TOTAL_CNT=4;
const TODAY_PROCURE_TYPE=3;
const TODAY_CROP_PRICE=2;
const TODAY_CROP_TOTOAL_CNT=1;
const CROP_NAME=0;
var int m_ManorID;
var int m_SumOfDefaultPrice;

function OnLoad ()
{
	RegisterEvent(2665);
	RegisterEvent(2666);
	RegisterEvent(2667);
	RegisterEvent(2668);
	RegisterEvent(1710);
	m_ManorID = -1;
	m_SumOfDefaultPrice = 0;
}

function OnEvent (int Event_ID, string _L2jBRVar17_)
{
	switch (Event_ID)
	{
		case 2665:
		HandleShow(_L2jBRVar17_);
		break;
		case 2666:
		HandleAddItem(_L2jBRVar17_);
		break;
		case 2667:
		CalculateSumOfDefaultPrice();
		ShowWindowWithFocus("ManorCropInfoSettingWnd");
		break;
		case 2668:
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
		case 777:
		HandleStop();
		break;
		case 888:
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

	RecordCnt = Class'UIAPI_LISTCTRL'.GetRecordCount("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl");
	i = 0;
	if ( UnknownFunction150(i,RecordCnt) )
	{
		Record = recordClear;
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl",i);
		Record.LVDataList[4].szData = "0";
		Record.LVDataList[5].szData = "0";
		Record.LVDataList[6].szData = "0";
		Class'UIAPI_LISTCTRL'.ModifyRecord("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl",i,Record);
		UnknownFunction163(i);
		goto JL0052;
	}
	CalculateSumOfDefaultPrice();
}

function HandleSetToday ()
{
	local int i;
	local int RecordCnt;
	local LVDataRecord Record;
	local LVDataRecord recordClear;

	RecordCnt = Class'UIAPI_LISTCTRL'.GetRecordCount("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl");
	i = 0;
	if ( UnknownFunction150(i,RecordCnt) )
	{
		Record = recordClear;
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl",i);
		Record.LVDataList[4].szData = Record.LVDataList[1].szData;
		Record.LVDataList[5].szData = Record.LVDataList[2].szData;
		Record.LVDataList[6].szData = Record.LVDataList[3].szData;
		Class'UIAPI_LISTCTRL'.ModifyRecord("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl",i,Record);
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
	Class'UIAPI_TEXTBOX'.SetText("ManorCropInfoSettingWnd.txtManorName",ManorName);
	DeleteAll();
}

function DeleteAll ()
{
	Class'UIAPI_LISTCTRL'.DeleteAllItem("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl");
}

function OnDBClickListCtrlRecord (string strID)
{
	switch (strID)
	{
		case "ManorCropInfoSettingListCtrl":
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
		DialogSetID(888);
		DialogShow(4,GetSystemMessage(1601));
		break;
		case "btnStop":
		DialogSetID(777);
		DialogShow(4,GetSystemMessage(1600));
		break;
		case "btnOk":
		OnOk();
		HideWindow("ManorCropInfoSettingWnd");
		break;
		case "btnCancel":
		HideWindow("ManorCropInfoSettingWnd");
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

	RecordCount = Class'UIAPI_LISTCTRL'.GetRecordCount("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl");
	ParamAdd(L2jBRVar1,"ManorID",string(m_ManorID));
	ParamAdd(L2jBRVar1,"CropCnt",string(RecordCount));
	i = 0;
	if ( UnknownFunction150(i,RecordCount) )
	{
		Record = recordClear;
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl",i);
		ParamAdd(L2jBRVar1,UnknownFunction112("CropID",string(i)),string(Record.nReserved1));
		ParamAdd(L2jBRVar1,UnknownFunction112("BuyCnt",string(i)),Record.LVDataList[4].szData);
		ParamAdd(L2jBRVar1,UnknownFunction112("Price",string(i)),Record.LVDataList[5].szData);
		ParamAdd(L2jBRVar1,UnknownFunction112("ProcureType",string(i)),Record.LVDataList[6].szData);
		UnknownFunction163(i);
		goto JL0088;
	}
	RequestSetCrop(L2jBRVar1);
}

function HandleAddItem (string _L2jBRVar17_)
{
	local LVDataRecord Record;
	local int CropID;
	local string CropName;
	local int TodayCropTotalCnt;
	local int TodayCropPrice;
	local int TodayProcureType;
	local int NextCropTotalCnt;
	local int NextCropPrice;
	local int NextProcureType;
	local int MinCropPrice;
	local int MaxCropPrice;
	local int CropLevel;
	local string RewardType1;
	local string RewardType2;
	local int MaxCropTotalCnt;
	local int DefaultCropPrice;

	ParseInt(_L2jBRVar17_,"CropID",CropID);
	ParseString(_L2jBRVar17_,"CropName",CropName);
	ParseInt(_L2jBRVar17_,"TodayCropTotalCnt",TodayCropTotalCnt);
	ParseInt(_L2jBRVar17_,"TodayCropPrice",TodayCropPrice);
	ParseInt(_L2jBRVar17_,"TodayProcureType",TodayProcureType);
	ParseInt(_L2jBRVar17_,"NextCropTotalCnt",NextCropTotalCnt);
	ParseInt(_L2jBRVar17_,"NextCropPrice",NextCropPrice);
	ParseInt(_L2jBRVar17_,"NextProcureType",NextProcureType);
	ParseInt(_L2jBRVar17_,"MinCropPrice",MinCropPrice);
	ParseInt(_L2jBRVar17_,"MaxCropPrice",MaxCropPrice);
	ParseInt(_L2jBRVar17_,"CropLevel",CropLevel);
	ParseString(_L2jBRVar17_,"RewardType1",RewardType1);
	ParseString(_L2jBRVar17_,"RewardType2",RewardType2);
	ParseInt(_L2jBRVar17_,"MaxCropTotalCnt",MaxCropTotalCnt);
	ParseInt(_L2jBRVar17_,"DefaultCropPrice",DefaultCropPrice);
	Record.LVDataList.Length = 12;
	Record.LVDataList[0].szData = CropName;
	Record.LVDataList[1].szData = string(TodayCropTotalCnt);
	Record.LVDataList[2].szData = string(TodayCropPrice);
	Record.LVDataList[3].szData = string(TodayProcureType);
	Record.LVDataList[4].szData = string(NextCropTotalCnt);
	Record.LVDataList[5].szData = string(NextCropPrice);
	Record.LVDataList[6].szData = string(NextProcureType);
	Record.LVDataList[7].szData = string(MinCropPrice);
	Record.LVDataList[8].szData = string(MaxCropPrice);
	Record.LVDataList[9].szData = string(CropLevel);
	Record.LVDataList[10].szData = RewardType1;
	Record.LVDataList[11].szData = RewardType2;
	Record.nReserved1 = CropID;
	Record.nReserved2 = MaxCropTotalCnt;
	Record.nReserved3 = DefaultCropPrice;
	Class'UIAPI_LISTCTRL'.InsertRecord("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl",Record);
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
	ItemCnt = Class'UIAPI_LISTCTRL'.GetRecordCount("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl");
	i = 0;
	if ( UnknownFunction150(i,ItemCnt) )
	{
		Record = recordClear;
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl",i);
		tmpMulti = UnknownFunction144(int(Record.LVDataList[5].szData),int(Record.LVDataList[4].szData));
		UnknownFunction161(m_SumOfDefaultPrice,tmpMulti);
		UnknownFunction163(i);
		goto JL0059;
	}
	L2jBRVar14 = MakeCostString(string(m_SumOfDefaultPrice));
	Class'UIAPI_TEXTBOX'.SetText("ManorCropInfoSettingWnd.txtVarNextTotalExpense",L2jBRVar14);
}

function OnChangeBtn ()
{
	local LVDataRecord Record;
	local string L2jBRVar1;

	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl");
	ParamAdd(L2jBRVar1,"CropName",Record.LVDataList[0].szData);
	ParamAdd(L2jBRVar1,"TomorrowVolumeOfBuy",Record.LVDataList[4].szData);
	ParamAdd(L2jBRVar1,"TomorrowLimit",string(Record.nReserved2));
	ParamAdd(L2jBRVar1,"TomorrowPrice",Record.LVDataList[5].szData);
	ParamAdd(L2jBRVar1,"TomorrowProcure",Record.LVDataList[6].szData);
	ParamAdd(L2jBRVar1,"MinCropPrice",Record.LVDataList[7].szData);
	ParamAdd(L2jBRVar1,"MaxCropPrice",Record.LVDataList[8].szData);
	ExecuteEvent(2670,L2jBRVar1);
}

function HandleChangeValue (string _L2jBRVar17_)
{
	local int TomorrowAmountOfPurchase;
	local int TomorrowPurchasePrice;
	local int TomorrowProcure;
	local LVDataRecord Record;
	local int SelectedIndex;

	ParseInt(_L2jBRVar17_,"TomorrowAmountOfPurchase",TomorrowAmountOfPurchase);
	ParseInt(_L2jBRVar17_,"TomorrowPurchasePrice",TomorrowPurchasePrice);
	ParseInt(_L2jBRVar17_,"TomorrowProcure",TomorrowProcure);
	SelectedIndex = Class'UIAPI_LISTCTRL'.GetSelectedIndex("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl");
	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl");
	Record.LVDataList[4].szData = string(TomorrowAmountOfPurchase);
	Record.LVDataList[5].szData = string(TomorrowPurchasePrice);
	Record.LVDataList[6].szData = string(TomorrowProcure);
	Class'UIAPI_LISTCTRL'.ModifyRecord("ManorCropInfoSettingWnd.ManorCropInfoSettingListCtrl",SelectedIndex,Record);
	CalculateSumOfDefaultPrice();
}

