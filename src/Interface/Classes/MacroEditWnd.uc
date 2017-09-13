//================================================================================
// MacroEditWnd.
//================================================================================

class MacroEditWnd extends UICommonAPI;

var bool m_bShow;
var int m_CurIconNum;
var int m_CurMacroID;
const MACRO_ICONANME= "L2UI.MacroWnd.Macro_Icon";
const MACROICON_MAX_COUNT= 7;
const MACROCOMMAND_MAX_COUNT= 12;
const MACRO_MAX_COUNT= 24;

function OnLoad ()
{
	RegisterEvent(1710);
	RegisterEvent(1260);
	RegisterEvent(1270);
	m_bShow = False;
	m_CurIconNum = 1;
	m_CurMacroID = 0;
	InitTabOrder();
}

function OnShow ()
{
	m_bShow = True;
}

function OnHide ()
{
	m_bShow = False;
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnInfo":
		OnClickInfo();
		break;
		case "btnHelp":
		OnClickHelp();
		break;
		case "btnCancel":
		OnClickCancel();
		break;
		case "btnLeft":
		OnClickLeft();
		break;
		case "btnRight":
		OnClickRight();
		break;
		case "btnSave":
		OnClickSave();
		break;
		default:
	}
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,1260) )
	{
		HandleMacroShowEditWnd(L2jBRVar1);
	} else {
		if ( UnknownFunction154(Event_ID,1270) )
		{
			HandleMacroDeleted(L2jBRVar1);
		} else {
			if ( UnknownFunction154(Event_ID,1710) )
			{
				if (! DialogIsMine() ) goto JL0052;
			}
		}
	}
}

function InitTabOrder ()
{
	local int L2jBRVar2;

	Class'UIAPI_WINDOW'.SetTabOrder("MacroEditWnd","MacroEditWnd.txtName","MacroEditWnd.txtShortName");
	Class'UIAPI_WINDOW'.SetTabOrder("MacroEditWnd.txtName","MacroEditWnd.txtShortName","MacroEditWnd");
	Class'UIAPI_WINDOW'.SetTabOrder("MacroEditWnd.txtShortName","MacroEditWnd.txtEdit0","MacroEditWnd.txtName");
JL00FA:
	L2jBRVar2 = 0;
	if ( UnknownFunction150(L2jBRVar2,12) )
	{
		if ( UnknownFunction154(L2jBRVar2,0) )
		{
			Class'UIAPI_WINDOW'.SetTabOrder("MacroEditWnd.txtEdit0","MacroEditWnd.txtEdit1","MacroEditWnd.txtShortName");
		} else {
			if ( UnknownFunction154(L2jBRVar2,UnknownFunction147(12,1)) )
			{
				Class'UIAPI_WINDOW'.SetTabOrder("MacroEditWnd.txtEdit11","MacroEditWnd.txtName","MacroEditWnd.txtEdit10");
			} else {
				Class'UIAPI_WINDOW'.SetTabOrder(UnknownFunction112("MacroEditWnd.txtEdit",string(L2jBRVar2)),UnknownFunction112("MacroEditWnd.txtEdit",string(UnknownFunction146(L2jBRVar2,1))),UnknownFunction112("MacroEditWnd.txtEdit",string(UnknownFunction147(L2jBRVar2,1))));
			}
		}
		UnknownFunction165(L2jBRVar2);
		goto JL00FA;
	}
}

function OnClickInfo ()
{
	if ( Class'UIAPI_WINDOW'.IsShowWindow("MacroInfoWnd") )
	{
		PlayConsoleSound(6);
		Class'UIAPI_WINDOW'.HideWindow("MacroInfoWnd");
	} else {
		PlayConsoleSound(5);
		Class'UIAPI_WINDOW'.ShowWindow("MacroInfoWnd");
		Class'UIAPI_WINDOW'.SetFocus("MacroInfoWnd");
	}
}

function OnClickHelp ()
{
	local string strParam;

	ParamAdd(strParam,"FilePath","..\L2text\help_macro.htm");
	ExecuteEvent(1210,strParam);
}

