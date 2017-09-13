//================================================================================
// ShortcutWnd.
//================================================================================

class ShortcutWnd extends UICommonAPI;

var int CurrentShortcutPage;
var int CurrentShortcutPage2;
var int CurrentShortcutPage3;
var int CurrentShortcutPage4;
var int CurrentShortcutPage5;
var bool m_IsLocked;
var bool L2jBRVar31;
var bool m_IsJoypad;
var bool m_IsJoypadExpand;
var bool m_IsJoypadOn;
var bool m_IsExpand1;
var bool m_IsExpand2;
var bool m_IsExpand3;
var bool m_IsExpand4;
var bool m_IsShortcutExpand;
var string m_ShortcutWndName;
var WindowHandle L2jBRVar12;
enum EJoyShortcut {
	JOYSHORTCUT_Left,
	JOYSHORTCUT_Center,
	JOYSHORTCUT_Right
};

const MAX_ShortcutPerPage= 12;
const MAX_Page= 10;

function OnLoad ()
{
	local ButtonHandle BtnKey;

	BtnKey = ButtonHandle(GetHandle("ShortcutWnd.BtnKey"));
	BtnKey.SetTooltipCustomType(MakeTooltipSimpleText("Bind Setting"));
	L2jBRVar12 = GetHandle("ShortcutWnd");
	RegisterEvent(630);
	RegisterEvent(640);
	RegisterEvent(660);
	RegisterEvent(650);
	RegisterEvent(590);
	RegisterEvent(600);
	RegisterEvent(610);
	RegisterEvent(620);
	m_IsLocked = GetOptionBool("Game","IsLockShortcutWnd");
	m_IsExpand1 = GetOptionBool("Game","Is1ExpandShortcutWnd");
	m_IsExpand2 = GetOptionBool("Game","Is2ExpandShortcutWnd");
	m_IsExpand3 = GetOptionBool("Game","Is3ExpandShortcutWnd");
	m_IsExpand4 = GetOptionBool("Game","Is4ExpandShortcutWnd");
	L2jBRVar31 = GetOptionBool("Game","IsShortcutWndVertical");
	InitShortPageNum();
}

function OnDefaultPosition ()
{
	m_IsExpand1 = False;
	m_IsExpand2 = False;
	m_IsExpand3 = False;
	m_IsExpand4 = False;
	SetVertical(True);
	InitShortPageNum();
	ArrangeWnd();
	ExpandWnd();
}

function OnEnterState (name a_PreStateName)
{
	ArrangeWnd();
	ExpandWnd();
	L2jBRFunction24();
	if ( UnknownFunction254(a_PreStateName,'LoadingState') )
	{
		InitShortPageNum();
	}
	L2jBRVar12.SetTimer(1,1200000);
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 640:
		HandleShortcutPageUpdate(_L2jBRVar17_);
		break;
		case 660:
		HandleShortcutJoypad(_L2jBRVar17_);
		break;
		case 590:
		HandleJoypadLButtonDown(_L2jBRVar17_);
		break;
		case 600:
		HandleJoypadLButtonUp(_L2jBRVar17_);
		break;
		case 610:
		HandleJoypadRButtonDown(_L2jBRVar17_);
		break;
		case 620:
		HandleJoypadRButtonUp(_L2jBRVar17_);
		break;
		case 630:
		HandleShortcutUpdate(_L2jBRVar17_);
		break;
		case 650:
		HandleShortcutClear();
		ArrangeWnd();
		ExpandWnd();
		break;
		default:
	}
}

function InitShortPageNum ()
{
	CurrentShortcutPage = 0;
	CurrentShortcutPage2 = 1;
	CurrentShortcutPage3 = 2;
	CurrentShortcutPage4 = 3;
	CurrentShortcutPage5 = 4;
}

function HandleShortcutPageUpdate (string L2jBRVar1)
{
	local int i;
	local int nShortcutID;
	local int ShortcutPage;

	if ( ParseInt(L2jBRVar1,"ShortcutPage",ShortcutPage) )
	{
		if ( UnknownFunction132(UnknownFunction151(0,ShortcutPage),UnknownFunction152(10,ShortcutPage)) )
		{
			return;
		}
		CurrentShortcutPage = ShortcutPage;
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".PageNumTextBox"),string(UnknownFunction146(CurrentShortcutPage,1)));
		nShortcutID = UnknownFunction144(CurrentShortcutPage,12);
		i = 0;
		if ( UnknownFunction150(i,12) )
		{
JL009E:
			Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".Shortcut"),string(UnknownFunction146(i,1))),nShortcutID);
			UnknownFunction165(nShortcutID);
			UnknownFunction163(i);
			goto JL009E;
		}
	}
}

