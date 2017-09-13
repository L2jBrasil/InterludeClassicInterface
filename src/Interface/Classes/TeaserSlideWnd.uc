//================================================================================
// TeaserSlideWnd.
//================================================================================

class TeaserSlideWnd extends UICommonAPI;

var WindowHandle m_TeaserSlideWnd_Main;
var WindowHandle m_BattleShot;
var WindowHandle m_BattleShot1;
var WindowHandle m_BattleShot2;
var WindowHandle m_BattleShot3;
var WindowHandle m_Female;
var WindowHandle m_Female1;
var WindowHandle m_Island;
var WindowHandle m_Island1;
var WindowHandle m_Island2;
var WindowHandle m_Island3;
var WindowHandle m_Male;
var WindowHandle m_Male1;
var WindowHandle m_Mark;
var WindowHandle m_Meeting1;
var WindowHandle m_Meeting2;
var WindowHandle m_Meeting3;
var WindowHandle m_Meeting4;
var WindowHandle m_Frame;
var WindowHandle m_OutsideFrame;
var WindowHandle m_Subtitle1;
var WindowHandle m_Subtitle2;
var WindowHandle m_Subtitle3;
var WindowHandle m_Subtitle4;
var WindowHandle m_Subtitle5;
var WindowHandle m_Subtitle6;
var WindowHandle m_Subtitle7;
var WindowHandle m_Subtitle8;
var WindowHandle m_blankback;
var WindowHandle m_blankback1;
var WindowHandle m_WhiteOut;
var WindowHandle m_LogoWhite;
var WindowHandle m_blankback2;
var WindowHandle m_FrameWnd;
var string t_Subtitle1;
var string t_Subtitle2;
var string t_Subtitle3;
var string t_Subtitle4;
var string t_Subtitle5;
var string t_Subtitle6;
var string t_Subtitle7;
var string t_Subtitle8;
var string t_voice;
var WindowHandle m_BillBoardLeft;
var WindowHandle m_BillBoardRight;
var float TempSoundVol;
var int CurrentTimer;
var int GlobalWidth;
var int GlobalMove;
var int GlobalLeft1;
var int GlobalRight2;
var int GlobalPixel;
var int GlobalMoveX;
var int totalplaytime;
var bool stat1;
var int stat2;
var bool gEndSlide;
var bool Slide1;
var int Slide2;
var float speedoffset;
var bool m_PlaySceneStarted;
const TIMER_DELAY= 5000;
const TIMER_ID= 0;

