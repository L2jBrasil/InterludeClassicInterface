//================================================================================
// ManorCropSellWnd.
//================================================================================

class ManorCropSellWnd extends UICommonAPI;

const COLUMN_CNT=10;
const REWARD_TYPE_2=9;
const REWARD_TYPE_1=8;
const CROP_LEVEL=7;
const SELL_CNT=6;
const MY_CROP_CNT=5;
const PROCURE_TYPE=4;
const CROP_PRICE=3;
const CROP_REMAIN_CNT=2;
const MANOR_NAME=1;
const CROP_NAME=0;

function OnLoad ()
{
	RegisterEvent(2640);
	RegisterEvent(2645);
	RegisterEvent(2646);
}

function OnEvent (int Event_ID, string _L2jBRVar17_)
{
	switch (Event_ID)
	{
		case 2640:
		if ( IsShowWindow("ManorCropSellWnd") )
		{
			HideWindow("ManorCropSellWnd");
		} else {
			DeleteAll();
			ShowWindowWithFocus("ManorCropSellWnd");
		}
		break;
		case 2645:
		HandleAddItem(_L2jBRVar17_);
		break;
		case 2646:
		HandleSetCropSell(_L2jBRVar17_);
		break;
		default:
	}
}

function DeleteAll ()
{
	Class'UIAPI_LISTCTRL'.DeleteAllItem("ManorCropSellWnd.ManorCropSellListCtrl");
}

function OnDBClickListCtrlRecord (string strID)
{
	switch (strID)
	{
		case "ManorCropSellListCtrl":
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
		case "btnSell":
		OnSellBtn();
		break;
		case "btnCancel":
		HideWindow("ManorCropSellWnd");
		break;
		default:
	}
}

function OnSellBtn ()
{
	local int RecordCount;
	local LVDataRecord Record;
	local int SellCnt;
	local int CropCnt;
	local int CropNum;
	local int i;
	local string L2jBRVar1;

	RecordCount = Class'UIAPI_LISTCTRL'.GetRecordCount("ManorCropSellWnd.ManorCropSellListCtrl");
	CropCnt = 0;
	i = 0;
	if ( UnknownFunction150(i,RecordCount) )
	{
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ManorCropSellWnd.ManorCropSellListCtrl",i);
		SellCnt = int(Record.LVDataList[6].szData);
		if ( UnknownFunction151(SellCnt,0) )
		{
			UnknownFunction165(CropCnt);
		}
		UnknownFunction163(i);
		goto JL004B;
	}
	ParamAdd(L2jBRVar1,"CropCnt",string(CropCnt));
	CropNum = 0;
	i = 0;
	if ( UnknownFunction150(i,RecordCount) )
	{
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ManorCropSellWnd.ManorCropSellListCtrl",i);
		SellCnt = int(Record.LVDataList[6].szData);
		if ( UnknownFunction152(SellCnt,0) )
		{
			goto JL022B;
		}
		ParamAdd(L2jBRVar1,UnknownFunction112("CropServerID",string(CropNum)),string(Record.nReserved3));
		ParamAdd(L2jBRVar1,UnknownFunction112("CropID",string(CropNum)),string(Record.nReserved2));
		ParamAdd(L2jBRVar1,UnknownFunction112("ManorID",string(CropNum)),string(Record.nReserved1));
		ParamAdd(L2jBRVar1,UnknownFunction112("SellCount",string(CropNum)),Record.LVDataList[6].szData);
		UnknownFunction165(CropNum);
		UnknownFunction163(i);
		goto JL00FB;
	}
	RequestProcureCropList(L2jBRVar1);
	HideWindow("ManorCropSellWnd");
}

function OnChangeBtn ()
{
	local LVDataRecord Record;
	local int SelectedIndex;
	local int CropID;
	local string ManorCropSellChangeWndString;
	local string L2jBRVar1;

	SelectedIndex = Class'UIAPI_LISTCTRL'.GetSelectedIndex("ManorCropSellWnd.ManorCropSellListCtrl");
	if ( UnknownFunction154(SelectedIndex,-1) )
	{
		return;
	}
	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("ManorCropSellWnd.ManorCropSellListCtrl");
	CropID = Record.nReserved2;
	ManorCropSellChangeWndString = UnknownFunction112(UnknownFunction112("manor_menu_select?ask=9&state=",string(CropID)),"&time=0");
	RequestBypassToServer(ManorCropSellChangeWndString);
	ParamAdd(L2jBRVar1,"CropName",Record.LVDataList[0].szData);
	ParamAdd(L2jBRVar1,"RewardType1",Record.LVDataList[8].szData);
	ParamAdd(L2jBRVar1,"RewardType2",Record.LVDataList[9].szData);
	ExecuteEvent(2649,L2jBRVar1);
}

