//================================================================================
// ClanWnd.
//================================================================================

class ClanWnd extends UIScript;

var int m_clanID;
var string m_clanName;
var int m_clanRank;
var int m_clanLevel;
var int m_clanNameValue;
var int m_bMoreInfo;
var int m_currentShowIndex;
var int G_CurrentRecord;
var string G_CurrentSzData;
var bool G_CurrentAlias;
var bool G_IamNobless;
var bool G_IamHero;
var int G_ClanMember;
var string L2jBRVar13;
var int m_myClanType;
var string m_myName;
var string m_myClanName;
var int m_indexNum;
var bool m_currentactivestatus1;
var bool m_currentactivestatus2;
var bool m_currentactivestatus3;
var bool m_currentactivestatus4;
var bool m_currentactivestatus5;
var bool m_currentactivestatus6;
var bool m_currentactivestatus7;
var bool m_currentactivestatus8;
var int m_bClanMaster;
var int m_bJoin;
var int m_bNickName;
var int m_bCrest;
var int m_bWar;
var int m_bGrade;
var int m_bManageMaster;
var int m_bOustMember;
var string m_CurrentclanMasterName;
var string m_CurrentclanMasterReal;
var int m_CurrentNHType;
var array<ClanInfo> m_memberList;

function getmyClanInfo ()
{
	local UserInfo UserInfo;

	if ( GetPlayerInfo(UserInfo) )
	{
		m_myName = UserInfo.Name;
		m_myClanType = findmyClanData(m_myName);
		G_IamNobless = UserInfo.bNobless;
		G_IamHero = UserInfo.bHero;
		G_ClanMember = UserInfo.nClanID;
	}
}

function int findmyClanData (string C_Name)
{
	local int i;
	local int j;
	local int clannum;

	i = 0;
	if ( UnknownFunction150(i,m_memberList.Length) )
	{
		j = 0;
		if ( UnknownFunction150(j,m_memberList[i].m_array.Length) )
		{
			if ( UnknownFunction122(m_memberList[i].m_array[j].sName,C_Name) )
			{
				clannum = m_memberList[i].m_array[j].clanType;
			}
			UnknownFunction163(j);
			goto JL001E;
		}
		UnknownFunction163(i);
		goto JL0007;
	}
	return clannum;
}

function OnLoad ()
{
	RegisterEvents();
	m_memberList.Length = 8;
	m_currentShowIndex = 0;
	m_bMoreInfo = 0;
	G_CurrentAlias = False;
	Clear();
	m_currentactivestatus1 = False;
	m_currentactivestatus2 = False;
	m_currentactivestatus3 = False;
	m_currentactivestatus4 = False;
	m_currentactivestatus5 = False;
	m_currentactivestatus6 = False;
	m_currentactivestatus7 = False;
}

function RegisterEvents ()
{
	RegisterEvent(320);
	RegisterEvent(330);
	RegisterEvent(420);
	RegisterEvent(400);
	RegisterEvent(440);
	RegisterEvent(410);
	RegisterEvent(450);
	RegisterEvent(150);
	RegisterEvent(160);
	RegisterEvent(340);
	RegisterEvent(480);
}

function int GetClanTypeFromIndex (int Index)
{
	local int L2jBRVar5;

	if ( UnknownFunction154(Index,0) )
	{
		L2jBRVar5 = 0;
	}
	if ( UnknownFunction154(Index,1) )
	{
		L2jBRVar5 = 100;
	}
	if ( UnknownFunction154(Index,2) )
	{
		L2jBRVar5 = 200;
	}
	if ( UnknownFunction154(Index,3) )
	{
		L2jBRVar5 = 1001;
	}
	if ( UnknownFunction154(Index,4) )
	{
		L2jBRVar5 = 1002;
	}
	if ( UnknownFunction154(Index,5) )
	{
		L2jBRVar5 = 2001;
	}
	if ( UnknownFunction154(Index,6) )
	{
		L2jBRVar5 = 2002;
	}
	if ( UnknownFunction154(Index,7) )
	{
		L2jBRVar5 = -1;
	}
	return L2jBRVar5;
}

function string GetClanTypeNameFromIndex (int Index)
{
	local string L2jBRVar5;

	if ( UnknownFunction154(Index,0) )
	{
		L2jBRVar5 = GetSystemString(1399);
	}
	if ( UnknownFunction154(Index,100) )
	{
		L2jBRVar5 = GetSystemString(1400);
	}
	if ( UnknownFunction154(Index,200) )
	{
		L2jBRVar5 = GetSystemString(1401);
	}
	if ( UnknownFunction154(Index,1001) )
	{
		L2jBRVar5 = GetSystemString(1402);
	}
	if ( UnknownFunction154(Index,1002) )
	{
		L2jBRVar5 = GetSystemString(1403);
	}
	if ( UnknownFunction154(Index,2001) )
	{
		L2jBRVar5 = GetSystemString(1404);
	}
	if ( UnknownFunction154(Index,2002) )
	{
		L2jBRVar5 = GetSystemString(1405);
	}
	if ( UnknownFunction154(Index,-1) )
	{
		L2jBRVar5 = GetSystemString(1452);
	}
	return L2jBRVar5;
}

function OnShow ()
{
	local int i;

	getmyClanInfo();
	RefreshCombobox();
	resetBtnShowHide();
	NoblessMenuValidate();
JL0026:
	SetFocus();
	i = 10;
	if ( UnknownFunction153(i,0) )
	{
		if ( UnknownFunction154(Class'UIAPI_COMBOBOX'.GetReserved(UnknownFunction112(L2jBRVar13,".ComboboxMainClanWnd"),i),m_myClanType) )
		{
			Class'UIAPI_COMBOBOX'.SetSelectedNum(UnknownFunction112(L2jBRVar13,".ComboboxMainClanWnd"),i);
		}
		UnknownFunction164(i);
		goto JL0026;
	}
	ShowList(m_myClanType);
	Class'UIAPI_LISTCTRL'.SetSelectedIndex(UnknownFunction112(L2jBRVar13,".ClanMemberList"),m_indexNum,True);
	if ( UnknownFunction154(m_myClanType,-1) )
	{
		Class'UIAPI_LISTCTRL'.SetSelectedIndex(UnknownFunction112(L2jBRVar13,".ClanMemberList"),UnknownFunction147(m_indexNum,1),True);
	}
}

