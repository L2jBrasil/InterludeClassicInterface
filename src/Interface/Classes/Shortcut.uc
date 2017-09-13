//================================================================================
// Shortcut.
//================================================================================

class Shortcut extends UICommonAPI;

const CHAT_WINDOW_SYSTEM= 5;
const CHAT_WINDOW_COUNT= 5;
const CHAT_WINDOW_ALLY= 4;
const CHAT_WINDOW_CLAN= 3;
const CHAT_WINDOW_PARTY= 2;
const CHAT_WINDOW_TRADE= 1;
const CHAT_WINDOW_NORMAL= 0;
var NPHRN_KeyWnd L2jBRVar21;
var bool m_chatstateok;
var bool L2jBRVar205;
var bool L2jBRVar206;
var bool L2jBRVar207;
var int L2jBRVar37;
var int L2jBRVar34;
var int L2jBRVar35;

function OnLoad ()
{
	RegisterEvent(90);
	L2jBRVar36();
	if ( UnknownFunction130(UnknownFunction130(UnknownFunction129(L2jBRVar205
	),UnknownFunction129(L2jBRVar206
	)),UnknownFunction129(
	L2jBRVar207)) )
	{
		L2jBRVar21 = NPHRN_KeyWnd(GetScript("NPHRN_KeyWnd"));
		SetOptionBool("Key","UseFPad",True);
		SetOptionBool("Key","UseNumpad",True);
		SetOptionBool("Key","UseQwerty",True);
		SetOptionInt("Key","Panel1",1);
		SetOptionInt("Key","Panel2",1);
		SetOptionInt("Key","Panel3",1);
		L2jBRVar21.L2jBRVar181.SetSelectedNum(UnknownFunction147(L2jBRVar37,1));
		L2jBRVar21.L2jBRVar180.SetSelectedNum(UnknownFunction147(L2jBRVar34,1));
		L2jBRVar21.L2jBRVar178.SetSelectedNum(UnknownFunction147(L2jBRVar35,1));
		L2jBRVar36();
	}
}

function L2jBRVar36 ()
{
	L2jBRVar205
	 = GetOptionBool("Key","UseNumpad");
	_ƒ
	 = GetOptionBool("Key","UseFPad");
	
	L2jBRVar207 = GetOptionBool("Key","UseQwerty");
	L2jBRVar37 = GetOptionInt("Key","Panel1");
	L2jBRVar34 = GetOptionInt("Key","Panel2");
	L2jBRVar35 = GetOptionInt("Key","Panel3");
	GetOptionBool("Game","EnterChatting");
	if ( UnknownFunction152(L2jBRVar37,0) )
	{
		L2jBRVar37 = 1;
	}
	if ( UnknownFunction152(L2jBRVar34,0) )
	{
		L2jBRVar34 = 1;
	}
	if ( UnknownFunction152(L2jBRVar35,0) )
	{
		L2jBRVar35 = 1;
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 90:
		HandleShortcutCommand(_L2jBRVar17_);
		break;
		default:
	}
}

function OnExitState (name a_NextStateName)
{
	if ( UnknownFunction254(a_NextStateName,'GamingState') )
	{
		m_chatstateok = True;
	} else {
		m_chatstateok = False;
	}
}

function HandleShortcutCommand (string _L2jBRVar17_)
{
	local string Command;
	local MenuWnd L2jBRVar21;
	local ButtonHandle L2jBRVar38;

	L2jBRVar38 = ButtonHandle(GetHandle("RadarWnd.BtnSupport"));
	L2jBRVar21 = MenuWnd(GetScript("MenuWnd"));
	if ( ParseString(_L2jBRVar17_,"Command",Command) )
	{
		switch (Command)
		{
			case "CloseAllWindow":
			HandleCloseAllWindow();
			break;
			case "ShowChatWindow":
			HandleShowChatWindow();
			break;
			case "SetPrevChatType":
			HandleSetPrevChatType();
			break;
			case "SetNextChatType":
			HandleSetNextChatType();
			break;
			case "ShowDetailStatusWnd":
			L2jBRVar21.L2jBRFunction26();
			break;
			case "ShowActionWnd":
			L2jBRVar21.L2jBRFunction27();
			break;
			case "ShowMagicSkillWnd":
			L2jBRVar21.L2jBRFunction83();
			break;
			case "ShowQuestTreeWnd":
			L2jBRVar21.L2jBRFunction28();
			break;
			case "ShowClanWnd":
			L2jBRVar21.L2jBRFunction84();
			break;
			default:
		}
		if ( UnknownFunction122(UnknownFunction128(Command,11),"UserShorcut") )
		{
			L2jBRFunction104(Command);
		}
	}
}

