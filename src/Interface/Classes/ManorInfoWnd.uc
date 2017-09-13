//================================================================================
// ManorInfoWnd.
//================================================================================

class ManorInfoWnd extends UICommonAPI;

var bool m_bTime;
var int m_MerchantOrChamberlain;
var int m_ManorID;
var int m_MyManorID;
const DEFAULT_MAX_COLUMN=6;
const DEFAULT_REWARD_TYPE_2=5;
const DEFAULT_REWARD_TYPE_1=4;
const DEFAULT_CROP_PRICE=3;
const DEFAULT_SEED_PRICE=2;
const DEFAULT_CROP_LEVEL=1;
const DEFAULT_CROP_NAME=0;
const CROP_MAX_COLUMN=8;
const CROP_REWARD_TYPE_2=7;
const CROP_REWARD_TYPE_1=6;
const CROP_LEVEL=5;
const CROP_PROCURE_TYPE=4;
const CROP_PRICE=3;
const CROP_TOTLAL_CNT=2;
const CROP_REMAIN_CNT=1;
const CROP_NAME=0;
const SEED_MAX_COLUMN=7;
const SEED_REWARD_TYPE_2=6;
const SEED_REWARD_TYPE_1=5;
const SEED_LEVEL=4;
const SEED_PRICE=3;
const SEED_TOTLAL_CNT=2;
const SEED_REMAIN_CNT=1;
const SEED_NAME=0;

function OnLoad ()
{
	RegisterEvent(2650);
	RegisterEvent(2652);
	RegisterEvent(2654);
	RegisterEvent(2651);
	RegisterEvent(2653);
	RegisterEvent(2655);
	m_MerchantOrChamberlain = 0;
	m_ManorID = -1;
	m_MyManorID = -1;
	m_bTime = False;
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2650:
		HandleSeedInfoShow(_L2jBRVar17_);
		break;
		case 2651:
		HandleSeedAdd(_L2jBRVar17_);
		break;
		case 2652:
		HandleCropInfoShow(_L2jBRVar17_);
		break;
		case 2653:
		HandleCropAdd(_L2jBRVar17_);
		break;
		case 2654:
		HandleDefaultInfoShow(_L2jBRVar17_);
		break;
		case 2655:
		HandleDefaultAdd(_L2jBRVar17_);
		break;
		default:
	}
}