function OnLoad ()
{
	RegisterEvent(3000);
	RegisterEvent(2900);
	m_BattleShot = GetHandle("TeaserSlideWnd.Slide_BattleShot1");
	m_TeaserSlideWnd_Main = GetHandle("TeaserSlideWnd");
	m_BattleShot1 = GetHandle("TeaserSlideWnd.Slide_BattleShot2");
	m_BattleShot2 = GetHandle("TeaserSlideWnd.Slide_BattleShot3");
	m_BattleShot3 = GetHandle("TeaserSlideWnd.Slide_BattleShot4");
	m_Female = GetHandle("TeaserSlideWnd.Slide_Female");
	m_Female1 = GetHandle("TeaserSlideWnd.Slide_Female1");
	m_Island = GetHandle("TeaserSlideWnd.Slide_Island");
	m_Island1 = GetHandle("TeaserSlideWnd.Slide_Island1");
	m_Island2 = GetHandle("TeaserSlideWnd.Slide_Island2");
	m_Island3 = GetHandle("TeaserSlideWnd.Slide_Island2");
	m_Male = GetHandle("TeaserSlideWnd.Slide_Male");
	m_Male1 = GetHandle("TeaserSlideWnd.Slide_Male1");
	m_Mark = GetHandle("TeaserSlideWnd.Slide_Mark");
	m_Meeting1 = GetHandle("Slide_Meeting");
	m_Meeting2 = GetHandle("TeaserSlideWnd.Slide_Meeting1");
	m_Meeting3 = GetHandle("TeaserSlideWnd.Slide_Meeting2");
	m_Meeting4 = GetHandle("TeaserSlideWnd.Slide_Meeting3");
	m_Frame = GetHandle("TeaserSlideWnd.Slide_TextFrame");
	m_OutsideFrame = GetHandle("TeaserSlideWnd.OutsideFrame");
	m_Subtitle1 = GetHandle("TeaserSlideWnd.Slide_Subtitle1");
	m_Subtitle2 = GetHandle("TeaserSlideWnd.Slide_Subtitle2");
	m_Subtitle3 = GetHandle("TeaserSlideWnd.Slide_Subtitle3");
	m_Subtitle4 = GetHandle("TeaserSlideWnd.Slide_Subtitle4");
	m_Subtitle5 = GetHandle("TeaserSlideWnd.Slide_Subtitle5");
	m_Subtitle6 = GetHandle("TeaserSlideWnd.Slide_Subtitle6");
	m_Subtitle7 = GetHandle("TeaserSlideWnd.Slide_Subtitle7");
	m_blankback = GetHandle("TeaserSlideWnd.Main_Frame");
	m_blankback1 = GetHandle("TeaserSlideWnd.Main_Frame2");
	m_blankback2 = GetHandle("TeaserSlideWnd.Main_Frame3");
	m_Subtitle8 = GetHandle("TeaserSlideWnd.Slide_Subtitle8");
	m_FrameWnd = GetHandle("TeaserSlideWnd.OutsideFrame12");
	m_WhiteOut = GetHandle("TeaserSlideWnd.Slide_WhiteOut");
	m_LogoWhite = GetHandle("TeaserSlideWnd.Slide_MarkAlpha");
	m_BillBoardLeft = GetHandle("TeaserSlideWnd.billboardleft");
	m_BillBoardRight = GetHandle("TeaserSlideWnd.billboardright");
	Class'UIAPI_TEXTURECTRL'.SetTexture("TeaserSlideWnd.Slide_Subtitle1.SolasysResult1",t_Subtitle1);
	Class'UIAPI_TEXTURECTRL'.SetTexture("TeaserSlideWnd.Slide_Subtitle2.SolasysResult1",t_Subtitle2);
	Class'UIAPI_TEXTURECTRL'.SetTexture("TeaserSlideWnd.Slide_Subtitle3.SolasysResult1",t_Subtitle3);
	Class'UIAPI_TEXTURECTRL'.SetTexture("TeaserSlideWnd.Slide_Subtitle4.SolasysResult1",t_Subtitle4);
	Class'UIAPI_TEXTURECTRL'.SetTexture("TeaserSlideWnd.Slide_Subtitle5.SolasysResult1",t_Subtitle5);
	Class'UIAPI_TEXTURECTRL'.SetTexture("TeaserSlideWnd.Slide_Subtitle6.SolasysResult1",t_Subtitle6);
	Class'UIAPI_TEXTURECTRL'.SetTexture("TeaserSlideWnd.Slide_Subtitle7.SolasysResult1",t_Subtitle7);
	Class'UIAPI_TEXTURECTRL'.SetTexture("TeaserSlideWnd.Slide_Subtitle8.SolasysResult1",t_Subtitle8);
}

function ResetReady ()
{
	local OptionWnd L2jBRVar21;

	if ( m_PlaySceneStarted )
	{
		Debug("PlayScene already started!!");
		return;
	}
	m_PlaySceneStarted = True;
	gEndSlide = True;
	L2jBRVar21 = OptionWnd(GetScript("OptionWnd"));
	TempSoundVol = L2jBRVar21.gSoundVolume;
	SetSoundVolume(0.0);
	m_BattleShot.HideWindow();
	m_BattleShot1.HideWindow();
	m_BattleShot2.HideWindow();
	m_BattleShot3.HideWindow();
	m_Female.HideWindow();
	m_Female1.HideWindow();
	m_Island.HideWindow();
	m_Island1.HideWindow();
	m_Island2.HideWindow();
	m_Island3.HideWindow();
	m_Male.HideWindow();
	m_Male1.HideWindow();
	m_Mark.HideWindow();
	m_Meeting1.HideWindow();
	m_Meeting2.HideWindow();
	m_Meeting3.HideWindow();
	m_Meeting4.HideWindow();
	m_Frame.HideWindow();
	m_OutsideFrame.HideWindow();
	m_Subtitle1.HideWindow();
	m_Subtitle2.HideWindow();
	m_Subtitle3.HideWindow();
	m_Subtitle4.HideWindow();
	m_Subtitle5.HideWindow();
	m_Subtitle6.HideWindow();
	m_Subtitle7.HideWindow();
	m_Subtitle8.HideWindow();
	m_blankback.HideWindow();
	m_blankback1.HideWindow();
	m_WhiteOut.HideWindow();
	m_LogoWhite.HideWindow();
	m_blankback2.HideWindow();
	m_FrameWnd.HideWindow();
	totalplaytime = 0;
	Class'AudioAPI'.PlayMusic(t_voice,0.0,False,True);
	Debug("몇번들어올까나");
	stat1 = False;
	stat2 = 0;
	speedoffset = 1.0;
	SetUIState("SlideQuestState");
	CheckResolution();
	FixWindow43();
	m_TeaserSlideWnd_Main.ShowWindow();
	Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",0,2000);
}

