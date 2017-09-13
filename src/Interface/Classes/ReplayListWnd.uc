//================================================================================
// ReplayListWnd.
//================================================================================

class ReplayListWnd extends UIScript;

var array<string> m_StrFileList;
const REPLAY_EXTENSION=".L2R";
const REPLAY_DIR="..\\REPLAY";

function OnLoad ()
{
}

function OnShow ()
{
	InitReplayList();
}

function InitReplayList ()
{
	local array<string> strReplayFileList;
	local int i;
	local int iLength;
	local string strFileName;

	Class'UIAPI_LISTCTRL'.DeleteAllItem("ReplayListWnd.ReplayListCtrl");
	GetFileList(strReplayFileList,"..\REPLAY",".L2R");
	i = 0;
	if ( UnknownFunction150(i,strReplayFileList.Length) )
	{
		iLength = UnknownFunction147(UnknownFunction125(strReplayFileList[i]),UnknownFunction125(".L2R"));
		strFileName = UnknownFunction128(strReplayFileList[i],iLength);
		AddItem(i,strFileName);
		UnknownFunction163(i);
		goto JL0050;
	}
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
}

function AddItem (int iNum, string strFileName)
{
	local LVDataRecord Record;
	local LVData Data;

	Data.szData = string(iNum);
	Record.LVDataList[0] = Data;
	Data.szData = strFileName;
	Record.LVDataList[1] = Data;
	Class'UIAPI_LISTCTRL'.InsertRecord("ReplayListWnd.ReplayListCtrl",Record);
}

function string GetSelectedFileName ()
{
	local int Index;
	local LVDataRecord Record;
	local string strFileName;

	Index = Class'UIAPI_LISTCTRL'.GetSelectedIndex("ReplayListWnd.ReplayListCtrl");
	if ( UnknownFunction153(Index,0) )
	{
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ReplayListWnd.ReplayListCtrl",Index);
		strFileName = Record.LVDataList[1].szData;
	}
	return strFileName;
}

function OnDBClickListCtrlRecord (string ListCtrlID)
{
	OnOk();
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnOK":
		OnOk();
		break;
		case "btnDel":
		OnDelete();
		InitReplayList();
		break;
		case "btnCancel":
		SetUIState("LoginState");
		break;
		default:
	}
}

function OnOk ()
{
	local string strFileName;
	local bool bLoadCameraInst;
	local bool bLoadChatData;

	strFileName = GetSelectedFileName();
	if ( UnknownFunction122(strFileName,"") )
	{
		return;
	}
	bLoadCameraInst = Class'UIAPI_CHECKBOX'.IsChecked("ReplayListWnd.chkLoadCamInst");
	bLoadChatData = Class'UIAPI_CHECKBOX'.IsChecked("ReplayListWnd.chkLoadChatData");
	BeginReplay(strFileName,bLoadCameraInst,bLoadChatData);
}

function OnDelete ()
{
	local string strFileName;

	strFileName = GetSelectedFileName();
	if ( UnknownFunction122(strFileName,"") )
	{
		return;
	}
	EraseReplayFile(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("..\REPLAY",""),strFileName),""),".L2R"));  //or ("..\REPLAY","\\")?
}