function HandleSeedInfoShow (string _L2jBRVar17_)
{
	local int MerchantOrChamberlain;
	local int NumOfManor;
	local int i;
	local int ManorID;
	local string ManorName;
	local string ParamString;
	local string Message;
	local int ManorCnt;
	local string MyManorName;

	ParseInt(_L2jBRVar17_,"MerchantOrChamberlain",MerchantOrChamberlain);
	ParseInt(_L2jBRVar17_,"ManorID",ManorID);
	ParseString(_L2jBRVar17_,"ManorName",ManorName);
	m_MerchantOrChamberlain = MerchantOrChamberlain;
	m_ManorID = ManorID;
	Debug(UnknownFunction112("HandleSeedInfoShow - m_ManorID:",string(m_ManorID)));
	Class'UIAPI_LISTCTRL'.DeleteAllItem("ManorInfoWnd.SeedInfoWnd.SeedInfoListCtrl");
	Class'UIAPI_COMBOBOX'.Clear("ManorInfoWnd.SeedInfoWnd.cbManorSelectInSeedInfo");
	i = 0;
	if ( UnknownFunction150(i,GetManorCount()) )
	{
		ManorID = GetManorIDInManorList(i);
		Class'UIAPI_COMBOBOX'.AddStringWithReserved("ManorInfoWnd.SeedInfoWnd.cbManorSelectInSeedInfo",GetManorNameInManorList(i),ManorID);
		UnknownFunction163(i);
		goto JL0123;
	}
	NumOfManor = Class'UIAPI_COMBOBOX'.GetNumOfItems("ManorInfoWnd.SeedInfoWnd.cbManorSelectInSeedInfo");
	i = 0;
	if ( UnknownFunction150(i,NumOfManor) )
	{
		if ( UnknownFunction154(m_ManorID,Class'UIAPI_COMBOBOX'.GetReserved("ManorInfoWnd.SeedInfoWnd.cbManorSelectInSeedInfo",i)) )
		{
			Class'UIAPI_COMBOBOX'.SetSelectedNum("ManorInfoWnd.SeedInfoWnd.cbManorSelectInSeedInfo",i);
		} else {
			UnknownFunction163(i);
			goto JL01ED;
		}
	}
	if ( UnknownFunction129(IsShowWindow("ManorInfoWnd")) )
	{
		m_MyManorID = m_ManorID;
	}
	if ( UnknownFunction154(MerchantOrChamberlain,1) )
	{
		HideWindow("ManorInfoWnd.SeedInfoWnd.btnBuySeed");
	} else {
		ShowWindow("ManorInfoWnd.SeedInfoWnd.btnBuySeed");
		ManorCnt = GetManorCount();
		i = 0;
		if ( UnknownFunction150(i,ManorCnt) )
		{
			if ( UnknownFunction154(m_MyManorID,GetManorIDInManorList(i)) )
			{
				MyManorName = GetManorNameInManorList(i);
			} else {
				UnknownFunction163(i);
				goto JL033A;
			}
		}
		ParamAdd(ParamString,"Type",string(0));
		ParamAdd(ParamString,"param1",MyManorName);
		AddSystemMessageParam(ParamString);
		Message = EndSystemMessageParam(1605,True);
		Class'UIAPI_TEXTBOX'.SetText("ManorInfoWnd.SeedInfoWnd.txtNotice",Message);
	}
	ShowWindowWithFocus("ManorInfoWnd");
	HideWindow("ManorInfoWnd.CropInfoWnd");
	HideWindow("ManorInfoWnd.DefaultInfoWnd");
	Class'UIAPI_TABCTRL'.SetTopOrder("ManorInfoWnd.ManorInfoTabCtrl",0,False);
	if ( UnknownFunction129(IsShowWindow("ManorInfoWnd.SeedInfoWnd")) )
	{
		Class'UIAPI_COMBOBOX'.SetSelectedNum("ManorInfoWnd.CropInfoWnd.cbManorSelectInCropInfo",-1);
		ShowWindowWithFocus("ManorInfoWnd.SeedInfoWnd");
		Debug(UnknownFunction112(UnknownFunction112(UnknownFunction112("HandleSeedInfoShow  !IsShowWindow 안 - m_ManorID:",string(m_ManorID)),"m_MyManorID:"),string(m_MyManorID)));
	}
}

function HandleSeedAdd (string _L2jBRVar17_)
{
	local int SeedID;
	local string SeedName;
	local int SeedRemainCnt;
	local int SeedTotalCnt;
	local int SeedPrice;
	local int SeedLevel;
	local string RewardType1;
	local string RewardType2;
	local LVDataRecord Record;

	ParseInt(_L2jBRVar17_,"SeedID",SeedID);
	ParseString(_L2jBRVar17_,"SeedName",SeedName);
	ParseInt(_L2jBRVar17_,"SeedRemainCnt",SeedRemainCnt);
	ParseInt(_L2jBRVar17_,"SeedTotalCnt",SeedTotalCnt);
	ParseInt(_L2jBRVar17_,"SeedPrice",SeedPrice);
	ParseInt(_L2jBRVar17_,"SeedLevel",SeedLevel);
	ParseString(_L2jBRVar17_,"RewardType1",RewardType1);
	ParseString(_L2jBRVar17_,"RewardType2",RewardType2);
	Record.LVDataList.Length = 7;
	Record.LVDataList[0].szData = SeedName;
	Record.LVDataList[1].szData = string(SeedRemainCnt);
	Record.LVDataList[2].szData = string(SeedTotalCnt);
	Record.LVDataList[3].szData = string(SeedPrice);
	Record.LVDataList[4].szData = string(SeedLevel);
	Record.LVDataList[5].szData = RewardType1;
	Record.LVDataList[6].szData = RewardType2;
	Class'UIAPI_LISTCTRL'.InsertRecord("ManorInfoWnd.SeedInfoWnd.SeedInfoListCtrl",Record);
}