function FixWindow43 ()
{
	m_Mark.SetWindowSizeRel43(1.0,1.0,0,0);
	m_BattleShot3.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Island.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Island1.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Island2.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Island3.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Meeting2.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Meeting3.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Meeting4.SetWindowSizeRel43(1.0,1.0,0,0);
	m_FrameWnd.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Subtitle1.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Subtitle2.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Subtitle3.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Subtitle4.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Subtitle5.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Subtitle6.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Subtitle7.SetWindowSizeRel43(1.0,1.0,0,0);
	m_Subtitle8.SetWindowSizeRel43(1.0,1.0,0,0);
	m_blankback.SetWindowSizeRel43(1.0,1.0,0,0);
	m_blankback1.SetWindowSizeRel43(1.0,1.0,0,0);
	m_blankback2.SetWindowSizeRel43(1.0,1.0,0,0);
	m_WhiteOut.SetWindowSizeRel43(1.0,1.0,0,0);
	m_LogoWhite.SetWindowSizeRel43(1.0,1.0,0,0);
}

function OnTimer (int TimerID)
{
	if ( UnknownFunction154(TimerID,0) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",0);
		Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",1,3000);
		CurrentTimer = 1;
		Debug(UnknownFunction168(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)),string(self)));
		totalplaytime = UnknownFunction146(totalplaytime,3000);
	}
	if ( UnknownFunction154(TimerID,1) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",1);
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.HideWindow();
			m_FrameWnd.ShowWindow();
			m_FrameWnd.SetFocus();
			m_blankback.ShowWindow();
			m_blankback2.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",2,2000);
			CurrentTimer = 2;
			Debug(UnknownFunction168(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)),string(self)));
			totalplaytime = UnknownFunction146(totalplaytime,2000);
		}
	}
	if ( UnknownFunction154(TimerID,2) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",2);
		m_blankback.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_Mark.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",3,3500);
			CurrentTimer = 3;
			Debug(UnknownFunction168(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)),string(self)));
			totalplaytime = UnknownFunction146(totalplaytime,3500);
		}
	}
	if ( UnknownFunction154(TimerID,3) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",3);
		m_Mark.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_blankback1.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",4,1000);
			CurrentTimer = 4;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,1000);
		}
	}
	if ( UnknownFunction154(TimerID,4) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",4);
		m_blankback1.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_Subtitle1.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",5,5300);
			CurrentTimer = 5;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,5300);
		}
	}
	if ( UnknownFunction154(TimerID,5) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",5);
		m_Subtitle1.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_Subtitle2.ShowWindow();
			m_blankback2.HideWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",6,6000);
			CurrentTimer = 6;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,6000);
		}
	}
	if ( UnknownFunction154(TimerID,6) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",6);
		m_Subtitle2.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.ShowWindow();
			m_FrameWnd.SetFocus();
			m_Meeting1.ShowWindow();
			m_Meeting1.ClearAnchor();
			m_Meeting1.Move(UnknownFunction145(GlobalMove,4),0,UnknownFunction171(14.0,speedoffset));
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",7,6000);
			CurrentTimer = 7;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,6000);
		}
	}
	if ( UnknownFunction154(TimerID,7) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",7);
		m_FrameWnd.SetFocus();
		m_Meeting1.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.SetFocus();
			m_Meeting2.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",8,3000);
			CurrentTimer = 8;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,3000);
		}
	}
	if ( UnknownFunction154(TimerID,8) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",8);
		m_Meeting2.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.SetFocus();
			m_Meeting3.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",9,3500);
			CurrentTimer = 9;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,3500);
		}
	}
	if ( UnknownFunction154(TimerID,9) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",9);
		m_Meeting3.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.SetFocus();
			m_Meeting4.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",10,3000);
			CurrentTimer = 10;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,3000);
		}
	}
	if ( UnknownFunction154(TimerID,10) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",10);
		m_Meeting4.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.HideWindow();
			m_Subtitle3.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",11,3800);
			CurrentTimer = 11;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,3800);
		}
	}
	if ( UnknownFunction154(TimerID,11) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",11);
		m_Subtitle3.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.ShowWindow();
			m_FrameWnd.SetFocus();
			m_Island.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",12,2500);
			CurrentTimer = 12;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,2500);
		}
	}
	if ( UnknownFunction154(TimerID,12) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",12);
		m_Island.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.SetFocus();
			m_Island1.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",13,2500);
			CurrentTimer = 13;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,2500);
		}
	}
	if ( UnknownFunction154(TimerID,13) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",13);
		m_Island1.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.HideWindow();
			m_Subtitle4.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",14,4800);
			CurrentTimer = 14;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,4800);
		}
	}
	if ( UnknownFunction154(TimerID,14) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",14);
		m_Subtitle4.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.ShowWindow();
			m_FrameWnd.SetFocus();
			m_BattleShot.ShowWindow();
			m_BattleShot.ClearAnchor();
			m_BattleShot.Move(UnknownFunction145(GlobalMove,4),0,UnknownFunction171(15.0,speedoffset));
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",15,2500);
			CurrentTimer = 15;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,2500);
		}
	}
	if ( UnknownFunction154(TimerID,15) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",15);
		m_BattleShot.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.SetFocus();
			m_BattleShot1.ShowWindow();
			m_BattleShot1.ClearAnchor();
			m_BattleShot1.Move(UnknownFunction144(-1,UnknownFunction145(GlobalMove,5)),0,UnknownFunction171(15.0,speedoffset));
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",16,2000);
			CurrentTimer = 16;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,2000);
		}
	}
	if ( UnknownFunction154(TimerID,16) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",16);
		m_BattleShot1.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.SetFocus();
			m_BattleShot2.ShowWindow();
			m_BattleShot2.ClearAnchor();
			m_BattleShot2.Move(UnknownFunction144(-1,UnknownFunction145(GlobalMove,5)),0,UnknownFunction171(10.0,speedoffset));
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",17,2000);
			CurrentTimer = 17;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,2000);
		}
	}
	if ( UnknownFunction154(TimerID,17) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",17);
		m_BattleShot2.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.SetFocus();
			m_BattleShot3.ShowWindow();
			m_BattleShot3.ClearAnchor();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",18,2300);
			CurrentTimer = 18;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,2300);
		}
	}
	if ( UnknownFunction154(TimerID,18) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",18);
		m_BattleShot3.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.HideWindow();
			m_Subtitle5.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",19,4900);
			CurrentTimer = 19;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,4900);
		}
	}
	if ( UnknownFunction154(TimerID,19) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",19);
		m_Subtitle5.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.ShowWindow();
			m_FrameWnd.SetFocus();
			m_Male.ShowWindow();
			m_Male.ClearAnchor();
			m_Male.Move(UnknownFunction145(GlobalMove,5),0,UnknownFunction171(14.0,speedoffset));
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",20,3000);
			CurrentTimer = 20;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,3000);
		}
	}
	if ( UnknownFunction154(TimerID,20) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",20);
		m_Male.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.SetFocus();
			m_Male1.ShowWindow();
			m_Male1.ClearAnchor();
			m_Male1.Move(UnknownFunction145(GlobalMove,5),0,UnknownFunction171(14.0,speedoffset));
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",21,3300);
			CurrentTimer = 21;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,3300);
		}
	}
	if ( UnknownFunction154(TimerID,21) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",21);
		m_FrameWnd.SetFocus();
		m_Male1.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.HideWindow();
			m_Subtitle6.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",22,3000);
			CurrentTimer = 22;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,3000);
		}
	}
	if ( UnknownFunction154(TimerID,22) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",22);
		m_Subtitle6.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.ShowWindow();
			m_FrameWnd.SetFocus();
			m_Female.ShowWindow();
			m_Female.ClearAnchor();
			m_Female.Move(UnknownFunction144(-1,UnknownFunction145(GlobalMove,5)),0,UnknownFunction171(14.0,speedoffset));
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",23,3000);
			CurrentTimer = 23;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,3000);
		}
	}
	if ( UnknownFunction154(TimerID,23) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",23);
		m_Female.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.SetFocus();
			m_Female1.ShowWindow();
			m_Female1.ClearAnchor();
			m_Female1.Move(UnknownFunction144(-1,UnknownFunction145(GlobalMove,5)),0,UnknownFunction171(16.0,speedoffset));
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",24,3300);
			CurrentTimer = 24;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,3300);
		}
	}
	if ( UnknownFunction154(TimerID,24) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",24);
		m_Female1.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_FrameWnd.HideWindow();
			m_blankback2.ShowWindow();
			m_Subtitle7.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",25,4400);
			CurrentTimer = 25;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,4400);
		}
	}
	if ( UnknownFunction154(TimerID,25) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",25);
		m_Subtitle7.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_Subtitle8.ShowWindow();
			m_blankback2.HideWindow();
			m_FrameWnd.HideWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",26,3000);
			CurrentTimer = 26;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,3000);
		}
	}
	if ( UnknownFunction154(TimerID,26) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",26);
		m_Subtitle8.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_WhiteOut.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",27,2000);
			CurrentTimer = 27;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,2000);
		}
	}
	if ( UnknownFunction154(TimerID,27) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",27);
		m_WhiteOut.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			m_LogoWhite.ShowWindow();
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",28,3500);
			CurrentTimer = 28;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,3500);
		}
	}
	if ( UnknownFunction154(TimerID,28) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",28);
		m_LogoWhite.HideWindow();
		if ( UnknownFunction242(gEndSlide,True) )
		{
			Class'UIAPI_WINDOW'.SetUITimer("TeaserSlideWnd",29,8000);
			CurrentTimer = 29;
			Debug(UnknownFunction168("현재슬라이드타이머=",string(CurrentTimer)));
			totalplaytime = UnknownFunction146(totalplaytime,3500);
		}
	}
	if ( UnknownFunction154(TimerID,29) )
	{
		EndShow();
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 3000:
		ResetReady();
		break;
		case 2900:
		FixWindow43();
		CheckResolution();
		break;
		default:
	}
}