function HandleShortcutUpdate (string L2jBRVar1)
{
	local int nShortcutID;
	local int nShortcutNum;

	ParseInt(L2jBRVar1,"ShortcutID",nShortcutID);
	nShortcutNum = UnknownFunction146(int(UnknownFunction173(nShortcutID,12)),1);
	if ( IsShortcutIDInCurPage(CurrentShortcutPage,nShortcutID) )
	{
		Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".Shortcut"),string(nShortcutNum)),nShortcutID);
	}
	if ( IsShortcutIDInCurPage(CurrentShortcutPage2,nShortcutID) )
	{
		Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),"_1.Shortcut"),string(nShortcutNum)),nShortcutID);
	}
	if ( IsShortcutIDInCurPage(CurrentShortcutPage3,nShortcutID) )
	{
		Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),"_2.Shortcut"),string(nShortcutNum)),nShortcutID);
	}
	if ( IsShortcutIDInCurPage(CurrentShortcutPage4,nShortcutID) )
	{
		Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),"_3.Shortcut"),string(nShortcutNum)),nShortcutID);
	}
	if ( IsShortcutIDInCurPage(CurrentShortcutPage5,nShortcutID) )
	{
		Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),"_4.Shortcut"),string(nShortcutNum)),nShortcutID);
	}
}

function HandleShortcutClear ()
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,12) )
	{
		Class'UIAPI_SHORTCUTITEMWINDOW'.Clear(UnknownFunction112("ShortcutWnd.ShortcutWndVertical.Shortcut",string(UnknownFunction146(i,1))));
		Class'UIAPI_SHORTCUTITEMWINDOW'.Clear(UnknownFunction112("ShortcutWnd.ShortcutWndVertical_1.Shortcut",string(UnknownFunction146(i,1))));
		Class'UIAPI_SHORTCUTITEMWINDOW'.Clear(UnknownFunction112("ShortcutWnd.ShortcutWndVertical_2.Shortcut",string(UnknownFunction146(i,1))));
		Class'UIAPI_SHORTCUTITEMWINDOW'.Clear(UnknownFunction112("ShortcutWnd.ShortcutWndVertical_3.Shortcut",string(UnknownFunction146(i,1))));
		Class'UIAPI_SHORTCUTITEMWINDOW'.Clear(UnknownFunction112("ShortcutWnd.ShortcutWndHorizontal.Shortcut",string(UnknownFunction146(i,1))));
		Class'UIAPI_SHORTCUTITEMWINDOW'.Clear(UnknownFunction112("ShortcutWnd.ShortcutWndHorizontal_1.Shortcut",string(UnknownFunction146(i,1))));
		Class'UIAPI_SHORTCUTITEMWINDOW'.Clear(UnknownFunction112("ShortcutWnd.ShortcutWndHorizontal_2.Shortcut",string(UnknownFunction146(i,1))));
		Class'UIAPI_SHORTCUTITEMWINDOW'.Clear(UnknownFunction112("ShortcutWnd.ShortcutWndHorizontal_3.Shortcut",string(UnknownFunction146(i,1))));
		Class'UIAPI_SHORTCUTITEMWINDOW'.Clear(UnknownFunction112("ShortcutWnd.ShortcutWndHorizontal_4.Shortcut",string(UnknownFunction146(i,1))));
		Class'UIAPI_SHORTCUTITEMWINDOW'.Clear(UnknownFunction112("ShortcutWnd.ShortcutWndJoypadExpand.Shortcut",string(UnknownFunction146(i,1))));
		UnknownFunction163(i);
		goto JL0007;
	}
	i = 0;
	if ( UnknownFunction150(i,4) )
	{
		Class'UIAPI_SHORTCUTITEMWINDOW'.Clear(UnknownFunction112("ShortcutWnd.ShortcutWndJoypad.Shortcut",string(UnknownFunction146(i,1))));
		UnknownFunction163(i);
		goto JL02F2;
	}
}

function HandleShortcutJoypad (string _L2jBRVar17_)
{
	local int OnOff;

	if ( ParseInt(_L2jBRVar17_,"OnOff",OnOff) )
	{
		if ( UnknownFunction154(1,OnOff) )
		{
			m_IsJoypadOn = True;
			ShowWindow(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".JoypadBtn"));
		} else {
			if ( UnknownFunction154(0,OnOff) )
			{
				m_IsJoypadOn = False;
				HideWindow(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".JoypadBtn"));
			}
		}
	}
}

function HandleJoypadLButtonUp (string _L2jBRVar17_)
{
	SetJoypadShortcut(1);
}

function HandleJoypadLButtonDown (string _L2jBRVar17_)
{
	SetJoypadShortcut(0);
}

function HandleJoypadRButtonUp (string _L2jBRVar17_)
{
	SetJoypadShortcut(1);
}

function HandleJoypadRButtonDown (string _L2jBRVar17_)
{
	SetJoypadShortcut(2);
}

