//================================================================================
// ClanDrawerWnd.
//================================================================================

class ClanDrawerWnd extends UIScript;

var string m_state;
var int m_clanType;
var int m_clanWarListPage;
var int m_currentEditGradeID;
var string m_currentName;
var string m_myName;
var int m_currentMaster;
var string currentMasterName;
var WindowHandle Clan3_OrgIcon[8];
const changelineval1= 23;
const c_maxranklimit= 100;

function OnLoad ()
{
	RegisterEvent(350);
	RegisterEvent(360);
	RegisterEvent(370);
	RegisterEvent(380);
	RegisterEvent(430);
	RegisterEvent(460);
	RegisterEvent(490);
	RegisterEvent(500);
	RegisterEvent(160);
	RegisterEvent(470);
	L2jBRFunction2();
	InitializeGradeComboBox();
	HideAll();
	m_clanWarListPage = -1;
}

function L2jBRFunction2 ()
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,8) )
	{
		Clan3_OrgIcon[i] = GetHandle(UnknownFunction112("ClanDrawerWnd.Clan3_OrgIcon",string(UnknownFunction146(i,1))));
		UnknownFunction163(i);
		goto JL0007;
	}
}

function OnShow ()
{
	local ClanWnd L2jBRVar21;

	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
	Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
	Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
	Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
	Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
	if ( UnknownFunction154(L2jBRVar21.m_bClanMaster,0) )
	{
		if ( UnknownFunction154(L2jBRVar21.m_bNickName,0) )
		{
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
		}
		if ( UnknownFunction154(L2jBRVar21.m_bGrade,0) )
		{
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
		}
		if ( UnknownFunction154(L2jBRVar21.m_bManageMaster,0) )
		{
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
		}
		if ( UnknownFunction154(L2jBRVar21.m_bOustMember,0) )
		{
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
		}
	}
}

function Clear ()
{
	m_state = "";
	m_clanType = -1;
	m_clanWarListPage = -1;
	m_currentEditGradeID = -1;
	m_currentName = "";
}

function SetStateAndShow (string State)
{
	local ClanWnd L2jBRVar21;
	local int i;
	local string string1;
	local string string2;
	local string string3;
	local string string4;

	m_state = State;
	if ( UnknownFunction129(Class'UIAPI_WINDOW'.IsShowWindow("ClanDrawerWnd")) )
	{
		Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd");
	}
	HideAll();
	if ( UnknownFunction122(m_state,"ClanMemberInfoState") )
	{
		Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.ClanMemberInfoWnd");
		Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
		Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
		Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
		Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
	} else {
		if ( UnknownFunction122(m_state,"ClanMemberAuthState") )
		{
			Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.ClanMemberAuthWnd");
			i = 0;
			if ( UnknownFunction152(i,9) )
			{
				Class'UIAPI_CHECKBOX'.SetDisable(UnknownFunction112("ClanDrawerWnd.Clan2_Check10",string(i)),True);
				UnknownFunction163(i);
				goto JL01E5;
			}
			i = 0;
			if ( UnknownFunction152(i,5) )
			{
				Class'UIAPI_CHECKBOX'.SetDisable(UnknownFunction112("ClanDrawerWnd.Clan2_Check20",string(i)),True);
				UnknownFunction163(i);
				goto JL0238;
			}
			i = 0;
			if ( UnknownFunction152(i,8) )
			{
				Class'UIAPI_CHECKBOX'.SetDisable(UnknownFunction112("ClanDrawerWnd.Clan2_Check30",string(i)),True);
				UnknownFunction163(i);
				goto JL028B;
			}
		} else {
			if ( UnknownFunction122(m_state,"ClanInfoState") )
			{
				Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.ClanInfoWnd");
				InitializeClanInfoWnd();
			} else {
				if ( UnknownFunction122(m_state,"ClanAuthManageWndState") )
				{
					Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.ClanAuthManageWnd");
				} else {
					if ( UnknownFunction122(m_state,"ClanEmblemManageWndState") )
					{
						Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.ClanEmblemManageWnd");
						string1 = UnknownFunction128(GetSystemMessage(211),23);
						string2 = UnknownFunction234(GetSystemMessage(211),UnknownFunction147(UnknownFunction125(GetSystemMessage(211)),23));
						string3 = UnknownFunction128(GetSystemMessage(1478),23);
						string4 = UnknownFunction234(GetSystemMessage(1478),UnknownFunction147(UnknownFunction125(GetSystemMessage(1478)),23));
						Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan7_ManageEmb1Text1",string1);
						Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan7_ManageEmb1Text2",string2);
						Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan7_ManageEmb2Text1",string3);
						Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan7_ManageEmb2Text2",string4);
						L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
					} else {
						if ( UnknownFunction122(m_state,"ClanWarManagementWndState") )
						{
							Class'UIAPI_TABCTRL'.SetTopOrder("ClanDrawerWnd.ClanWarTabCtrl",0,True);
							Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.ClanWarManagementWnd");
						} else {
							if ( UnknownFunction122(m_state,"ClanAuthEditWndState") )
							{
								Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.ClanAuthEditWnd");
							} else {
								if ( UnknownFunction122(m_state,"ClanHeroWndState") )
								{
									Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.ClanHeroWnd");
								}
							}
						}
					}
				}
			}
		}
	}
}

function HideAll ()
{
	Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.ClanMemberInfoWnd");
	Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.ClanMemberAuthWnd");
	Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.ClanInfoWnd");
	Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.ClanPenaltyWnd");
	Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.ClanWarManagementWnd");
	Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.ClanAuthManageWnd");
	Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.ClanAuthEditWnd");
	Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.ClanEmblemManageWnd");
	Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.ClanHeroWnd");
}