function OnClickCancel ()
{
	Class'UIAPI_WINDOW'.HideWindow("MacroEditWnd");
}

function OnClickSave ()
{
	SaveMacro();
}

function OnDropItem (string strID, ItemInfo L2jBRVar3, int X, int Y)
{
	if ( UnknownFunction150(UnknownFunction125(strID),1) )
	{
		return;
	}
	if ( UnknownFunction123(UnknownFunction128(strID,7),"txtEdit") )
	{
		return;
	}
	Class'UIAPI_EDITBOX'.SetString(UnknownFunction112("MacroEditWnd.",strID),L2jBRVar3.MacroCommand);
	Class'UIAPI_EDITBOX'.SetHighLight(UnknownFunction112("MacroEditWnd.",strID),False);
}

function OnDragItemStart (string strID, ItemInfo L2jBRVar3)
{
	if ( UnknownFunction150(UnknownFunction125(strID),1) )
	{
		return;
	}
	if ( UnknownFunction123(UnknownFunction128(strID,7),"txtEdit") )
	{
		return;
	}
	Class'UIAPI_EDITBOX'.SetHighLight(UnknownFunction112("MacroEditWnd.",strID),True);
}

function OnDragItemEnd (string strID)
{
	if ( UnknownFunction150(UnknownFunction125(strID),1) )
	{
		return;
	}
	if ( UnknownFunction123(UnknownFunction128(strID,7),"txtEdit") )
	{
		return;
	}
	Class'UIAPI_EDITBOX'.SetHighLight(UnknownFunction112("MacroEditWnd.",strID),False);
}

function OnChangeEditBox (string strID)
{
	switch (strID)
	{
		case "txtShortName":
		UpdateIconName();
		break;
		default:
	}
}

function OnClickLeft ()
{
	UnknownFunction166(m_CurIconNum);
	if ( UnknownFunction150(m_CurIconNum,1) )
	{
		m_CurIconNum = 7;
	}
	UpdateIcon();
}

function OnClickRight ()
{
	UnknownFunction165(m_CurIconNum);
	if ( UnknownFunction151(m_CurIconNum,7) )
	{
		m_CurIconNum = 1;
	}
	UpdateIcon();
}

function UpdateIcon ()
{
	Class'UIAPI_TEXTURECTRL'.SetTexture("MacroEditWnd.texMacro",UnknownFunction112("L2UI.MacroWnd.Macro_Icon",string(m_CurIconNum)));
}

function UpdateIconName ()
{
	local string strShortName;

	strShortName = Class'UIAPI_EDITBOX'.GetString("MacroEditWnd.txtShortName");
	Class'UIAPI_TEXTBOX'.SetText("MacroEditWnd.txtMacroName",strShortName);
}

function Clear ()
{
	local int L2jBRVar2;
	local WindowHandle m_MacroEditWnd;

	m_CurIconNum = 1;
	m_MacroEditWnd = GetHandle("MacroEditWnd.areaEdit");
	Class'UIAPI_EDITBOX'.SetString("MacroEditWnd.txtName","");
	Class'UIAPI_EDITBOX'.SetString("MacroEditWnd.txtShortName","");
	L2jBRVar2 = 0;
JL0084:
	if ( UnknownFunction150(L2jBRVar2,12) )
	{
		Class'UIAPI_EDITBOX'.SetString(UnknownFunction112("MacroEditWnd.txtEdit",string(L2jBRVar2)),"");
		UnknownFunction165(L2jBRVar2);
		goto JL0084;
	}
	UpdateIcon();
	UpdateIconName();
	m_MacroEditWnd.SetScrollPosition(0);
}

function HandleMacroDeleted (string L2jBRVar1)
{
	local int MacroID;

	ParseInt(L2jBRVar1,"MacroID",MacroID);
	if ( UnknownFunction130(m_bShow,UnknownFunction154(m_CurMacroID,MacroID)) )
	{
		PlayConsoleSound(6);
		Class'UIAPI_WINDOW'.HideWindow("MacroEditWnd");
	}
}