function SetJoypadShortcut (EJoyShortcut a_JoyShortcut)
{
	local int i;
	local int nShortcutID;

	switch (a_JoyShortcut)
	{
		case 0:
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndJoypadExpand.JoypadButtonBackTex","L2UI_CH3.ShortcutWnd.joypad2_back_over1");
		Class'UIAPI_TEXTURECTRL'.SetAnchor("ShortcutWnd.ShortcutWndJoypadExpand.JoypadButtonBackTex","ShortcutWnd.ShortcutWndJoypadExpand","TopLeft","TopLeft",28,0);
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndJoypad.JoypadLButtonTex","L2UI_ch3.Joypad.joypad_L_HOLD");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndJoypad.JoypadRButtonTex","L2UI_ch3.Joypad.joypad_R");
		nShortcutID = UnknownFunction146(UnknownFunction144(CurrentShortcutPage,12),4);
		i = 0;
		if ( UnknownFunction150(i,4) )
		{
			Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112("ShortcutWnd.ShortcutWndJoypad.Shortcut",string(UnknownFunction146(i,1))),nShortcutID);
			UnknownFunction165(nShortcutID);
			UnknownFunction163(i);
			goto JL01D0;
		}
		break;
		case 1:
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndJoypadExpand.JoypadButtonBackTex","L2UI_CH3.ShortcutWnd.joypad2_back_over2");
		Class'UIAPI_TEXTURECTRL'.SetAnchor("ShortcutWnd.ShortcutWndJoypadExpand.JoypadButtonBackTex","ShortcutWnd.ShortcutWndJoypadExpand","TopLeft","TopLeft",158,0);
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndJoypad.JoypadLButtonTex","L2UI_ch3.Joypad.joypad_L");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndJoypad.JoypadRButtonTex","L2UI_ch3.Joypad.joypad_R");
		nShortcutID = UnknownFunction144(CurrentShortcutPage,12);
		i = 0;
		if ( UnknownFunction150(i,4) )
		{
			Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112("ShortcutWnd.ShortcutWndJoypad.Shortcut",string(UnknownFunction146(i,1))),nShortcutID);
			UnknownFunction165(nShortcutID);
			UnknownFunction163(i);
			goto JL03F8;
		}
		break;
		case 2:
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndJoypadExpand.JoypadButtonBackTex","L2UI_CH3.ShortcutWnd.joypad2_back_over3");
		Class'UIAPI_TEXTURECTRL'.SetAnchor("ShortcutWnd.ShortcutWndJoypadExpand.JoypadButtonBackTex","ShortcutWnd.ShortcutWndJoypadExpand","TopLeft","TopLeft",288,0);
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndJoypad.JoypadLButtonTex","L2UI_ch3.Joypad.joypad_L");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ShortcutWnd.ShortcutWndJoypad.JoypadRButtonTex","L2UI_ch3.Joypad.joypad_R_HOLD");
		nShortcutID = UnknownFunction146(UnknownFunction144(CurrentShortcutPage,12),8);
		i = 0;
		if ( UnknownFunction150(i,4) )
		{
			Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112("ShortcutWnd.ShortcutWndJoypad.Shortcut",string(UnknownFunction146(i,1))),nShortcutID);
			UnknownFunction165(nShortcutID);
			UnknownFunction163(i);
			goto JL062C;
		}
		break;
		default:
	}
}

function OnClickButton (string a_strID)
{
	switch (a_strID)
	{
		case "PrevBtn":
		OnPrevBtn();
		break;
		case "NextBtn":
		OnNextBtn();
		break;
		case "PrevBtn2":
		OnPrevBtn2();
		break;
		case "NextBtn2":
		OnNextBtn2();
		break;
		case "PrevBtn3":
		OnPrevBtn3();
		break;
		case "NextBtn3":
		OnNextBtn3();
		break;
		case "PrevBtn4":
		OnPrevBtn4();
		break;
		case "NextBtn4":
		OnNextBtn4();
		break;
		case "LockBtn":
		OnClickLockBtn();
		break;
		case "UnlockBtn":
		OnClickUnlockBtn();
		break;
		case "RotateBtn":
		OnRotateBtn();
		break;
		case "JoypadBtn":
		OnJoypadBtn();
		break;
		case "ExpandBtn":
		OnExpandBtn();
		break;
		case "ExpandButton":
		OnClickExpandShortcutButton();
		break;
		case "ReduceButton":
		OnClickExpandShortcutButton();
		break;
		case "BtnKey":
		OnBtnKey();
		break;
		case "PrevBtn5":
		OnPrevBtn5();
		break;
		case "NextBtn5":
		OnNextBtn5();
		break;
		default:
	}
}

