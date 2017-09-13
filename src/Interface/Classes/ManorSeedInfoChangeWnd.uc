//================================================================================
// ManorSeedInfoChangeWnd.
//================================================================================

class ManorSeedInfoChangeWnd extends UICommonAPI;

var int m_MinCropPrice;
var int m_MaxCropPrice;
var int m_TomorrowLimit;

function OnLoad ()
{
	RegisterEvent(2660);
}

function OnEvent (int Event_ID, string _L2jBRVar17_)
{
	switch (Event_ID)
	{
		case 2660:
		HandleShow(_L2jBRVar17_);
		break;
		default:
	}
}

function HandleShow (string _L2jBRVar17_)
{
	local string SeedName;
	local int TomorrowVolumeOfSales;
	local int TomorrowLimit;
	local int TomorrowPrice;
	local int MinCropPrice;
	local int MaxCropPrice;
	local string TomorrowLimitString;

	ParseString(_L2jBRVar17_,"SeedName",SeedName);
	ParseInt(_L2jBRVar17_,"TomorrowVolumeOfSales",TomorrowVolumeOfSales);
	ParseInt(_L2jBRVar17_,"TomorrowLimit",TomorrowLimit);
	ParseInt(_L2jBRVar17_,"TomorrowPrice",TomorrowPrice);
	ParseInt(_L2jBRVar17_,"MinCropPrice",MinCropPrice);
	ParseInt(_L2jBRVar17_,"MaxCropPrice",MaxCropPrice);
	Class'UIAPI_TEXTBOX'.SetText("ManorSeedInfoChangeWnd.txtSeedName",SeedName);
	Class'UIAPI_EDITBOX'.SetString("ManorSeedInfoChangeWnd.ebTomorrowSalesVolume",string(TomorrowVolumeOfSales));
	m_TomorrowLimit = TomorrowLimit;
	TomorrowLimitString = MakeCostString(string(TomorrowLimit));
	Class'UIAPI_TEXTBOX'.SetText("ManorSeedInfoChangeWnd.txtVarTomorrowLimit",TomorrowLimitString);
	Class'UIAPI_EDITBOX'.SetString("ManorSeedInfoChangeWnd.ebTomorrowPrice",string(TomorrowPrice));
	m_MinCropPrice = MinCropPrice;
	m_MaxCropPrice = MaxCropPrice;
	ShowWindowWithFocus("ManorSeedInfoChangeWnd");
	Class'UIAPI_WINDOW'.SetFocus("ManorSeedInfoChangeWnd.ebTomorrowSalesVolume");
}

function OnClickButton (string strID)
{
	Debug(UnknownFunction112(" ",strID));
	switch (strID)
	{
		case "btnOk":
		OnClickBtnOk();
		break;
		case "btnCancel":
		HideWindow("ManorSeedInfoChangeWnd");
		break;
		default:
	}
}

function OnClickBtnOk ()
{
	local int InputTomorrowSalesVolume;
	local int InputTomorrowPrice;
	local string ParamString;

	InputTomorrowSalesVolume = int(Class'UIAPI_EDITBOX'.GetString("ManorSeedInfoChangeWnd.ebTomorrowSalesVolume"));
	InputTomorrowPrice = int(Class'UIAPI_EDITBOX'.GetString("ManorSeedInfoChangeWnd.ebTomorrowPrice"));
	if ( UnknownFunction132(UnknownFunction150(InputTomorrowSalesVolume,0),UnknownFunction151(InputTomorrowSalesVolume,m_TomorrowLimit)) )
	{
		ShowErrorDialog(0,m_TomorrowLimit,1558);
		return;
	}
	if ( UnknownFunction130(UnknownFunction155(InputTomorrowSalesVolume,0),UnknownFunction132(UnknownFunction150(InputTomorrowPrice,m_MinCropPrice),UnknownFunction151(InputTomorrowPrice,m_MaxCropPrice))) )
	{
		ShowErrorDialog(m_MinCropPrice,m_MaxCropPrice,1557);
		return;
	}
	ParamAdd(ParamString,"TomorrowSalesVolume",string(InputTomorrowSalesVolume));
	ParamAdd(ParamString,"TomorrowPrice",string(InputTomorrowPrice));
	ExecuteEvent(2659,ParamString);
	HideWindow("ManorSeedInfoChangeWnd");
}

function ShowErrorDialog (int MinValue, int MaxValue, int SystemStringIdx)
{
	local string ParamString;
	local string Message;

	ParamAdd(ParamString,"Type",string(1));
	ParamAdd(ParamString,"param1",string(MinValue));
	AddSystemMessageParam(ParamString);
	ParamString = "";
	ParamAdd(ParamString,"Type",string(1));
	ParamAdd(ParamString,"param1",string(MaxValue));
	AddSystemMessageParam(ParamString);
	Message = EndSystemMessageParam(SystemStringIdx,True);
	DialogShow(5,Message);
}

