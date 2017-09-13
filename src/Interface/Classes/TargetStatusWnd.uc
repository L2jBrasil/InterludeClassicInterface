//================================================================================
// TargetStatusWnd.
//================================================================================

class TargetStatusWnd extends UICommonAPI;

var bool m_bExpand;
var WindowHandle L2jBRVar103;
var EditBoxHandle ChatEditBox;
var int L2jBRVar208;
var int L2jBRVar90;
var int L2jBRVar76;
var int L2jBRVar209;
var int L2jBRVar91;
var string dlgText;
var bool m_bShow;
var PartyWnd L2jBRVar21;

function OnLoad ()
{
	RegisterEvent(980);
	RegisterEvent(990);
	RegisterEvent(190);
	RegisterEvent(210);
	RegisterEvent(200);
	RegisterEvent(220);
	RegisterEvent(300);
	RegisterEvent(290);
	RegisterEvent(50);
	RegisterEvent(110);
	RegisterEvent(2960);
	SetExpandMode(False);
	L2jBRVar103 = GetHandle("TargetStatusWnd");
	L2jBRVar21 = PartyWnd(GetScript("PartyWnd"));
	ChatEditBox = EditBoxHandle(GetHandle("ChatWnd.ChatEditBox"));
	m_bShow = False;
	L2jBRVar90 = -1;
	Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.NPHRN_Bumper");
}

function OnEnterState (name a_PreStateName)
{
	SetExpandMode(m_bExpand);
	L2jBRVar103.SetTimer(1,500);
}

function OnTimer (int TimerID)
{
	local StatusWnd L2jBRVar21;

	L2jBRVar21 = StatusWnd(GetScript("StatusWnd"));
	if ( UnknownFunction154(TimerID,1) )
	{
		L2jBRVar103.KillTimer(1);
		L2jBRVar76 = L2jBRVar21.L2jBRVar76;
	}
}

function OnShow ()
{
	m_bShow = True;
}

