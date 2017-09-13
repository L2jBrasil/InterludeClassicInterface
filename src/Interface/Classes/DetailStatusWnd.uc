//================================================================================
// DetailStatusWnd.
//================================================================================

class DetailStatusWnd extends UIScript;

var string L2jBRVar13;
var int L2jBRVar76;
var bool m_bReceivedUserInfo;
var bool m_bShow;
var HennaInfo m_HennaInfo;
const NSTATUS_BARHEIGHT= 12;
const NSTATUS_SMALLBARSIZE= 85;

function OnLoad ()
{
	RegisterEvent(180);
	RegisterEvent(260);
	RegisterEvent(190);
	RegisterEvent(200);
	RegisterEvent(210);
	RegisterEvent(220);
	RegisterEvent(230);
	RegisterEvent(240);
	m_bShow = False;
}

function OnEnterState (name a_PreStateName)
{
	m_bReceivedUserInfo = False;
	HandleUpdateUserInfo();
}

function OnShow ()
{
	HandleUpdateUserInfo();
	m_bShow = True;
	SetFocus();
}

function OnHide ()
{
	m_bShow = False;
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,180) )
	{
		HandleUpdateUserInfo();
	} else {
		if ( UnknownFunction154(Event_ID,260) )
		{
			HandleUpdateHennaInfo(L2jBRVar1);
		} else {
			if ( UnknownFunction154(Event_ID,200) )
			{
				HandleUpdateStatusPacket(L2jBRVar1);
			} else {
				if ( UnknownFunction154(Event_ID,210) )
				{
					HandleUpdateStatusPacket(L2jBRVar1);
				} else {
					if ( UnknownFunction154(Event_ID,220) )
					{
						HandleUpdateStatusPacket(L2jBRVar1);
					} else {
						if ( UnknownFunction154(Event_ID,230) )
						{
							HandleUpdateStatusPacket(L2jBRVar1);
						} else {
							if ( UnknownFunction154(Event_ID,240) )
							{
								HandleUpdateStatusPacket(L2jBRVar1);
							}
						}
					}
				}
			}
		}
	}
}

function OnClickButton (string strID)
{
	if ( UnknownFunction122(strID,"BtnClose") )
	{
		Class'UIAPI_WINDOW'.HideWindow("DetailStatusWnd");
	}
}

function HandleUpdateStatusPacket (string L2jBRVar1)
{
	local int ServerID;

	ParseInt(L2jBRVar1,"ServerID",ServerID);
	if ( UnknownFunction132(UnknownFunction154(L2jBRVar76,ServerID),UnknownFunction129(m_bReceivedUserInfo)) )
	{
		m_bReceivedUserInfo = True;
		HandleUpdateUserInfo();
	}
}

function HandleUpdateHennaInfo (string L2jBRVar1)
{
	ParseInt(L2jBRVar1,"HennaID",m_HennaInfo.HennaID);
	ParseInt(L2jBRVar1,"ClassID",m_HennaInfo.ClassID);
	ParseInt(L2jBRVar1,"Num",m_HennaInfo.Num);
	ParseInt(L2jBRVar1,"Fee",m_HennaInfo.Fee);
	ParseInt(L2jBRVar1,"CanUse",m_HennaInfo.CanUse);
	ParseInt(L2jBRVar1,"INTnow",m_HennaInfo.INTnow);
	ParseInt(L2jBRVar1,"INTchange",m_HennaInfo.INTchange);
	ParseInt(L2jBRVar1,"STRnow",m_HennaInfo.STRnow);
	ParseInt(L2jBRVar1,"STRchange",m_HennaInfo.STRchange);
	ParseInt(L2jBRVar1,"CONnow",m_HennaInfo.CONnow);
	ParseInt(L2jBRVar1,"CONchange",m_HennaInfo.CONchange);
	ParseInt(L2jBRVar1,"MENnow",m_HennaInfo.MENnow);
	ParseInt(L2jBRVar1,"MENchange",m_HennaInfo.MENchange);
	ParseInt(L2jBRVar1,"DEXnow",m_HennaInfo.DEXnow);
	ParseInt(L2jBRVar1,"DEXchange",m_HennaInfo.DEXchange);
	ParseInt(L2jBRVar1,"WITnow",m_HennaInfo.WITnow);
	ParseInt(L2jBRVar1,"WITchange",m_HennaInfo.WITchange);
}