function L2jBRFunction104 (string Name)
{
	switch (Name)
	{
		case "UserShorcutKey_1":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar37))," 1"));
		}
		break;
		case "UserShorcutKey_2":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar37))," 2"));
		}
		break;
		case "UserShorcutKey_3":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar37))," 3"));
		}
		break;
		case "UserShorcutKey_4":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar37))," 4"));
		}
		break;
		case "UserShorcutKey_5":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar37))," 5"));
		}
		break;
		case "UserShorcutKey_6":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar37))," 6"));
		}
		break;
		case "UserShorcutKey_7":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar37))," 7"));
		}
		break;
		case "UserShorcutKey_8":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar37))," 8"));
		}
		break;
		case "UserShorcutKey_9":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar37))," 9"));
		}
		break;
		case "UserShorcutKey_10":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar37))," 10"));
		}
		break;
		case "UserShorcutKey_11":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar37))," 11"));
		}
		break;
		case "UserShorcutKey_12":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar37))," 12"));
		}
		break;
		case "UserShorcutKey_Q":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar34))," 1"));
		}
		break;
		case "UserShorcutKey_W":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar34))," 2"));
		}
		break;
		case "UserShorcutKey_E":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar34))," 3"));
		}
		break;
		case "UserShorcutKey_R":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar34))," 4"));
		}
		break;
		case "UserShorcutKey_T":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar34))," 5"));
		}
		break;
		case "UserShorcutKey_Y":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar34))," 6"));
		}
		break;
		case "UserShorcutKey_U":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar34))," 7"));
		}
		break;
		case "UserShorcutKey_I":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar34))," 8"));
		}
		break;
		case "UserShorcutKey_O":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar34))," 9"));
		}
		break;
		case "UserShorcutKey_P":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar34))," 10"));
		}
		break;
		case "UserShorcutKey_[":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar34))," 11"));
		}
		break;
		case "UserShorcutKey_]":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar34))," 12"));
		}
		break;
		case "UserShorcutKey_F1":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar35))," 1"));
		}
		break;
		case "UserShorcutKey_F2":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar35))," 2"));
		}
		break;
		case "UserShorcutKey_F3":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar35))," 3"));
		}
		break;
		case "UserShorcutKey_F4":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar35))," 4"));
		}
		break;
		case "UserShorcutKey_F5":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar35))," 5"));
		}
		break;
		case "UserShorcutKey_F6":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar35))," 6"));
		}
		break;
		case "UserShorcutKey_F7":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar35))," 7"));
		}
		break;
		case "UserShorcutKey_F8":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar35))," 8"));
		}
		break;
		case "UserShorcutKey_F9":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar35))," 9"));
		}
		break;
		case "UserShorcutKey_F10":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar35))," 10"));
		}
		break;
		case "UserShorcutKey_F11":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar35))," 11"));
		}
		break;
		case "UserShorcutKey_F12":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcut ",string(L2jBRVar35))," 12"));
		}
		break;
		case "UserShorcutKeyForce_1":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar37))," 1"));
		}
		break;
		case "UserShorcutKeyForce_2":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar37))," 2"));
		}
		break;
		case "UserShorcutKeyForce_3":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar37))," 3"));
		}
		break;
		case "UserShorcutKeyForce_4":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar37))," 4"));
		}
		break;
		case "UserShorcutKeyForce_5":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar37))," 5"));
		}
		break;
		case "UserShorcutKeyForce_6":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar37))," 6"));
		}
		break;
		case "UserShorcutKeyForce_7":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar37))," 7"));
		}
		break;
		case "UserShorcutKeyForce_8":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar37))," 8"));
		}
		break;
		case "UserShorcutKeyForce_9":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar37))," 9"));
		}
		break;
		case "UserShorcutKeyForce_10":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar37))," 10"));
		}
		break;
		case "UserShorcutKeyForce_11":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar37))," 11"));
		}
		break;
		case "UserShorcutKeyForce_12":
		if ( L2jBRVar205
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar37))," 12"));
		}
		break;
		case "UserShorcutKeyForce_Q":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar34))," 1"));
		}
		break;
		case "UserShorcutKeyForce_W":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar34))," 2"));
		}
		break;
		case "UserShorcutKeyForce_E":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar34))," 3"));
		}
		break;
		case "UserShorcutKeyForce_R":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar34))," 4"));
		}
		break;
		case "UserShorcutKeyForce_T":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar34))," 5"));
		}
		break;
		case "UserShorcutKeyForce_Y":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar34))," 6"));
		}
		break;
		case "UserShorcutKeyForce_U":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar34))," 7"));
		}
		break;
		case "UserShorcutKeyForce_I":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar34))," 8"));
		}
		break;
		case "UserShorcutKeyForce_O":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar34))," 9"));
		}
		break;
		case "UserShorcutKeyForce_P":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar34))," 10"));
		}
		break;
		case "UserShorcutKeyForce_[":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar34))," 11"));
		}
		break;
		case "UserShorcutKeyForce_]":
		if ( L2jBRVar206
		 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar34))," 12"));
		}
		break;
		case "UserShorcutKeyForce_F1":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar35))," 1"));
		}
		break;
		case "UserShorcutKeyForce_F2":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar35))," 2"));
		}
		break;
		case "UserShorcutKeyForce_F3":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar35))," 3"));
		}
		break;
		case "UserShorcutKeyForce_F4":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar35))," 4"));
		}
		break;
		case "UserShorcutKeyForce_F5":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar35))," 5"));
		}
		break;
		case "UserShorcutKeyForce_F6":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar35))," 6"));
		}
		break;
		case "UserShorcutKeyForce_F7":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar35))," 7"));
		}
		break;
		case "UserShorcutKeyForce_F8":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar35))," 8"));
		}
		break;
		case "UserShorcutKeyForce_F9":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar35))," 9"));
		}
		break;
		case "UserShorcutKeyForce_F10":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar35))," 10"));
		}
		break;
		case "UserShorcutKeyForce_F11":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar35))," 11"));
		}
		break;
		case "UserShorcutKeyForce_F12":
		if ( 
		L2jBRVar207 )
		{
			ExecuteCommand(UnknownFunction112(UnknownFunction112("/useshortcutforce ",string(L2jBRVar35))," 12"));
		}
		break;
		default:
	}
}