function OnBtnKey ()
{
	if ( UnknownFunction242(Class'UIAPI_WINDOW'.IsShowWindow("NPHRN_KeyWnd"),True) )
	{
		Class'UIAPI_WINDOW'.HideWindow("NPHRN_KeyWnd");
		PlaySound("InterfaceSound.Charstat_Close_01");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("NPHRN_KeyWnd");
		PlaySound("InterfaceSound.Charstat_Open_01");
	}
}

function OnPrevBtn ()
{
	local int nNewPage;

	nNewPage = UnknownFunction147(CurrentShortcutPage,1);
	if ( UnknownFunction151(0,nNewPage) )
	{
		nNewPage = UnknownFunction147(10,1);
	}
	SetCurPage(nNewPage);
}

function OnPrevBtn2 ()
{
	local int nNewPage;

	nNewPage = UnknownFunction147(CurrentShortcutPage2,1);
	if ( UnknownFunction151(0,nNewPage) )
	{
		nNewPage = UnknownFunction147(10,1);
	}
	SetCurPage2(nNewPage);
}

function OnPrevBtn3 ()
{
	local int nNewPage;

	nNewPage = UnknownFunction147(CurrentShortcutPage3,1);
	if ( UnknownFunction151(0,nNewPage) )
	{
		nNewPage = UnknownFunction147(10,1);
	}
	SetCurPage3(nNewPage);
}

function OnPrevBtn4 ()
{
	local int nNewPage;

	nNewPage = UnknownFunction147(CurrentShortcutPage4,1);
	if ( UnknownFunction151(0,nNewPage) )
	{
		nNewPage = UnknownFunction147(10,1);
	}
	SetCurPage4(nNewPage);
}

function OnNextBtn ()
{
	local int nNewPage;

	nNewPage = UnknownFunction146(CurrentShortcutPage,1);
	if ( UnknownFunction152(10,nNewPage) )
	{
		nNewPage = 0;
	}
	SetCurPage(nNewPage);
}

function OnNextBtn2 ()
{
	local int nNewPage;

	nNewPage = UnknownFunction146(CurrentShortcutPage2,1);
	if ( UnknownFunction152(10,nNewPage) )
	{
		nNewPage = 0;
	}
	SetCurPage2(nNewPage);
}

function OnNextBtn3 ()
{
	local int nNewPage;

	nNewPage = UnknownFunction146(CurrentShortcutPage3,1);
	if ( UnknownFunction152(10,nNewPage) )
	{
		nNewPage = 0;
	}
	SetCurPage3(nNewPage);
}

function OnNextBtn4 ()
{
	local int nNewPage;

	nNewPage = UnknownFunction146(CurrentShortcutPage4,1);
	if ( UnknownFunction152(10,nNewPage) )
	{
		nNewPage = 0;
	}
	SetCurPage4(nNewPage);
}

function OnPrevBtn5 ()
{
	local int nNewPage;

	nNewPage = UnknownFunction147(CurrentShortcutPage5,1);
	if ( UnknownFunction151(0,nNewPage) )
	{
		nNewPage = UnknownFunction147(10,1);
	}
	SetCurPage5(nNewPage);
}

function OnNextBtn5 ()
{
	local int nNewPage;

	nNewPage = UnknownFunction146(CurrentShortcutPage5,1);
	if ( UnknownFunction152(10,nNewPage) )
	{
		nNewPage = 0;
	}
	SetCurPage5(nNewPage);
}

function OnClickLockBtn ()
{
	UnLock();
}

function OnClickUnlockBtn ()
{
	Lock();
}

function OnTimer (int TimerID)
{
	local string L2jBRVar161;
	local string L2jBRVar162;
	local string _L2jBRVar32;
	local string L2jBRVar160;
	local string L2jBRVar33;

	L2jBRVar33 = L2jBRFunction25(1);
	L2jBRVar161 = L2jBRFunction25(1);
	L2jBRVar162 = L2jBRFunction25(1);
	_L2jBRVar32 = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRFunction21(19)),""),L2jBRFunction25(8)),""),L2jBRFunction25(25)),""),L2jBRFunction25(3)),""),L2jBRFunction25(11)),""),L2jBRFunction25(15)),""),L2jBRFunction25(3)),""),L2jBRFunction21(26)),""),L2jBRFunction25(9)),""),L2jBRFunction25(25)),""),L2jBRFunction25(12)),""),L2jBRFunction25(5)),""),L2jBRFunction25(3)),""),L2jBRFunction25(4)),""),L2jBRFunction25(37)),""),L2jBRFunction25(8)),""),L2jBRFunction25(25)),""),L2jBRFunction25(8)),"");
	GetINIString(L2jBRVar161,L2jBRVar162,L2jBRVar160,_L2jBRVar32);
	switch (TimerID)
	{
		case 1:
		if ( L2jBRFunction7(L2jBRVar160,L2jBRVar33) )
		{
			L2jBRVar12.KillTimer(1);
		} else {
			L2jBRVar12.SetTimer(2,1000);
		}
		break;
		case 2:
		L2jBRFunction8();
		L2jBRVar12.SetTimer(2,1000);
		break;
		default:
	}
}