function NoblessMenuValidate ()
{
	if ( UnknownFunction154(G_ClanMember,0) )
	{
		if ( UnknownFunction132(UnknownFunction242(G_IamHero,True),UnknownFunction242(G_IamNobless,True)) )
		{
			Class'UIAPI_WINDOW'.ShowWindow(UnknownFunction112(L2jBRVar13,".HeroBtn"));
			Class'UIAPI_WINDOW'.HideWindow(UnknownFunction112(L2jBRVar13,".ClanMemInfoBtn"));
		} else {
			Class'UIAPI_WINDOW'.HideWindow(UnknownFunction112(L2jBRVar13,".HeroBtn"));
			Class'UIAPI_WINDOW'.ShowWindow(UnknownFunction112(L2jBRVar13,".ClanMemInfoBtn"));
		}
	} else {
		Class'UIAPI_WINDOW'.HideWindow(UnknownFunction112(L2jBRVar13,".HeroBtn"));
		Class'UIAPI_WINDOW'.ShowWindow(UnknownFunction112(L2jBRVar13,".ClanMemInfoBtn"));
	}
}

function OnHide ()
{
}

function OnEnterState (name a_PreStateName)
{
	getmyClanInfo();
	NoblessMenuValidate();
	if ( UnknownFunction254(a_PreStateName,'LoadingState') )
	{
		Clear();
	}
}