function HandleShowChatWindow ()
{
	local WindowHandle L2jBRVar38;

	L2jBRVar38 = GetHandle("ChatWnd");
	if ( L2jBRVar38.IsShowWindow() )
	{
		L2jBRVar38.HideWindow();
		if ( GetOptionBool("Game","SystemMsgWnd") )
		{
			Class'UIAPI_WINDOW'.HideWindow("SystemMsgWnd");
		}
	} else {
		L2jBRVar38.ShowWindow();
		if ( GetOptionBool("Game","SystemMsgWnd") )
		{
			Class'UIAPI_WINDOW'.ShowWindow("SystemMsgWnd");
		}
	}
}

function HandleSetPrevChatType ()
{
	local ChatWnd chatWndScript;

	chatWndScript = ChatWnd(GetScript("ChatWnd"));
	switch (chatWndScript.m_chatType)
	{
		case 0:
		chatWndScript.ChatTabCtrl.MergeTab(1);
		chatWndScript.ChatTabCtrl.MergeTab(2);
		chatWndScript.ChatTabCtrl.MergeTab(3);
		chatWndScript.ChatTabCtrl.MergeTab(4);
		chatWndScript.ChatTabCtrl.SetTopOrder(4,True);
		chatWndScript.HandleTabClick("ChatTabCtrl4");
		break;
		case 1:
		chatWndScript.ChatTabCtrl.MergeTab(0);
		chatWndScript.ChatTabCtrl.MergeTab(2);
		chatWndScript.ChatTabCtrl.MergeTab(3);
		chatWndScript.ChatTabCtrl.MergeTab(4);
		chatWndScript.ChatTabCtrl.SetTopOrder(0,True);
		chatWndScript.HandleTabClick("ChatTabCtrl0");
		break;
		case 2:
		chatWndScript.ChatTabCtrl.MergeTab(0);
		chatWndScript.ChatTabCtrl.MergeTab(1);
		chatWndScript.ChatTabCtrl.MergeTab(3);
		chatWndScript.ChatTabCtrl.MergeTab(4);
		chatWndScript.ChatTabCtrl.SetTopOrder(1,True);
		chatWndScript.HandleTabClick("ChatTabCtrl1");
		break;
		case 3:
		chatWndScript.ChatTabCtrl.MergeTab(0);
		chatWndScript.ChatTabCtrl.MergeTab(1);
		chatWndScript.ChatTabCtrl.MergeTab(2);
		chatWndScript.ChatTabCtrl.MergeTab(3);
		chatWndScript.ChatTabCtrl.SetTopOrder(2,True);
		chatWndScript.HandleTabClick("ChatTabCtrl2");
		break;
		case 4:
		chatWndScript.ChatTabCtrl.MergeTab(0);
		chatWndScript.ChatTabCtrl.MergeTab(1);
		chatWndScript.ChatTabCtrl.MergeTab(2);
		chatWndScript.ChatTabCtrl.MergeTab(3);
		chatWndScript.ChatTabCtrl.SetTopOrder(3,True);
		chatWndScript.HandleTabClick("ChatTabCtrl3");
		break;
		default:
	}
}