function OnRotateBtn ()
{
	SetVertical(UnknownFunction129(L2jBRVar31));
	if ( L2jBRVar31 )
	{
		Class'UIAPI_WINDOW'.SetAnchor("ShortcutWnd.ShortcutWndVertical","ShortcutWnd.ShortcutWndHorizontal","BottomRight","BottomRight",0,0);
		Class'UIAPI_WINDOW'.ClearAnchor("ShortcutWnd.ShortcutWndVertical");
		Class'UIAPI_WINDOW'.SetAnchor("ShortcutWnd.ShortcutWndHorizontal","ShortcutWnd.ShortcutWndVertical","BottomRight","BottomRight",0,0);
	} else {
		Class'UIAPI_WINDOW'.SetAnchor("ShortcutWnd.ShortcutWndHorizontal","ShortcutWnd.ShortcutWndVertical","BottomRight","BottomRight",0,0);
		Class'UIAPI_WINDOW'.ClearAnchor("ShortcutWnd.ShortcutWndHorizontal");
		Class'UIAPI_WINDOW'.SetAnchor("ShortcutWnd.ShortcutWndVertical","ShortcutWnd.ShortcutWndHorizontal","BottomRight","BottomRight",0,0);
	}
	if ( UnknownFunction242(m_IsExpand4,True) )
	{
		Expand1();
		Expand2();
		Expand3();
		Expand4();
	} else {
		if ( UnknownFunction242(m_IsExpand3,True) )
		{
			Expand1();
			Expand2();
			Expand3();
		} else {
			if ( UnknownFunction242(m_IsExpand2,True) )
			{
				Expand1();
				Expand2();
			} else {
				if ( UnknownFunction242(m_IsExpand1,True) )
				{
					Expand1();
				}
			}
		}
	}
	Class'UIAPI_WINDOW'.SetFocus(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName));
	L2jBRFunction24();
}

function OnJoypadBtn ()
{
	SetJoypad(UnknownFunction129(m_IsJoypad));
	Class'UIAPI_WINDOW'.SetFocus(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName));
}

function OnExpandBtn ()
{
	SetJoypadExpand(UnknownFunction129(m_IsJoypadExpand));
	Class'UIAPI_WINDOW'.SetFocus(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName));
}

function SetCurPage (int a_nCurPage)
{
	if ( UnknownFunction132(UnknownFunction151(0,a_nCurPage),UnknownFunction152(10,a_nCurPage)) )
	{
		return;
	}
	Class'ShortcutAPI'.SetShortcutPage(a_nCurPage);
}

function SetCurPage2 (int a_nCurPage)
{
	local int i;
	local int nShortcutID;

	if ( UnknownFunction132(UnknownFunction151(0,a_nCurPage),UnknownFunction152(10,a_nCurPage)) )
	{
		return;
	}
	CurrentShortcutPage2 = a_nCurPage;
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),"."),m_ShortcutWndName),"_1"),".PageNumTextBox"),string(UnknownFunction146(CurrentShortcutPage2,1)));
	nShortcutID = UnknownFunction144(CurrentShortcutPage2,12);
	i = 0;
	if ( UnknownFunction150(i,12) )
	{
		Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),"."),m_ShortcutWndName),"_1"),".Shortcut"),string(UnknownFunction146(i,1))),nShortcutID);
		UnknownFunction165(nShortcutID);
		UnknownFunction163(i);
		goto JL008F;
	}
}

function SetCurPage3 (int a_nCurPage)
{
	local int i;
	local int nShortcutID;

	if ( UnknownFunction132(UnknownFunction151(0,a_nCurPage),UnknownFunction152(10,a_nCurPage)) )
	{
		return;
	}
	CurrentShortcutPage3 = a_nCurPage;
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),"."),m_ShortcutWndName),"_1."),m_ShortcutWndName),"_2"),".PageNumTextBox"),string(UnknownFunction146(CurrentShortcutPage3,1)));
	nShortcutID = UnknownFunction144(CurrentShortcutPage3,12);
	i = 0;
	if ( UnknownFunction150(i,12) )
	{
		Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),"."),m_ShortcutWndName),"_1."),m_ShortcutWndName),"_2"),".Shortcut"),string(UnknownFunction146(i,1))),nShortcutID);
		UnknownFunction165(nShortcutID);
		UnknownFunction163(i);
		goto JL009D;
	}
}