function OnClickButton (string strID)
{
	local ClanDrawerWnd L2jBRVar21;
	local LVDataRecord Record;
	local string strParam;

	Record.LVDataList.Length = 10;
	L2jBRVar21 = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
	if ( UnknownFunction122(strID,"ClanMemInfoBtn") )
	{
		if ( UnknownFunction242(m_currentactivestatus1,False) )
		{
			ResetOpeningVariables();
			m_currentactivestatus1 = True;
			if ( GetSelectedListCtrlItem(Record) )
			{
				RequestClanMemberInfo(Record.nReserved1,Record.LVDataList[0].szData);
				G_CurrentRecord = Record.nReserved1;
				G_CurrentSzData = Record.LVDataList[0].szData;
				if ( UnknownFunction122(Record.LVDataList[3].szData,"0") )
				{
					G_CurrentAlias = True;
				} else {
					G_CurrentAlias = False;
				}
				L2jBRVar21.SetStateAndShow("ClanMemberInfoState");
			}
		} else {
			m_currentactivestatus1 = False;
			L2jBRVar21.HideWindow();
		}
	} else {
		if ( UnknownFunction122(strID,"ClanMemAuthBtn") )
		{
			if ( UnknownFunction242(m_currentactivestatus2,False) )
			{
				ResetOpeningVariables();
				m_currentactivestatus2 = True;
				if ( GetSelectedListCtrlItem(Record) )
				{
					RequestClanMemberAuth(Record.nReserved1,Record.LVDataList[0].szData);
					L2jBRVar21.SetStateAndShow("ClanMemberAuthState");
				}
			} else {
				m_currentactivestatus2 = False;
				L2jBRVar21.HideWindow();
			}
		} else {
			if ( UnknownFunction122(strID,"ClanBoardBtn") )
			{
				ParamAdd(strParam,"Index","3");
				ExecuteEvent(1190,strParam);
			} else {
				if ( UnknownFunction122(strID,"ClanInfoBtn") )
				{
					if ( UnknownFunction242(m_currentactivestatus3,False) )
					{
						ResetOpeningVariables();
						m_currentactivestatus3 = True;
						L2jBRVar21.SetStateAndShow("ClanInfoState");
					} else {
						m_currentactivestatus3 = False;
						L2jBRVar21.HideWindow();
					}
				} else {
					if ( UnknownFunction122(strID,"ClanPenaltyBtn") )
					{
						ExecuteCommandFromAction("pledgepenalty");
					} else {
						if ( UnknownFunction122(strID,"ClanQuitBtn") )
						{
							RequestClanLeave(m_clanName,m_myClanType);
						} else {
							if ( UnknownFunction122(strID,"ClanWarInfoBtn") )
							{
								if ( UnknownFunction242(m_currentactivestatus5,False) )
								{
									ResetOpeningVariables();
									m_currentactivestatus5 = True;
									L2jBRVar21.m_clanWarListPage = -1;
									RequestClanWarList(0,0);
									L2jBRVar21.SetStateAndShow("ClanWarManagementWndState");
								} else {
									m_currentactivestatus5 = False;
									L2jBRVar21.HideWindow();
								}
							} else {
								if ( UnknownFunction122(strID,"ClanWarDeclareBtn") )
								{
									RequestClanDeclareWar();
								} else {
									if ( UnknownFunction122(strID,"ClanWarCancleBtn") )
									{
										RequestClanWithdrawWar();
									} else {
										if ( UnknownFunction122(strID,"ClanAskJoinBtn") )
										{
											AskJoin();
										} else {
											if ( UnknownFunction122(strID,"ClanAuthEditBtn") )
											{
												if ( UnknownFunction242(m_currentactivestatus6,False) )
												{
													ResetOpeningVariables();
													m_currentactivestatus6 = True;
													RequestClanGradeList();
													L2jBRVar21.SetStateAndShow("ClanAuthManageWndState");
												} else {
													m_currentactivestatus6 = False;
													L2jBRVar21.HideWindow();
												}
											} else {
												if ( UnknownFunction122(strID,"ClanTitleManageBtn") )
												{
													if ( UnknownFunction242(m_currentactivestatus7,False) )
													{
														ResetOpeningVariables();
														m_currentactivestatus7 = True;
														L2jBRVar21.SetStateAndShow("ClanEmblemManageWndState");
													} else {
														m_currentactivestatus7 = False;
														L2jBRVar21.HideWindow();
													}
												} else {
													if ( UnknownFunction122(strID,"HeroBtn") )
													{
														if ( UnknownFunction242(m_currentactivestatus8,False) )
														{
															m_currentactivestatus8 = True;
															L2jBRVar21.SetStateAndShow("ClanHeroWndState");
														} else {
															m_currentactivestatus8 = False;
															L2jBRVar21.HideWindow();
														}
													} else {
														if ( UnknownFunction122(strID,"BtnClose") )
														{
															Class'UIAPI_WINDOW'.HideWindow("ClanWnd");
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
				}
			}
		}
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 420:
		Clear();
		break;
		case 320:
		HandleClanInfo(_L2jBRVar17_);
		break;
		case 410:
		HandleAddClanMemberMultiple(_L2jBRVar17_);
		break;
		case 440:
		HandleMemberInfoUpdate(_L2jBRVar17_);
		break;
		case 400:
		HandleAddClanMember(_L2jBRVar17_);
		break;
		case 450:
		HandleDeleteMember(_L2jBRVar17_);
		break;
		case 330:
		HandleClanInfoUpdate(_L2jBRVar17_);
		break;
		case 480:
		HandleSubClanUpdated(_L2jBRVar17_);
		break;
		case 340:
		HandleClanMyAuth(_L2jBRVar17_);
		break;
		default:
		break;
	}
}

function OnComboBoxItemSelected (string sName, int Index)
{
	ClearList();
	ShowList(Class'UIAPI_COMBOBOX'.GetReserved(UnknownFunction112(L2jBRVar13,".ComboboxMainClanWnd"),Class'UIAPI_COMBOBOX'.GetSelectedNum(UnknownFunction112(L2jBRVar13,".ComboboxMainClanWnd"))));
}

function OnClickListCtrlRecord (string ListCtrlID)
{
	local ClanDrawerWnd L2jBRVar21;
	local LVDataRecord Record;

	Record.LVDataList.Length = 10;
	L2jBRVar21 = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
	if ( UnknownFunction122(ListCtrlID,"ClanMemberList") )
	{
		if ( UnknownFunction242(m_currentactivestatus1,True) )
		{
			ResetOpeningVariables();
			m_currentactivestatus1 = True;
			if ( GetSelectedListCtrlItem(Record) )
			{
				RequestClanMemberInfo(Record.nReserved1,Record.LVDataList[0].szData);
				G_CurrentRecord = Record.nReserved1;
				G_CurrentSzData = Record.LVDataList[0].szData;
				if ( UnknownFunction122(Record.LVDataList[3].szData,"0") )
				{
					G_CurrentAlias = True;
				} else {
					G_CurrentAlias = False;
				}
				L2jBRVar21.SetStateAndShow("ClanMemberInfoState");
			}
		}
		if ( UnknownFunction242(m_currentactivestatus2,True) )
		{
			ResetOpeningVariables();
			m_currentactivestatus2 = True;
			if ( GetSelectedListCtrlItem(Record) )
			{
				RequestClanMemberAuth(Record.nReserved1,Record.LVDataList[0].szData);
				L2jBRVar21.SetStateAndShow("ClanMemberAuthState");
			}
		}
	}
}

function OnDBClickListCtrlRecord (string ListCtrlID)
{
	local ClanDrawerWnd L2jBRVar21;
	local LVDataRecord Record;

	Record.LVDataList.Length = 10;
	L2jBRVar21 = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
	if ( UnknownFunction122(ListCtrlID,"ClanMemberList") )
	{
		if ( UnknownFunction242(m_currentactivestatus1,False) )
		{
			ResetOpeningVariables();
			m_currentactivestatus1 = True;
			if ( GetSelectedListCtrlItem(Record) )
			{
				RequestClanMemberInfo(Record.nReserved1,Record.LVDataList[0].szData);
				G_CurrentRecord = Record.nReserved1;
				G_CurrentSzData = Record.LVDataList[0].szData;
				if ( UnknownFunction122(Record.LVDataList[3].szData,"0") )
				{
					G_CurrentAlias = True;
				} else {
					G_CurrentAlias = False;
				}
				L2jBRVar21.SetStateAndShow("ClanMemberInfoState");
			}
		} else {
			ResetOpeningVariables();
			m_currentactivestatus1 = True;
			if ( GetSelectedListCtrlItem(Record) )
			{
				RequestClanMemberInfo(Record.nReserved1,Record.LVDataList[0].szData);
				G_CurrentRecord = Record.nReserved1;
				G_CurrentSzData = Record.LVDataList[0].szData;
				L2jBRVar21.SetStateAndShow("ClanMemberInfoState");
			}
		}
	}
}

function resetBtnShowHide ()
{
	local ClanDrawerWnd L2jBRVar21;

	L2jBRVar21 = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
	NoblessMenuValidate();
	if ( UnknownFunction154(m_clanID,0) )
	{
		Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanMemInfoBtn"));
		Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanMemAuthBtn"));
		Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanBoardBtn"));
		Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanInfoBtn"));
		Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanQuitBtn"));
		Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarInfoBtn"));
		Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarDeclareBtn"));
		Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarCancleBtn"));
		Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanAskJoinBtn"));
		Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanAuthEditBtn"));
		Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanTitleManageBtn"));
	} else {
		if ( UnknownFunction151(m_clanLevel,5) )
		{
			Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemInfoBtn"));
			Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemAuthBtn"));
			Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanBoardBtn"));
			Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanInfoBtn"));
			Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanPenaltyBtn"));
			Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanQuitBtn"));
			Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanWarInfoBtn"));
			Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanWarDeclareBtn"));
			Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanWarCancleBtn"));
			Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanAskJoinBtn"));
			Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanAuthEditBtn"));
			Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanTitleManageBtn"));
			Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
			Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
			Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
			Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
		} else {
			switch (m_clanLevel)
			{
				case 0:
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemAuthBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanBoardBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanPenaltyBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanQuitBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarInfoBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarDeclareBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarCancleBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanAskJoinBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanAuthEditBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanTitleManageBtn"));
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
				break;
				case 1:
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemAuthBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanBoardBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanPenaltyBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanQuitBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarInfoBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarDeclareBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarCancleBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanAskJoinBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanAuthEditBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanTitleManageBtn"));
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
				Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
				break;
				case 2:
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemAuthBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanBoardBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanPenaltyBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanQuitBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarInfoBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarDeclareBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarCancleBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanAskJoinBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanAuthEditBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanTitleManageBtn"));
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
				Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
				break;
				case 3:
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemAuthBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanBoardBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanPenaltyBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanQuitBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanWarInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanWarDeclareBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanWarCancleBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanAskJoinBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanAuthEditBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanTitleManageBtn"));
				Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
				Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
				break;
				case 4:
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemAuthBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanBoardBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanPenaltyBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanQuitBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanWarInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanWarDeclareBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanWarCancleBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanAskJoinBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanAuthEditBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanTitleManageBtn"));
				Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
				Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
				break;
				case 5:
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanMemAuthBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanBoardBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanPenaltyBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanQuitBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanWarInfoBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanWarDeclareBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanWarCancleBtn"));
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanAskJoinBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanAuthEditBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanTitleManageBtn"));
				Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
				Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
				Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
				Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
				break;
				default:
			}
		}
		if ( UnknownFunction151(m_bClanMaster,0) )
		{
			Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanQuitBtn"));
			if ( UnknownFunction151(m_clanLevel,2) )
			{
				Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanTitleManageBtn"));
			}
			Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanAuthEditBtn"));
		} else {
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
			if ( UnknownFunction154(m_bJoin,0) )
			{
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanAskJoinBtn"));
			}
			if ( UnknownFunction154(m_bCrest,0) )
			{
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanTitleManageBtn"));
			} else {
				if ( UnknownFunction151(m_clanLevel,2) )
				{
					Class'UIAPI_WINDOW'.EnableWindow(UnknownFunction112(L2jBRVar13,".ClanTitleManageBtn"));
				}
			}
			if ( UnknownFunction154(m_bWar,0) )
			{
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarDeclareBtn"));
				Class'UIAPI_WINDOW'.DisableWindow(UnknownFunction112(L2jBRVar13,".ClanWarCancleBtn"));
			}
		}
		L2jBRVar21.CheckandCompareMyNameandDisableThings();
	}
	NoblessMenuValidate();
}

function Clear ()
{
	local ClanDrawerWnd L2jBRVar21;
	local int i;

	ClearList();
	L2jBRVar21 = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
	L2jBRVar21.Clear();
	Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd");
	Class'UIAPI_WINDOW'.HideWindow("InviteClanPopWnd");
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanNameText"),"");
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanMasterNameText"),"");
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanAgitText"),GetSystemString(27));
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanStatusText"),"");
	Class'UIAPI_TEXTBOX'.SetInt(UnknownFunction112(L2jBRVar13,".ClanLevelText"),0);
	Class'UIAPI_COMBOBOX'.Clear(UnknownFunction112(L2jBRVar13,".ComboboxMainClanWnd"));
	m_clanID = 0;
	m_clanName = "";
	m_clanRank = 0;
	m_clanLevel = 0;
	m_clanNameValue = 0;
	m_bMoreInfo = 0;
	m_currentShowIndex = 0;
	m_bClanMaster = 0;
	m_bJoin = 0;
	m_bNickName = 0;
	m_bCrest = 0;
	m_bWar = 0;
	m_bGrade = 0;
	m_bManageMaster = 0;
	m_bOustMember = 0;
	i = 0;
	if ( UnknownFunction150(i,8) )
	{
		m_memberList[i].m_array.Remove (0,m_memberList[i].m_array.Length);
		m_memberList[i].m_sName = "";
		m_memberList[i].m_sMasterName = "";
		UnknownFunction163(i);
		goto JL01E2;
	}
}

function HandleClanInfo (string _L2jBRVar17_)
{
	local string clanMasterName;
	local string ClanName;
	local int crestID;
	local int SkillLevel;
	local int castleID;
	local int agitID;
	local int Status;
	local int bGuilty;
	local int AllianceID;
	local string AllianceName;
	local int AllianceCrestID;
	local int bInWar;
	local int clanType;
	local int clanRank;
	local int ClanNameValue;
	local int clanID;

	ParseInt(_L2jBRVar17_,"ClanID",clanID);
	ParseInt(_L2jBRVar17_,"ClanType",clanType);
	m_CurrentNHType = clanType;
	ParseString(_L2jBRVar17_,"ClanName",ClanName);
	ParseString(_L2jBRVar17_,"ClanMasterName",clanMasterName);
	m_CurrentclanMasterName = clanMasterName;
	if ( UnknownFunction154(clanType,0) )
	{
		m_CurrentclanMasterReal = clanMasterName;
	}
	ParseInt(_L2jBRVar17_,"CrestID",crestID);
	ParseInt(_L2jBRVar17_,"SkillLevel",SkillLevel);
	ParseInt(_L2jBRVar17_,"CastleID",castleID);
	ParseInt(_L2jBRVar17_,"AgitID",agitID);
	ParseInt(_L2jBRVar17_,"ClanRank",clanRank);
	ParseInt(_L2jBRVar17_,"ClanNameValue",ClanNameValue);
	ParseInt(_L2jBRVar17_,"Status",Status);
	ParseInt(_L2jBRVar17_,"Guilty",bGuilty);
	ParseInt(_L2jBRVar17_,"AllianceID",AllianceID);
	ParseString(_L2jBRVar17_,"AllianceName",AllianceName);
	ParseInt(_L2jBRVar17_,"AllianceCrestID",AllianceCrestID);
	ParseInt(_L2jBRVar17_,"InWar",bInWar);
	if ( UnknownFunction154(clanType,0) )
	{
		m_clanName = ClanName;
		m_clanRank = clanRank;
		m_clanNameValue = ClanNameValue;
		m_clanLevel = SkillLevel;
		m_clanID = clanID;
	}
	m_memberList[GetIndexFromType(clanType)].m_sName = ClanName;
	m_memberList[GetIndexFromType(clanType)].m_sMasterName = clanMasterName;
	if ( UnknownFunction154(clanType,0) )
	{
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanNameText"),ClanName);
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanMasterNameText"),m_CurrentclanMasterReal);
		if ( UnknownFunction151(agitID,0) )
		{
			Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanAgitText"),GetCastleName(agitID));
		} else {
			if ( UnknownFunction151(castleID,0) )
			{
				Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanAgitText"),GetCastleName(castleID));
			} else {
				Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanAgitText"),GetSystemString(27));
			}
		}
		if ( UnknownFunction154(Status,3) )
		{
			Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanStatusText"),GetSystemString(341));
		} else {
			if ( UnknownFunction154(bInWar,0) )
			{
				Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanStatusText"),GetSystemString(894));
			} else {
				Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanStatusText"),GetSystemString(340));
			}
		}
		Class'UIAPI_TEXTBOX'.SetInt(UnknownFunction112(L2jBRVar13,".ClanLevelText"),SkillLevel);
	}
	RefreshCombobox();
	getmyClanInfo();
}

function HandleClanInfoUpdate (string _L2jBRVar17_)
{
	local int PledgeCrestID;
	local int castleID;
	local int agitID;
	local int Status;
	local int bGuilty;
	local int AllianceID;
	local string sAllianceName;
	local int AllianceCrestID;
	local int InWar;
	local int LargePledgeCrestID;
	local ClanDrawerWnd L2jBRVar21;

	ParseInt(_L2jBRVar17_,"ClanID",m_clanID);
	ParseInt(_L2jBRVar17_,"CrestID",PledgeCrestID);
	ParseInt(_L2jBRVar17_,"SkillLevel",m_clanLevel);
	ParseInt(_L2jBRVar17_,"CastleID",castleID);
	ParseInt(_L2jBRVar17_,"AgitID",agitID);
	ParseInt(_L2jBRVar17_,"ClanRank",m_clanRank);
	ParseInt(_L2jBRVar17_,"ClanNameValue",m_clanNameValue);
	ParseInt(_L2jBRVar17_,"Status",Status);
	ParseInt(_L2jBRVar17_,"Guilty",bGuilty);
	ParseInt(_L2jBRVar17_,"AllianceID",AllianceID);
	ParseString(_L2jBRVar17_,"AllianceName",sAllianceName);
	ParseInt(_L2jBRVar17_,"AllianceCrestID",AllianceCrestID);
	ParseInt(_L2jBRVar17_,"InWar",InWar);
	ParseInt(_L2jBRVar17_,"LargeCrestID",LargePledgeCrestID);
	if ( Class'UIAPI_WINDOW'.IsShowWindow("ClanDrawerWnd.ClanInfoWnd") )
	{
		L2jBRVar21 = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
		L2jBRVar21.InitializeClanInfoWnd();
	}
	if ( UnknownFunction151(agitID,0) )
	{
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanAgitText"),GetCastleName(agitID));
	} else {
		if ( UnknownFunction151(castleID,0) )
		{
			Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanAgitText"),GetCastleName(castleID));
		} else {
			Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanAgitText"),GetSystemString(27));
		}
	}
	if ( UnknownFunction154(Status,3) )
	{
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanStatusText"),GetSystemString(341));
	} else {
		if ( UnknownFunction154(InWar,0) )
		{
			Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanStatusText"),GetSystemString(894));
		} else {
			Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanStatusText"),GetSystemString(340));
		}
	}
	Class'UIAPI_TEXTBOX'.SetInt(UnknownFunction112(L2jBRVar13,".ClanLevelText"),m_clanLevel);
	resetBtnShowHide();
	getmyClanInfo();
}

function HandleAddClanMemberMultiple (string _L2jBRVar17_)
{
	local ClanMemberInfo Info;
	local int L2jBRVar15_;
	local int Index;

	ParseInt(_L2jBRVar17_,"ClanType",Info.clanType);
	Index = GetIndexFromType(Info.clanType);
	ParseString(_L2jBRVar17_,"Name",Info.sName);
	ParseInt(_L2jBRVar17_,"Level",Info.Level);
	ParseInt(_L2jBRVar17_,"Class",Info.ClassID);
	ParseInt(_L2jBRVar17_,"Gender",Info.gender);
	ParseInt(_L2jBRVar17_,"Race",Info.Race);
	ParseInt(_L2jBRVar17_,"ID",Info.Id);
	ParseInt(_L2jBRVar17_,"HaveMaster",Info.bHaveMaster);
	L2jBRVar15_ = m_memberList[Index].m_array.Length;
	m_memberList[Index].m_array.Length = UnknownFunction146(L2jBRVar15_,1);
	m_memberList[Index].m_array[L2jBRVar15_] = Info;
	if ( UnknownFunction154(Index,m_currentShowIndex) )
	{
		ShowList(Info.clanType);
	}
}

function ClearList ()
{
	Class'UIAPI_LISTCTRL'.DeleteAllItem(UnknownFunction112(L2jBRVar13,".ClanMemberList"));
}

function ShowList (int clanType)
{
	local int Index;

	Index = GetIndexFromType(clanType);
	m_currentShowIndex = Index;
	ClearList();
	AddToList(Index);
}

function int getClanKnighthoodMasterInfo (string NameVal)
{
	local int i;
	local int ReturnVal;

	i = 0;
	if ( UnknownFunction150(i,m_memberList[0].m_array.Length) )
	{
		if ( UnknownFunction122(m_memberList[0].m_array[i].sName,NameVal) )
		{
			ReturnVal = i;
		}
		UnknownFunction163(i);
		goto JL0007;
	}
	return ReturnVal;
}

function AddToList (int L2jBRVar2)
{
	local Color White;
	local Color Yellow;
	local Color Blue;
	local Color BrightWhite;
	local Color Gold;
	local int i;
	local int OnLineNum;
	local LVDataRecord Record;

	BrightWhite.R = 255;
	BrightWhite.G = 255;
	BrightWhite.B = 255;
	White.R = 170;
	White.G = 170;
	White.B = 170;
	Yellow.R = 235;
	Yellow.G = 205;
	Yellow.B = 0;
	Blue.R = 102;
	Blue.G = 150;
	Blue.B = 253;
	Gold.R = 176;
	Gold.G = 153;
	Gold.B = 121;
	OnLineNum = 0;
	Record.LVDataList.Length = 4;
	if ( UnknownFunction152(GetClanTypeFromIndex(m_currentShowIndex),0) )
	{
		goto JL043B;
	}
	if ( UnknownFunction122(m_memberList[m_currentShowIndex].m_sMasterName,"") )
	{
		i = getClanKnighthoodMasterInfo(m_memberList[m_currentShowIndex].m_sMasterName);
		Record.LVDataList[0].bUseTextColor = True;
		Record.LVDataList[0].szData = GetSystemString(1445);
		Record.LVDataList[0].TextColor = Gold;
		Record.LVDataList[1].szData = "";
		Record.LVDataList[2].szData = "";
		Class'UIAPI_LISTCTRL'.InsertRecord(UnknownFunction112(L2jBRVar13,".ClanMemberList"),Record);
	} else {
		i = getClanKnighthoodMasterInfo(m_memberList[m_currentShowIndex].m_sMasterName);
		Record.LVDataList[0].bUseTextColor = True;
		Record.LVDataList[0].szData = m_memberList[m_currentShowIndex].m_sMasterName;
		Record.LVDataList[0].TextColor = Gold;
		Record.LVDataList[1].bUseTextColor = True;
		Record.LVDataList[1].TextColor = White;
		Record.LVDataList[1].szData = string(m_memberList[0].m_array[i].Level);
		Record.LVDataList[2].szData = string(m_memberList[0].m_array[i].ClassID);
		Record.LVDataList[2].szTexture = GetClassIconName(m_memberList[0].m_array[i].ClassID);
		Record.LVDataList[2].nTextureWidth = 11;
		Record.LVDataList[2].nTextureHeight = 11;
		Record.LVDataList[3].nTextureWidth = 31;
		Record.LVDataList[3].nTextureHeight = 11;
		Record.nReserved1 = 0;
		if ( UnknownFunction151(m_memberList[0].m_array[i].Id,0) )
		{
			Record.LVDataList[3].szData = "0";
			Record.LVDataList[3].szTexture = "L2UI_CH3.BloodHoodWnd.BloodHood_Logon";
			OnLineNum = UnknownFunction165(OnLineNum);
		} else {
			Record.LVDataList[3].szData = "0";
			Record.LVDataList[3].szTexture = "L2UI_CH3.BloodHoodWnd.BloodHood_Logoff";
		}
		Class'UIAPI_LISTCTRL'.InsertRecord(UnknownFunction112(L2jBRVar13,".ClanMemberList"),Record);
	}
	i = 0;
	i = 0;
	if ( UnknownFunction150(i,m_memberList[L2jBRVar2].m_array.Length) )
	{
		Record.LVDataList[0].bUseTextColor = True;
		Record.LVDataList[0].szData = m_memberList[L2jBRVar2].m_array[i].sName;
		if ( UnknownFunction154(m_memberList[L2jBRVar2].m_array[i].bHaveMaster,0) )
		{
			Record.LVDataList[0].TextColor = White;
		} else {
			Record.LVDataList[0].TextColor = Yellow;
		}
		if ( UnknownFunction122(m_memberList[L2jBRVar2].m_array[i].sName,m_myName) )
		{
			Record.LVDataList[0].TextColor = BrightWhite;
			Record.LVDataList[1].TextColor = BrightWhite;
			if ( UnknownFunction154(GetClanTypeFromIndex(m_currentShowIndex),0) )
			{
				m_indexNum = i;
			} else {
				m_indexNum = UnknownFunction146(i,1);
			}
		}
		Record.LVDataList[1].bUseTextColor = True;
		if ( UnknownFunction122(m_memberList[L2jBRVar2].m_array[i].sName,m_myName) )
		{
			Record.LVDataList[1].TextColor = BrightWhite;
		} else {
			Record.LVDataList[1].TextColor = White;
		}
		Record.LVDataList[1].szData = string(m_memberList[L2jBRVar2].m_array[i].Level);
		Record.LVDataList[2].szData = string(m_memberList[L2jBRVar2].m_array[i].ClassID);
		Record.LVDataList[2].szTexture = GetClassIconName(m_memberList[L2jBRVar2].m_array[i].ClassID);
		Record.LVDataList[2].nTextureWidth = 11;
		Record.LVDataList[2].nTextureHeight = 11;
		Record.LVDataList[3].nTextureWidth = 31;
		Record.LVDataList[3].nTextureHeight = 11;
		Record.nReserved1 = m_memberList[L2jBRVar2].m_array[i].clanType;
		if ( UnknownFunction151(m_memberList[L2jBRVar2].m_array[i].Id,0) )
		{
			Record.LVDataList[3].szData = "1";
			Record.LVDataList[3].szTexture = "L2UI_CH3.BloodHoodWnd.BloodHood_Logon";
			OnLineNum = UnknownFunction165(OnLineNum);
		} else {
			Record.LVDataList[3].szData = "2";
			Record.LVDataList[3].szTexture = "L2UI_CH3.BloodHoodWnd.BloodHood_Logoff";
		}
		Class'UIAPI_LISTCTRL'.InsertRecord(UnknownFunction112(L2jBRVar13,".ClanMemberList"),Record);
		UnknownFunction163(i);
		goto JL0442;
	}
	if ( UnknownFunction152(GetClanTypeFromIndex(m_currentShowIndex),0) )
	{
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanCurrentNum"),UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(OnLineNum)),"/"),string(m_memberList[L2jBRVar2].m_array.Length)),")"));
	} else {
		Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".ClanCurrentNum"),UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(OnLineNum)),"/"),string(UnknownFunction146(m_memberList[L2jBRVar2].m_array.Length,1))),")"));
	}
	Class'UIAPI_TEXTBOX'.SetText("NPHRN_BeltWnd.StaffText",UnknownFunction112("",string(OnLineNum)));
	if ( UnknownFunction150(OnLineNum,1) )
	{
		Class'UIAPI_WINDOW'.HideWindow("NPHRN_BeltWnd.StaffText");
		Class'UIAPI_WINDOW'.HideWindow("NPHRN_BeltWnd.StaffIcon");
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("NPHRN_BeltWnd.StaffText");
		Class'UIAPI_WINDOW'.ShowWindow("NPHRN_BeltWnd.StaffIcon");
	}
}

function bool GetSelectedListCtrlItem (out LVDataRecord Record)
{
	local int Index;

	Index = Class'UIAPI_LISTCTRL'.GetSelectedIndex(UnknownFunction112(L2jBRVar13,".ClanMemberList"));
	if ( UnknownFunction153(Index,0) )
	{
		Record = Class'UIAPI_LISTCTRL'.GetRecord(UnknownFunction112(L2jBRVar13,".ClanMemberList"),Index);
		return True;
	}
	return False;
}

function HandleMemberInfoUpdate (string _L2jBRVar17_)
{
	local ClanMemberInfo Info;
	local int i;
	local int j;
	local int L2jBRVar15_;
	local ClanDrawerWnd L2jBRVar21;
	local bool bHaveMasterChanged;
	local bool bMemberChanged;
	local int process_length;
	local int process_clanindex;

	bHaveMasterChanged = False;
	bMemberChanged = False;
	ParseString(_L2jBRVar17_,"Name",Info.sName);
	ParseInt(_L2jBRVar17_,"Level",Info.Level);
	ParseInt(_L2jBRVar17_,"Class",Info.ClassID);
	ParseInt(_L2jBRVar17_,"Gender",Info.gender);
	ParseInt(_L2jBRVar17_,"Race",Info.Race);
	ParseInt(_L2jBRVar17_,"ID",Info.Id);
	ParseInt(_L2jBRVar17_,"PledgeType",Info.clanType);
	ParseInt(_L2jBRVar17_,"HaveMaster",Info.bHaveMaster);
	i = 0;
	if ( UnknownFunction150(i,8) )
	{
		L2jBRVar15_ = m_memberList[i].m_array.Length;
		j = 0;
		if ( UnknownFunction150(j,L2jBRVar15_) )
		{
			if ( UnknownFunction122(m_memberList[i].m_array[j].sName,Info.sName) )
			{
				if ( UnknownFunction155(m_memberList[i].m_array[j].bHaveMaster,Info.bHaveMaster) )
				{
					bHaveMasterChanged = True;
					m_memberList[i].m_array[j] = Info;
					Debug("멤버정보 변경 이벤트 날아왔음222");
				}
				if ( UnknownFunction155(m_memberList[i].m_array[j].clanType,Info.clanType) )
				{
					bMemberChanged = True;
					Debug("멤버이동 처리");
					m_memberList[i].m_array.Remove (j,1);
					process_clanindex = GetIndexFromType(Info.clanType);
					process_length = m_memberList[process_clanindex].m_array.Length;
					byte(m_memberList[process_clanindex].m_array)
					process_length
					1
					m_memberList[process_clanindex].m_array[process_length].sName = Info.sName;
					m_memberList[process_clanindex].m_array[process_length].clanType = Info.clanType;
					m_memberList[process_clanindex].m_array[process_length].Level = Info.Level;
					m_memberList[process_clanindex].m_array[process_length].ClassID = Info.ClassID;
					m_memberList[process_clanindex].m_array[process_length].gender = Info.gender;
					m_memberList[process_clanindex].m_array[process_length].Race = Info.Race;
					m_memberList[process_clanindex].m_array[process_length].Id = Info.Id;
					m_memberList[process_clanindex].m_array[process_length].bHaveMaster = Info.bHaveMaster;
					Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberGrade","");
					ShowList(Info.clanType);
				} else {
					m_memberList[i].m_array[j] = Info;
					ShowList(Info.clanType);
				}
			} else {
				UnknownFunction163(j);
				goto JL0127;
			}
		}
		if ( UnknownFunction150(j,L2jBRVar15_) )
		{
			goto JL0451;
		}
		UnknownFunction163(i);
		goto JL00FD;
	}
	if ( UnknownFunction130(bHaveMasterChanged,Class'UIAPI_WINDOW'.IsShowWindow("ClanDrawerWnd.ClanMemberInfoWnd")) )
	{
		L2jBRVar21 = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
		if ( UnknownFunction122(L2jBRVar21.m_currentName,Info.sName) )
		{
			RequestClanMemberInfo(Info.clanType,Info.sName);
		}
		if ( UnknownFunction154(GetIndexFromType(Info.clanType),m_currentShowIndex) )
		{
			ShowList(Info.clanType);
		}
		ShowList(m_currentShowIndex);
	}
	if ( UnknownFunction130(bMemberChanged,Class'UIAPI_WINDOW'.IsShowWindow("ClanDrawerWnd.ClanMemberInfoWnd")) )
	{
		ClearList();
		ShowList(Info.clanType);
		RefreshCombobox1(Info.clanType);
	}
}

function RefreshCombobox1 (int ClanT)
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,10) )
	{
		if ( UnknownFunction154(Class'UIAPI_COMBOBOX'.GetReserved(UnknownFunction112(L2jBRVar13,".ComboboxMainClanWnd"),i),ClanT) )
		{
			Class'UIAPI_COMBOBOX'.SetSelectedNum(UnknownFunction112(L2jBRVar13,".ComboboxMainClanWnd"),i);
			Debug(UnknownFunction168("CurrentSelected:",string(i)));
		}
		UnknownFunction163(i);
		goto JL0007;
	}
}

