//================================================================================
// OnScreenMessageWnd.
//================================================================================

class OnScreenMessageWnd extends UIScript;

var string currentwnd1;
var bool onshowstat1;
var bool onshowstat2;
var int timerset1;
var int globalAlphavalue1;
var int globalAlphavalue2;
var int globalDuration;
var int droprate;
var int moveval;
var int moveval2;
var string MovedWndName;
var int m_TimerCount;
var bool linedivided;

function OnLoad ()
{
	RegisterEvent(140);
	RegisterEvent(580);
	ResetAllMessage();
	timerset1 = 0;
	moveval = 0;
	moveval2 = 0;
	globalAlphavalue1 = 0;
	globalAlphavalue2 = 255;
	m_TimerCount = 0;
}

function OnTick ()
{
	if ( UnknownFunction242(onshowstat1,True) )
	{
		FadeIn(currentwnd1);
	}
	if ( UnknownFunction242(onshowstat2,True) )
	{
		FadeOut(currentwnd1);
	}
}

function OnTimer (int TimerID)
{
	if ( UnknownFunction151(m_TimerCount,0) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("OnScreenMessageWnd1",m_TimerCount);
		UnknownFunction166(m_TimerCount);
		if ( UnknownFunction150(m_TimerCount,1) )
		{
			m_TimerCount = 0;
			onshowstat2 = True;
		}
	}
}

function OnHide ()
{
}

function ResetAllMessage ()
{
	local int i;
	local Color DefaultColor;
	local string WndName;

	DefaultColor.R = 255;
	DefaultColor.G = 255;
	DefaultColor.B = 255;
	globalAlphavalue1 = 0;
	globalAlphavalue2 = 255;
	currentwnd1 = "";
	onshowstat1 = False;
	onshowstat2 = False;
	Class'UIAPI_WINDOW'.HideWindow("OnScreenMessageWnd1");
	Class'UIAPI_WINDOW'.HideWindow("OnScreenMessageWnd2");
	Class'UIAPI_WINDOW'.HideWindow("OnScreenMessageWnd3");
	Class'UIAPI_WINDOW'.HideWindow("OnScreenMessageWnd4");
	Class'UIAPI_WINDOW'.HideWindow("OnScreenMessageWnd5");
	Class'UIAPI_WINDOW'.HideWindow("OnScreenMessageWnd6");
	Class'UIAPI_WINDOW'.HideWindow("OnScreenMessageWnd7");
	Class'UIAPI_WINDOW'.HideWindow("OnScreenMessageWnd8");
	i = 1;
	if ( UnknownFunction152(i,8) )
	{
		WndName = UnknownFunction112("OnScreenMessageWnd",string(i));
		Class'UIAPI_TEXTBOX'.SetTextColor(UnknownFunction112(UnknownFunction112(WndName,".TextBox"),string(i)),DefaultColor);
		Class'UIAPI_TEXTBOX'.SetTextColor(UnknownFunction112(UnknownFunction112(UnknownFunction112(WndName,".TextBox"),string(i)),"-1"),DefaultColor);
		Class'UIAPI_TEXTBOX'.SetTextColor(UnknownFunction112(UnknownFunction112(WndName,".TextBoxsm"),string(i)),DefaultColor);
		Class'UIAPI_TEXTBOX'.SetTextColor(UnknownFunction112(UnknownFunction112(UnknownFunction112(WndName,".TextBoxsm"),string(i)),"-1"),DefaultColor);
		UnknownFunction163(i);
		goto JL0175;
	}
}