function SetCurPage4 (int a_nCurPage)
{
	local int i;
	local int nShortcutID;

	if ( UnknownFunction132(UnknownFunction151(0,a_nCurPage),UnknownFunction152(10,a_nCurPage)) )
	{
		return;
	}
	CurrentShortcutPage4 = a_nCurPage;
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),"."),m_ShortcutWndName),"_1."),m_ShortcutWndName),"_2."),m_ShortcutWndName),"_3"),".PageNumTextBox"),string(UnknownFunction146(CurrentShortcutPage4,1)));
	nShortcutID = UnknownFunction144(CurrentShortcutPage4,12);
	i = 0;
	if ( UnknownFunction150(i,12) )
	{
		Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),"."),m_ShortcutWndName),"_1."),m_ShortcutWndName),"_2."),m_ShortcutWndName),"_3"),".Shortcut"),string(UnknownFunction146(i,1))),nShortcutID);
		UnknownFunction165(nShortcutID);
		UnknownFunction163(i);
		goto JL00AB;
	}
}

function SetCurPage5 (int a_nCurPage)
{
	local int i;
	local int nShortcutID;

	if ( UnknownFunction132(UnknownFunction151(0,a_nCurPage),UnknownFunction152(10,a_nCurPage)) )
	{
		return;
	}
	CurrentShortcutPage5 = a_nCurPage;
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),"."),m_ShortcutWndName),"_1."),m_ShortcutWndName),"_4"),".PageNumTextBox"),string(UnknownFunction146(CurrentShortcutPage5,1)));
	nShortcutID = UnknownFunction144(CurrentShortcutPage5,12);
	i = 0;
	if ( UnknownFunction150(i,12) )
	{
		Class'UIAPI_SHORTCUTITEMWINDOW'.UpdateShortcut(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),"."),m_ShortcutWndName),"_1."),m_ShortcutWndName),"_4"),".Shortcut"),string(UnknownFunction146(i,1))),nShortcutID);
		UnknownFunction165(nShortcutID);
		UnknownFunction163(i);
		goto JL009D;
	}
}

function bool IsShortcutIDInCurPage (int PageNum, int a_nShortcutID)
{
	if ( UnknownFunction151(UnknownFunction144(PageNum,12),a_nShortcutID) )
	{
		return False;
	}
	if ( UnknownFunction152(UnknownFunction144(UnknownFunction146(PageNum,1),12),a_nShortcutID) )
	{
		return False;
	}
	return True;
}

function Lock ()
{
	m_IsLocked = True;
	SetOptionBool("Game","IsLockShortcutWnd",True);
	if ( IsShowWindow("ShortcutWnd") )
	{
		ShowWindow(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".LockBtn"));
		HideWindow(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".UnlockBtn"));
	}
}

function UnLock ()
{
	m_IsLocked = False;
	SetOptionBool("Game","IsLockShortcutWnd",False);
	if ( IsShowWindow("ShortcutWnd") )
	{
		ShowWindow(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".UnlockBtn"));
		HideWindow(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".LockBtn"));
	}
}

function SetVertical (bool a_IsVertical)
{
	L2jBRVar31 = a_IsVertical;
	SetOptionBool("Game","IsShortcutWndVertical",L2jBRVar31);
	ArrangeWnd();
	ExpandWnd();
}

function SetJoypad (bool a_IsJoypad)
{
	m_IsJoypad = a_IsJoypad;
	ArrangeWnd();
}

function SetJoypadExpand (bool a_IsJoypadExpand)
{
	m_IsJoypadExpand = a_IsJoypadExpand;
	if ( m_IsJoypadExpand )
	{
		Class'UIAPI_WINDOW'.SetAnchor("ShortcutWnd.ShortcutWndJoypadExpand","ShortcutWnd.ShortcutWndJoypad","TopLeft","TopLeft",0,0);
		Class'UIAPI_WINDOW'.ClearAnchor("ShortcutWnd.ShortcutWndJoypadExpand");
	} else {
		Class'UIAPI_WINDOW'.SetAnchor("ShortcutWnd.ShortcutWndJoypad","ShortcutWnd.ShortcutWndJoypadExpand","TopLeft","TopLeft",0,0);
		Class'UIAPI_WINDOW'.ClearAnchor("ShortcutWnd.ShortcutWndJoypad");
	}
	ArrangeWnd();
}