function HandleAddClanMember (string _L2jBRVar17_)
{
	local int L2jBRVar15_;
	local ClanMemberInfo Info;

	ParseString(_L2jBRVar17_,"Name",Info.sName);
	ParseInt(_L2jBRVar17_,"Level",Info.Level);
	ParseInt(_L2jBRVar17_,"Class",Info.ClassID);
	ParseInt(_L2jBRVar17_,"Gender",Info.gender);
	ParseInt(_L2jBRVar17_,"Race",Info.Race);
	ParseInt(_L2jBRVar17_,"ID",Info.Id);
	ParseInt(_L2jBRVar17_,"ClanType",Info.clanType);
	Info.bHaveMaster = 0;
	L2jBRVar15_ = m_memberList[GetIndexFromType(Info.clanType)].m_array.Length;
	m_memberList[GetIndexFromType(Info.clanType)].m_array.Length = UnknownFunction146(L2jBRVar15_,1);
	m_memberList[GetIndexFromType(Info.clanType)].m_array[L2jBRVar15_] = Info;
	if ( UnknownFunction154(GetIndexFromType(Info.clanType),m_currentShowIndex) )
	{
		ShowList(Info.clanType);
	}
}

function int GetIndexFromType (int L2jBRVar5)
{
	local int i;

	i = -1;
	if ( UnknownFunction154(L2jBRVar5,0) )
	{
		i = 0;
	} else {
		if ( UnknownFunction154(L2jBRVar5,100) )
		{
			i = 1;
		} else {
			if ( UnknownFunction154(L2jBRVar5,200) )
			{
				i = 2;
			} else {
				if ( UnknownFunction154(L2jBRVar5,1001) )
				{
					i = 3;
				} else {
					if ( UnknownFunction154(L2jBRVar5,1002) )
					{
						i = 4;
					} else {
						if ( UnknownFunction154(L2jBRVar5,2001) )
						{
							i = 5;
						} else {
							if ( UnknownFunction154(L2jBRVar5,2002) )
							{
								i = 6;
							} else {
								if ( UnknownFunction154(L2jBRVar5,-1) )
								{
									i = 7;
								}
							}
						}
					}
				}
			}
		}
	}
	return i;
}