function OnHide ()
{
	m_bShow = False;
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,980) )
	{
		HandleTargetUpdate();
		if ( UnknownFunction129(L2jBRVar103.IsShowWindow()) )
		{
			ExecuteEvent(2960);
		}
	} else {
		if ( UnknownFunction154(Event_ID,990) )
		{
			Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd");
		} else {
			if ( UnknownFunction154(Event_ID,300) )
			{
				HandleReceiveTargetLevelDiff(L2jBRVar1);
			} else {
				if ( UnknownFunction154(Event_ID,190) )
				{
					HandleUpdateHPMP(L2jBRVar1);
				} else {
					if ( UnknownFunction154(Event_ID,210) )
					{
						HandleUpdateHPMP(L2jBRVar1);
					} else {
						if ( UnknownFunction154(Event_ID,200) )
						{
							HandleUpdateHPMP(L2jBRVar1);
						} else {
							if ( UnknownFunction154(Event_ID,220) )
							{
								HandleUpdateHPMP(L2jBRVar1);
							} else {
								if ( UnknownFunction154(Event_ID,290) )
								{
									if ( UnknownFunction242(GetOptionBool("Neophron","IgnoreAggr"),True) )
									{
										L2jBRFunction69(L2jBRVar1);
									}
								} else {
									if ( UnknownFunction132(UnknownFunction154(Event_ID,50),UnknownFunction154(Event_ID,110)) )
									{
										L2jBRVar209 = -1;
									} else {
										if (! UnknownFunction154(Event_ID,2960) ) goto JL0164;
									}
								}
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
	local UserInfo Info;

	GetTargetInfo(Info);
	switch (strID)
	{
		case "BtnExpand":
		SetExpandMode(m_bExpand);
		case "BtnClose":
		OnCloseButton();
		break;
		case "BtnExchange":
		RequestStartTrade(Info.nID);
		break;
		case "BtnInvite":
		RequestInviteParty(Info.Name);
		break;
		default:
	}
}

function OnCloseButton ()
{
	RequestTargetCancel();
	PlayConsoleSound(6);
}

function HandleUpdateHPMP (string L2jBRVar1)
{
	local int ServerID;

	if ( m_bShow )
	{
		ParseInt(L2jBRVar1,"ServerID",ServerID);
		if ( UnknownFunction154(L2jBRVar90,ServerID) )
		{
			HandleTargetUpdate();
		}
	}
}

function HandleReceiveTargetLevelDiff (string L2jBRVar1)
{
	ParseInt(L2jBRVar1,"LevelDiff",L2jBRVar208);
}

function HandleTargetUpdate ()
{
	local Rect rectWnd;
	local string strTmp;
	local int L2jBRVar210;
	local int PlayerID;
	local int PetID;
	local int clanType;
	local int ClanNameValue;
	local bool bIsServerObject;
	local bool bIsHPShowableNPC;
	local string Name;
	local string RankName;
	local Color TargetNameColor;
	local int ServerObjectNameID;
	local EServerObjectType ServerObjectType;
	local bool bShowHPBar;
	local bool bShowMPBar;
	local bool bShowPledgeInfo;
	local bool bShowPledgeTex;
	local bool bShowPledgeAllianceTex;
	local string PledgeName;
	local string PledgeAllianceName;
	local Texture PledgeCrestTexture;
	local Texture PledgeAllianceCrestTexture;
	local Color PledgeNameColor;
	local Color PledgeAllianceNameColor;
	local bool bShowNpcInfo;
	local array<int> arrNpcInfo;
	local bool IsTargetChanged;
	local UserInfo Info;
	local Color WhiteColor;

	WhiteColor.R = 0;
	WhiteColor.G = 0;
	WhiteColor.B = 0;
	L2jBRVar210 = Class'UIDATA_TARGET'.GetTargetID();
	if ( UnknownFunction242(GetOptionBool("Neophron","IgnoreAggr"),True) )
	{
		if ( UnknownFunction154(L2jBRVar210,L2jBRVar91) )
		{
			RequestTargetCancel();
			L2jBRVar91 = -1;
			L2jBRVar210 = -1;
		}
	}
	if ( UnknownFunction154(L2jBRVar210,L2jBRVar76) )
	{
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.NPHRN_Bumper");
	}
	if ( UnknownFunction150(L2jBRVar210,1) )
	{
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd");
		return;
	}
	if ( UnknownFunction155(L2jBRVar90,L2jBRVar210) )
	{
		IsTargetChanged = True;
		L2jBRVar209 = L2jBRVar210;
	}
	L2jBRVar90 = L2jBRVar210;
	GetTargetInfo(Info);
	rectWnd = Class'UIAPI_WINDOW'.GetRect("TargetStatusWnd");
	PledgeName = GetSystemString(431);
	PledgeAllianceName = GetSystemString(591);
	PledgeNameColor.R = 128;
	PledgeNameColor.G = 128;
	PledgeNameColor.B = 128;
	PledgeAllianceNameColor.R = 128;
	PledgeAllianceNameColor.G = 128;
	PledgeAllianceNameColor.B = 128;
	TargetNameColor = Class'UIDATA_TARGET'.GetTargetNameColor(L2jBRVar208);
	bIsServerObject = Class'UIDATA_TARGET'.IsServerObject();
	if ( bIsServerObject )
	{
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.NPHRN_Bumper");
		ServerObjectNameID = Class'UIDATA_STATICOBJECT'.GetServerObjectNameID(L2jBRVar90);
		if ( UnknownFunction151(ServerObjectNameID,0) )
		{
			Name = Class'UIDATA_STATICOBJECT'.GetStaticObjectName(ServerObjectNameID);
			RankName = "";
		}
		Class'UIAPI_NAMECTRL'.SetName("TargetStatusWnd.UserName",Name,0,2);
		Class'UIAPI_NAMECTRL'.SetName("TargetStatusWnd.RankName",RankName,0,2);
		ServerObjectType = Class'UIDATA_STATICOBJECT'.GetServerObjectType(L2jBRVar90);
		if ( UnknownFunction154(ServerObjectType,2) )
		{
			if ( Class'UIDATA_STATICOBJECT'.GetStaticObjectShowHP(L2jBRVar90) )
			{
				bShowHPBar = True;
				UpdateHPBar(Class'UIDATA_STATICOBJECT'.GetServerObjectHP(L2jBRVar90),Class'UIDATA_STATICOBJECT'.GetServerObjectMaxHP(L2jBRVar90));
			}
		}
	} else {
		if ( UnknownFunction150(UnknownFunction125(Info.Name),1) )
		{
			Name = Class'UIDATA_PARTY'.GetMemberName(L2jBRVar90			);
			RankName = "";
			Debug(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("m_TargetID",string(L2jBRVar90			)),", info.Name : "),Info.Name),", Name : "),Name));
			Class'UIAPI_NAMECTRL'.SetName("TargetStatusWnd.UserName",Name,0,2);
			Class'UIAPI_NAMECTRL'.SetName("TargetStatusWnd.RankName",RankName,0,2);
		} else {
			PlayerID = Class'UIDATA_PLAYER'.GetPlayerID();
			PetID = Class'UIDATA_PET'.GetPetID();
			bIsHPShowableNPC = Class'UIDATA_TARGET'.IsHPShowableNPC();
			if ( bIsHPShowableNPC )
			{
				Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.NPHRN_Bumper");
			}
			if ( UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction130(UnknownFunction130(Info.bNpc,UnknownFunction129(Info.bPet)),Info.bCanBeAttacked),UnknownFunction130(UnknownFunction151(PlayerID,0),UnknownFunction154(L2jBRVar90			,PlayerID))),UnknownFunction130(UnknownFunction130(Info.bNpc,Info.bPet),UnknownFunction154(L2jBRVar90			,PetID))),UnknownFunction130(Info.bNpc,bIsHPShowableNPC)) )
			{
				if ( IsAllWhiteID(Info.nClassID) )
				{
					Name = Info.Name;
					RankName = "";
					Class'UIAPI_NAMECTRL'.SetName("TargetStatusWnd.UserName",Name,0,2);
					Class'UIAPI_NAMECTRL'.SetName("TargetStatusWnd.RankName",RankName,0,2);
					if ( UnknownFunction129(IsNoBarID(Info.nClassID)) )
					{
						bShowHPBar = True;
						UpdateHPBar(Info.nCurHP,Info.nMaxHP);
					}
				} else {
					Name = Info.Name;
					RankName = "";
					Class'UIAPI_NAMECTRL'.SetNameWithColor("TargetStatusWnd.UserName",Name,0,2,TargetNameColor);
					Class'UIAPI_NAMECTRL'.SetName("TargetStatusWnd.RankName",RankName,0,2);
					bShowHPBar = True;
					UpdateHPBar(Info.nCurHP,Info.nMaxHP);
					if ( UnknownFunction129(UnknownFunction130(UnknownFunction130(Info.bNpc,UnknownFunction129(Info.bPet)),Info.bCanBeAttacked)) )
					{
						bShowMPBar = True;
						UpdateMPBar(Info.nCurMP,Info.nMaxMP);
					}
				}
			} else {
				Name = Info.Name;
				if ( Info.bNpc )
				{
					RankName = "";
					Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.NPHRN_Bumper");
				} else {
					RankName = GetUserRankString(Info.nUserRank);
					Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd.NPHRN_Bumper");
				}
				Class'UIAPI_NAMECTRL'.SetName("TargetStatusWnd.UserName",Name,0,2);
				Class'UIAPI_NAMECTRL'.SetName("TargetStatusWnd.RankName",RankName,0,2);
			}
			if ( m_bExpand )
			{
				if ( Info.bNpc )
				{
					if ( Class'UIDATA_NPC'.GetNpcProperty(Info.nClassID,arrNpcInfo) )
					{
						bShowNpcInfo = True;
						if ( IsTargetChanged )
						{
							UpdateNpcInfoTree(arrNpcInfo);
						}
					}
				} else {
					bShowPledgeInfo = True;
					if ( UnknownFunction151(Info.nClanID,0) )
					{
						PledgeName = Class'UIDATA_CLAN'.GetName(Info.nClanID);
						PledgeNameColor.R = 176;
						PledgeNameColor.G = 152;
						PledgeNameColor.B = 121;
						if ( UnknownFunction130(UnknownFunction130(UnknownFunction123(PledgeName,""),Class'UIDATA_USER'.GetClanType(L2jBRVar90		,clanType)),Class'UIDATA_CLAN'.GetNameValue(Info.nClanID,ClanNameValue)) )
						{
							if ( UnknownFunction154(clanType,-1) )
							{
								PledgeNameColor.R = 209;
								PledgeNameColor.G = 167;
								PledgeNameColor.B = 2;
							} else {
								if ( UnknownFunction151(ClanNameValue,0) )
								{
									PledgeNameColor.R = 0;
									PledgeNameColor.G = 130;
									PledgeNameColor.B = 255;
								} else {
									if ( UnknownFunction150(ClanNameValue,0) )
									{
										PledgeNameColor.R = 255;
										PledgeNameColor.G = 0;
										PledgeNameColor.B = 0;
									}
								}
							}
						}
						if ( Class'UIDATA_CLAN'.GetCrestTexture(Info.nClanID,PledgeCrestTexture) )
						{
							bShowPledgeTex = True;
							Class'UIAPI_TEXTURECTRL'.SetTextureWithObject("TargetStatusWnd.texPledgeCrest",PledgeCrestTexture);
						} else {
							bShowPledgeTex = False;
						}
						strTmp = Class'UIDATA_CLAN'.GetAllianceName(Info.nClanID);
						if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
						{
							PledgeAllianceName = strTmp;
							PledgeAllianceNameColor.R = 176;
							PledgeAllianceNameColor.G = 155;
							PledgeAllianceNameColor.B = 121;
							if ( Class'UIDATA_CLAN'.GetAllianceCrestTexture(Info.nClanID,PledgeAllianceCrestTexture) )
							{
								bShowPledgeAllianceTex = True;
								Class'UIAPI_TEXTURECTRL'.SetTextureWithObject("TargetStatusWnd.texPledgeAllianceCrest",PledgeAllianceCrestTexture);
							} else {
								bShowPledgeAllianceTex = False;
							}
						}
					}
				}
			}
		}
	}
	if ( UnknownFunction129(Class'UIAPI_WINDOW'.IsShowWindow("TargetStatusWnd")) )
	{
		Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd");
		SetExpandMode(m_bExpand);
	}
	if ( bShowHPBar )
	{
		Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd.barHP");
	} else {
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.barHP");
	}
	if ( bShowMPBar )
	{
		Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd.barMP");
	} else {
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.barMP");
	}
	if ( bShowPledgeInfo )
	{
		Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd.txtPledge");
		Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd.txtAlliance");
		Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd.txtPledgeName");
		Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd.txtPledgeAllianceName");
		Class'UIAPI_TEXTBOX'.SetText("TargetStatusWnd.txtPledgeName",PledgeName);
		Class'UIAPI_TEXTBOX'.SetText("TargetStatusWnd.txtPledgeAllianceName",PledgeAllianceName);
		Class'UIAPI_TEXTBOX'.SetTextColor("TargetStatusWnd.txtPledgeName",PledgeNameColor);
		Class'UIAPI_TEXTBOX'.SetTextColor("TargetStatusWnd.txtPledgeAllianceName",PledgeAllianceNameColor);
		if ( bShowPledgeTex )
		{
			Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd.texPledgeCrest");
			Class'UIAPI_WINDOW'.MoveTo("TargetStatusWnd.txtPledgeName",UnknownFunction146(rectWnd.nX,63),UnknownFunction146(rectWnd.nY,43));
		} else {
			Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.texPledgeCrest");
			Class'UIAPI_WINDOW'.MoveTo("TargetStatusWnd.txtPledgeName",UnknownFunction146(rectWnd.nX,45),UnknownFunction146(rectWnd.nY,43));
		}
		if ( bShowPledgeAllianceTex )
		{
			Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd.texPledgeAllianceCrest");
			Class'UIAPI_WINDOW'.MoveTo("TargetStatusWnd.txtPledgeAllianceName",UnknownFunction146(rectWnd.nX,63),UnknownFunction146(rectWnd.nY,59));
		} else {
			Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.texPledgeAllianceCrest");
			Class'UIAPI_WINDOW'.MoveTo("TargetStatusWnd.txtPledgeAllianceName",UnknownFunction146(rectWnd.nX,45),UnknownFunction146(rectWnd.nY,59));
		}
	} else {
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.txtPledge");
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.texPledgeCrest");
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.txtPledgeName");
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.txtAlliance");
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.texPledgeAllianceCrest");
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.txtPledgeAllianceName");
	}
	if ( bShowNpcInfo )
	{
		Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd.NpcInfo");
		Class'UIAPI_TREECTRL'.ShowScrollBar("TargetStatusWnd.NpcInfo",False);
	} else {
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.NpcInfo");
	}
}