function HandleAddItem (string _L2jBRVar17_)
{
	local LVDataRecord Record;
	local string CropName;
	local string ManorName;
	local int CropRemainCnt;
	local int CropPrice;
	local int ProcureType;
	local int MyCropCnt;
	local int CropLevel;
	local string RewardType1;
	local string RewardType2;
	local int ManorID;
	local int CropID;
	local int CropServerID;

	Record.LVDataList.Length = 10;
	ParseString(_L2jBRVar17_,"CropName",CropName);
	ParseString(_L2jBRVar17_,"ManorName",ManorName);
	ParseInt(_L2jBRVar17_,"CropRemainCnt",CropRemainCnt);
	ParseInt(_L2jBRVar17_,"CropPrice",CropPrice);
	ParseInt(_L2jBRVar17_,"ProcureType",ProcureType);
	ParseInt(_L2jBRVar17_,"MyCropCnt",MyCropCnt);
	ParseInt(_L2jBRVar17_,"CropLevel",CropLevel);
	ParseString(_L2jBRVar17_,"RewardType1",RewardType1);
	ParseString(_L2jBRVar17_,"RewardType2",RewardType2);
	ParseInt(_L2jBRVar17_,"ManorID",ManorID);
	ParseInt(_L2jBRVar17_,"CropID",CropID);
	ParseInt(_L2jBRVar17_,"CropServerID",CropServerID);
	Record.LVDataList[0].szData = CropName;
	Record.LVDataList[1].szData = ManorName;
	Record.LVDataList[2].szData = string(CropRemainCnt);
	Record.LVDataList[3].szData = string(CropPrice);
	Record.LVDataList[4].szData = string(ProcureType);
	Record.LVDataList[5].szData = string(MyCropCnt);
	Record.LVDataList[6].szData = "0";
	Record.LVDataList[7].szData = string(CropLevel);
	Record.LVDataList[8].szData = RewardType1;
	Record.LVDataList[9].szData = RewardType2;
	Record.nReserved1 = ManorID;
	Record.nReserved2 = CropID;
	Record.nReserved3 = CropServerID;
	Class'UIAPI_LISTCTRL'.InsertRecord("ManorCropSellWnd.ManorCropSellListCtrl",Record);
}

function HandleSetCropSell (string _L2jBRVar17_)
{
	local string SellCntString;
	local int ManorID;
	local string ManorName;
	local string CropRemainCntString;
	local string CropPriceString;
	local string ProcureTypeString;
	local int SelectedIndex;
	local LVDataRecord Record;

	ParseString(_L2jBRVar17_,"SellCntString",SellCntString);
	ParseInt(_L2jBRVar17_,"ManorID",ManorID);
	ParseString(_L2jBRVar17_,"ManorName",ManorName);
	ParseString(_L2jBRVar17_,"CropRemainCntString",CropRemainCntString);
	ParseString(_L2jBRVar17_,"CropPriceString",CropPriceString);
	ParseString(_L2jBRVar17_,"ProcureTypeString",ProcureTypeString);
	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("ManorCropSellWnd.ManorCropSellListCtrl");
	Record.LVDataList[1].szData = ManorName;
	Record.LVDataList[2].szData = CropRemainCntString;
	Record.LVDataList[3].szData = CropPriceString;
	Record.LVDataList[4].szData = ProcureTypeString;
	Record.LVDataList[6].szData = SellCntString;
	Record.nReserved1 = ManorID;
	SelectedIndex = Class'UIAPI_LISTCTRL'.GetSelectedIndex("ManorCropSellWnd.ManorCropSellListCtrl");
	Class'UIAPI_LISTCTRL'.ModifyRecord("ManorCropSellWnd.ManorCropSellListCtrl",SelectedIndex,Record);
}