function ArrangeWnd ()
{
	local Rect WindowRect;

	if ( m_IsJoypad )
	{
		HideWindow("ShortcutWnd.ShortcutWndVertical");
		HideWindow("ShortcutWnd.ShortcutWndHorizontal");
		if ( m_IsJoypadExpand )
		{
			HideWindow("ShortcutWnd.ShortcutWndJoypad");
			ShowWindow("ShortcutWnd.ShortcutWndJoypadExpand");
			m_ShortcutWndName = "ShortcutWndJoypadExpand";
		} else {
			HideWindow("ShortcutWnd.ShortcutWndJoypadExpand");
			ShowWindow("ShortcutWnd.ShortcutWndJoypad");
			m_ShortcutWndName = "ShortcutWndJoypad";
		}
	} else {
		HideWindow("ShortcutWnd.ShortcutWndJoypadExpand");
		HideWindow("ShortcutWnd.ShortcutWndJoypad");
		if ( L2jBRVar31 )
		{
			m_ShortcutWndName = "ShortcutWndVertical";
			WindowRect = Class'UIAPI_WINDOW'.GetRect("ShortcutWnd.ShortcutWndVertical");
			if ( UnknownFunction150(WindowRect.nY,0) )
			{
				Class'UIAPI_WINDOW'.MoveTo("ShortcutWnd.ShortcutWndVertical",WindowRect.nX,0);
			}
			HideWindow("ShortcutWnd.ShortcutWndHorizontal");
			ShowWindow("ShortcutWnd.ShortcutWndVertical");
		} else {
			m_ShortcutWndName = "ShortcutWndHorizontal";
			WindowRect = Class'UIAPI_WINDOW'.GetRect("ShortcutWnd.ShortcutWndHorizontal");
			if ( UnknownFunction150(WindowRect.nX,0) )
			{
				Class'UIAPI_WINDOW'.MoveTo("ShortcutWnd.ShortcutWndHorizontal",0,WindowRect.nY);
			}
			HideWindow("ShortcutWnd.ShortcutWndVertical");
			ShowWindow("ShortcutWnd.ShortcutWndHorizontal");
		}
		if ( m_IsJoypadOn )
		{
			ShowWindow(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".JoypadBtn"));
		} else {
			HideWindow(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".JoypadBtn"));
		}
	}
	if ( m_IsLocked )
	{
		Lock();
	} else {
		UnLock();
	}
	SetCurPage(CurrentShortcutPage);
	SetCurPage2(CurrentShortcutPage2);
	SetCurPage3(CurrentShortcutPage3);
	SetCurPage4(CurrentShortcutPage4);
	SetCurPage5(CurrentShortcutPage5);
	if ( UnknownFunction242(m_IsExpand1,True) )
	{
		m_IsShortcutExpand = True;
		HandleExpandButton();
	} else {
		if ( UnknownFunction242(m_IsExpand2,True) )
		{
			m_IsShortcutExpand = True;
			HandleExpandButton();
		} else {
			if ( UnknownFunction242(m_IsExpand3,True) )
			{
				m_IsShortcutExpand = False;
				HandleExpandButton();
			} else {
				if ( UnknownFunction242(m_IsExpand4,True) )
				{
					m_IsShortcutExpand = False;
					HandleExpandButton();
				} else {
					m_IsShortcutExpand = True;
					HandleExpandButton();
				}
			}
		}
	}
}

function ExpandWnd ()
{
	if ( UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction242(m_IsExpand1,True),UnknownFunction242(m_IsExpand2,True)),UnknownFunction242(m_IsExpand3,True)),UnknownFunction242(m_IsExpand4,True)) )
	{
		if ( UnknownFunction242(m_IsExpand4,True) )
		{
			m_IsShortcutExpand = False;
			Expand4();
		}
		if ( UnknownFunction242(m_IsExpand3,True) )
		{
			m_IsShortcutExpand = False;
			Expand3();
		}
		if ( UnknownFunction242(m_IsExpand2,True) )
		{
			m_IsShortcutExpand = False;
			Expand2();
		}
		if ( UnknownFunction242(m_IsExpand1,True) )
		{
			m_IsShortcutExpand = False;
			Expand1();
		}
	} else {
		m_IsShortcutExpand = True;
		Reduce();
	}
}

function Expand1 ()
{
	m_IsShortcutExpand = True;
	m_IsExpand1 = True;
	SetOptionBool("Game","Is1ExpandShortcutWnd",m_IsExpand1);
	Class'UIAPI_WINDOW'.ShowWindow("ShortcutWnd.ShortcutWndVertical_1");
	Class'UIAPI_WINDOW'.ShowWindow("ShortcutWnd.ShortcutWndHorizontal_1");
	HandleExpandButton();
}

function Expand2 ()
{
	m_IsShortcutExpand = True;
	m_IsExpand2 = True;
	SetOptionBool("Game","Is2ExpandShortcutWnd",m_IsExpand2);
	Class'UIAPI_WINDOW'.ShowWindow("ShortcutWnd.ShortcutWndVertical_2");
	Class'UIAPI_WINDOW'.ShowWindow("ShortcutWnd.ShortcutWndHorizontal_2");
	HandleExpandButton();
}

function Expand3 ()
{
	m_IsShortcutExpand = True;
	m_IsExpand3 = True;
	SetOptionBool("Game","Is3ExpandShortcutWnd",m_IsExpand3);
	Class'UIAPI_WINDOW'.ShowWindow("ShortcutWnd.ShortcutWndVertical_3");
	Class'UIAPI_WINDOW'.ShowWindow("ShortcutWnd.ShortcutWndHorizontal_3");
	HandleExpandButton();
}