function L2jBRFunction105 ()
{
	if ( UnknownFunction242(GetOptionBool("Neophron","HoldTarget"),True) )
	{
		if ( UnknownFunction155(L2jBRVar209,L2jBRVar91) )
		{
			RequestTargetUser(	L2jBRVar209 );
		}
	}
}

function L2jBRFunction69 (string _L2jBRVar17_)
{
	local int L2jBRVar24;
	local int L2jBRVar210;

	ParseInt(_L2jBRVar17_,"SkillID",L2jBRVar24);
	if ( L2jBRFunction107(L2jBRVar24) )
	{
		ParseInt(_L2jBRVar17_,"AttackerID",L2jBRVar210);
		if ( UnknownFunction129( L2jBRFunction106(L2jBRVar210)) )
		{
			L2jBRVar91 = L2jBRVar210;
		}
	}
}

function bool L2jBRFunction106 (int L2jBRVar90)
{
	local int i;
	local bool flag;

	i = 0;
	if ( UnknownFunction150(i,8) )
	{
		if ( UnknownFunction154(L2jBRVar90		,L2jBRVar21.L2jBRVar41[i]) )
		{
			flag = True;
		}
		UnknownFunction165(i);
		goto JL0007;
	}
	return flag;
}

function bool L2jBRFunction107 (int L2jBRVar24)
{
	local bool ff;

	switch (L2jBRVar24)
	{
		case 18:
		case 28:
		case 286:
		ff = True;
		break;
		default:
	}
	return ff;
}