function bool GetMyUserInfo (out UserInfo a_MyUserInfo)
{
	return GetPlayerInfo(a_MyUserInfo);
}

function string GetMovingSpeed (UserInfo a_UserInfo)
{
	local int MovingSpeed;
	local EMoveType MoveType;
	local EEnvType EnvType;

	MoveType = Class'UIDATA_PLAYER'.GetPlayerMoveType();
	EnvType = Class'UIDATA_PLAYER'.GetPlayerEnvironment();
	if ( UnknownFunction154(MoveType,2) )
	{
		MovingSpeed = int(UnknownFunction171(a_UserInfo.nGroundMaxSpeed,a_UserInfo.fNonAttackSpeedModifier));
		switch (EnvType)
		{
			case 2:
			MovingSpeed = int(UnknownFunction171(a_UserInfo.nWaterMaxSpeed,a_UserInfo.fNonAttackSpeedModifier));
			break;
			case 3:
			MovingSpeed = int(UnknownFunction171(a_UserInfo.nAirMaxSpeed,a_UserInfo.fNonAttackSpeedModifier));
			break;
			default:
		}
	} else {
		if ( UnknownFunction154(MoveType,1) )
		{
			MovingSpeed = int(UnknownFunction171(a_UserInfo.nGroundMinSpeed,a_UserInfo.fNonAttackSpeedModifier));
			switch (EnvType)
			{
				case 2:
				MovingSpeed = int(UnknownFunction171(a_UserInfo.nWaterMinSpeed,a_UserInfo.fNonAttackSpeedModifier));
				break;
				case 3:
				MovingSpeed = int(UnknownFunction171(a_UserInfo.nAirMinSpeed,a_UserInfo.fNonAttackSpeedModifier));
				break;
				default:
			}
		}
	}
	return string(MovingSpeed);
}

function float GetMyExpRate ()
{
	return UnknownFunction171(Class'UIDATA_PLAYER'.GetPlayerEXPRate(),100.0);
}