function ShowMsg (int WndNum, string TextValue, int Duration, int Animation, int FontType, int BackgroundType, int ColorR, int ColorG, int ColorB)
{
	local string WndName;
	local string TextBoxName;
	local string ShadowBoxName;
	local string TextBoxName2;
	local string ShadowBoxName2;
	local string TextValue1;
	local string TextValue2;
	local string CurText;
	local string SmallBoxName1;
	local string SmallBoxName2;
	local Color FontColor;
	local int i;
	local int j;
	local int LengthTotal;
	local int TotalLength;
	local int TextOffsetTotal1;

	j = 1;
	TotalLength = UnknownFunction125(TextValue);
	TextValue1 = "";
	TextValue2 = "";
	linedivided = False;
	FontColor.R = ColorR;
	FontColor.G = ColorG;
	FontColor.B = ColorB;
	Debug(UnknownFunction168("totalval",TextValue));
	i = 1;
	if ( UnknownFunction152(i,TotalLength) )
	{
		LengthTotal = UnknownFunction147(UnknownFunction125(TextValue),1);
		CurText = UnknownFunction128(TextValue,1);
		TextValue = UnknownFunction234(TextValue,LengthTotal);
		if ( UnknownFunction122(CurText,"`") )
		{
			CurText = "";
		}
		if ( UnknownFunction122(CurText,"#") )
		{
			CurText = "";
			j = 2;
			linedivided = True;
		}
		if ( UnknownFunction154(j,1) )
		{
			TextValue1 = UnknownFunction112(TextValue1,CurText);
		} else {
			TextValue2 = UnknownFunction112(TextValue2,CurText);
		}
		UnknownFunction163(i);
		goto JL0080;
	}
	Debug(TextValue1);
	Debug(TextValue2);
	WndName = UnknownFunction112("OnScreenMessageWnd",string(WndNum));
	TextBoxName = UnknownFunction112(UnknownFunction112(WndName,".TextBox"),string(WndNum));
	ShadowBoxName = UnknownFunction112(UnknownFunction112(UnknownFunction112(WndName,".TextBox"),string(WndNum)),"-0");
	TextBoxName2 = UnknownFunction112(UnknownFunction112(UnknownFunction112(WndName,".TextBox"),string(WndNum)),"-1");
	ShadowBoxName2 = UnknownFunction112(UnknownFunction112(UnknownFunction112(WndName,".TextBox"),string(WndNum)),"-1-0");
	SmallBoxName1 = UnknownFunction112(UnknownFunction112(WndName,".TextBoxsm"),string(WndNum));
	SmallBoxName2 = UnknownFunction112(UnknownFunction112(UnknownFunction112(WndName,".TextBoxsm"),string(WndNum)),"-1");
	currentwnd1 = WndName;
	Class'UIAPI_TEXTBOX'.SetTextColor(TextBoxName,FontColor);
	Class'UIAPI_TEXTBOX'.SetTextColor(TextBoxName2,FontColor);
	Class'UIAPI_TEXTBOX'.SetTextColor(SmallBoxName1,FontColor);
	Class'UIAPI_TEXTBOX'.SetTextColor(SmallBoxName2,FontColor);
	if ( UnknownFunction154(FontType,0) )
	{
		Class'UIAPI_WINDOW'.ShowWindow(currentwnd1);
		Class'UIAPI_TEXTBOX'.SetText(ShadowBoxName,TextValue1);
		Class'UIAPI_TEXTBOX'.SetText(TextBoxName,TextValue1);
		Class'UIAPI_TEXTBOX'.SetText(ShadowBoxName2,TextValue2);
		Class'UIAPI_TEXTBOX'.SetText(TextBoxName2,TextValue2);
		Class'UIAPI_TEXTBOX'.SetText(SmallBoxName1,"");
		Class'UIAPI_TEXTBOX'.SetText(SmallBoxName2,"");
	} else {
		if ( UnknownFunction154(FontType,1) )
		{
			Class'UIAPI_WINDOW'.ShowWindow(currentwnd1);
			Class'UIAPI_TEXTBOX'.SetText(ShadowBoxName,"");
			Class'UIAPI_TEXTBOX'.SetText(TextBoxName,"");
			Class'UIAPI_TEXTBOX'.SetText(ShadowBoxName2,"");
			Class'UIAPI_TEXTBOX'.SetText(TextBoxName2,"");
			Class'UIAPI_TEXTBOX'.SetText(SmallBoxName1,TextValue1);
			Class'UIAPI_TEXTBOX'.SetText(SmallBoxName2,TextValue2);
		}
	}
	if ( UnknownFunction154(WndNum,2) )
	{
		if (! UnknownFunction155(moveval,0) ) goto JL042D;
		MovedWndName = WndName;
		moveval2 = UnknownFunction144(UnknownFunction145(TextOffsetTotal1,2),29);
		if ( UnknownFunction154(BackgroundType,1) )
		{
			Class'UIAPI_WINDOW'.ShowWindow(UnknownFunction112(MovedWndName,".texturetype1"));
		} else {
			Class'UIAPI_WINDOW'.HideWindow(UnknownFunction112(MovedWndName,".texturetype1"));
		}
	} else {
		if ( UnknownFunction154(WndNum,5) )
		{
			if (! UnknownFunction155(moveval,0) ) goto JL04BD;
			MovedWndName = WndName;
		} else {
			if ( UnknownFunction154(WndNum,7) )
			{
				if (! UnknownFunction155(moveval,0) ) goto JL04E2;
				MovedWndName = WndName;
			} else {
				moveval = 0;
			}
		}
	}
	onshowstat1 = True;
	onshowstat2 = False;
	globalDuration = Duration;
	switch (Animation)
	{
		case 0:
		droprate = 255;
		break;
		case 1:
		droprate = 25;
		break;
		case 11:
		droprate = 15;
		break;
		case 12:
		droprate = 25;
		break;
		case 13:
		droprate = 35;
		break;
		default:
	}
}

function FadeIn (string WndName)
{
	globalAlphavalue1 = UnknownFunction146(globalAlphavalue1,droprate);
	if ( UnknownFunction150(globalAlphavalue1,255) )
	{
		Class'UIAPI_WINDOW'.SetAlpha(WndName,globalAlphavalue1);
	} else {
		Class'UIAPI_WINDOW'.SetAlpha(WndName,255);
		globalAlphavalue1 = 0;
		onshowstat1 = False;
		UnknownFunction165(m_TimerCount);
		Class'UIAPI_WINDOW'.SetUITimer("OnScreenMessageWnd1",m_TimerCount,globalDuration);
	}
}

