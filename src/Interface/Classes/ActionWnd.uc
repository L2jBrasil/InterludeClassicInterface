//================================================================================
// ActionWnd.
//================================================================================

class ActionWnd extends UICommonAPI;

var bool m_bShow;

function OnLoad ()
{
	RegisterEvent(1300);
	RegisterEvent(1310);
	RegisterEvent(1900);
	m_bShow = False;
	HideScrollBar();
}

function OnShow ()
{
	Class'ActionAPI'.RequestActionList();
	m_bShow = True;
	SetFocus();
}

function OnHide ()
{
	m_bShow = False;
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,1300) )
	{
		HandleActionListStart();
	} else {
		if ( UnknownFunction154(Event_ID,1310) )
		{
			HandleActionList(L2jBRVar1);
		} else {
			if ( UnknownFunction154(Event_ID,1900) )
			{
				__L2jBRFunction1();
			}
		}
	}
}

function OnClickItem (string strID, int Index)
{
	local ItemInfo L2jBRVar3;

	if ( UnknownFunction130(UnknownFunction122(strID,"ActionBasicItem"),UnknownFunction151(Index,-1)) )
	{
		if ( UnknownFunction129(Class'UIAPI_ITEMWINDOW'.GetItem("ActionWnd.ActionBasicItem",Index,L2jBRVar3)) )
		{
			return;
		}
	} else {
		if ( UnknownFunction130(UnknownFunction122(strID,"ActionPartyItem"),UnknownFunction151(Index,-1)) )
		{
			if ( UnknownFunction129(Class'UIAPI_ITEMWINDOW'.GetItem("ActionWnd.ActionPartyItem",Index,L2jBRVar3)) )
			{
				return;
			}
		} else {
			if ( UnknownFunction130(UnknownFunction122(strID,"ActionSocialItem"),UnknownFunction151(Index,-1)) )
			{
				if ( UnknownFunction129(Class'UIAPI_ITEMWINDOW'.GetItem("ActionWnd.ActionSocialItem",Index,L2jBRVar3)) )
				{
					return;
				}
			}
		}
	}
	DoAction(L2jBRVar3.ClassID);
}

function OnClickButton (string strID)
{
	if ( UnknownFunction122(strID,"BtnClose") )
	{
		HideWindow("ActionWnd");
	}
}

function HideScrollBar ()
{
	Class'UIAPI_ITEMWINDOW'.ShowScrollBar("ActionWnd.ActionBasicItem",False);
	Class'UIAPI_ITEMWINDOW'.ShowScrollBar("ActionWnd.ActionPartyItem",False);
	Class'UIAPI_ITEMWINDOW'.ShowScrollBar("ActionWnd.ActionSocialItem",False);
}

function __L2jBRFunction1()
{
	Class'ActionAPI'.RequestActionList();
}

function HandleActionListStart ()
{
	Clear();
}

function Clear ()
{
	Class'UIAPI_ITEMWINDOW'.Clear("ActionWnd.ActionBasicItem");
	Class'UIAPI_ITEMWINDOW'.Clear("ActionWnd.ActionPartyItem");
	Class'UIAPI_ITEMWINDOW'.Clear("ActionWnd.ActionSocialItem");
}

function HandleActionList (string L2jBRVar1)
{
	local string WndName;
	local int L2jBRVar4;
	local EActionCategory L2jBRVar5;
	local int ActionID;
	local string strActionName;
	local string strIconName;
	local string strDescription;
	local string strCommand;
	local ItemInfo L2jBRVar3;

	ParseInt(L2jBRVar1,"Type",L2jBRVar4);
	ParseInt(L2jBRVar1,"ActionID",ActionID);
	ParseString(L2jBRVar1,"Name",strActionName);
	ParseString(L2jBRVar1,"IconName",strIconName);
	ParseString(L2jBRVar1,"Description",strDescription);
	ParseString(L2jBRVar1,"Command",strCommand);
	L2jBRVar3.ClassID = ActionID;
	L2jBRVar3.Name = strActionName;
	L2jBRVar3.IconName = strIconName;
	L2jBRVar3.Description = strDescription;
	L2jBRVar3.ItemSubType = 3;
	L2jBRVar3.MacroCommand = strCommand;
	L2jBRVar5 = L2jBRVar4;
	if ( UnknownFunction154(L2jBRVar5,1) )
	{
		WndName = "ActionBasicItem";
	} else {
		if ( UnknownFunction154(L2jBRVar5,2) )
		{
			WndName = "ActionPartyItem";
		} else {
			if ( UnknownFunction154(L2jBRVar5,3) )
			{
				WndName = "ActionSocialItem";
			} else {
				return;
			}
		}
	}
	Class'UIAPI_ITEMWINDOW'.AddItem(UnknownFunction112("ActionWnd.",WndName),L2jBRVar3);
}

function SetFocus ()
{
	Class'UIAPI_WINDOW'.SetFocus("ActionWnd.ActionBasicItem");
	Class'UIAPI_WINDOW'.SetFocus("ActionWnd.ActionPartyItem");
	Class'UIAPI_WINDOW'.SetFocus("ActionWnd.ActionSocialItem");
	Class'UIAPI_WINDOW'.SetFocus("ActionWnd.txtBasic1");
	Class'UIAPI_WINDOW'.SetFocus("ActionWnd.txtBasic2");
	Class'UIAPI_WINDOW'.SetFocus("ActionWnd.txtBasic3");
}