function HandleUpdateUserInfo ()
{
	local Rect rectWnd;
	local int Width1;
	local int Height1;
	local int Width2;
	local int Height2;
	local string Name;
	local string nickName;
	local Color NameColor;
	local Color NickNameColor;
	local int SubClassID;
	local string ClassName;
	local string UserRank;
	local int HP;
	local int maxHP;
	local int MP;
	local int maxMP;
	local int CP;
	local int maxCP;
	local int CarryWeight;
	local int CarringWeight;
	local int SP;
	local int Level;
	local float fExpRate;
	local float fTmp;
	local int PledgeID;
	local string PledgeName;
	local Texture PledgeCrestTexture;
	local bool bPledgeCrestTexture;
	local Color PledgeNameColor;
	local string HeroTexture;
	local bool bHero;
	local bool bNobless;
	local int nStr;
	local int nDex;
	local int nCon;
	local int nInt;
	local int nWit;
	local int nMen;
	local string strTmp;
	local int PhysicalAttack;
	local int PhysicalDefense;
	local int HitRate;
	local int CriticalRate;
	local int PhysicalAttackSpeed;
	local int MagicalAttack;
	local int MagicDefense;
	local int PhysicalAvoid;
	local string MovingSpeed;
	local int MagicCastingSpeed;
	local int CriminalRate;
	local int CrimRate;
	local string strCriminalRate;
	local int DualCount;
	local int PKCount;
	local int Sociality;
	local int RemainSulffrage;
	local UserInfo Info;

	Class'UIAPI_TEXTURECTRL'.SetTexture(UnknownFunction112(L2jBRVar13,".texPledgeCrest"),"");
	rectWnd = Class'UIAPI_WINDOW'.GetRect(L2jBRVar13);
	if ( GetMyUserInfo(Info) )
	{
		L2jBRVar76 = Info.nID;
		Name = Info.Name;
		nickName = Info.strNickName;
		SubClassID = Info.nSubClass;
		ClassName = GetClassType(SubClassID);
		SP = Info.nSP;
		Level = Info.nLevel;
		UserRank = GetUserRankString(Info.nUserRank);
		HP = Info.nCurHP;
		maxHP = Info.nMaxHP;
		MP = Info.nCurMP;
		maxMP = Info.nMaxMP;
		CarryWeight = Info.nCarryWeight;
		CarringWeight = Info.nCarringWeight;
		CP = Info.nCurCP;
		maxCP = Info.nMaxCP;
		fExpRate = GetMyExpRate();
		PledgeID = Info.nClanID;
		bHero = Info.bHero;
		bNobless = Info.bNobless;
		nStr = Info.nStr;
		nDex = Info.nDex;
		nCon = Info.nCon;
		nInt = Info.nInt;
		nWit = Info.nWit;
		nMen = Info.nMen;
		PhysicalAttack = Info.nPhysicalAttack;
		PhysicalDefense = Info.nPhysicalDefense;
		HitRate = Info.nHitRate;
		CriticalRate = Info.nCriticalRate;
		PhysicalAttackSpeed = Info.nPhysicalAttackSpeed;
		MagicalAttack = Info.nMagicalAttack;
		MagicDefense = Info.nMagicDefense;
		PhysicalAvoid = Info.nPhysicalAvoid;
		MagicCastingSpeed = Info.nMagicCastingSpeed;
		MovingSpeed = GetMovingSpeed(Info);
		CriminalRate = Info.nCriminalRate;
		DualCount = Info.nDualCount;
		PKCount = Info.nPKCount;
		Sociality = Info.nSociality;
		RemainSulffrage = Info.nRemainSulffrage;
		if ( UnknownFunction153(CriminalRate,999999) )
		{
			strCriminalRate = UnknownFunction112(string(CriminalRate),"+");
		} else {
			strCriminalRate = UnknownFunction112(string(CriminalRate),"");
		}
	}
	CrimRate = CriminalRate;
	if ( UnknownFunction151(CrimRate,255) )
	{
		CrimRate = 255;
	}
	if ( UnknownFunction151(CrimRate,0) )
	{
		CrimRate = UnknownFunction251(CrimRate,UnknownFunction146(100,UnknownFunction145(CrimRate,16)),255);
	}
	NameColor.R = 255;
	NameColor.G = UnknownFunction147(255,CrimRate);
	NameColor.B = UnknownFunction147(255,CrimRate);
	NameColor.A = 255;
	NickNameColor.R = 162;
	NickNameColor.G = 249;
	NickNameColor.B = 236;
	NickNameColor.A = 255;
	if ( UnknownFunction151(UnknownFunction125(nickName),0) )
	{
		GetTextSize(Name,Width1,Height1);
		GetTextSize(nickName,Width2,Height2);
		if ( UnknownFunction151(UnknownFunction146(Width1,Width2),220) )
		{
			if ( UnknownFunction151(Width1,109) )
			{
				Name = UnknownFunction128(Name,8);
				GetTextSize(Name,Width1,Height1);
			}
			if ( UnknownFunction151(Width2,109) )
			{
				nickName = UnknownFunction128(nickName,8);
				GetTextSize(nickName,Width2,Height2);
			}
		}
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtName1"),nickName);
		Class'UIAPI_TEXTBOX'.SetTextColor(UnknownFunction112(L2jBRVar13,".txtName1"),NickNameColor);
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtName2"),Name);
		Class'UIAPI_TEXTBOX'.SetTextColor(UnknownFunction112(L2jBRVar13,".txtName2"),NameColor);
		Class'UIAPI_WINDOW'.MoveTo(UnknownFunction112(L2jBRVar13,".txtName2"),UnknownFunction146(UnknownFunction146(UnknownFunction146(rectWnd.nX,15),Width2),6),UnknownFunction146(rectWnd.nY,9));
	} else {
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtName1"),Name);
		Class'UIAPI_TEXTBOX'.SetTextColor(UnknownFunction112(L2jBRVar13,".txtName1"),NameColor);
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtName2"),"");
	}
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtClass"),UnknownFunction112("",ClassName));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtLvl"),UnknownFunction112("",string(Level)));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtRank"),UserRank);
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtHP"),UnknownFunction112(UnknownFunction112(string(HP),"/"),string(maxHP)));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtMP"),UnknownFunction112(UnknownFunction112(string(MP),"/"),string(maxMP)));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtExp"),UnknownFunction112(string(fExpRate),"%"));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtCP"),UnknownFunction112(UnknownFunction112(string(CP),"/"),string(maxCP)));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtSP"),string(SP));
	fTmp = UnknownFunction172(UnknownFunction171(100.0,CarringWeight),CarryWeight);
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtWeight"),UnknownFunction112(string(fTmp),"%"));
	if ( UnknownFunction151(PledgeID,0) )
	{
		bPledgeCrestTexture = Class'UIDATA_CLAN'.GetCrestTexture(PledgeID,PledgeCrestTexture);
		PledgeName = Class'UIDATA_CLAN'.GetName(PledgeID);
		PledgeNameColor.R = 176;
		PledgeNameColor.G = 155;
		PledgeNameColor.B = 121;
		PledgeNameColor.A = 255;
	} else {
		PledgeName = GetSystemString(431);
		PledgeNameColor.R = 255;
		PledgeNameColor.G = 255;
		PledgeNameColor.B = 255;
		PledgeNameColor.A = 255;
	}
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtPledge"),PledgeName);
	Class'UIAPI_TEXTBOX'.SetTextColor(UnknownFunction112(L2jBRVar13,".txtPledge"),PledgeNameColor);
	if ( bPledgeCrestTexture )
	{
		Class'UIAPI_TEXTURECTRL'.SetTextureWithObject(UnknownFunction112(L2jBRVar13,".texPledgeCrest"),PledgeCrestTexture);
		Class'UIAPI_WINDOW'.MoveTo(UnknownFunction112(L2jBRVar13,".txtPledge"),UnknownFunction146(rectWnd.nX,88),UnknownFunction146(rectWnd.nY,25));
	} else {
		Class'UIAPI_WINDOW'.MoveTo(UnknownFunction112(L2jBRVar13,".txtPledge"),UnknownFunction146(rectWnd.nX,68),UnknownFunction146(rectWnd.nY,25));
	}
	if ( bHero )
	{
		HeroTexture = "L2UI_CH3.PlayerStatusWnd.myinfo_heroicon";
	} else {
		if ( bNobless )
		{
			HeroTexture = "L2UI_CH3.PlayerStatusWnd.myinfo_nobleicon";
		}
	}
	Class'UIAPI_TEXTURECTRL'.SetTexture(UnknownFunction112(L2jBRVar13,".texHero"),HeroTexture);
	if ( UnknownFunction151(m_HennaInfo.STRchange,0) )
	{
		strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(string(nStr),"(+"),string(m_HennaInfo.STRchange)),")");
	} else {
		if ( UnknownFunction150(m_HennaInfo.STRchange,0) )
		{
			strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(string(nStr),"("),string(m_HennaInfo.STRchange)),")");
		} else {
			strTmp = string(nStr);
		}
	}
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtSTR"),strTmp);
	if ( UnknownFunction151(m_HennaInfo.DEXchange,0) )
	{
		strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(string(nDex),"(+"),string(m_HennaInfo.DEXchange)),")");
	} else {
		if ( UnknownFunction150(m_HennaInfo.DEXchange,0) )
		{
			strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(string(nDex),"("),string(m_HennaInfo.DEXchange)),")");
		} else {
			strTmp = string(nDex);
		}
	}
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtDEX"),strTmp);
	if ( UnknownFunction151(m_HennaInfo.CONchange,0) )
	{
		strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(string(nCon),"(+"),string(m_HennaInfo.CONchange)),")");
	} else {
		if ( UnknownFunction150(m_HennaInfo.CONchange,0) )
		{
			strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(string(nCon),"("),string(m_HennaInfo.CONchange)),")");
		} else {
			strTmp = string(nCon);
		}
	}
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtCON"),strTmp);
	if ( UnknownFunction151(m_HennaInfo.INTchange,0) )
	{
		strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(string(nInt),"(+"),string(m_HennaInfo.INTchange)),")");
	} else {
		if ( UnknownFunction150(m_HennaInfo.INTchange,0) )
		{
			strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(string(nInt),"("),string(m_HennaInfo.INTchange)),")");
		} else {
			strTmp = string(nInt);
		}
	}
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtINT"),strTmp);
	if ( UnknownFunction151(m_HennaInfo.WITchange,0) )
	{
		strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(string(nWit),"(+"),string(m_HennaInfo.WITchange)),")");
	} else {
		if ( UnknownFunction150(m_HennaInfo.WITchange,0) )
		{
			strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(string(nWit),"("),string(m_HennaInfo.WITchange)),")");
		} else {
			strTmp = string(nWit);
		}
	}
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtWIT"),strTmp);
	if ( UnknownFunction151(m_HennaInfo.MENchange,0) )
	{
		strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(string(nMen),"(+"),string(m_HennaInfo.MENchange)),")");
	} else {
		if ( UnknownFunction150(m_HennaInfo.MENchange,0) )
		{
			strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(string(nMen),"("),string(m_HennaInfo.MENchange)),")");
		} else {
			strTmp = string(nMen);
		}
	}
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtMEN"),strTmp);
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtPhysicalAttack"),string(PhysicalAttack));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtPhysicalDefense"),string(PhysicalDefense));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtHitRate"),string(HitRate));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtCriticalRate"),string(CriticalRate));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtPhysicalAttackSpeed"),string(PhysicalAttackSpeed));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtMagicalAttack"),string(MagicalAttack));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtMagicDefense"),string(MagicDefense));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtPhysicalAvoid"),string(PhysicalAvoid));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtMovingSpeed"),MovingSpeed);
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtMagicCastingSpeed"),string(MagicCastingSpeed));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtCriminalRate"),strCriminalRate);
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtPVP"),UnknownFunction112(UnknownFunction112(string(DualCount)," / "),string(PKCount)));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtSociality"),string(Sociality));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtRemainSulffrage"),string(RemainSulffrage));
	UpdateHPBar(HP,maxHP);
	UpdateMPBar(MP,maxMP);
	UpdateCPBar(CP,maxCP);
	UpdateEXPBar(int(fExpRate),100);
	UpdateWeightBar(CarringWeight,CarryWeight);
}