function OnFrameExpandClick (bool bIsExpand)
{
	SetExpandMode(bIsExpand);
}

function SetExpandMode (bool bExpand)
{
	local ButtonHandle L2jBRVar38;

	L2jBRVar38 = ButtonHandle(GetHandle("TargetStatusWnd.BtnExpand"));
	m_bExpand = bExpand;
	L2jBRVar90	 = -1;
	HandleTargetUpdate();
	if ( bExpand )
	{
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.BackTex");
		Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd.BackExpTex");
		L2jBRVar38.SetTexture("Interface.Shortcut_Expand","Interface.Shortcut_Expand_Down","Interface.Shortcut_Expand_Over");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("TargetStatusWnd.BackTex");
		Class'UIAPI_WINDOW'.HideWindow("TargetStatusWnd.BackExpTex");
		L2jBRVar38.SetTexture("Interface.Shortcut_Minimize","Interface.Shortcut_Minimize_Down","Interface.Shortcut_Minimize_Over");
	}
}

function UpdateHPBar (int HP, int maxHP)
{
	Class'UIAPI_BARCTRL'.SetValue("TargetStatusWnd.barHP",maxHP,HP);
}

function UpdateMPBar (int MP, int maxMP)
{
	Class'UIAPI_BARCTRL'.SetValue("TargetStatusWnd.barMP",maxMP,MP);
}