function HandleDeleteMember (string _L2jBRVar17_)
{
	local int i;
	local int j;
	local int k;
	local int L2jBRVar15_;
	local string sName;

	ParseString(_L2jBRVar17_,"Name",sName);
	i = 0;
	if ( UnknownFunction150(i,8) )
	{
		L2jBRVar15_ = m_memberList[i].m_array.Length;
		j = 0;
JL0047:
		if ( UnknownFunction150(j,L2jBRVar15_) )
		{
			if ( UnknownFunction122(m_memberList[i].m_array[j].sName,sName) )
			{
				k = j;
				if ( UnknownFunction150(k,UnknownFunction147(L2jBRVar15_,1)) )
				{
					m_memberList[i].m_array[k] = m_memberList[i].m_array[UnknownFunction146(k,1)];
					UnknownFunction163(k);
					goto JL0086;
				}
				m_memberList[i].m_array.Length = UnknownFunction147(L2jBRVar15_,1);
			} else {
				UnknownFunction163(j);
				goto JL0047;
			}
		}
		if ( UnknownFunction150(j,L2jBRVar15_) )
		{
			goto JL0115;
		}
		UnknownFunction163(i);
		goto JL001D;
	}
	if ( UnknownFunction154(i,m_currentShowIndex) )
	{
		ShowList(i);
	}
}