function HandleMacroShowEditWnd (string L2jBRVar1)
{
	local int MacroCount;
	local Color TextColor;

	Clear();
	m_CurMacroID = 0;
	if ( ParseInt(L2jBRVar1,"MacroID",m_CurMacroID) )
	{
		SetMacroID(m_CurMacroID);
		if ( UnknownFunction129(m_bShow) )
		{
			PlayConsoleSound(5);
			Class'UIAPI_WINDOW'.ShowWindow("MacroEditWnd");
		}
		Class'UIAPI_WINDOW'.SetFocus("MacroEditWnd.txtName");
	} else {
		if ( m_bShow )
		{
			PlayConsoleSound(6);
			Class'UIAPI_WINDOW'.HideWindow("MacroEditWnd");
		} else {
			MacroCount = Class'UIDATA_MACRO'.GetMacroCount();
			if ( UnknownFunction153(MacroCount,24) )
			{
				TextColor.R = 176;
				TextColor.G = 155;
				TextColor.B = 121;
				TextColor.A = 255;
				DialogShow(5,GetSystemMessage(797));
				DialogSetID(0);
				return;
			}
			PlayConsoleSound(5);
			Class'UIAPI_WINDOW'.ShowWindow("MacroEditWnd");
			Class'UIAPI_WINDOW'.SetFocus("MacroEditWnd.txtName");
		}
	}
}

function SetMacroID (int MacroID)
{
	local int L2jBRVar2;
	local MacroInfo Info;
	local MacroInfoWnd L2jBRVar21;

	if ( UnknownFunction150(MacroID,1) )
	{
		return;
	}
	if ( Class'UIDATA_MACRO'.GetMacroInfo(MacroID,Info) )
	{
		Class'UIAPI_EDITBOX'.SetString("MacroEditWnd.txtName",Info.Name);
		Class'UIAPI_EDITBOX'.SetString("MacroEditWnd.txtShortName",Info.IconName);
		m_CurIconNum = int(UnknownFunction234(Info.IconTextureName,1));
		if ( UnknownFunction150(m_CurIconNum,1) )
		{
			m_CurIconNum = 1;
		}
		UpdateIcon();
		L2jBRVar21 = MacroInfoWnd(GetScript("MacroInfoWnd"));
		L2jBRVar21.SetInfoText(Info.Description);
		L2jBRVar2 = 0;
		if ( UnknownFunction150(L2jBRVar2,12) )
		{
			Class'UIAPI_EDITBOX'.SetString(UnknownFunction112("MacroEditWnd.txtEdit",string(L2jBRVar2)),Info.CommandList[L2jBRVar2]);
			UnknownFunction165(L2jBRVar2);
			goto JL00F8;
		}
	}
}

function SaveMacro ()
{
	local int L2jBRVar2;
	local MacroInfoWnd L2jBRVar21;
	local string Name;
	local string IconName;
	local string Description;
	local string Command;
	local array<string> CommandList;

	L2jBRVar21 = MacroInfoWnd(GetScript("MacroInfoWnd"));
	Name = Class'UIAPI_EDITBOX'.GetString("MacroEditWnd.txtName");
	IconName = Class'UIAPI_EDITBOX'.GetString("MacroEditWnd.txtShortName");
	Description = L2jBRVar21.GetInfoText();
	L2jBRVar2 = 0;
	if ( UnknownFunction150(L2jBRVar2,12) )
	{
		Command = Class'UIAPI_EDITBOX'.GetString(UnknownFunction112("MacroEditWnd.txtEdit",string(L2jBRVar2)));
		byte(CommandList)
		CommandList.Length
		1
		CommandList[UnknownFunction147(CommandList.Length,1)] = Command;
		UnknownFunction165(L2jBRVar2);
		goto JL0096;
	}
	if ( Class'MacroAPI'.RequestMakeMacro(m_CurMacroID,Name,IconName,UnknownFunction147(m_CurIconNum,1),Description,CommandList) )
	{
		Class'UIAPI_WINDOW'.HideWindow("MacroEditWnd");
	}
}