function HandleSetNextChatType ()
{
	local ChatWnd chatWndScript;

	chatWndScript = ChatWnd(GetScript("ChatWnd"));
	switch (chatWndScript.m_chatType)
	{
		case 0:
		chatWndScript.ChatTabCtrl.MergeTab(0);
		chatWndScript.ChatTabCtrl.MergeTab(2);
		chatWndScript.ChatTabCtrl.MergeTab(3);
		chatWndScript.ChatTabCtrl.MergeTab(4);
		chatWndScript.ChatTabCtrl.SetTopOrder(1,True);
		chatWndScript.HandleTabClick("ChatTabCtrl1");
		break;
		case 1:
		chatWndScript.ChatTabCtrl.MergeTab(0);
		chatWndScript.ChatTabCtrl.MergeTab(1);
		chatWndScript.ChatTabCtrl.MergeTab(3);
		chatWndScript.ChatTabCtrl.MergeTab(4);
		chatWndScript.ChatTabCtrl.SetTopOrder(2,True);
		chatWndScript.HandleTabClick("ChatTabCtrl2");
		break;
		case 2:
		chatWndScript.ChatTabCtrl.MergeTab(0);
		chatWndScript.ChatTabCtrl.MergeTab(1);
		chatWndScript.ChatTabCtrl.MergeTab(2);
		chatWndScript.ChatTabCtrl.MergeTab(4);
		chatWndScript.ChatTabCtrl.SetTopOrder(3,True);
		chatWndScript.HandleTabClick("ChatTabCtrl3");
		break;
		case 3:
		chatWndScript.ChatTabCtrl.MergeTab(0);
		chatWndScript.ChatTabCtrl.MergeTab(1);
		chatWndScript.ChatTabCtrl.MergeTab(2);
		chatWndScript.ChatTabCtrl.MergeTab(3);
		chatWndScript.ChatTabCtrl.SetTopOrder(4,True);
		chatWndScript.HandleTabClick("ChatTabCtrl4");
		break;
		case 4:
		chatWndScript.ChatTabCtrl.MergeTab(1);
		chatWndScript.ChatTabCtrl.MergeTab(2);
		chatWndScript.ChatTabCtrl.MergeTab(3);
		chatWndScript.ChatTabCtrl.MergeTab(4);
		chatWndScript.ChatTabCtrl.SetTopOrder(0,True);
		chatWndScript.HandleTabClick("ChatTabCtrl0");
		break;
		default:
	}
}

function HandleCloseAllWindow ()
{
	Class'UIAPI_WINDOW'.HideWindow("SystemMenuWnd");
}