function UpdateHPBar (int Value, int MaxValue)
{
	local int Size;

	Size = 0;
	if ( UnknownFunction151(MaxValue,0) )
	{
		Size = 85;
		if ( UnknownFunction150(Value,MaxValue) )
		{
			Size = UnknownFunction145(UnknownFunction144(85,Value),MaxValue);
		}
	}
	Class'UIAPI_WINDOW'.SetWindowSize(UnknownFunction112(L2jBRVar13,".texHP"),Size,12);
}

function UpdateMPBar (int Value, int MaxValue)
{
	local int Size;

	Size = 0;
	if ( UnknownFunction151(MaxValue,0) )
	{
		Size = 85;
		if ( UnknownFunction150(Value,MaxValue) )
		{
			Size = UnknownFunction145(UnknownFunction144(85,Value),MaxValue);
		}
	}
	Class'UIAPI_WINDOW'.SetWindowSize(UnknownFunction112(L2jBRVar13,".texMP"),Size,12);
}

function UpdateEXPBar (int Value, int MaxValue)
{
	local int Size;

	Size = 0;
	if ( UnknownFunction151(MaxValue,0) )
	{
		Size = 85;
		if ( UnknownFunction150(Value,MaxValue) )
		{
			Size = UnknownFunction145(UnknownFunction144(85,Value),MaxValue);
		}
	}
	Class'UIAPI_WINDOW'.SetWindowSize(UnknownFunction112(L2jBRVar13,".texEXP"),Size,12);
}

