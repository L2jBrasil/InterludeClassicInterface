//================================================================================
// MacroListWnd.
//================================================================================

class MacroListWnd extends UICommonAPI;

var bool m_bShow;
var int m_DeleteID;
var int m_Max;
const MACRO_MAX_COUNT= 24;

function OnLoad ()
{
	RegisterEvent(1710);
	RegisterEvent(1230);
	RegisterEvent(1240);
	RegisterEvent(1250);
	m_bShow = False;
	m_DeleteID = 0;
}

function OnEnterState (name a_PreStateName)
{
	Class'MacroAPI'.RequestMacroList();
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
		case "btnHelp":
		OnClickHelp();
		break;
		case "btnAdd":
		OnClickAdd();
		break;
		default:
	}
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,1230) )
	{
		HandleMacroShowListWnd();
	} else {
		if ( UnknownFunction154(Event_ID,1240) )
		{
			HandleMacroUpdate();
		} else {
			if ( UnknownFunction154(Event_ID,1250) )
			{
				HandleMacroList(L2jBRVar1);
			} else {
				if ( UnknownFunction154(Event_ID,1710) )
				{
					if ( DialogIsMine() )
					{
						if ( UnknownFunction151(m_DeleteID,0) )
						{
							Class'MacroAPI'.RequestDeleteMacro(m_DeleteID);
							m_DeleteID = 0;
							if ( UnknownFunction154(m_Max,1) )
							{
								HandleMacroList("");
							}
						}
					}
				}
			}
		}
	}
}

function OnClickItem (string strID, int Index)
{
	local ItemInfo L2jBRVar3;

	if ( UnknownFunction130(UnknownFunction122(strID,"MacroItem"),UnknownFunction151(Index,-1)) )
	{
		if ( Class'UIAPI_ITEMWINDOW'.GetItem("MacroListWnd.MacroItem",Index,L2jBRVar3) )
		{
			Class'MacroAPI'.RequestUseMacro(L2jBRVar3.ClassID);
		}
	}
}

function OnClickHelp ()
{
	local string strParam;

	ParamAdd(strParam,"FilePath","..\L2text\help_macro.htm");
	ExecuteEvent(1210,strParam);
}

function OnClickAdd ()
{
	Class'UIAPI_MULTIEDITBOX'.SetString("MacroInfoWnd.txtInfo","");
	ExecuteEvent(1260,"");
}

function HandleMacroUpdate ()
{
	Class'MacroAPI'.RequestMacroList();
}

function HandleMacroShowListWnd ()
{
	if ( m_bShow )
	{
		PlayConsoleSound(6);
		Class'UIAPI_WINDOW'.HideWindow("MacroListWnd");
	} else {
		PlayConsoleSound(5);
		Class'UIAPI_WINDOW'.ShowWindow("MacroListWnd");
		Class'UIAPI_WINDOW'.SetFocus("MacroListWnd");
	}
}

function Clear ()
{
	Class'UIAPI_ITEMWINDOW'.Clear("MacroListWnd.MacroItem");
}

function HandleMacroList (string L2jBRVar1)
{
	local int L2jBRVar2;
	local int L2jBRVar29;
	local int MacroID;
	local string strIconName;
	local string strMacroName;
	local string strDescription;
	local string strTexture;
	local string strTmp;
	local ItemInfo L2jBRVar3;

	Clear();
	ParseInt(L2jBRVar1,"Max",L2jBRVar29);
	m_Max = L2jBRVar29;
	L2jBRVar2 = 0;
	if ( UnknownFunction150(L2jBRVar2,L2jBRVar29) )
	{
		MacroID = 0;
		strIconName = "";
		strMacroName = "";
		strDescription = "";
		strTexture = "";
		ParseInt(L2jBRVar1,UnknownFunction112("ID_",string(L2jBRVar2)),MacroID);
		ParseString(L2jBRVar1,UnknownFunction112("IconName_",string(L2jBRVar2)),strIconName);
		ParseString(L2jBRVar1,UnknownFunction112("MacroName_",string(L2jBRVar2)),strMacroName);
		ParseString(L2jBRVar1,UnknownFunction112("Description_",string(L2jBRVar2)),strDescription);
		ParseString(L2jBRVar1,UnknownFunction112("TextureName_",string(L2jBRVar2)),strTexture);
		L2jBRVar3.ClassID = MacroID;
		L2jBRVar3.Name = strMacroName;
		L2jBRVar3.AdditionalName = strIconName;
		L2jBRVar3.IconName = strTexture;
		L2jBRVar3.Description = strDescription;
		L2jBRVar3.ItemSubType = 4;
		Class'UIAPI_ITEMWINDOW'.AddItem("MacroListWnd.MacroItem",L2jBRVar3);
		UnknownFunction165(L2jBRVar2);
		goto JL002D;
	}
	if ( UnknownFunction150(L2jBRVar29,10) )
	{
		strTmp = UnknownFunction112(strTmp,"0");
	}
	strTmp = UnknownFunction112(strTmp,string(L2jBRVar29));
	strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",strTmp),"/"),string(24)),")");
	Class'UIAPI_TEXTBOX'.SetText("MacroListWnd.txtCount",strTmp);
}

function OnDropItem (string strID, ItemInfo L2jBRVar3, int X, int Y)
{
	switch (strID)
	{
		case "btnTrash":
		DeleteMacro(L2jBRVar3);
		break;
		case "btnEdit":
		EditMacro(L2jBRVar3);
		break;
		default:
	}
}

function DeleteMacro (ItemInfo L2jBRVar3)
{
	local string strMsg;

	if ( UnknownFunction155(L2jBRVar3.ItemSubType,4) )
	{
		return;
	}
	strMsg = MakeFullSystemMsg(GetSystemMessage(828),L2jBRVar3.Name,"");
	m_DeleteID = L2jBRVar3.ClassID;
	DialogShow(4,strMsg);
}

function EditMacro (ItemInfo L2jBRVar3)
{
	local int MacroID;
	local string L2jBRVar1;

	if ( UnknownFunction155(L2jBRVar3.ItemSubType,4) )
	{
		return;
	}
	MacroID = L2jBRVar3.ClassID;
	ParamAdd(L2jBRVar1,"MacroID",string(MacroID));
	ExecuteEvent(1260,L2jBRVar1);
}

