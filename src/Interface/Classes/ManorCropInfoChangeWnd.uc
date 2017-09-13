//================================================================================
// ManorCropInfoChangeWnd.
//================================================================================

class ManorCropInfoChangeWnd extends UICommonAPI;

var int m_MinCropPrice;
var int m_MaxCropPrice;
var int m_TomorrowLimit;

function OnLoad ()
{
	RegisterEvent(2670);
}

function OnEvent (int Event_ID, string _L2jBRVar17_)
{
	Debug(UnknownFunction112("",string(Event_ID)));
	switch (Event_ID)
	{
		case 2670:
		HandleShow(_L2jBRVar17_);
		break;
		default:
	}
}

function HandleShow (string _L2jBRVar17_)
{
	local string CropName;
	local int TomorrowVolumeOfBuy;
	local int TomorrowLimit;
	local int TomorrowPrice;
	local int TomorrowProcure;
	local int MinCropPrice;
	local int MaxCropPrice;
	local string TomorrowLimitString;

	ParseString(_L2jBRVar17_,"CropName",CropName);
	ParseInt(_L2jBRVar17_,"TomorrowVolumeOfBuy",TomorrowVolumeOfBuy);
	ParseInt(_L2jBRVar17_,"TomorrowLimit",TomorrowLimit);
	ParseInt(_L2jBRVar17_,"TomorrowPrice",TomorrowPrice);
	ParseInt(_L2jBRVar17_,"TomorrowProcure",TomorrowProcure);
	ParseInt(_L2jBRVar17_,"MinCropPrice",MinCropPrice);
	ParseInt(_L2jBRVar17_,"MaxCropPrice",MaxCropPrice);
	Class'UIAPI_TEXTBOX'.SetText("ManorCropInfoChangeWnd.txtCropName",CropName);
	Class'UIAPI_EDITBOX'.SetString("ManorCropInfoChangeWnd.ebTomorrowAmountOfPurchase",string(TomorrowVolumeOfBuy));
	m_TomorrowLimit = TomorrowLimit;
	TomorrowLimitString = MakeCostString(string(TomorrowLimit));
	Class'UIAPI_TEXTBOX'.SetText("ManorCropInfoChangeWnd.txtVarTomorrowPurchaseLimit",TomorrowLimitString);
	Class'UIAPI_EDITBOX'.SetString("ManorCropInfoChangeWnd.ebTomorrowPurchasePrice",string(TomorrowPrice));
	if ( UnknownFunction154(TomorrowProcure,0) )
	{
		TomorrowProcure = 1;
	}
	Class'UIAPI_COMBOBOX'.SetSelectedNum("ManorCropInfoChangeWnd.cbTomorrowReward",UnknownFunction147(TomorrowProcure,1));
	m_MinCropPrice = MinCropPrice;
	m_MaxCropPrice = MaxCropPrice;
	ShowWindowWithFocus("ManorCropInfoChangeWnd");
	Class'UIAPI_WINDOW'.SetFocus("ManorCropInfoChangeWnd.ebTomorrowAmountOfPurchase");
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
		HideWindow("ManorCropInfoChangeWnd");
		break;
		default:
	}
}

function OnClickBtnOk ()
{
	local int InputTomorrowAmountOfPurchase;
	local int InputTomorrowPurchasePrice;
	local int InputTomorrowProcure;
	local string Procure;
	local int SelectedNum;
	local string ParamString;

	InputTomorrowAmountOfPurchase = int(Class'UIAPI_EDITBOX'.GetString("ManorCropInfoChangeWnd.ebTomorrowAmountOfPurchase"));
	InputTomorrowPurchasePrice = int(Class'UIAPI_EDITBOX'.GetString("ManorCropInfoChangeWnd.ebTomorrowPurchasePrice"));
	if ( UnknownFunction132(UnknownFunction150(InputTomorrowAmountOfPurchase,0),UnknownFunction151(InputTomorrowAmountOfPurchase,m_TomorrowLimit)) )
	{
		ShowErrorDialog(0,m_TomorrowLimit,1560);
		return;
	}
	if ( UnknownFunction130(UnknownFunction155(InputTomorrowAmountOfPurchase,0),UnknownFunction132(UnknownFunction150(InputTomorrowPurchasePrice,m_MinCropPrice),UnknownFunction151(InputTomorrowPurchasePrice,m_MaxCropPrice))) )
	{
		ShowErrorDialog(m_MinCropPrice,m_MaxCropPrice,1559);
		return;
	}
	SelectedNum = Class'UIAPI_COMBOBOX'.GetSelectedNum("ManorCropInfoChangeWnd.cbTomorrowReward");
	Procure = Class'UIAPI_COMBOBOX'.GetString("ManorCropInfoChangeWnd.cbTomorrowReward",SelectedNum);
	InputTomorrowProcure = int(Procure);
	ParamAdd(ParamString,"TomorrowAmountOfPurchase",string(InputTomorrowAmountOfPurchase));
	ParamAdd(ParamString,"TomorrowPurchasePrice",string(InputTomorrowPurchasePrice));
	ParamAdd(ParamString,"TomorrowProcure",string(InputTomorrowProcure));
	ExecuteEvent(2668,ParamString);
	HideWindow("ManorCropInfoChangeWnd");
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