function UpdateCPBar (int Value, int MaxValue)
{
	local int Size;

	Size = 0;
	if ( UnknownFunction151(MaxValue,0) )
	{
		Size = 85;
		if ( UnknownFunction150(Value,MaxValue) )
		{
			Size = UnknownFunction145(UnknownFunction144(85,Value),MaxValue);
		}
	}
	Class'UIAPI_WINDOW'.SetWindowSize(UnknownFunction112(L2jBRVar13,".texCP"),Size,12);
}

function UpdateWeightBar (int Value, int MaxValue)
{
	local int Size;
	local float fTmp;
	local string strName;

	Size = 0;
	if ( UnknownFunction151(MaxValue,0) )
	{
		fTmp = UnknownFunction172(UnknownFunction171(100.0,Value),MaxValue);
		if ( UnknownFunction178(fTmp,50.0) )
		{
			strName = "L2UI_CH3.PlayerStatusWnd.ps_weightbar1";
		} else {
			if ( UnknownFunction130(UnknownFunction177(fTmp,50.0),UnknownFunction178(fTmp,66.66366)) )
			{
				strName = "L2UI_CH3.PlayerStatusWnd.ps_weightbar2";
			} else {
				if ( UnknownFunction130(UnknownFunction177(fTmp,66.66366),UnknownFunction178(fTmp,80.0)) )
				{
					strName = "L2UI_CH3.PlayerStatusWnd.ps_weightbar3";
				} else {
					if ( UnknownFunction177(fTmp,80.0) )
					{
						strName = "L2UI_CH3.PlayerStatusWnd.ps_weightbar4";
					}
				}
			}
		}
		Size = 85;
		if ( UnknownFunction150(Value,MaxValue) )
		{
			Size = UnknownFunction145(UnknownFunction144(85,Value),MaxValue);
		}
	}
	Class'UIAPI_TEXTURECTRL'.SetTexture(UnknownFunction112(L2jBRVar13,".texWeight"),strName);
	Class'UIAPI_WINDOW'.SetWindowSize(UnknownFunction112(L2jBRVar13,".texWeight"),Size,12);
}