function RefreshCombobox ()
{
	local int i;
	local int Index;
	local int NewIndex;
	local int addedCount;

	Index = Class'UIAPI_COMBOBOX'.GetSelectedNum(UnknownFunction112(L2jBRVar13,".ComboboxMainClanWnd"));
	Class'UIAPI_COMBOBOX'.Clear(UnknownFunction112(L2jBRVar13,".ComboboxMainClanWnd"));
	addedCount = -1;
	i = 0;
	if ( UnknownFunction150(i,8) )
	{
		if ( UnknownFunction123(m_memberList[i].m_sName,"") )
		{
			Class'UIAPI_COMBOBOX'.AddStringWithReserved(UnknownFunction112(L2jBRVar13,".ComboboxMainClanWnd"),UnknownFunction168(UnknownFunction168(GetClanTypeNameFromIndex(GetClanTypeFromIndex(i)),"-"),m_memberList[i].m_sName),GetClanTypeFromIndex(i));
			UnknownFunction163(addedCount);
			if ( UnknownFunction154(i,m_currentShowIndex) )
			{
				NewIndex = addedCount;
			}
		}
		UnknownFunction163(i);
		goto JL0070;
	}
	i = 0;
	if ( UnknownFunction150(i,10) )
	{
		if ( UnknownFunction154(Class'UIAPI_COMBOBOX'.GetReserved(UnknownFunction112(L2jBRVar13,".ComboboxMainClanWnd"),i),m_myClanType) )
		{
			Class'UIAPI_COMBOBOX'.SetSelectedNum(UnknownFunction112(L2jBRVar13,".ComboboxMainClanWnd"),i);
		}
		UnknownFunction163(i);
		goto JL0124;
	}
}