function UpdateNpcInfoTree (array<int> arrNpcInfo)
{
	local int i;
	local int SkillID;
	local int SkillLevel;
	local string strNodeName;
	local XMLTreeNodeInfo infNode;
	local XMLTreeNodeItemInfo infNodeItem;
	local XMLTreeNodeInfo infNodeClear;
	local XMLTreeNodeItemInfo infNodeItemClear;

	Class'UIAPI_TREECTRL'.Clear("TargetStatusWnd.NpcInfo");
	infNode.strName = "root";
	strNodeName = Class'UIAPI_TREECTRL'.InsertNode("TargetStatusWnd.NpcInfo","",infNode);
	if ( UnknownFunction150(UnknownFunction125(strNodeName),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert root node. Name: ",infNode.strName));
		return;
	}
	i = 0;
	if ( UnknownFunction150(i,arrNpcInfo.Length) )
	{
		SkillID = arrNpcInfo[i];
		SkillLevel = arrNpcInfo[UnknownFunction146(i,1)];
		infNode = infNodeClear;
		infNode.nOffSetX = UnknownFunction144(int(UnknownFunction173(UnknownFunction145(i,2),8)),18);
		if ( UnknownFunction180(UnknownFunction173(UnknownFunction145(i,2),8),0) )
		{
			if ( UnknownFunction151(i,0) )
			{
				infNode.nOffSetY = 3;
			} else {
				infNode.nOffSetY = 0;
			}
		} else {
			infNode.nOffSetY = -15;
		}
		infNode.strName = UnknownFunction112("",string(UnknownFunction145(i,2)));
		infNode.bShowButton = 0;
		infNode.ToolTip = SetNpcInfoTooltip(SkillID,SkillLevel);
		strNodeName = Class'UIAPI_TREECTRL'.InsertNode("TargetStatusWnd.NpcInfo","root",infNode);
		if ( UnknownFunction150(UnknownFunction125(strNodeName),1) )
		{
			UnknownFunction231(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
			return;
		}
		infNode.ToolTip.DrawList.Remove (0,infNode.ToolTip.DrawList.Length);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.u_nTextureWidth = 15;
		infNodeItem.u_nTextureHeight = 15;
		infNodeItem.u_nTextureUWidth = 32;
		infNodeItem.u_nTextureUHeight = 32;
		infNodeItem.u_strTexture = Class'UIDATA_SKILL'.GetIconName(SkillID,SkillLevel);
		Class'UIAPI_TREECTRL'.InsertNodeItem("TargetStatusWnd.NpcInfo",strNodeName,infNodeItem);
		UnknownFunction161(i,2);
		goto JL00BD;
	}
}

function CustomTooltip SetNpcInfoTooltip (int Id, int Level)
{
	local CustomTooltip ToolTip;
	local DrawItemInfo Info;
	local DrawItemInfo infoClear;
	local ItemInfo item;

	item.Name = Class'UIDATA_SKILL'.GetName(Id,Level);
	item.Description = Class'UIDATA_SKILL'.GetDescription(Id,Level);
	ToolTip.DrawList.Length = 1;
	Info = infoClear;
	Info.eType = 1;
	Info.t_bDrawOneLine = True;
	Info.t_strText = item.Name;
	ToolTip.DrawList[0] = Info;
	if ( UnknownFunction151(UnknownFunction125(item.Description),0) )
	{
		ToolTip.MinimumWidth = 144;
		ToolTip.DrawList.Length = 2;
		Info = infoClear;
		Info.eType = 1;
		Info.nOffSetY = 6;
		Info.bLineBreak = True;
		Info.t_color.R = 178;
		Info.t_color.G = 190;
		Info.t_color.B = 207;
		Info.t_color.A = 255;
		Info.t_strText = item.Description;
		ToolTip.DrawList[1] = Info;
	}
	return ToolTip;
}

function bool IsAllWhiteID (int L2jBRVar90
)
{
	local bool bIsAllWhiteName;

	bIsAllWhiteName = False;
	switch (L2jBRVar90	)
	{
		case 12778:
		case 13031:
		case 13032:
		case 13033:
		case 13034:
		case 13035:
		case 13036:
		bIsAllWhiteName = True;
		break;
		default:
	}
	return bIsAllWhiteName;
}

function bool IsNoBarID (int L2jBRVar90
)
{
	local bool bIsNoBarName;

	bIsNoBarName = False;
	switch (L2jBRVar90	)
	{
		case 13036:
		bIsNoBarName = True;
		break;
		default:
	}
	return bIsNoBarName;
}

function OnRButtonUp (int X, int Y)
{
	local Rect rectWnd;
	local UserInfo UserInfo;

	dlgText = DialogGetString();
	rectWnd = L2jBRVar103.GetRect();
	if ( UnknownFunction151(X,rectWnd.nX) )
	{
		GetTargetInfo(UserInfo);
		SetChatMessage(UnknownFunction112(UnknownFunction112(" ",UserInfo.Name)," "));
		ChatEditBox.ReleaseFocus();
	}
}