function HandleCropInfoShow (string _L2jBRVar17_)
{
	local int MerchantOrChamberlain;
	local int NumOfManor;
	local int i;
	local int ManorID;

	ParseInt(_L2jBRVar17_,"MerchantOrChamberlain",MerchantOrChamberlain);
	ParseInt(_L2jBRVar17_,"ManorID",ManorID);
	m_MerchantOrChamberlain = MerchantOrChamberlain;
	m_ManorID = ManorID;
	Class'UIAPI_LISTCTRL'.DeleteAllItem("ManorInfoWnd.CropInfoWnd.CropInfoListCtrl");
	Class'UIAPI_COMBOBOX'.Clear("ManorInfoWnd.CropInfoWnd.cbManorSelectInCropInfo");
	i = 0;
	if ( UnknownFunction150(i,GetManorCount()) )
	{
		ManorID = GetManorIDInManorList(i);
		Class'UIAPI_COMBOBOX'.AddStringWithReserved("ManorInfoWnd.CropInfoWnd.cbManorSelectInCropInfo",GetManorNameInManorList(i),ManorID);
		UnknownFunction163(i);
		goto JL00D8;
	}
	NumOfManor = Class'UIAPI_COMBOBOX'.GetNumOfItems("ManorInfoWnd.CropInfoWnd.cbManorSelectInCropInfo");
	i = 0;
	if ( UnknownFunction150(i,NumOfManor) )
	{
		if ( UnknownFunction154(m_ManorID,Class'UIAPI_COMBOBOX'.GetReserved("ManorInfoWnd.CropInfoWnd.cbManorSelectInCropInfo",i)) )
		{
			Class'UIAPI_COMBOBOX'.SetSelectedNum("ManorInfoWnd.CropInfoWnd.cbManorSelectInCropInfo",i);
		} else {
			UnknownFunction163(i);
			goto JL01A2;
		}
	}
	if ( UnknownFunction154(MerchantOrChamberlain,1) )
	{
		HideWindow("ManorInfoWnd.CropInfoWnd.btnSellCrop");
	} else {
		ShowWindow("ManorInfoWnd.CropInfoWnd.btnSellCrop");
	}
	if ( UnknownFunction129(IsShowWindow("ManorInfoWnd.CropInfoWnd")) )
	{
		ShowWindowWithFocus("ManorInfoWnd.CropInfoWnd");
		if ( UnknownFunction129(IsShowWindow("ManorInfoWnd")) )
		{
			ShowWindow("ManorInfoWnd");
		}
		HideWindow("ManorInfoWnd.SeedInfoWnd");
		HideWindow("ManorInfoWnd.DefaultInfoWnd");
	}
}

function HandleCropAdd (string _L2jBRVar17_)
{
	local int CropID;
	local string CropName;
	local int CropRemainCnt;
	local int CropTotalCnt;
	local int CropPrice;
	local int ProcureType;
	local int CropLevel;
	local string RewardType1;
	local string RewardType2;
	local LVDataRecord Record;

	ParseInt(_L2jBRVar17_,"CropID",CropID);
	ParseString(_L2jBRVar17_,"CropName",CropName);
	ParseInt(_L2jBRVar17_,"CropRemainCnt",CropRemainCnt);
	ParseInt(_L2jBRVar17_,"CropTotalCnt",CropTotalCnt);
	ParseInt(_L2jBRVar17_,"CropPrice",CropPrice);
	ParseInt(_L2jBRVar17_,"ProcureType",ProcureType);
	ParseInt(_L2jBRVar17_,"CropLevel",CropLevel);
	ParseString(_L2jBRVar17_,"RewardType1",RewardType1);
	ParseString(_L2jBRVar17_,"RewardType2",RewardType2);
	Record.LVDataList.Length = 8;
	Record.LVDataList[0].szData = CropName;
	Record.LVDataList[1].szData = string(CropRemainCnt);
	Record.LVDataList[2].szData = string(CropTotalCnt);
	Record.LVDataList[3].szData = string(CropPrice);
	Record.LVDataList[4].szData = string(ProcureType);
	Record.LVDataList[5].szData = string(CropLevel);
	Record.LVDataList[6].szData = RewardType1;
	Record.LVDataList[7].szData = RewardType2;
	Class'UIAPI_LISTCTRL'.InsertRecord("ManorInfoWnd.CropInfoWnd.CropInfoListCtrl",Record);
}