function OnClickButton (string strID)
{
	local LVDataRecord Record;
	local int i;
	local ClanWnd L2jBRVar21;

	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	if ( UnknownFunction122(strID,"Clan1_AskJoinPartyBtn") )
	{
		RequestInviteParty(Class'UIAPI_TEXTBOX'.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"));
	} else {
		if ( UnknownFunction122(strID,"Clan1_ChangeMemberNameBtn") )
		{
			Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
			Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
			Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
			Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
			Class'UIAPI_EDITBOX'.SetString("ClanDrawerWnd.Clan1_ChangeNameTextEditbox","");
		} else {
			if ( UnknownFunction122(strID,"Clan1_ChangeMemberGradeBtn") )
			{
				Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
				Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
				Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
				Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
			} else {
				if ( UnknownFunction122(strID,"Clan1_ChangeBanishBtn") )
				{
					Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
					Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
					Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
					HideWindow();
					RequestClanExpelMember(m_clanType,Class'UIAPI_TEXTBOX'.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"));
				} else {
					if ( UnknownFunction122(strID,"Clan1_AssignApprenticeBtn") )
					{
						Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
						Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
						Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
						Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
						InitializeAcademyList();
					} else {
						if ( UnknownFunction122(strID,"Clan1_ChangeMemberKHOpen") )
						{
							Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
							Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
							Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
							Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
							KnighthoodCombobox();
						} else {
							if ( UnknownFunction122(strID,"Clan1_DeleteApprenticeBtn") )
							{
								RequestClanDeletePupil(Class'UIAPI_TEXTBOX'.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"),Class'UIAPI_TEXTBOX'.GetText("ClanDrawerWnd.Clan1_CurrentSelectedApprentice"));
								RecallCurrentMemberInfo();
							} else {
								if ( UnknownFunction122(strID,"Clan1_OKBtn") )
								{
									HideWindow();
								} else {
									if ( UnknownFunction122(strID,"Clan1_ChangeNameAssignBtn") )
									{
										RequestClanChangeNickName(Class'UIAPI_TEXTBOX'.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"),Class'UIAPI_EDITBOX'.GetString("ClanDrawerWnd.Clan1_ChangeNameTextEditbox"));
										Class'UIAPI_EDITBOX'.SetString("ClanDrawerWnd.Clan1_ChangeNameTextEditbox","");
										Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
										RecallCurrentMemberInfo();
									} else {
										if ( UnknownFunction122(strID,"Clan1_ChangeNameDeleteBtn") )
										{
											RequestClanChangeNickName(Class'UIAPI_TEXTBOX'.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"),"");
											Class'UIAPI_EDITBOX'.SetString("ClanDrawerWnd.Clan1_ChangeNameTextEditbox","");
											Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
											RecallCurrentMemberInfo();
										} else {
											if ( UnknownFunction122(strID,"Clan1_ChangeMemberGradeAssignBtn") )
											{
												Debug("Clan1_ChangeMemberGradeAssignBtn");
												if ( UnknownFunction150(Class'UIAPI_COMBOBOX'.GetSelectedNum("ClanDrawerWnd.Clan1_MemberGradeList"),5) )
												{
													Debug("지정된 그레이드를 세팅함");
													RequestClanChangeGrade(Class'UIAPI_TEXTBOX'.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"),UnknownFunction146(Class'UIAPI_COMBOBOX'.GetSelectedNum("ClanDrawerWnd.Clan1_MemberGradeList"),1));
												} else {
													Debug("현재 등급을 찾아서 세팅하도록");
													Debug(UnknownFunction168("현재 설정된 클랜 고유번호:",string(m_clanType)));
													RequestClanChangeGrade(Class'UIAPI_TEXTBOX'.GetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName"),getCurrentGradebyClanType());
												}
												Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
												RecallCurrentMemberInfo();
											} else {
												if ( UnknownFunction122(strID,"Clan1_ApprenticeAssignBtn") )
												{
													i = Class'UIAPI_LISTCTRL'.GetSelectedIndex("ClanDrawerWnd.Clan1_AssignApprenticeList");
													if ( UnknownFunction130(UnknownFunction153(i,0),UnknownFunction123(m_currentName,"")) )
													{
														Record = Class'UIAPI_LISTCTRL'.GetRecord("ClanDrawerWnd.Clan1_AssignApprenticeList",i);
														RequestClanAssignPupil(m_currentName,Record.LVDataList[0].szData);
													}
													Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
												} else {
													if ( UnknownFunction122(strID,"Clan1_ChangeMemberKnightHoodBtn") )
													{
														proc_swapmember();
														Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
													} else {
														if ( UnknownFunction122(strID,"Clan1_Cancel1") )
														{
															Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberNameWnd");
														} else {
															if ( UnknownFunction122(strID,"Clan1_Cancel2") )
															{
																Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeNameWnd");
															} else {
																if ( UnknownFunction122(strID,"Clan1_Cancel3") )
																{
																	Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
																} else {
																	if ( UnknownFunction122(strID,"Clan1_Cancel4") )
																	{
																		Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodWnd");
																	} else {
																		if ( UnknownFunction122(strID,"Clan7_RegEmbBtn") )
																		{
																			RequestClanRegisterCrest();
																		} else {
																			if ( UnknownFunction122(strID,"Clan7_RmEmbBtn") )
																			{
																				RequestClanUnregisterCrest();
																			} else {
																				if ( UnknownFunction122(strID,"Clan7_RegEmb2Btn") )
																				{
																					RequestClanRegisterEmblem();
																				} else {
																					if ( UnknownFunction122(strID,"Clan7_RmEmb2Btn") )
																					{
																						RequestClanUnregisterEmblem();
																					} else {
																						if ( UnknownFunction122(strID,"Clan8_CancelWar1Btn") )
																						{
																							HandleCancelWar1();
																						} else {
																							if ( UnknownFunction122(strID,"Clan8_DeclareWar1Btn") )
																							{
																								HandleDeclareWar();
																							} else {
																								if ( UnknownFunction122(strID,"Clan8_CancelWar2Btn") )
																								{
																									HandleCancelWar2();
																								} else {
																									if ( UnknownFunction122(strID,"Clan8_ViewMoreBtn") )
																									{
																										RequestClanWarList(UnknownFunction163(m_clanWarListPage),1);
																									} else {
																										if ( UnknownFunction122(strID,"Clan2_OKBtn") )
																										{
																											HideWindow();
																										} else {
																											if ( UnknownFunction122(strID,"Clan3_OKBtn") )
																											{
																												HideWindow();
																											} else {
																												if ( UnknownFunction122(strID,"Clan4_OKBtn") )
																												{
																													HideWindow();
																												} else {
																													if ( UnknownFunction122(strID,"Clan5_OKBtn") )
																													{
																														HideWindow();
																													} else {
																														if ( UnknownFunction122(strID,"Clan7_OKBtn") )
																														{
																															HideWindow();
																														} else {
																															if ( UnknownFunction122(strID,"ClanWar_OKBtn") )
																															{
																																HideWindow();
																															} else {
																																if ( UnknownFunction122(strID,"Clan5_ManageBtn") )
																																{
																																	EditAuthGrade();
																																} else {
																																	if ( UnknownFunction122(strID,"Clan5_ManageBtn2") )
																																	{
																																		EditAuthGrade2();
																																	} else {
																																		if ( UnknownFunction122(strID,"Clan6_ApplyBtn") )
																																		{
																																			ApplyEditGrade();
																																			SetStateAndShow("ClanAuthManageWndState");
																																		} else {
																																			if ( UnknownFunction122(strID,"Clan6_CancelBtn") )
																																			{
																																				SetStateAndShow("ClanAuthManageWndState");
																																			} else {
																																				if ( UnknownFunction122(strID,"ClanWarTabCtrl0") )
																																				{
																																					RequestClanWarList(0,0);
																																				} else {
																																					if ( UnknownFunction122(strID,"ClanWarTabCtrl1") )
																																					{
																																						RequestClanWarList(m_clanWarListPage,1);
																																					} else {
																																						if ( UnknownFunction122(strID,"Clan1_ChangeNameAssignNobBtn") )
																																						{
																																							RequestClanChangeNickName(L2jBRVar21.m_myName,Class'UIAPI_EDITBOX'.GetString("ClanDrawerWnd.Clan1_ChangeNobNameTextEditbox"));
																																							Class'UIAPI_EDITBOX'.SetString("ClanDrawerWnd.Clan1_ChangeNobNameTextEditbox","");
																																						} else {
																																							if ( UnknownFunction122(strID,"Clan1_NobCancel1") )
																																							{
																																								HideWindow();
																																							} else {
																																								if ( UnknownFunction122(strID,"Clan1_ChangeNameDeleteNobBtn") )
																																								{
																																									RequestClanChangeNickName(L2jBRVar21.m_myName,"");
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

function OnDBClickListCtrlRecord (string ListCtrlID)
{
	local int i;
	local LVDataRecord Record;

	if ( UnknownFunction122(ListCtrlID,"Clan5_AuthListCtrl") )
	{
		EditAuthGrade();
	}
	if ( UnknownFunction122(ListCtrlID,"Clan5_AuthListCtrl2") )
	{
		EditAuthGrade2();
	}
	if ( UnknownFunction122(ListCtrlID,"Clan1_AssignApprenticeList") )
	{
		i = Class'UIAPI_LISTCTRL'.GetSelectedIndex("ClanDrawerWnd.Clan1_AssignApprenticeList");
		if ( UnknownFunction130(UnknownFunction153(i,0),UnknownFunction123(m_currentName,"")) )
		{
			Record = Class'UIAPI_LISTCTRL'.GetRecord("ClanDrawerWnd.Clan1_AssignApprenticeList",i);
			RequestClanAssignPupil(m_currentName,Record.LVDataList[0].szData);
		}
		Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd.Clan1_AssignApprenticeWnd");
	}
}

function RecallCurrentMemberInfo ()
{
	local ClanWnd L2jBRVar21;

	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	RequestClanMemberInfo(L2jBRVar21.G_CurrentRecord,L2jBRVar21.G_CurrentSzData);
	SetStateAndShow("ClanMemberInfoState");
}

function OnClickCheckBox (string CheckBoxID)
{
	local string CheckboxNum;
	local string CheckboxName;
	local bool CheckedStat;
	local int i;

	CheckboxName = UnknownFunction128(CheckBoxID,12);
	if ( UnknownFunction122(CheckboxName,"Clan6_Check1") )
	{
		CheckboxNum = UnknownFunction234(CheckBoxID,2);
		if ( UnknownFunction122(CheckboxNum,"00") )
		{
			CheckedStat = Class'UIAPI_CHECKBOX'.IsChecked("ClanDrawerWnd.Clan6_Check100");
			switch (CheckedStat)
			{
				case True:
				i = 0;
				if ( UnknownFunction152(i,9) )
				{
					Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan6_Check10",string(i)),True);
					UnknownFunction163(i);
					goto JL008B;
				}
				break;
				case False:
				i = 0;
				if ( UnknownFunction152(i,9) )
				{
					Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan6_Check10",string(i)),False);
					UnknownFunction163(i);
					goto JL00E5;
				}
				break;
				default:
			}
		} else {
			if ( UnknownFunction242(count_all_check("10",9),True) )
			{
				Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan6_Check100",True);
			} else {
				Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan6_Check100",False);
			}
		}
	}
	if ( UnknownFunction122(CheckboxName,"Clan6_Check2") )
	{
		CheckboxNum = UnknownFunction234(CheckBoxID,2);
		if ( UnknownFunction122(CheckboxNum,"00") )
		{
			CheckedStat = Class'UIAPI_CHECKBOX'.IsChecked("ClanDrawerWnd.Clan6_Check200");
			switch (CheckedStat)
			{
				case True:
				i = 0;
				if ( UnknownFunction152(i,5) )
				{
					Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan6_Check20",string(i)),True);
					UnknownFunction163(i);
JL0227:
					goto JL0227;
				}
				break;
				case False:
				i = 0;
				if ( UnknownFunction152(i,5) )
				{
					Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan6_Check20",string(i)),False);
					UnknownFunction163(i);
					goto JL0281;
				}
				break;
				default:
			}
		} else {
			if ( UnknownFunction242(count_all_check("20",8),True) )
			{
				Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan6_Check200",True);
			} else {
				Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan6_Check200",False);
			}
		}
	}
	if ( UnknownFunction122(CheckboxName,"Clan6_Check3") )
	{
		CheckboxNum = UnknownFunction234(CheckBoxID,2);
		if ( UnknownFunction122(CheckboxNum,"00") )
		{
			CheckedStat = Class'UIAPI_CHECKBOX'.IsChecked("ClanDrawerWnd.Clan6_Check300");
			switch (CheckedStat)
			{
				case True:
				i = 0;
				if ( UnknownFunction152(i,9) )
				{
					Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan6_Check30",string(i)),True);
					UnknownFunction163(i);
					goto JL03C3;
				}
				break;
				case False:
				i = 0;
				if ( UnknownFunction152(i,9) )
				{
					Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan6_Check30",string(i)),False);
					UnknownFunction163(i);
					goto JL041D;
				}
				break;
				default:
			}
		} else {
			if ( UnknownFunction242(count_all_check("30",9),True) )
			{
				Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan6_Check300",True);
			} else {
				Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan6_Check300",False);
			}
		}
	}
}

function bool count_all_check (string numString, int TotalNum)
{
	local bool checkall;
	local bool currentcheck;
	local int i;

	checkall = False;
	i = 1;
	if ( UnknownFunction152(i,TotalNum) )
	{
		currentcheck = Class'UIAPI_CHECKBOX'.IsChecked(UnknownFunction112(UnknownFunction112("ClanDrawerWnd.Clan6_Check",numString),string(i)));
		if ( UnknownFunction242(currentcheck,True) )
		{
			checkall = True;
		}
		UnknownFunction163(i);
		goto JL000F;
	}
	return checkall;
}

function bool count_all_check2 (string numString, int TotalNum)
{
	local bool checkall;
	local bool currentcheck;
	local int i;

	checkall = False;
	i = 1;
	if ( UnknownFunction152(i,TotalNum) )
	{
		currentcheck = Class'UIAPI_CHECKBOX'.IsChecked(UnknownFunction112(UnknownFunction112("ClanDrawerWnd.Clan2_Check",numString),string(i)));
		if ( UnknownFunction242(currentcheck,True) )
		{
			checkall = True;
		}
		UnknownFunction163(i);
		goto JL000F;
	}
	return checkall;
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	Debug(UnknownFunction168("Igotthisevent:",string(L2jBRVar16)));
	switch (L2jBRVar16)
	{
		case 350:
		HandleClanAuthGradeList(_L2jBRVar17_);
		break;
		case 460:
		HandleClanWarList(_L2jBRVar17_);
		break;
		case 360:
		HandleCrestChange(_L2jBRVar17_);
		case 430:
		HandleClanMemberInfo(_L2jBRVar17_);
		break;
		case 490:
		L2jBRFunction68(_L2jBRVar17_);
		break;
		case 500:
		HandleSkillListAdd(_L2jBRVar17_);
		break;
		case 370:
		HandleClanAuth(_L2jBRVar17_);
		break;
		case 380:
		HandleClanAuthMember(_L2jBRVar17_);
		break;
		case 160:
		Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd");
		break;
		case 470:
		HandleClearWarList(_L2jBRVar17_);
		break;
		default:
		break;
	}
}

function HandleClanAuthGradeList (string _L2jBRVar17_)
{
	local int L2jBRVar15_;
	local int Id;
	local int members;
	local int i;
	local LVDataRecord Record;
	local LVData Data;

	Record.LVDataList.Length = 2;
	Class'UIAPI_LISTCTRL'.DeleteAllItem("ClanDrawerWnd.Clan5_AuthListCtrl");
	Class'UIAPI_LISTCTRL'.DeleteAllItem("ClanDrawerWnd.Clan5_AuthListCtrl2");
	ParseInt(_L2jBRVar17_,"Count",L2jBRVar15_);
	i = 0;
	if ( UnknownFunction150(i,5) )
	{
		ParseInt(_L2jBRVar17_,UnknownFunction112("GradeID",string(i)),Id);
		ParseInt(_L2jBRVar17_,UnknownFunction112("GradeMemberCount",string(i)),members);
		Data.szData = GetStringByGradeID(Id);
		Record.LVDataList[0] = Data;
		Data.szData = string(members);
		Record.LVDataList[1] = Data;
		Record.nReserved1 = Id;
		Class'UIAPI_LISTCTRL'.InsertRecord("ClanDrawerWnd.Clan5_AuthListCtrl",Record);
		UnknownFunction163(i);
		goto JL008F;
	}
	i = 5;
	if ( UnknownFunction150(i,9) )
	{
		ParseInt(_L2jBRVar17_,UnknownFunction112("GradeID",string(i)),Id);
		ParseInt(_L2jBRVar17_,UnknownFunction112("GradeMemberCount",string(i)),members);
JL018C:
		Data.szData = GetStringByGradeID(Id);
		Record.LVDataList[0] = Data;
		Data.szData = string(members);
		Record.LVDataList[1] = Data;
		Record.nReserved1 = Id;
		Class'UIAPI_LISTCTRL'.InsertRecord("ClanDrawerWnd.Clan5_AuthListCtrl2",Record);
		UnknownFunction163(i);
		goto JL018C;
	}
	Class'UIAPI_LISTCTRL'.SetSelectedIndex("ClanDrawerWnd.Clan5_AuthListCtrl",0,True);
	Class'UIAPI_LISTCTRL'.SetSelectedIndex("ClanDrawerWnd.Clan5_AuthListCtrl2",0,True);
}

function HandleClanWarList (string _L2jBRVar17_)
{
	local string sClanName;
	local int L2jBRVar5;
	local int period;
	local LVDataRecord Record;
	local int page;

	ParseInt(_L2jBRVar17_,"Page",page);
	ParseString(_L2jBRVar17_,"ClanName",sClanName);
	ParseInt(_L2jBRVar17_,"Type",L2jBRVar5);
	ParseInt(_L2jBRVar17_,"Period",period);
	Record.LVDataList.Length = 3;
	Record.LVDataList[0].szData = sClanName;
	Record.LVDataList[1].szData = GetWarStateString(L2jBRVar5);
	Record.LVDataList[2].szData = string(period);
	if ( UnknownFunction132(UnknownFunction154(L2jBRVar5,0),UnknownFunction154(L2jBRVar5,2)) )
	{
		Class'UIAPI_TABCTRL'.SetTopOrder("ClanDrawerWnd.ClanWarTabCtrl",0,True);
		Class'UIAPI_LISTCTRL'.InsertRecord("ClanDrawerWnd.Clan8_DeclaredListCtrl",Record);
	} else {
		Class'UIAPI_TABCTRL'.SetTopOrder("ClanDrawerWnd.ClanWarTabCtrl",1,True);
		m_clanWarListPage = page;
		Class'UIAPI_LISTCTRL'.InsertRecord("ClanDrawerWnd.Clan8_GotDeclaredListCtrl",Record);
	}
}

function HandleClanMemberInfo (string _L2jBRVar17_)
{
	local string nickName;
	local int gradeID;
	local string organization;
	local string MasterName;
	local ClanWnd L2jBRVar21;
	local string organizationtext;

	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	ParseInt(_L2jBRVar17_,"ClanType",m_clanType);
	ParseString(_L2jBRVar17_,"Name",m_currentName);
	ParseString(_L2jBRVar17_,"NickName",nickName);
	ParseInt(_L2jBRVar17_,"GradeID",gradeID);
	ParseString(_L2jBRVar17_,"OrderName",organization);
	ParseString(_L2jBRVar17_,"MasterName",MasterName);
	currentMasterName = MasterName;
	if ( UnknownFunction122(MasterName,"") )
	{
		MasterName = GetSystemString(27);
	}
	organizationtext = UnknownFunction168(UnknownFunction168(getClanOrderString(m_clanType),"-"),organization);
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberName",m_currentName);
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberSName",nickName);
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberGrade",GetStringByGradeID(gradeID));
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberOrderName",organizationtext);
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan1_CurrentSelectedApprentice",MasterName);
	if ( UnknownFunction122(L2jBRVar21.m_CurrentclanMasterReal,m_currentName) )
	{
		if ( UnknownFunction154(L2jBRVar21.m_currentShowIndex,0) )
		{
			Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberGrade",GetSystemString(342));
		}
	}
	if ( UnknownFunction154(m_clanType,-1) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
		Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan1_CurrentSelectedApprenticeTitle",GetSystemString(1332));
	} else {
		Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
		Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
		if ( UnknownFunction123(currentMasterName,"") )
		{
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
			Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
		} else {
			Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
		}
		Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan1_CurrentSelectedApprenticeTitle",GetSystemString(1431));
	}
	L2jBRVar21.resetBtnShowHide();
	CheckandCompareMyNameandDisableThings();
}

function CheckandCompareMyNameandDisableThings ()
{
	local ClanWnd L2jBRVar21;
	local UserInfo UserInfo;

	GetPlayerInfo(UserInfo);
	m_myName = UserInfo.Name;
	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	if ( UnknownFunction151(L2jBRVar21.m_bClanMaster,0) )
	{
		Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
		Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberKHOpen");
		if ( UnknownFunction123(currentMasterName,"") )
		{
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
			Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
			if ( UnknownFunction242(L2jBRVar21.G_CurrentAlias,True) )
			{
				Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
			}
		} else {
			Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
		}
	} else {
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberKHOpen");
		Proc_AuthValidation();
		if ( UnknownFunction150(L2jBRVar21.GetClanTypeFromIndex(L2jBRVar21.m_currentShowIndex),L2jBRVar21.m_myClanType) )
		{
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
			if ( UnknownFunction154(m_clanType,-1) )
			{
				goto JL03F4;
			}
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
		}
		if ( UnknownFunction151(L2jBRVar21.m_myClanType,1) )
		{
			if ( UnknownFunction155(L2jBRVar21.GetClanTypeFromIndex(L2jBRVar21.m_currentShowIndex),0) )
			{
				if ( UnknownFunction154(UnknownFunction147(L2jBRVar21.m_myClanType,L2jBRVar21.GetClanTypeFromIndex(L2jBRVar21.m_currentShowIndex)),1) )
				{
					Proc_AuthValidation();
				}
				if ( UnknownFunction154(UnknownFunction147(L2jBRVar21.m_myClanType,L2jBRVar21.GetClanTypeFromIndex(L2jBRVar21.m_currentShowIndex)),1000) )
				{
					Proc_AuthValidation();
				}
				if ( UnknownFunction154(UnknownFunction147(L2jBRVar21.m_myClanType,L2jBRVar21.GetClanTypeFromIndex(L2jBRVar21.m_currentShowIndex)),100) )
				{
					Proc_AuthValidation();
				}
				if ( UnknownFunction154(UnknownFunction147(L2jBRVar21.m_myClanType,L2jBRVar21.GetClanTypeFromIndex(L2jBRVar21.m_currentShowIndex)),999) )
				{
					Proc_AuthValidation();
				}
				if ( UnknownFunction154(UnknownFunction147(L2jBRVar21.m_myClanType,L2jBRVar21.GetClanTypeFromIndex(L2jBRVar21.m_currentShowIndex)),1001) )
				{
					Proc_AuthValidation();
				}
			}
		}
		if ( UnknownFunction242(L2jBRVar21.G_CurrentAlias,True) )
		{
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberKHOpen");
		}
		if ( UnknownFunction122(L2jBRVar21.m_CurrentclanMasterReal,m_currentName) )
		{
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberKHOpen");
		}
	}
	if ( UnknownFunction122(m_currentName,m_myName) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberKHOpen");
	}
	if ( UnknownFunction154(m_clanType,-1) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
	}
}

function Proc_AuthValidation ()
{
	local ClanWnd L2jBRVar21;

	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	if ( UnknownFunction154(L2jBRVar21.m_bNickName,0) )
	{
		if ( UnknownFunction132(UnknownFunction242(L2jBRVar21.G_IamHero,True),UnknownFunction242(L2jBRVar21.G_IamNobless,True)) )
		{
			Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
		} else {
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
		}
	} else {
		Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberNameBtn");
	}
	if ( UnknownFunction154(L2jBRVar21.m_bGrade,0) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
	} else {
		Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberGradeBtn");
	}
	if ( UnknownFunction154(L2jBRVar21.m_bManageMaster,0) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
	} else {
		if ( UnknownFunction123(currentMasterName,"") )
		{
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
			Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
		} else {
			Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_AssignApprenticeBtn");
			Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_DeleteApprenticeBtn");
		}
	}
	if ( UnknownFunction154(L2jBRVar21.m_bOustMember,0) )
	{
		Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
	} else {
		Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeBanishBtn");
	}
}

function HandleCrestChange (string L2jBRVar1)
{
	local ClanWnd L2jBRVar21;

	if ( UnknownFunction122(m_state,"ClanEmblemManageWndState") )
	{
		L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
		Class'UIAPI_TEXTURECTRL'.SetTextureWithClanCrest("ClanDrawerWnd.ClanCrestTextureCtrl",L2jBRVar21.m_clanID);
	}
}

function L2jBRFunction68 (string _L2jBRVar17_)
{
	local int L2jBRVar15_;
	local int i;
	local int Id;
	local int Level;

	ParseInt(_L2jBRVar17_,"Count",L2jBRVar15_);
	Class'UIAPI_ITEMWINDOW'.Clear("ClanDrawerWnd.ClanSkillWnd");
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar15_) )
	{
		ParseInt(_L2jBRVar17_,UnknownFunction112("SkillID",string(i)),Id);
		ParseInt(_L2jBRVar17_,UnknownFunction112("SkillLevel",string(i)),Level);
		AddSkill(Id,Level);
		UnknownFunction163(i);
		goto JL0049;
	}
}

function HandleSkillListAdd (string _L2jBRVar17_)
{
	local int Id;
	local int Level;
	local int i;
	local int L2jBRVar15_;
	local ItemInfo Info;

	ParseInt(_L2jBRVar17_,"SkillID",Id);
	ParseInt(_L2jBRVar17_,"SkillLevel",Level);
	L2jBRVar15_ = Class'UIAPI_ITEMWINDOW'.GetItemNum("ClanDrawerWnd.ClanSkillWnd");
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar15_) )
	{
		Class'UIAPI_ITEMWINDOW'.GetItem("ClanDrawerWnd.ClanSkillWnd",i,Info);
		if ( UnknownFunction154(Info.ClassID,Id) )
		{
			goto JL00D2;
		}
		UnknownFunction163(i);
		goto JL006D;
	}
	if ( UnknownFunction150(i,L2jBRVar15_) )
	{
		ReplaceSkill(i,Id,Level);
	} else {
		AddSkill(Id,Level);
	}
}

function HandleCancelWar1 ()
{
	local LVDataRecord Record;
	local int Index;

	Index = Class'UIAPI_LISTCTRL'.GetSelectedIndex("ClanDrawerWnd.Clan8_DeclaredListCtrl");
	if ( UnknownFunction153(Index,0) )
	{
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ClanDrawerWnd.Clan8_DeclaredListCtrl",Index);
		RequestClanWithdrawWarWithClanName(Record.LVDataList[0].szData);
		RequestClanWarList(0,0);
		SetStateAndShow("ClanWarManagementWndState");
	}
}

function HandleDeclareWar ()
{
	local LVDataRecord Record;
	local int Index;

	Index = Class'UIAPI_LISTCTRL'.GetSelectedIndex("ClanDrawerWnd.Clan8_GotDeclaredListCtrl");
	if ( UnknownFunction153(Index,0) )
	{
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ClanDrawerWnd.Clan8_GotDeclaredListCtrl",Index);
		RequestClanDeclareWarWidhClanName(Record.LVDataList[0].szData);
		RequestClanWarList(m_clanWarListPage,1);
	}
}

function HandleCancelWar2 ()
{
	local LVDataRecord Record;
	local int Index;

	Index = Class'UIAPI_LISTCTRL'.GetSelectedIndex("ClanDrawerWnd.Clan8_GotDeclaredListCtrl");
	if ( UnknownFunction153(Index,0) )
	{
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ClanDrawerWnd.Clan8_GotDeclaredListCtrl",Index);
		RequestClanWithdrawWarWithClanName(Record.LVDataList[0].szData);
		RequestClanWarList(m_clanWarListPage,1);
		Class'UIAPI_TABCTRL'.SetTopOrder("ClanDrawerWnd.ClanWarTabCtrl",1,True);
		Class'UIAPI_WINDOW'.ShowWindow("ClanDrawerWnd.ClanWarManagementWnd");
	}
}

function HandleClanAuth (string _L2jBRVar17_)
{
	local int gradeID;
	local int Command;
	local array<int> powers;
	local int i;
	local int Index;

	ParseInt(_L2jBRVar17_,"GradeID",gradeID);
	ParseInt(_L2jBRVar17_,"Command",Command);
	powers.Length = 32;
	i = 0;
	if ( UnknownFunction150(i,32) )
	{
		ParseInt(_L2jBRVar17_,UnknownFunction112("PowerValue",string(i)),powers[i]);
		UnknownFunction163(i);
		goto JL0042;
	}
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan6_CurrentSelectedRankName",UnknownFunction112(GetStringByGradeID(gradeID),GetSystemString(1376)));
	Index = 1;
	i = 1;
	if ( UnknownFunction152(i,9) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan6_Check10",string(i)),bool(powers[UnknownFunction165(Index)]));
		UnknownFunction163(i);
		goto JL00E5;
	}
	i = 1;
	if ( UnknownFunction152(i,5) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan6_Check20",string(i)),bool(powers[UnknownFunction165(Index)]));
		UnknownFunction163(i);
		goto JL0146;
	}
	i = 1;
	if ( UnknownFunction152(i,8) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan6_Check30",string(i)),bool(powers[UnknownFunction165(Index)]));
		UnknownFunction163(i);
		goto JL01A7;
	}
	if ( UnknownFunction242(count_all_check("10",9),True) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan6_Check100",True);
	} else {
		Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan6_Check100",False);
	}
	if ( UnknownFunction242(count_all_check("20",5),True) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan6_Check200",True);
	} else {
		Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan6_Check200",False);
	}
	if ( UnknownFunction242(count_all_check("30",8),True) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan6_Check300",True);
	} else {
		Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan6_Check300",False);
	}
	if ( UnknownFunction154(gradeID,9) )
	{
		disableAcademyAuth();
	} else {
		resetAcademyAuth();
	}
}

function HandleClanAuthMember (string _L2jBRVar17_)
{
	local ClanWnd L2jBRVar21;
	local int gradeID;
	local string sName;
	local array<int> powers;
	local int i;
	local int Index;

	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	ParseInt(_L2jBRVar17_,"Grade",gradeID);
	ParseString(_L2jBRVar17_,"Name",sName);
	powers.Length = 32;
	i = 0;
	if ( UnknownFunction150(i,32) )
	{
		ParseInt(_L2jBRVar17_,UnknownFunction112("PowerValue",string(i)),powers[i]);
		UnknownFunction163(i);
		goto JL0057;
	}
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan2_CurrentSelectedMemberName",UnknownFunction168(UnknownFunction168(sName,"-"),GetStringByGradeID(gradeID)));
	Index = 1;
	i = 1;
	if ( UnknownFunction152(i,9) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan2_Check10",string(i)),bool(powers[UnknownFunction165(Index)]));
		UnknownFunction163(i);
		goto JL00FB;
	}
	i = 1;
	if ( UnknownFunction152(i,5) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan2_Check20",string(i)),bool(powers[UnknownFunction165(Index)]));
		UnknownFunction163(i);
		goto JL015C;
	}
	i = 1;
	if ( UnknownFunction152(i,8) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan2_Check30",string(i)),bool(powers[UnknownFunction165(Index)]));
		UnknownFunction163(i);
		goto JL01BD;
	}
	if ( UnknownFunction242(count_all_check2("10",9),True) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan2_Check100",True);
	} else {
		Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan2_Check100",False);
	}
	if ( UnknownFunction242(count_all_check2("20",5),True) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan2_Check200",True);
	} else {
		Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan2_Check200",False);
	}
	if ( UnknownFunction242(count_all_check2("30",8),True) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan2_Check300",True);
	} else {
		Class'UIAPI_CHECKBOX'.SetCheck("ClanDrawerWnd.Clan2_Check300",False);
	}
	if ( UnknownFunction122(L2jBRVar21.m_myName,sName) )
	{
		if ( UnknownFunction242(Class'UIAPI_CHECKBOX'.IsChecked("ClanDrawerWnd.Clan2_Check101"),True) )
		{
			L2jBRVar21.m_bJoin = 1;
		} else {
			L2jBRVar21.m_bJoin = 0;
		}
		if ( UnknownFunction242(Class'UIAPI_CHECKBOX'.IsChecked("ClanDrawerWnd.Clan2_Check107"),True) )
		{
			L2jBRVar21.m_bCrest = 1;
		} else {
			L2jBRVar21.m_bCrest = 0;
		}
		if ( UnknownFunction242(Class'UIAPI_CHECKBOX'.IsChecked("ClanDrawerWnd.Clan2_Check105"),True) )
		{
			L2jBRVar21.m_bWar = 1;
		} else {
			L2jBRVar21.m_bWar = 0;
		}
		L2jBRVar21.resetBtnShowHide();
	}
	if ( UnknownFunction122(L2jBRVar21.m_CurrentclanMasterReal,sName) )
	{
		Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan2_CurrentSelectedMemberName",UnknownFunction168(UnknownFunction168(sName,"-"),GetSystemString(342)));
		i = 0;
		if ( UnknownFunction152(i,9) )
		{
			Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan2_Check10",string(i)),True);
			UnknownFunction163(i);
			goto JL0507;
		}
		i = 0;
		if ( UnknownFunction152(i,5) )
		{
			Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan2_Check20",string(i)),True);
			UnknownFunction163(i);
			goto JL055A;
		}
		i = 0;
		if ( UnknownFunction152(i,8) )
		{
			Class'UIAPI_CHECKBOX'.SetCheck(UnknownFunction112("ClanDrawerWnd.Clan2_Check30",string(i)),True);
			UnknownFunction163(i);
JL0507:
			goto JL05AD;
		}
	}
}

function HandleClearWarList (string _L2jBRVar17_)
{
	local int Condition;

	if ( ParseInt(_L2jBRVar17_,"Condition",Condition) )
	{
		if ( UnknownFunction154(Condition,0) )
		{
			Class'UIAPI_LISTCTRL'.DeleteAllItem("ClanDrawerWnd.Clan8_DeclaredListCtrl");
		} else {
			Class'UIAPI_LISTCTRL'.DeleteAllItem("ClanDrawerWnd.Clan8_GotDeclaredListCtrl");
		}
	}
}

function string GetStringByGradeID (int gradeID)
{
	local int stringIndex;

	stringIndex = -1;
	Debug(UnknownFunction168("gradeID",string(gradeID)));
	if ( UnknownFunction154(gradeID,1) )
	{
		stringIndex = 1406;
	} else {
		if ( UnknownFunction154(gradeID,2) )
		{
			stringIndex = 1407;
		} else {
			if ( UnknownFunction154(gradeID,3) )
			{
				stringIndex = 1408;
			} else {
				if ( UnknownFunction154(gradeID,4) )
				{
					stringIndex = 1409;
				} else {
					if ( UnknownFunction154(gradeID,5) )
					{
						stringIndex = 1410;
					} else {
						if ( UnknownFunction154(gradeID,6) )
						{
							stringIndex = 1411;
						} else {
							if ( UnknownFunction154(gradeID,7) )
							{
								stringIndex = 1412;
							} else {
								if ( UnknownFunction154(gradeID,8) )
								{
									stringIndex = 1413;
								} else {
									if ( UnknownFunction154(gradeID,9) )
									{
										stringIndex = 1414;
									}
								}
							}
						}
					}
				}
			}
		}
	}
	if ( UnknownFunction155(stringIndex,-1) )
	{
		return GetSystemString(stringIndex);
	} else {
		return "";
	}
}

function InitializeAcademyList ()
{
	local ClanWnd L2jBRVar21;
	local int i;
	local LVDataRecord Record;

	Record.LVDataList.Length = 3;
	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	InitializeClan1_AssignApprenticeList();
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar21.m_memberList[L2jBRVar21.GetIndexFromType(-1)].m_array.Length) )
	{
		if ( UnknownFunction154(L2jBRVar21.m_memberList[L2jBRVar21.GetIndexFromType(-1)].m_array[i].bHaveMaster,0) )
		{
			Record.LVDataList[0].szData = L2jBRVar21.m_memberList[L2jBRVar21.GetIndexFromType(-1)].m_array[i].sName;
			Record.LVDataList[1].szData = string(L2jBRVar21.m_memberList[L2jBRVar21.GetIndexFromType(-1)].m_array[i].Level);
			Record.nReserved1 = L2jBRVar21.m_memberList[L2jBRVar21.GetIndexFromType(-1)].m_array[i].clanType;
			Record.LVDataList[2].szData = string(L2jBRVar21.m_memberList[L2jBRVar21.GetIndexFromType(-1)].m_array[i].ClassID);
			Record.LVDataList[2].szTexture = GetClassIconName(L2jBRVar21.m_memberList[L2jBRVar21.GetIndexFromType(-1)].m_array[i].ClassID);
			Record.LVDataList[2].nTextureWidth = 11;
			Record.LVDataList[2].nTextureHeight = 11;
			Class'UIAPI_LISTCTRL'.InsertRecord("ClanDrawerWnd.Clan1_AssignApprenticeList",Record);
		}
		UnknownFunction163(i);
		goto JL0035;
	}
}

function InitializeClan1_AssignApprenticeList ()
{
	Class'UIAPI_LISTCTRL'.DeleteAllItem("ClanDrawerWnd.Clan1_AssignApprenticeList");
}

function InitializeClanInfoWnd ()
{
	local Color Blue;
	local Color Red;
	local Color DarkYellow;
	local ClanWnd L2jBRVar21;
	local int i;
	local string ClanNameVal;
	local string ClanRankStr;
	local string ToolTip;
	local int clanType;

	Blue.R = 126;
	Blue.G = 158;
	Blue.B = 245;
	Red.R = 200;
	Red.G = 50;
	Red.B = 80;
	DarkYellow.R = 175;
	DarkYellow.G = 152;
	DarkYellow.B = 120;
	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	ClanNameVal = UnknownFunction168(string(L2jBRVar21.m_clanNameValue),GetSystemString(1442));
	reset_clan_org();
	if ( UnknownFunction154(L2jBRVar21.m_clanRank,0) )
	{
		ClanRankStr = GetSystemString(1374);
	} else {
		if ( UnknownFunction152(L2jBRVar21.m_clanRank,100) )
		{
			ClanRankStr = UnknownFunction168(GetSystemString(1375),string(L2jBRVar21.m_clanRank));
		} else {
			ClanRankStr = GetSystemString(1374);
		}
	}
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan3_ClanName",L2jBRVar21.m_clanName);
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan3_ClanPoint",ClanNameVal);
	if ( UnknownFunction154(L2jBRVar21.m_clanNameValue,0) )
	{
		Class'UIAPI_TEXTBOX'.SetTextColor("ClanDrawerWnd.Clan3_ClanPoint",DarkYellow);
	} else {
		if ( UnknownFunction150(L2jBRVar21.m_clanNameValue,0) )
		{
			Class'UIAPI_TEXTBOX'.SetTextColor("ClanDrawerWnd.Clan3_ClanPoint",Red);
		} else {
			if ( UnknownFunction151(L2jBRVar21.m_clanNameValue,0) )
			{
				Class'UIAPI_TEXTBOX'.SetTextColor("ClanDrawerWnd.Clan3_ClanPoint",Blue);
			}
		}
	}
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan3_ClanRanking",ClanRankStr);
	i = 0;
	if ( UnknownFunction150(i,8) )
	{
		if ( UnknownFunction123(L2jBRVar21.m_memberList[i].m_sName,"") )
		{
			clanType = L2jBRVar21.GetClanTypeFromIndex(i);
			if ( UnknownFunction154(clanType,0) )
			{
				ToolTip = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(L2jBRVar21.m_memberList[i].m_sName,"\n"),GetSystemString(342))," : "),L2jBRVar21.m_memberList[i].m_sMasterName);
			}
			if ( UnknownFunction154(clanType,-1) )
			{
				ToolTip = L2jBRVar21.m_memberList[i].m_sName;
			}
			if ( UnknownFunction132(UnknownFunction154(clanType,100),UnknownFunction154(clanType,200)) )
			{
				ToolTip = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(L2jBRVar21.m_memberList[i].m_sName,"\n"),GetSystemString(1438))," : "),L2jBRVar21.m_memberList[i].m_sMasterName);
			}
			if ( UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction154(clanType,1001),UnknownFunction154(clanType,1002)),UnknownFunction154(clanType,2001)),UnknownFunction154(clanType,2002)) )
			{
				ToolTip = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(L2jBRVar21.m_memberList[i].m_sName,"\n"),GetSystemString(1433))," : "),L2jBRVar21.m_memberList[i].m_sMasterName);
			}
			if ( UnknownFunction123(ToolTip,"") )
			{
				Clan3_OrgIcon[i].ShowWindow();
				Clan3_OrgIcon[i].EnableWindow();
				Clan3_OrgIcon[i].SetTooltipCustomType(L2jBRFunction29(ToolTip));
			}
		}
		UnknownFunction163(i);
		goto JL02B1;
	}
}

function InitializeGradeComboBox ()
{
	local int i;

	Class'UIAPI_COMBOBOX'.Clear("ClanDrawerWnd.Clan1_MemberGradeList");
	i = 1;
	if ( UnknownFunction150(i,6) )
	{
		Class'UIAPI_COMBOBOX'.AddString("ClanDrawerWnd.Clan1_MemberGradeList",GetStringByGradeID(i));
		UnknownFunction163(i);
		goto JL003B;
	}
	Class'UIAPI_COMBOBOX'.AddString("ClanDrawerWnd.Clan1_MemberGradeList",GetSystemString(1451));
}

function KnighthoodCombobox ()
{
	local ClanWnd L2jBRVar21;
	local int i;

	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	Class'UIAPI_COMBOBOX'.Clear("ClanDrawerWnd.Clan1_targetknighthoodcombobox");
	Class'UIAPI_COMBOBOX'.Clear("ClanDrawerWnd.Clan1_targetknighthoodmember");
	Class'UIAPI_COMBOBOX'.AddStringWithReserved("ClanDrawerWnd.Clan1_targetknighthoodcombobox",GetSystemString(1465),0);
	Class'UIAPI_COMBOBOX'.AddStringWithReserved("ClanDrawerWnd.Clan1_targetknighthoodmember",GetSystemString(1466),0);
	Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_targetknighthoodmember");
	Class'UIAPI_WINDOW'.DisableWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodBtn");
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodTXT1",MakeFullSystemMsg(GetSystemMessage(1906),m_currentName,""));
	i = 0;
	if ( UnknownFunction150(i,L2jBRVar21.8) )
	{
		if ( UnknownFunction123(L2jBRVar21.m_memberList[i].m_sName,"") )
		{
JL01F9:
			if ( UnknownFunction155(L2jBRVar21.GetClanTypeFromIndex(i),-1) )
			{
				Class'UIAPI_COMBOBOX'.AddStringWithReserved("ClanDrawerWnd.Clan1_targetknighthoodcombobox",L2jBRVar21.m_memberList[i].m_sName,i);
			}
		}
		UnknownFunction163(i);
		goto JL01F9;
	}
	Class'UIAPI_COMBOBOX'.SetSelectedNum("ClanDrawerWnd.Clan1_targetknighthoodcombobox",0);
}

function swapTargetSelect (int clanNo)
{
	local ClanWnd L2jBRVar21;
	local int i;

	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	Class'UIAPI_COMBOBOX'.Clear("ClanDrawerWnd.Clan1_targetknighthoodmember");
	Class'UIAPI_COMBOBOX'.AddStringWithReserved("ClanDrawerWnd.Clan1_targetknighthoodmember",GetSystemString(1466),0);
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodTXT1",MakeFullSystemMsg(GetSystemMessage(1907),m_currentName,""));
	i = 0;
	if ( UnknownFunction152(i,L2jBRVar21.m_memberList[clanNo].m_array.Length) )
	{
		if ( UnknownFunction123(L2jBRVar21.m_memberList[clanNo].m_array[i].sName,L2jBRVar21.m_CurrentclanMasterReal) )
		{
			Class'UIAPI_COMBOBOX'.AddStringWithReserved("ClanDrawerWnd.Clan1_targetknighthoodmember",L2jBRVar21.m_memberList[clanNo].m_array[i].sName,L2jBRVar21.m_memberList[clanNo].m_array[i].clanType);
		}
		UnknownFunction163(i);
		goto JL00FA;
	}
	Class'UIAPI_COMBOBOX'.SetSelectedNum("ClanDrawerWnd.Clan1_targetknighthoodmember",0);
}

function proc_swapmember ()
{
	local int currentindexnew1;
	local int currentindexnew2;
	local string currentstring1;
	local string currentstring2;
	local int L2jBRVar5;
	local int clantype1;
	local ClanWnd L2jBRVar21;

	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	currentindexnew1 = Class'UIAPI_COMBOBOX'.GetSelectedNum("ClanDrawerWnd.Clan1_targetknighthoodcombobox");
	currentstring1 = Class'UIAPI_COMBOBOX'.GetString("ClanDrawerWnd.Clan1_targetknighthoodcombobox",currentindexnew1);
	clantype1 = L2jBRVar21.GetClanTypeFromIndex(Class'UIAPI_COMBOBOX'.GetReserved("ClanDrawerWnd.Clan1_targetknighthoodcombobox",currentindexnew1));
	currentindexnew2 = Class'UIAPI_COMBOBOX'.GetSelectedNum("ClanDrawerWnd.Clan1_targetknighthoodmember");
	currentstring2 = Class'UIAPI_COMBOBOX'.GetString("ClanDrawerWnd.Clan1_targetknighthoodmember",currentindexnew2);
	if ( UnknownFunction154(currentindexnew2,0) )
	{
		L2jBRVar5 = 0;
	} else {
		L2jBRVar5 = 1;
	}
	if ( UnknownFunction154(L2jBRVar5,1) )
	{
		RequestClanReorganizeMember(1,m_currentName,clantype1,currentstring2);
	} else {
		if ( UnknownFunction154(L2jBRVar5,0) )
		{
			RequestClanReorganizeMember(0,m_currentName,clantype1,"");
		}
	}
	Class'UIAPI_TEXTBOX'.SetText("ClanDrawerWnd.Clan1_CurrentSelectedMemberOrderName",UnknownFunction168(UnknownFunction168(getClanOrderString(clantype1),"-"),currentstring1));
}

function OnComboBoxItemSelected (string strID, int Index)
{
	local int selectval;

	if ( UnknownFunction122(strID,"Clan1_targetknighthoodcombobox") )
	{
		Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_targetknighthoodmember");
		Class'UIAPI_WINDOW'.EnableWindow("ClanDrawerWnd.Clan1_ChangeMemberKnightHoodBtn");
		selectval = Class'UIAPI_COMBOBOX'.GetReserved("ClanDrawerWnd.Clan1_targetknighthoodcombobox",Index);
		swapTargetSelect(selectval);
	}
}

function HideWindow ()
{
	local ClanWnd L2jBRVar21;

	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	Class'UIAPI_WINDOW'.HideWindow("ClanDrawerWnd");
	L2jBRVar21.ResetOpeningVariables();
}

function ApplyEditGrade ()
{
	local array<int> powers;
	local int i;
	local int Index;

	powers.Length = 32;
	powers[0] = 0;
	Index = 1;
	i = 1;
	if ( UnknownFunction152(i,9) )
	{
		if ( Class'UIAPI_CHECKBOX'.IsChecked(UnknownFunction112("ClanDrawerWnd.Clan6_Check10",string(i))) )
		{
			powers[Index] = 1;
		}
		UnknownFunction163(Index);
		UnknownFunction163(i);
		goto JL0020;
	}
	i = 1;
	if ( UnknownFunction152(i,5) )
	{
		if ( Class'UIAPI_CHECKBOX'.IsChecked(UnknownFunction112("ClanDrawerWnd.Clan6_Check20",string(i))) )
		{
			powers[Index] = 1;
		}
		UnknownFunction163(Index);
		UnknownFunction163(i);
		goto JL0089;
	}
	i = 1;
	if ( UnknownFunction152(i,8) )
	{
		if ( Class'UIAPI_CHECKBOX'.IsChecked(UnknownFunction112("ClanDrawerWnd.Clan6_Check30",string(i))) )
		{
			powers[Index] = 1;
		}
		UnknownFunction163(Index);
		UnknownFunction163(i);
		goto JL00F2;
	}
	RequestEditClanAuth(m_currentEditGradeID,powers);
}

function EditAuthGrade ()
{
	local int Index;
	local LVDataRecord Record;

	Index = Class'UIAPI_LISTCTRL'.GetSelectedIndex("ClanDrawerWnd.Clan5_AuthListCtrl");
	if ( UnknownFunction153(Index,0) )
	{
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ClanDrawerWnd.Clan5_AuthListCtrl",Index);
		RequestClanAuth(Record.nReserved1);
		m_currentEditGradeID = Record.nReserved1;
		SetStateAndShow("ClanAuthEditWndState");
	} else {
		SetStateAndShow("ClanAuthManageWndState");
	}
}

function EditAuthGrade2 ()
{
	local int Index;
	local LVDataRecord Record;

	Index = Class'UIAPI_LISTCTRL'.GetSelectedIndex("ClanDrawerWnd.Clan5_AuthListCtrl2");
	if ( UnknownFunction153(Index,0) )
	{
		Record = Class'UIAPI_LISTCTRL'.GetRecord("ClanDrawerWnd.Clan5_AuthListCtrl2",Index);
		RequestClanAuth(Record.nReserved1);
		m_currentEditGradeID = Record.nReserved1;
		SetStateAndShow("ClanAuthEditWndState");
	} else {
		SetStateAndShow("ClanAuthManageWndState");
	}
}

function string GetWarStateString (int State)
{
	if ( UnknownFunction154(State,0) )
	{
		return GetSystemString(1429);
	} else {
		if ( UnknownFunction154(State,1) )
		{
			return GetSystemString(1430);
		} else {
			if ( UnknownFunction154(State,2) )
			{
				return GetSystemString(1367);
			}
		}
	}
	return "Error";
}

function AddSkill (int Id, int Level)
{
	local ItemInfo Info;

	Info.ClassID = Id;
	Info.Level = Level;
	Info.Name = Class'UIDATA_SKILL'.GetName(Info.ClassID,Info.Level);
	Info.IconName = Class'UIDATA_SKILL'.GetIconName(Info.ClassID,Info.Level);
	Info.Description = Class'UIDATA_SKILL'.GetDescription(Info.ClassID,Info.Level);
	Info.AdditionalName = Class'UIDATA_SKILL'.GetEnchantName(Info.ClassID,Info.Level);
	Class'UIAPI_ITEMWINDOW'.AddItem("ClanDrawerWnd.ClanSkillWnd",Info);
}

function ReplaceSkill (int Index, int Id, int Level)
{
	local ItemInfo Info;

	Info.ClassID = Id;
	Info.Level = Level;
	Info.Name = Class'UIDATA_SKILL'.GetName(Info.ClassID,Info.Level);
	Info.IconName = Class'UIDATA_SKILL'.GetIconName(Info.ClassID,Info.Level);
	Info.Description = Class'UIDATA_SKILL'.GetDescription(Info.ClassID,Info.Level);
	Info.AdditionalName = Class'UIDATA_SKILL'.GetEnchantName(Info.ClassID,Info.Level);
	Class'UIAPI_ITEMWINDOW'.SetItem("ClanDrawerWnd.ClanSkillWnd",Index,Info);
}

function string getClanOrderString (int gradeID)
{
	local int stringIndex;

	stringIndex = -1;
	if ( UnknownFunction154(gradeID,0) )
	{
		stringIndex = 1399;
	} else {
		if ( UnknownFunction154(gradeID,100) )
		{
			stringIndex = 1400;
		} else {
			if ( UnknownFunction154(gradeID,200) )
			{
				stringIndex = 1401;
			} else {
				if ( UnknownFunction154(gradeID,1001) )
				{
					stringIndex = 1402;
				} else {
					if ( UnknownFunction154(gradeID,1002) )
					{
						stringIndex = 1403;
					} else {
						if ( UnknownFunction154(gradeID,2001) )
						{
							stringIndex = 1404;
						} else {
							if ( UnknownFunction154(gradeID,2002) )
							{
								stringIndex = 1405;
							} else {
								if ( UnknownFunction154(gradeID,-1) )
								{
									stringIndex = 1419;
								}
							}
						}
					}
				}
			}
		}
	}
	if ( UnknownFunction155(stringIndex,-1) )
	{
		return GetSystemString(stringIndex);
	} else {
		return "";
	}
}

function reset_clan_org ()
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,8) )
	{
		Clan3_OrgIcon[i].HideWindow();
		Clan3_OrgIcon[i].DisableWindow();
		Clan3_OrgIcon[i].SetTooltipCustomType(L2jBRFunction29(""));
		UnknownFunction163(i);
		goto JL0007;
	}
}

function disableAcademyAuth ()
{
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check100",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check101",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check102",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check106",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check104",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check105",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check107",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check108",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check109",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check110",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check200",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check203",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check204",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check205",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check300",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check303",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check302",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check305",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check306",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check307",True);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check308",True);
}

function resetAcademyAuth ()
{
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check100",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check101",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check102",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check106",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check104",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check105",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check107",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check108",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check109",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check109",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check200",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check203",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check204",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check205",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check300",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check303",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check302",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check305",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check306",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check307",False);
	Class'UIAPI_CHECKBOX'.SetDisable("ClanDrawerWnd.Clan6_Check308",False);
}

function int getCurrentGradebyClanType ()
{
	local int GradeNum;

	Debug(UnknownFunction168("현재 그레이드를 클랜에서 가져옴:",string(m_clanType)));
	switch (m_clanType)
	{
		case 0:
		GradeNum = 6;
		break;
		case 100:
		GradeNum = 7;
		break;
		case 200:
		GradeNum = 7;
		break;
		case 1001:
		GradeNum = 8;
		break;
		case 1002:
		GradeNum = 8;
		break;
		case 2001:
		GradeNum = 8;
		break;
		case 2002:
		GradeNum = 8;
		break;
		case -1:
		GradeNum = 9;
		break;
		default:
	}
	Debug(UnknownFunction168("현재 그레이드 번호는?",string(GradeNum)));
	return GradeNum;
}

function CustomTooltip L2jBRFunction29 (string Text)
{
	local CustomTooltip ToolTip;
	local DrawItemInfo Info;

	ToolTip.MinimumWidth = 144;
	ToolTip.DrawList.Length = 1;
	Info.eType = 1;
	Info.t_color.R = 178;
	Info.t_color.G = 190;
	Info.t_color.B = 207;
	Info.t_color.A = 255;
	Info.t_strText = Text;
	ToolTip.DrawList[0] = Info;
	return ToolTip;
}