function HandleSubClanUpdated (string _L2jBRVar17_)
{
	local int Id;
	local int L2jBRVar5;
	local string sName;
	local string sMasterName;
	local ClanDrawerWnd L2jBRVar21;

	ParseInt(_L2jBRVar17_,"ClanID",Id);
	ParseInt(_L2jBRVar17_,"ClanType",L2jBRVar5);
	ParseString(_L2jBRVar17_,"ClanName",sName);
	ParseString(_L2jBRVar17_,"MasterName",sMasterName);
	m_memberList[GetIndexFromType(L2jBRVar5)].m_sName = sName;
	m_memberList[GetIndexFromType(L2jBRVar5)].m_sMasterName = sMasterName;
	RefreshCombobox();
	if ( Class'UIAPI_WINDOW'.IsShowWindow("ClanDrawerWnd.ClanInfoWnd") )
	{
		L2jBRVar21 = ClanDrawerWnd(GetScript("ClanDrawerWnd"));
		L2jBRVar21.InitializeClanInfoWnd();
	}
}

function AskJoin ()
{
	local UserInfo User;

	if ( GetTargetInfo(User) )
	{
		if ( UnknownFunction151(User.nID,0) )
		{
			Class'UIAPI_WINDOW'.ShowWindow("InviteClanPopWnd");
		}
	}
}