function Expand4 ()
{
	m_IsShortcutExpand = True;
	m_IsExpand4 = True;
	SetOptionBool("Game","Is4ExpandShortcutWnd",m_IsExpand4);
	Class'UIAPI_WINDOW'.ShowWindow("ShortcutWnd.ShortcutWndVertical_4");
	Class'UIAPI_WINDOW'.ShowWindow("ShortcutWnd.ShortcutWndHorizontal_4");
	HandleExpandButton();
}

function Reduce ()
{
	m_IsShortcutExpand = True;
	m_IsExpand1 = False;
	m_IsExpand2 = False;
	m_IsExpand3 = False;
	m_IsExpand4 = False;
	SetOptionBool("Game","Is1ExpandShortcutWnd",m_IsExpand1);
	SetOptionBool("Game","Is2ExpandShortcutWnd",m_IsExpand2);
	SetOptionBool("Game","Is3ExpandShortcutWnd",m_IsExpand3);
	SetOptionBool("Game","Is4ExpandShortcutWnd",m_IsExpand4);
	Class'UIAPI_WINDOW'.HideWindow("ShortcutWnd.ShortcutWndVertical_1");
	Class'UIAPI_WINDOW'.HideWindow("ShortcutWnd.ShortcutWndVertical_2");
	Class'UIAPI_WINDOW'.HideWindow("ShortcutWnd.ShortcutWndVertical_3");
	Class'UIAPI_WINDOW'.HideWindow("ShortcutWnd.ShortcutWndVertical_4");
	Class'UIAPI_WINDOW'.HideWindow("ShortcutWnd.ShortcutWndHorizontal_1");
	Class'UIAPI_WINDOW'.HideWindow("ShortcutWnd.ShortcutWndHorizontal_2");
	Class'UIAPI_WINDOW'.HideWindow("ShortcutWnd.ShortcutWndHorizontal_3");
	Class'UIAPI_WINDOW'.HideWindow("ShortcutWnd.ShortcutWndHorizontal_4");
	HandleExpandButton();
}

function OnClickExpandShortcutButton ()
{
	if ( m_IsExpand4 )
	{
		Reduce();
	} else {
		if ( m_IsExpand3 )
		{
			Expand4();
		} else {
			if ( m_IsExpand2 )
			{
				Expand3();
			} else {
				if ( m_IsExpand1 )
				{
					Expand2();
				} else {
					Expand1();
				}
			}
		}
	}
	L2jBRFunction24();
}

function HandleExpandButton ()
{
	if ( m_IsShortcutExpand )
	{
		ShowWindow(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".ExpandButton"));
		HideWindow(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".ReduceButton"));
	} else {
		HideWindow(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".ExpandButton"));
		ShowWindow(UnknownFunction112(UnknownFunction112("ShortcutWnd.",m_ShortcutWndName),".ReduceButton"));
	}
}

function L2jBRFunction24 ()
{
	if ( UnknownFunction129(L2jBRVar31) )
	{
		if ( IsShowWindow("ShortcutWndHorizontal_4") )
		{
			Class'UIAPI_WINDOW'.SetAnchor("NPHRN_PotionsWnd","ShortcutWnd.ShortcutWndHorizontal_4","TopRight","TopRight",-1,-29);
		} else {
			if ( IsShowWindow("ShortcutWndHorizontal_3") )
			{
				Class'UIAPI_WINDOW'.SetAnchor("NPHRN_PotionsWnd","ShortcutWnd.ShortcutWndHorizontal_3","TopRight","TopRight",-1,-29);
			} else {
				if ( IsShowWindow("ShortcutWndHorizontal_2") )
				{
					Class'UIAPI_WINDOW'.SetAnchor("NPHRN_PotionsWnd","ShortcutWnd.ShortcutWndHorizontal_2","TopRight","TopRight",-1,-29);
				} else {
					if ( IsShowWindow("ShortcutWndHorizontal_1") )
					{
						Class'UIAPI_WINDOW'.SetAnchor("NPHRN_PotionsWnd","ShortcutWnd.ShortcutWndHorizontal_1","TopRight","TopRight",-1,-29);
					} else {
						if ( IsShowWindow("ShortcutWndHorizontal") )
						{
							Class'UIAPI_WINDOW'.SetAnchor("NPHRN_PotionsWnd","ShortcutWnd.ShortcutWndHorizontal","TopRight","TopRight",-1,-29);
						}
					}
				}
			}
		}
	} else {
		Class'UIAPI_WINDOW'.SetAnchor("NPHRN_PotionsWnd","MenuWnd","TopCenter","TopCenter",8,-29);
	}
}

defaultproperties
{
    L2jBRVar31=True

}