function SetFocus ()
{
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtName1");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtName2");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadPledge");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.texPledgeCrest");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtPledge");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.texHero");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtLvHead");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtLvName");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadRank");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtRank");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.texHP");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.texMP");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.texExp");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.texCP");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.texWeight");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHP");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtMP");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtExp");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtCP");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtWeight");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtSP");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadFight");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadPhysicalAttack");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadPhysicalDefense");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadHitRate");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadCriticalRate");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadPhysicalAttackSpeed");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadMagicalAttack");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadMagicDefense");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadPhysicalAvoid");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadMovingSpeed");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadMagicCastingSpeed");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadBasic");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadSTR");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadDEX");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadCON");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadINT");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadWIT");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadMEN");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadSocial");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadCriminalRate");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadPVP");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadSociality");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHeadRemainSulffrage");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtPhysicalAttack");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtPhysicalDefense");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtHitRate");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtCriticalRate");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtPhysicalAttackSpeed");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtMagicalAttack");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtMagicDefense");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtPhysicalAvoid");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtGmMoving");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtMovingSpeed");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtMagicCastingSpeed");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtSTR");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtDEX");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtCON");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtINT");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtWIT");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtMEN");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtCriminalRate");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtPVP");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtSociality");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtRemainSulffrage");
	Class'UIAPI_WINDOW'.SetFocus("DetailStatusWnd.txtClass");
}

defaultproperties
{
    L2jBRVar13="DetailStatusWnd"

}