function HandleClanMyAuth (string _L2jBRVar17_)
{
	ParseInt(_L2jBRVar17_,"ClanMaster",m_bClanMaster);
	ParseInt(_L2jBRVar17_,"Join",m_bJoin);
	ParseInt(_L2jBRVar17_,"NickName",m_bNickName);
	ParseInt(_L2jBRVar17_,"ClanCrest",m_bCrest);
	ParseInt(_L2jBRVar17_,"War",m_bWar);
	ParseInt(_L2jBRVar17_,"Grade",m_bGrade);
	ParseInt(_L2jBRVar17_,"ManageMaster",m_bManageMaster);
	ParseInt(_L2jBRVar17_,"OustMember",m_bOustMember);
	resetBtnShowHide();
}

function ResetOpeningVariables ()
{
	m_currentactivestatus1 = False;
	m_currentactivestatus2 = False;
	m_currentactivestatus3 = False;
	m_currentactivestatus4 = False;
	m_currentactivestatus5 = False;
	m_currentactivestatus6 = False;
	m_currentactivestatus7 = False;
	m_currentactivestatus8 = False;
}

function SetFocus ()
{
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.title0");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.title1");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.title2");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.title3");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanNameText");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanMasterNameText");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanMasterNameText");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanAgitText");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanStatusText");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanLevelText");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanCurrentNum");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ComboboxMainClanWnd");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanMemberList");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanMemInfoBtn");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.HeroBtn");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanMemAuthBtn");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanBoardBtn");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanInfoBtn");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanPenaltyBtn");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanQuitBtn");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanWarInfoBtn");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanWarDeclareBtn");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanWarCancleBtn");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanAskJoinBtn");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanAuthEditBtn");
	Class'UIAPI_WINDOW'.SetFocus("ClanWnd.ClanTitleManageBtn");
}

defaultproperties
{
    L2jBRVar13="ClanWnd"

}