function HandleDefaultInfoShow (string _L2jBRVar17_)
{
	local int MerchantOrChamberlain;

	ParseInt(_L2jBRVar17_,"MerchantOrChamberlain",MerchantOrChamberlain);
	m_MerchantOrChamberlain = MerchantOrChamberlain;
	Class'UIAPI_LISTCTRL'.DeleteAllItem("ManorInfoWnd.DefaultInfoWnd.DefaultInfoListCtrl");
	if ( UnknownFunction154(MerchantOrChamberlain,1) )
	{
		HideWindow("ManorInfoWnd.DefaultInfoWnd.btnSellCrop");
		HideWindow("ManorInfoWnd.DefaultInfoWnd.btnBuySeed");
	} else {
		ShowWindow("ManorInfoWnd.DefaultInfoWnd.btnSellCrop");
		ShowWindow("ManorInfoWnd.DefaultInfoWnd.btnBuySeed");
	}
	ShowWindowWithFocus("ManorInfoWnd");
	ShowWindowWithFocus("ManorInfoWnd.DefaultInfoWnd");
	Class'UIAPI_TABCTRL'.SetTopOrder("ManorInfoWnd.ManorInfoTabCtrl",2,False);
	HideWindow("ManorInfoWnd.SeedInfoWnd");
	HideWindow("ManorInfoWnd.CropInfoWnd");
}

function HandleDefaultAdd (string _L2jBRVar17_)
{
	local int CropID;
	local string CropName;
	local int CropLevel;
	local int SeedPrice;
	local int CropPrice;
	local string RewardType1;
	local string RewardType2;
	local LVDataRecord Record;

	ParseInt(_L2jBRVar17_,"CropID",CropID);
	ParseString(_L2jBRVar17_,"CropName",CropName);
	ParseInt(_L2jBRVar17_,"CropLevel",CropLevel);
	ParseInt(_L2jBRVar17_,"SeedPrice",SeedPrice);
	ParseInt(_L2jBRVar17_,"CropPrice",CropPrice);
	ParseString(_L2jBRVar17_,"RewardType1",RewardType1);
	ParseString(_L2jBRVar17_,"RewardType2",RewardType2);
	Record.LVDataList.Length = 6;
	Record.LVDataList[0].szData = CropName;
	Record.LVDataList[1].szData = string(CropLevel);
	Record.LVDataList[2].szData = string(SeedPrice);
	Record.LVDataList[3].szData = string(CropPrice);
	Record.LVDataList[4].szData = RewardType1;
	Record.LVDataList[5].szData = RewardType2;
	Class'UIAPI_LISTCTRL'.InsertRecord("ManorInfoWnd.DefaultInfoWnd.DefaultInfoListCtrl",Record);
}

function OnClickButton (string strID)
{
	Debug(strID);
	switch (strID)
	{
		case "btnBuySeed":
		RequestBypassToServer("manor_menu_select?ask=1&state=-1&time=0");
		break;
		case "btnSellCrop":
		RequestBypassToServer("manor_menu_select?ask=2&state=-1&time=0");
		break;
		case "ManorInfoTabCtrl0":
		OnClickInfoTab("SeedInfo");
		break;
		case "ManorInfoTabCtrl1":
		OnClickInfoTab("CropInfo");
		break;
		case "ManorInfoTabCtrl2":
		RequestBypassToServer("manor_menu_select?ask=5&state=-1&time=0");
		break;
		default:
	}
}