function FadeOut (string WndName)
{
	globalAlphavalue2 = UnknownFunction147(globalAlphavalue2,droprate);
	if ( UnknownFunction151(globalAlphavalue2,1) )
	{
		Class'UIAPI_WINDOW'.SetAlpha(WndName,globalAlphavalue2);
	} else {
		Class'UIAPI_WINDOW'.SetAlpha(WndName,0);
		globalAlphavalue2 = 255;
		onshowstat2 = False;
		ResetAllMessage();
		moveval2 = 0;
		moveval = 0;
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	local int MsgType;
	local int msgNo;
	local int WindowType;
	local int FontSize;
	local int FontType;
	local int MsgColor;
	local int msgcolorR;
	local int msgcolorG;
	local int msgcolorB;
	local int shadowtype;
	local int BackgroundType;
	local int Lifetime;
	local int AnimationType;
	local int L2jBRVar124;
	local string msgtext;
	local string ParamString1;
	local string ParamString2;

	if ( UnknownFunction154(L2jBRVar16,140) )
	{
		ParseInt(_L2jBRVar17_,"MsgType",MsgType);
		ParseInt(_L2jBRVar17_,"MsgNo",msgNo);
		ParseInt(_L2jBRVar17_,"WindowType",WindowType);
		ParseInt(_L2jBRVar17_,"FontSize",FontSize);
		ParseInt(_L2jBRVar17_,"FontType",FontType);
		ParseInt(_L2jBRVar17_,"MsgColor",MsgColor);
		if ( UnknownFunction129(ParseInt(_L2jBRVar17_,"MsgColorR",msgcolorR)) )
		{
			msgcolorR = 255;
		}
		if ( UnknownFunction129(ParseInt(_L2jBRVar17_,"MsgColorG",msgcolorG)) )
		{
			msgcolorG = 255;
		}
		if ( UnknownFunction129(ParseInt(_L2jBRVar17_,"MsgColorB",msgcolorB)) )
		{
			msgcolorB = 255;
		}
		ParseInt(_L2jBRVar17_,"ShadowType",shadowtype);
		ParseInt(_L2jBRVar17_,"BackgroundType",BackgroundType);
		ParseInt(_L2jBRVar17_,"LifeTime",Lifetime);
		ParseInt(_L2jBRVar17_,"AnimationType",AnimationType);
		ParseString(_L2jBRVar17_,"Msg",msgtext);
		ResetAllMessage();
		switch (MsgType)
		{
			case 1:
			ShowMsg(WindowType,msgtext,Lifetime,AnimationType,FontType,BackgroundType,msgcolorR,msgcolorG,msgcolorB);
			break;
			case 0:
			msgtext = GetSystemMessage(msgNo);
			ShowMsg(WindowType,msgtext,Lifetime,AnimationType,FontType,BackgroundType,msgcolorR,msgcolorG,msgcolorB);
			break;
			default:
		}
	}
	if ( UnknownFunction154(L2jBRVar16,580) )
	{
		ParseInt(_L2jBRVar17_,"Index",L2jBRVar124);
		ParseString(_L2jBRVar17_,"Param1",ParamString1);
		ParseString(_L2jBRVar17_,"Param2",ParamString2);
		ValidateSystemMsg(L2jBRVar124,ParamString1,ParamString2);
	}
}

function ValidateSystemMsg (int Index, string StringTxt1, string StringTxt2)
{
	local SystemMsgData SystemMsgCurrent;
	local int WindowType;
	local int FontType;
	local int BackgroundType;
	local int Lifetime;
	local int AnimationType;
	local string msgtext;
	local Color TextColor;

	GetSystemMsgInfo(Index,SystemMsgCurrent);
	if ( UnknownFunction155(SystemMsgCurrent.WindowType,0) )
	{
		WindowType = SystemMsgCurrent.WindowType;
		msgtext = SystemMsgCurrent.OnScrMsg;
		msgtext = MakeFullSystemMsg(msgtext,StringTxt1,StringTxt2);
		Lifetime = UnknownFunction144(SystemMsgCurrent.Lifetime,1000);
		AnimationType = SystemMsgCurrent.AnimationType;
		FontType = SystemMsgCurrent.FontType;
		BackgroundType = SystemMsgCurrent.BackgroundType;
		TextColor = SystemMsgCurrent.Color;
		if ( UnknownFunction130(UnknownFunction154(WindowType,1),UnknownFunction242(GetOptionBool("Neophron","ShowDamage"),False)) )
		{
			return;
		}
		if ( UnknownFunction130(UnknownFunction130(UnknownFunction154(TextColor.R,0),UnknownFunction154(TextColor.G,0)),UnknownFunction154(TextColor.B,0)) )
		{
			TextColor.R = 255;
			TextColor.G = 255;
			TextColor.B = 255;
		} else {
			if ( UnknownFunction130(UnknownFunction130(UnknownFunction154(TextColor.R,176),UnknownFunction154(TextColor.G,155)),UnknownFunction154(TextColor.B,121)) )
			{
				TextColor.R = 255;
				TextColor.G = 255;
				TextColor.B = 255;
			}
		}
		ShowMsg(WindowType,msgtext,Lifetime,AnimationType,FontType,BackgroundType,TextColor.R,TextColor.G,TextColor.B);
	}
}