function CheckResolution ()
{
	local int CurrentMaxWidth;
	local int CurrentMaxHeight;
	local int a1;
	local int a2;

	Debug("MinimapExpand - Checkresolution");
	GetCurrentResolution(CurrentMaxWidth,CurrentMaxHeight);
	GlobalWidth = CurrentMaxWidth;
	GlobalMove = UnknownFunction145(UnknownFunction144(CurrentMaxHeight,1024),768);
	GlobalMoveX = 0;
	if ( UnknownFunction152(UnknownFunction144(CurrentMaxWidth,3),UnknownFunction144(CurrentMaxHeight,4)) )
	{
		m_Meeting1.SetWindowSize(UnknownFunction145(UnknownFunction144(UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024),1440),768),UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024));
		m_BattleShot.SetWindowSize(UnknownFunction145(UnknownFunction144(UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024),1440),768),UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024));
		m_BattleShot1.SetWindowSize(UnknownFunction145(UnknownFunction144(UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024),1440),768),UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024));
		m_BattleShot2.SetWindowSize(UnknownFunction145(UnknownFunction144(UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024),1440),768),UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024));
		m_Male.SetWindowSize(UnknownFunction145(UnknownFunction144(UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024),1440),768),UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024));
		m_Male1.SetWindowSize(UnknownFunction145(UnknownFunction144(UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024),1440),768),UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024));
		m_Female.SetWindowSize(UnknownFunction145(UnknownFunction144(UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024),1440),768),UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024));
		m_Female1.SetWindowSize(UnknownFunction145(UnknownFunction144(UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024),1440),768),UnknownFunction145(UnknownFunction144(CurrentMaxWidth,768),1024));
	} else {
		m_Meeting1.SetWindowSize(UnknownFunction145(UnknownFunction144(CurrentMaxHeight,1440),768),CurrentMaxHeight);
		m_BattleShot.SetWindowSize(UnknownFunction145(UnknownFunction144(CurrentMaxHeight,1440),768),CurrentMaxHeight);
		m_BattleShot1.SetWindowSize(UnknownFunction145(UnknownFunction144(CurrentMaxHeight,1440),768),CurrentMaxHeight);
		m_BattleShot2.SetWindowSize(UnknownFunction145(UnknownFunction144(CurrentMaxHeight,1440),768),CurrentMaxHeight);
		m_Male.SetWindowSize(UnknownFunction145(UnknownFunction144(CurrentMaxHeight,1440),768),CurrentMaxHeight);
		m_Male1.SetWindowSize(UnknownFunction145(UnknownFunction144(CurrentMaxHeight,1440),768),CurrentMaxHeight);
		m_Female.SetWindowSize(UnknownFunction145(UnknownFunction144(CurrentMaxHeight,1440),768),CurrentMaxHeight);
		m_Female1.SetWindowSize(UnknownFunction145(UnknownFunction144(CurrentMaxHeight,1440),768),CurrentMaxHeight);
	}
	m_Meeting1.GetWindowSize(a1,a2);
	speedoffset = UnknownFunction172(1440.0,a1);
	m_BattleShot.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_BattleShot1.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_BattleShot2.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_BattleShot3.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Female.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Female1.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Island.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Island1.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Island2.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Island3.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Male.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Male1.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Mark.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Meeting1.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Meeting2.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Meeting3.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Meeting4.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Frame.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_OutsideFrame.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Subtitle1.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Subtitle2.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Subtitle3.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Subtitle4.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Subtitle5.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Subtitle6.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Subtitle7.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_blankback.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_blankback1.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_blankback2.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_Subtitle8.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_WhiteOut.SetAnchor("TeaserSlideWnd","CenterCenter","CenterCenter",0,0);
	m_BillBoardLeft.SetWindowSize(UnknownFunction146(UnknownFunction145(UnknownFunction147(CurrentMaxWidth,UnknownFunction145(UnknownFunction144(CurrentMaxHeight,1024),768)),2),2),CurrentMaxHeight);
	m_BillBoardRight.SetWindowSize(UnknownFunction146(UnknownFunction145(UnknownFunction147(CurrentMaxWidth,UnknownFunction145(UnknownFunction144(CurrentMaxHeight,1024),768)),2),2),CurrentMaxHeight);
	m_BillBoardLeft.SetAnchor("TeaserSlideWnd","CenterLeft","CenterLeft",0,0);
	m_BillBoardRight.SetAnchor("TeaserSlideWnd","CenterRight","CenterRight",0,0);
}