function OnClickInfoTab (string tabname)
{
	local int SelectedManorID;
	local int SelectedTime;
	local string RequestString;
	local string PreString;
	local int Index;
	local string ManorComboBoxName;
	local string TimeComboBoxName;

	switch (tabname)
	{
		case "SeedInfo":
		PreString = "manor_menu_select?ask=3&state=";
		ManorComboBoxName = "ManorInfoWnd.SeedInfoWnd.cbManorSelectInSeedInfo";
		TimeComboBoxName = "ManorInfoWnd.SeedInfoWnd.cbTimeInSeedInfo";
		break;
		case "CropInfo":
		PreString = "manor_menu_select?ask=4&state=";
		ManorComboBoxName = "ManorInfoWnd.CropInfoWnd.cbManorSelectInCropInfo";
		TimeComboBoxName = "ManorInfoWnd.CropInfoWnd.cbTimeInCropInfo";
		break;
		default:
	}
	Index = Class'UIAPI_COMBOBOX'.GetSelectedNum(ManorComboBoxName);
	SelectedManorID = Class'UIAPI_COMBOBOX'.GetReserved(ManorComboBoxName,Index);
	SelectedTime = Class'UIAPI_COMBOBOX'.GetSelectedNum(TimeComboBoxName);
	Debug(UnknownFunction112("ID:",string(SelectedManorID)));
	if ( UnknownFunction130(UnknownFunction122(tabname,"CropInfo"),UnknownFunction154(SelectedManorID,-1)) )
	{
		SelectedManorID = m_MyManorID;
	}
	if ( UnknownFunction155(SelectedManorID,0) )
	{
		Debug(UnknownFunction112("장원ID - ID:",string(SelectedManorID)));
		RequestString = UnknownFunction112(UnknownFunction112(UnknownFunction112(PreString,string(SelectedManorID)),"&time="),string(SelectedTime));
		RequestBypassToServer(RequestString);
	} else {
		Debug(UnknownFunction112("장원ID 오류 - ID:",string(SelectedManorID)));
	}
}

function OnComboBoxItemSelected (string sName, int Index)
{
	Debug(UnknownFunction112(UnknownFunction112(sName,", index:"),string(Index)));
	switch (sName)
	{
		case "cbManorSelectInSeedInfo":
		m_bTime = False;
		RequestSelectedData("SeedInfo",Index);
		break;
		case "cbTimeInSeedInfo":
		m_bTime = True;
		RequestSelectedData("SeedInfo",Index);
		break;
		case "cbManorSelectInCropInfo":
		m_bTime = False;
		RequestSelectedData("CropInfo",Index);
		break;
		case "cbTimeInCropInfo":
		m_bTime = True;
		RequestSelectedData("CropInfo",Index);
		break;
		default:
	}
}

function RequestSelectedData (string WindowName, int Index)
{
	local int ManorID;
	local string RequestString;
	local string PreString;
	local int Time;
	local string ManorComboBoxName;
	local string TimeComboBoxName;

	if ( UnknownFunction122(WindowName,"SeedInfo") )
	{
		PreString = "manor_menu_select?ask=3&state=";
		ManorComboBoxName = "ManorInfoWnd.SeedInfoWnd.cbManorSelectInSeedInfo";
		TimeComboBoxName = "ManorInfoWnd.SeedInfoWnd.cbTimeInSeedInfo";
	} else {
		PreString = "manor_menu_select?ask=4&state=";
		ManorComboBoxName = "ManorInfoWnd.CropInfoWnd.cbManorSelectInCropInfo";
		TimeComboBoxName = "ManorInfoWnd.CropInfoWnd.cbTimeInCropInfo";
	}
	if ( m_bTime )
	{
		ManorID = m_ManorID;
		Time = Class'UIAPI_COMBOBOX'.GetSelectedNum(TimeComboBoxName);
	} else {
		ManorID = Class'UIAPI_COMBOBOX'.GetReserved(ManorComboBoxName,Index);
		Time = Class'UIAPI_COMBOBOX'.GetSelectedNum(TimeComboBoxName);
	}
	if ( UnknownFunction151(ManorID,0) )
	{
		Debug(UnknownFunction112("장원ID",string(ManorID)));
		RequestString = UnknownFunction112(UnknownFunction112(UnknownFunction112(PreString,string(ManorID)),"&time="),string(Time));
	} else {
		Debug(UnknownFunction112("장원ID오류 : ",string(ManorID)));
	}
	RequestBypassToServer(RequestString);
}

