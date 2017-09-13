//================================================================================
// ManorCropSellChangeWnd.
//================================================================================

class ManorCropSellChangeWnd extends UICommonAPI;

const COLUMN_CNT=4;
const PROCURE_TYPE=3;
const CROP_PRICE=2;
const CROP_REMAIN_CNT=1;
const MANOR_NAME=0;

function OnLoad ()
{
	RegisterEvent(2647);
	RegisterEvent(2648);
	RegisterEvent(2649);
}

function OnEvent (int Event_ID, string _L2jBRVar17_)
{
	switch (Event_ID)
	{
		case 2647:
		if ( IsShowWindow("ManorCropSellChangeWnd") )
		{
			HideWindow("ManorCropSellChangeWnd");
		} else {
			Clear();
			ShowWindowWithFocus("ManorCropSellChangeWnd");
		}
		break;
		case 2648:
		HandleAddItem(_L2jBRVar17_);
		break;
		case 2649:
		HandleSetCropNameAndRewardType(_L2jBRVar17_);
		break;
		default:
	}
}

function Clear ()
{
	Class'UIAPI_LISTCTRL'.DeleteAllItem("ManorCropSellChangeWnd.ManorCropSellChangeListCtrl");
	Class'UIAPI_COMBOBOX'.Clear("ManorCropSellChangeWnd.cbPurchasePlace");
	Class'UIAPI_COMBOBOX'.SYS_AddStringWithReserved("ManorCropSellChangeWnd.cbPurchasePlace",1276,-1);
	Class'UIAPI_COMBOBOX'.SetSelectedNum("ManorCropSellChangeWnd.cbPurchasePlace",0);
	Class'UIAPI_EDITBOX'.Clear("ManorCropSellChangeWnd.ebSalesVolume");
}

function HandleSetCropNameAndRewardType (string _L2jBRVar17_)
{
	local string CropName;
	local string RewardType1;
	local string RewardType2;

	ParseString(_L2jBRVar17_,"CropName",CropName);
	ParseString(_L2jBRVar17_,"RewardType1",RewardType1);
	ParseString(_L2jBRVar17_,"RewardType2",RewardType2);
	Class'UIAPI_TEXTBOX'.SetText("ManorCropSellChangeWnd.txtVarCropName",CropName);
	Class'UIAPI_TEXTBOX'.SetText("ManorCropSellChangeWnd.txtVarRewardType1",RewardType1);
	Class'UIAPI_TEXTBOX'.SetText("ManorCropSellChangeWnd.txtVarRewardType2",RewardType2);
}

function HandleAddItem (string _L2jBRVar17_)
{
	local LVDataRecord Record;
	local string ManorName;
	local int CropRemainCnt;
	local int CropPrice;
	local int ProcureType;
	local int ManorID;

	Record.LVDataList.Length = 4;
	ParseString(_L2jBRVar17_,"ManorName",ManorName);
	ParseInt(_L2jBRVar17_,"CropRemainCnt",CropRemainCnt);
	ParseInt(_L2jBRVar17_,"CropPrice",CropPrice);
	ParseInt(_L2jBRVar17_,"ProcureType",ProcureType);
	ParseInt(_L2jBRVar17_,"ManorID",ManorID);
	Record.LVDataList[0].szData = ManorName;
	Record.LVDataList[1].szData = string(CropRemainCnt);
	Record.LVDataList[2].szData = string(CropPrice);
	Record.LVDataList[3].szData = string(ProcureType);
	Record.nReserved1 = ManorID;
	Class'UIAPI_LISTCTRL'.InsertRecord("ManorCropSellChangeWnd.ManorCropSellChangeListCtrl",Record);
	Class'UIAPI_COMBOBOX'.AddStringWithReserved("ManorCropSellChangeWnd.cbPurchasePlace",ManorName,ManorID);
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnMax":
		HandleMaxButton();
		break;
		case "btnOk":
		HandleOkBtn();
		break;
		case "btnCancel":
		HideWindow("ManorCropSellChangeWnd");
		break;
		default:
	}
}

function HandleMaxButton ()
{
	local LVDataRecord Record;
	local int ManorID;
	local int MyCropCnt;
	local int CropRemainCnt;
	local int MinValue;
	local string MinValueString;

	Record = GetComboBoxSelectedRecord();
	CropRemainCnt = int(Record.LVDataList[1].szData);
	ManorID = GetComboBoxSelectedManorID();
	if ( UnknownFunction154(ManorID,-1) )
	{
		return;
	}
	MyCropCnt = GetMyCropCnt(ManorID);
	MinValue = UnknownFunction249(MyCropCnt,CropRemainCnt);
	if ( UnknownFunction154(MinValue,-1) )
	{
		MinValueString = "0";
	} else {
		MinValueString = string(MinValue);
	}
	Class'UIAPI_EDITBOX'.SetString("ManorCropSellChangeWnd.ebSalesVolume",MinValueString);
}

function HandleOkBtn ()
{
	local LVDataRecord Record;
	local int ManorID;
	local string SellCntString;
	local string L2jBRVar1;

	Record = GetComboBoxSelectedRecord();
	SellCntString = Class'UIAPI_EDITBOX'.GetString("ManorCropSellChangeWnd.ebSalesVolume");
	ManorID = Record.nReserved1;
	ParamAdd(L2jBRVar1,"SellCntString",SellCntString);
	ParamAdd(L2jBRVar1,"ManorID",string(ManorID));
	ParamAdd(L2jBRVar1,"ManorName",Record.LVDataList[0].szData);
	ParamAdd(L2jBRVar1,"CropRemainCntString",Record.LVDataList[1].szData);
	ParamAdd(L2jBRVar1,"CropPriceString",Record.LVDataList[2].szData);
	ParamAdd(L2jBRVar1,"ProcureTypeString",Record.LVDataList[3].szData);
	ExecuteEvent(2646,L2jBRVar1);
	HideWindow("ManorCropSellChangeWnd");
}

function int GetComboBoxSelectedManorID ()
{
	local int ManorID;
	local int cbSelectedIndex;

	cbSelectedIndex = Class'UIAPI_COMBOBOX'.GetSelectedNum("ManorCropSellChangeWnd.cbPurchasePlace");
	ManorID = Class'UIAPI_COMBOBOX'.GetReserved("ManorCropSellChangeWnd.cbPurchasePlace",cbSelectedIndex);
	return ManorID;
}

function LVDataRecord GetComboBoxSelectedRecord ()
{
	local LVDataRecord Record;
	local int ManorID;
	local int RecordCount;
	local int i;

	ManorID = GetComboBoxSelectedManorID();
	RecordCount = Class'UIAPI_LISTCTRL'.GetRecordCount("ManorCropSellChangeWnd.ManorCropSellChangeListCtrl");
	i = 0;
	if ( UnknownFunction150(i,RecordCount) )
	{
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ManorCropSellChangeWnd.ManorCropSellChangeListCtrl",i);
		if ( UnknownFunction154(Record.nReserved1,ManorID) )
		{
			goto JL00DA;
		}
		UnknownFunction163(i);
		goto JL005C;
	}
	return Record;
}

function int GetMyCropCnt (int ManorID)
{
	local int MyCropCnt;
	local LVDataRecord Record;

	MyCropCnt = -1;
	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("ManorCropSellWnd.ManorCropSellListCtrl");
	MyCropCnt = int(Record.LVDataList[5].szData);
	return MyCropCnt;
}