function EndShow ()
{
	local int i;

	gEndSlide = False;
	Debug("end slide실행 되었음");
	i = 1;
	if ( UnknownFunction150(i,29) )
	{
		Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",i);
		UnknownFunction163(i);
		goto JL002B;
	}
	Class'UIAPI_WINDOW'.KillUITimer("TeaserSlideWnd",CurrentTimer);
	m_TeaserSlideWnd_Main.HideWindow();
	Class'AudioAPI'.StopVoice();
	SetUIState("GamingState");
	Debug("게이밍스테이트이동");
	totalplaytime = UnknownFunction146(totalplaytime,0);
	totalplaytime = UnknownFunction145(totalplaytime,1000);
	Debug(UnknownFunction168(UnknownFunction168("최종 플레이타임:",string(totalplaytime)),"초"));
	SetSoundVolume(TempSoundVol);
	m_BattleShot.HideWindow();
	m_BattleShot1.HideWindow();
	m_BattleShot2.HideWindow();
	m_BattleShot3.HideWindow();
	m_Female.HideWindow();
	m_Female1.HideWindow();
	m_Island.HideWindow();
	m_Island1.HideWindow();
	m_Island2.HideWindow();
	m_Island3.HideWindow();
	m_Male.HideWindow();
	m_Male1.HideWindow();
	m_Mark.HideWindow();
	m_Meeting1.HideWindow();
	m_Meeting2.HideWindow();
	m_Meeting3.HideWindow();
	m_Meeting4.HideWindow();
	m_Frame.HideWindow();
	m_OutsideFrame.HideWindow();
	m_Subtitle1.HideWindow();
	m_Subtitle2.HideWindow();
	m_Subtitle3.HideWindow();
	m_Subtitle4.HideWindow();
	m_Subtitle5.HideWindow();
	m_Subtitle6.HideWindow();
	m_Subtitle7.HideWindow();
	m_Subtitle8.HideWindow();
	m_blankback.HideWindow();
	m_blankback1.HideWindow();
	m_WhiteOut.HideWindow();
	m_LogoWhite.HideWindow();
	m_blankback2.HideWindow();
	m_FrameWnd.HideWindow();
	m_PlaySceneStarted = False;
}

defaultproperties
{
    t_Subtitle1="Slideshow.Kamael_teaserquest.Frame_Text_0001"

    t_Subtitle2="Slideshow.Kamael_teaserquest.Frame_Text_0002"

    t_Subtitle3="Slideshow.Kamael_teaserquest.Frame_Text_0003"

    t_Subtitle4="Slideshow.Kamael_teaserquest.Frame_Text_0004"

    t_Subtitle5="Slideshow.Kamael_teaserquest.Frame_Text_0005"

    t_Subtitle6="Slideshow.Kamael_teaserquest.Frame_Text_0006"

    t_Subtitle7="Slideshow.Kamael_teaserquest.Frame_Text_0007"

    t_Subtitle8="Slideshow.Kamael_teaserquest.Frame_Text_0008"

    t_voice="TQ"

}
