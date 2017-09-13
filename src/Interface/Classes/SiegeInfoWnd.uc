//================================================================================
// SiegeInfoWnd.
//================================================================================

class SiegeInfoWnd extends UICommonAPI;

var bool m_bShow;
var int m_CastleID;
var string m_CastleName;
var int m_PlayerClanID;
var bool m_IsCastleOwner;
var int m_SiegeTime;
var array<int> m_SelectableTimeArray;
var bool m_IsExistMyClanIDinAttackSide;
var bool m_IsExistMyClanIDinDefenseSide;
var int m_AcceptedClan;
var int m_WaitingClan;
var int m_DialogClanID;
var int m_DialogSelectedTimeID;
var WindowHandle L2jBRVar103;
var TabHandle TabCtrl;
var TextBoxHandle txtCastleName;
var TextBoxHandle txtOwnerName;
var TextBoxHandle txtClanName;
var TextBoxHandle txtAllianceName;
var TextureHandle texClan;
var TextureHandle texAlliance;
var TextBoxHandle txtCurTime;
var TextBoxHandle txtSiegeTime;
var ComboBoxHandle cboTime;
var ListCtrlHandle lstAttackClan;
var TextBoxHandle txtAttackCount;
var ButtonHandle btnAttackApply;
var ButtonHandle btnAttackCancel;
var ListCtrlHandle lstDefenseClan;
var TextBoxHandle txtDefenseCount;
var ButtonHandle btnDefenseApply;
var ButtonHandle btnDefenseCancel;
var ButtonHandle btnDefenseReject;
var ButtonHandle btnDefenseConfirm;

function OnLoad ()
{
	RegisterEvent(1710);
	RegisterEvent(1450);
	RegisterEvent(1460);
	RegisterEvent(1470);
	RegisterEvent(1480);
	RegisterEvent(1490);
	m_bShow = False;
	m_CastleID = 0;
	m_CastleName = "";
	m_SiegeTime = 0;
	m_AcceptedClan = 0;
	m_WaitingClan = 0;
	L2jBRVar103 = GetHandle("SiegeInfoWnd");
	TabCtrl = TabHandle(GetHandle("SiegeInfoWnd.TabCtrl"));
	txtCastleName = TextBoxHandle(GetHandle("SiegeInfoWnd.txtCastleName"));
	txtOwnerName = TextBoxHandle(GetHandle("SiegeInfoWnd.txtOwnerName"));
	txtClanName = TextBoxHandle(GetHandle("SiegeInfoWnd.txtClanName"));
	txtAllianceName = TextBoxHandle(GetHandle("SiegeInfoWnd.txtAllianceName"));
	texClan = TextureHandle(GetHandle("SiegeInfoWnd.texClan"));
	texAlliance = TextureHandle(GetHandle("SiegeInfoWnd.texAlliance"));
	txtCurTime = TextBoxHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Date.txtCurTime"));
	txtSiegeTime = TextBoxHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Date.txtSiegeTime"));
	cboTime = ComboBoxHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Date.cboTime"));
	lstAttackClan = ListCtrlHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Party1.lstClan"));
	txtAttackCount = TextBoxHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Party1.txtCount"));
	btnAttackApply = ButtonHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Party1.btnAttackApply"));
	btnAttackCancel = ButtonHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Party1.btnAttackCancel"));
	lstDefenseClan = ListCtrlHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Party2.lstClan"));
	txtDefenseCount = TextBoxHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Party2.txtCount"));
	btnDefenseApply = ButtonHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Party2.btnDefenseApply"));
	btnDefenseCancel = ButtonHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Party2.btnDefenseCancel"));
	btnDefenseReject = ButtonHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Party2.btnDefenseReject"));
	btnDefenseConfirm = ButtonHandle(GetHandle("SiegeInfoWnd.SiegeInfoWnd_Party2.btnDefenseConfirm"));
	UpdateAttackCount();
	UpdateDefenseCount();
}

function OnShow ()
{
	m_bShow = True;
}

function OnHide ()
{
	m_bShow = False;
}

function OnEnterState (name a_PreStateName)
{
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,1450) )
	{
		HandleSiegeInfo(L2jBRVar1);
	} else {
		if ( UnknownFunction154(Event_ID,1460) )
		{
			HandleSiegeInfoClanListStart(L2jBRVar1);
		} else {
			if ( UnknownFunction154(Event_ID,1470) )
			{
				HandleSiegeInfoClanList(L2jBRVar1);
			} else {
				if ( UnknownFunction154(Event_ID,1480) )
				{
					HandleSiegeInfoClanListEnd(L2jBRVar1);
				} else {
					if ( UnknownFunction154(Event_ID,1490) )
					{
						HandleSiegeInfoSelectableTime(L2jBRVar1);
					} else {
						if ( UnknownFunction154(Event_ID,1710) )
						{
							if ( DialogIsMine() )
							{
								if ( UnknownFunction154(DialogGetID(),1) )
								{
									Class'SiegeAPI'.RequestJoinCastleSiege(m_CastleID,1,1);
								} else {
									if ( UnknownFunction154(DialogGetID(),2) )
									{
										Class'SiegeAPI'.RequestJoinCastleSiege(m_CastleID,1,0);
									} else {
										if ( UnknownFunction154(DialogGetID(),3) )
										{
											Class'SiegeAPI'.RequestJoinCastleSiege(m_CastleID,0,1);
										} else {
											if ( UnknownFunction154(DialogGetID(),4) )
											{
												Class'SiegeAPI'.RequestJoinCastleSiege(m_CastleID,0,0);
											} else {
												if ( UnknownFunction154(DialogGetID(),5) )
												{
													if ( UnknownFunction151(m_DialogClanID,0) )
													{
														Class'SiegeAPI'.RequestConfirmCastleSiegeWaitingList(m_CastleID,m_DialogClanID,0);
														m_DialogClanID = 0;
													}
												} else {
													if ( UnknownFunction154(DialogGetID(),6) )
													{
														if ( UnknownFunction151(m_DialogClanID,0) )
														{
															Class'SiegeAPI'.RequestConfirmCastleSiegeWaitingList(m_CastleID,m_DialogClanID,1);
															m_DialogClanID = 0;
														}
													} else {
														if ( UnknownFunction154(DialogGetID(),7) )
														{
															if ( UnknownFunction151(m_DialogSelectedTimeID,0) )
															{
																Class'SiegeAPI'.RequestSetCastleSiegeTime(m_CastleID,m_DialogSelectedTimeID);
																m_DialogSelectedTimeID = 0;
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

function OnComboBoxItemSelected (string strID, int Index)
{
	if ( UnknownFunction122(strID,"cboTime") )
	{
		if ( UnknownFunction151(Index,0) )
		{
			m_DialogSelectedTimeID = m_SelectableTimeArray[UnknownFunction147(Index,1)];
			DialogShow(0,MakeFullSystemMsg(GetSystemMessage(663),cboTime.GetString(Index),""));
			DialogSetID(7);
		}
	}
}

function ClearInfo ()
{
	local Rect rectWnd;

	rectWnd = L2jBRVar103.GetRect();
	m_CastleID = 0;
	m_CastleName = "";
	m_IsCastleOwner = False;
	m_SiegeTime = 0;
	txtCurTime.SetText("");
	txtSiegeTime.SetText("");
	txtCastleName.SetText("");
	txtOwnerName.SetText(GetSystemString(595));
	txtClanName.SetText("");
	txtAllianceName.SetText("");
	texClan.SetTexture("");
	texAlliance.SetTexture("");
	txtClanName.MoveTo(UnknownFunction146(rectWnd.nX,80),UnknownFunction146(rectWnd.nY,86));
	txtAllianceName.MoveTo(UnknownFunction146(rectWnd.nX,80),UnknownFunction146(rectWnd.nY,102));
	TabCtrl.SetTopOrder(0,True);
	ClearTimeCombo();
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnAttackApply":
		OnAttackApplyClick();
		break;
		case "btnAttackCancel":
		OnAttackCancelClick();
		break;
		case "btnDefenseApply":
		OnDefenseApplyClick();
		break;
		case "btnDefenseCancel":
		OnDefenseCancelClick();
		break;
		case "btnDefenseReject":
		OnDefenseRejectClick();
		break;
		case "btnDefenseConfirm":
		OnDefenseConfirmClick();
		break;
		case "TabCtrl0":
		OnTabCtrl0Click();
		case "TabCtrl1":
		OnTabCtrl1Click();
		break;
		case "TabCtrl2":
		OnTabCtrl2Click();
		break;
		default:
	}
}

function OnAttackApplyClick ()
{
	DialogShow(0,MakeFullSystemMsg(GetSystemMessage(667),m_CastleName,""));
	DialogSetID(1);
}

function OnAttackCancelClick ()
{
	DialogShow(0,MakeFullSystemMsg(GetSystemMessage(669),m_CastleName,""));
	DialogSetID(2);
}

function OnDefenseApplyClick ()
{
	DialogShow(0,MakeFullSystemMsg(GetSystemMessage(668),m_CastleName,""));
	DialogSetID(3);
}

function OnDefenseCancelClick ()
{
	DialogShow(0,MakeFullSystemMsg(GetSystemMessage(669),m_CastleName,""));
	DialogSetID(4);
}

function OnDefenseRejectClick ()
{
	local int L2jBRVar2;
	local int clanID;
	local string ClanName;
	local int Status;
	local ECastleSiegeDefenderType DefenderType;
	local LVDataRecord Record;

	L2jBRVar2 = lstDefenseClan.GetSelectedIndex();
	if ( UnknownFunction151(L2jBRVar2,-1) )
	{
		Record = lstDefenseClan.GetRecord(L2jBRVar2);
		clanID = Record.nReserved1;
		Status = Record.nReserved2;
		DefenderType = Status;
		if ( UnknownFunction151(clanID,0) )
		{
			if ( UnknownFunction132(UnknownFunction154(DefenderType,2),UnknownFunction154(DefenderType,3)) )
			{
				ClanName = Class'UIDATA_CLAN'.GetName(clanID);
				m_DialogClanID = clanID;
				DialogShow(0,MakeFullSystemMsg(GetSystemMessage(670),ClanName,""));
				DialogSetID(5);
			}
		}
	}
}

function OnDefenseConfirmClick ()
{
	local int L2jBRVar2;
	local int clanID;
	local string ClanName;
	local int Status;
	local ECastleSiegeDefenderType DefenderType;
	local LVDataRecord Record;

	L2jBRVar2 = lstDefenseClan.GetSelectedIndex();
	if ( UnknownFunction151(L2jBRVar2,-1) )
	{
		Record = lstDefenseClan.GetRecord(L2jBRVar2);
		clanID = Record.nReserved1;
		Status = Record.nReserved2;
		DefenderType = Status;
		if ( UnknownFunction151(clanID,0) )
		{
			if ( UnknownFunction154(DefenderType,2) )
			{
				ClanName = Class'UIDATA_CLAN'.GetName(clanID);
				m_DialogClanID = clanID;
				DialogShow(0,MakeFullSystemMsg(GetSystemMessage(671),ClanName,""));
				DialogSetID(6);
			}
		}
	}
}

function OnTabCtrl0Click ()
{
	UpdateTimeCombo();
}

function OnTabCtrl1Click ()
{
	ClearAttackButton();
	Class'SiegeAPI'.RequestCastleSiegeAttackerList(m_CastleID);
}

function OnTabCtrl2Click ()
{
	ClearDefenseButton();
	Class'SiegeAPI'.RequestCastleSiegeDefenderList(m_CastleID);
}

function HandleSiegeInfo (string L2jBRVar1)
{
	local Rect rectWnd;
	local int castleID;
	local int IsOwner;
	local string OwnerName;
	local int clanID;
	local string ClanName;
	local int AllianceID;
	local string AllianceName;
	local int NowTime;
	local int SiegeTime;
	local string CastleName;
	local Texture ClanCrestTexture;
	local Texture AllianceCrestTexture;

	ClearInfo();
	rectWnd = L2jBRVar103.GetRect();
	ParseInt(L2jBRVar1,"CastleID",castleID);
	ParseInt(L2jBRVar1,"IsOwner",IsOwner);
	if ( UnknownFunction154(IsOwner,1) )
	{
		m_IsCastleOwner = True;
	}
	ParseString(L2jBRVar1,"OwnerName",OwnerName);
	ParseInt(L2jBRVar1,"ClanID",clanID);
	ParseString(L2jBRVar1,"ClanName",ClanName);
	ParseInt(L2jBRVar1,"AllianceID",AllianceID);
	ParseString(L2jBRVar1,"AllianceName",AllianceName);
	ParseInt(L2jBRVar1,"NowTime",NowTime);
	ParseInt(L2jBRVar1,"SiegeTime",SiegeTime);
	m_SiegeTime = SiegeTime;
	CastleName = GetCastleName(castleID);
	m_CastleID = castleID;
	m_CastleName = CastleName;
	txtCastleName.SetText(CastleName);
	if ( UnknownFunction151(UnknownFunction125(OwnerName),0) )
	{
		txtOwnerName.SetText(OwnerName);
	}
	if ( UnknownFunction151(UnknownFunction125(ClanName),0) )
	{
		txtClanName.SetText(ClanName);
	}
	if ( UnknownFunction151(UnknownFunction125(AllianceName),0) )
	{
		txtAllianceName.SetText(AllianceName);
	} else {
		if ( UnknownFunction151(UnknownFunction125(ClanName),0) )
		{
			txtAllianceName.SetText(GetSystemString(591));
		}
	}
	if ( UnknownFunction151(clanID,0) )
	{
		if ( Class'UIDATA_CLAN'.GetCrestTexture(clanID,ClanCrestTexture) )
		{
			texClan.SetTextureWithObject(ClanCrestTexture);
			txtClanName.MoveTo(UnknownFunction146(rectWnd.nX,100),UnknownFunction146(rectWnd.nY,86));
		}
	}
	if ( UnknownFunction151(AllianceID,0) )
	{
		if ( Class'UIDATA_CLAN'.GetAllianceCrestTexture(clanID,AllianceCrestTexture) )
		{
			texAlliance.SetTextureWithObject(AllianceCrestTexture);
			txtAllianceName.MoveTo(UnknownFunction146(rectWnd.nX,100),UnknownFunction146(rectWnd.nY,102));
		}
	}
	if ( UnknownFunction151(NowTime,0) )
	{
		txtCurTime.SetText(ConvertTimetoStr(NowTime));
	}
	if ( UnknownFunction151(SiegeTime,0) )
	{
		txtSiegeTime.SetText(ConvertTimetoStr(SiegeTime));
	} else {
		if ( UnknownFunction129(m_IsCastleOwner) )
		{
			txtSiegeTime.SetText(GetSystemString(584));
		}
	}
	L2jBRVar103.ShowWindow();
	L2jBRVar103.SetFocus();
	UpdateTimeCombo();
}

function HandleSiegeInfoClanListStart (string L2jBRVar1)
{
	local int L2jBRVar5;
	local UserInfo infUser;

	m_PlayerClanID = 0;
	if ( GetPlayerInfo(infUser) )
	{
		m_PlayerClanID = infUser.nClanID;
	}
	if ( ParseInt(L2jBRVar1,"Type",L2jBRVar5) )
	{
		if ( UnknownFunction154(L2jBRVar5,0) )
		{
			lstAttackClan.DeleteAllItem();
			m_IsExistMyClanIDinAttackSide = False;
			UpdateAttackCount();
			ClearAttackButton();
		} else {
			if ( UnknownFunction154(L2jBRVar5,1) )
			{
				lstDefenseClan.DeleteAllItem();
				m_IsExistMyClanIDinDefenseSide = False;
				m_AcceptedClan = 0;
				m_WaitingClan = 0;
				UpdateDefenseCount();
				ClearDefenseButton();
			}
		}
	}
}

function HandleSiegeInfoClanList (string L2jBRVar1)
{
	local int L2jBRVar5;
	local int clanID;
	local string ClanName;
	local string AllianceName;
	local int AllianceID;
	local int Status;
	local ECastleSiegeDefenderType DefenderType;
	local LVDataRecord Record;
	local Texture texClan;
	local Texture texAlliance;

	Record.LVDataList.Length = 2;
	if ( ParseInt(L2jBRVar1,"Type",L2jBRVar5) )
	{
		ParseInt(L2jBRVar1,"ClanID",clanID);
		ParseString(L2jBRVar1,"ClanName",ClanName);
		ParseInt(L2jBRVar1,"AllianceID",AllianceID);
		ParseString(L2jBRVar1,"AllianceName",AllianceName);
		ParseInt(L2jBRVar1,"Status",Status);
		if ( UnknownFunction150(clanID,1) )
		{
			return;
		}
		if ( UnknownFunction154(L2jBRVar5,0) )
		{
			if ( UnknownFunction130(UnknownFunction151(m_PlayerClanID,0),UnknownFunction154(clanID,m_PlayerClanID)) )
			{
				m_IsExistMyClanIDinAttackSide = True;
			}
			Record.LVDataList[0].szData = ClanName;
			if ( Class'UIDATA_CLAN'.GetCrestTexture(clanID,texClan) )
			{
				Record.LVDataList[0].arrTexture.Length = 1;
				Record.LVDataList[0].arrTexture[0].objTex = texClan;
				Record.LVDataList[0].arrTexture[0].X = 6;
				Record.LVDataList[0].arrTexture[0].Y = 0;
				Record.LVDataList[0].arrTexture[0].Width = 16;
				Record.LVDataList[0].arrTexture[0].Height = 12;
				Record.LVDataList[0].arrTexture[0].U = 0;
				Record.LVDataList[0].arrTexture[0].V = 4;
			}
			Record.LVDataList[1].szData = AllianceName;
			if ( UnknownFunction151(AllianceID,0) )
			{
				if ( Class'UIDATA_CLAN'.GetAllianceCrestTexture(clanID,texAlliance) )
				{
					Record.LVDataList[1].arrTexture.Length = 1;
					Record.LVDataList[1].arrTexture[0].objTex = texAlliance;
					Record.LVDataList[1].arrTexture[0].X = 6;
					Record.LVDataList[1].arrTexture[0].Y = 0;
					Record.LVDataList[1].arrTexture[0].Width = 8;
					Record.LVDataList[1].arrTexture[0].Height = 12;
					Record.LVDataList[1].arrTexture[0].U = 0;
					Record.LVDataList[1].arrTexture[0].V = 4;
				}
			}
			lstAttackClan.InsertRecord(Record);
			UpdateAttackCount();
		} else {
			if ( UnknownFunction154(L2jBRVar5,1) )
			{
				if ( UnknownFunction130(UnknownFunction151(m_PlayerClanID,0),UnknownFunction154(clanID,m_PlayerClanID)) )
				{
					m_IsExistMyClanIDinDefenseSide = True;
				}
				Record.nReserved1 = clanID;
				Record.nReserved2 = Status;
				Record.LVDataList[0].szData = ClanName;
				if ( Class'UIDATA_CLAN'.GetCrestTexture(clanID,texClan) )
				{
					Record.LVDataList[0].arrTexture.Length = 1;
					Record.LVDataList[0].arrTexture[0].objTex = texClan;
					Record.LVDataList[0].arrTexture[0].X = 6;
					Record.LVDataList[0].arrTexture[0].Y = 0;
					Record.LVDataList[0].arrTexture[0].Width = 16;
					Record.LVDataList[0].arrTexture[0].Height = 12;
					Record.LVDataList[0].arrTexture[0].U = 0;
					Record.LVDataList[0].arrTexture[0].V = 4;
				}
				DefenderType = Status;
				switch (DefenderType)
				{
					case 1:
					Record.LVDataList[1].szData = GetSystemString(588);
					UnknownFunction165(m_WaitingClan);
					break;
					case 2:
					Record.LVDataList[1].szData = GetSystemString(568);
					UnknownFunction165(m_WaitingClan);
					break;
					case 3:
					Record.LVDataList[1].szData = GetSystemString(567);
					UnknownFunction165(m_AcceptedClan);
					break;
					case 4:
					Record.LVDataList[1].szData = GetSystemString(579);
					break;
					default:
				}
				lstDefenseClan.InsertRecord(Record);
				UpdateDefenseCount();
			}
		}
	}
}

function HandleSiegeInfoClanListEnd (string L2jBRVar1)
{
	local int L2jBRVar5;

	if ( ParseInt(L2jBRVar1,"Type",L2jBRVar5) )
	{
		if ( UnknownFunction154(L2jBRVar5,0) )
		{
			UpdateAttackButton();
		} else {
			if ( UnknownFunction154(L2jBRVar5,1) )
			{
				UpdateDefenseButton();
			}
		}
	}
}

function HandleSiegeInfoSelectableTime (string L2jBRVar1)
{
	local int TimeID;
	local string TimeString;

	if ( ParseInt(L2jBRVar1,"TimeID",TimeID) )
	{
		if ( UnknownFunction151(TimeID,0) )
		{
			TimeString = ConvertTimetoStr(TimeID);
			cboTime.AddString(TimeString);
			byte(m_SelectableTimeArray)
			m_SelectableTimeArray.Length
			1
			m_SelectableTimeArray[UnknownFunction147(m_SelectableTimeArray.Length,1)] = TimeID;
		}
	}
}

function UpdateAttackCount ()
{
	txtAttackCount.SetText(UnknownFunction112(UnknownFunction112(GetSystemString(576)," : "),string(lstAttackClan.GetRecordCount())));
}

function UpdateDefenseCount ()
{
	txtDefenseCount.SetText(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(GetSystemString(577),"/"),GetSystemString(578))," : "),string(m_AcceptedClan)),"/"),string(m_WaitingClan)));
}

function UpdateTimeCombo ()
{
	if ( UnknownFunction130(m_IsCastleOwner,UnknownFunction150(m_SiegeTime,1)) )
	{
		cboTime.ShowWindow();
	} else {
		cboTime.HideWindow();
	}
}

function UpdateAttackButton ()
{
	if ( UnknownFunction129(m_IsCastleOwner) )
	{
		if ( m_IsExistMyClanIDinAttackSide )
		{
			btnAttackCancel.ShowWindow();
		} else {
			btnAttackApply.ShowWindow();
		}
	}
}

function UpdateDefenseButton ()
{
	if ( UnknownFunction129(m_IsCastleOwner) )
	{
		if ( m_IsExistMyClanIDinDefenseSide )
		{
			btnDefenseCancel.ShowWindow();
		} else {
			btnDefenseApply.ShowWindow();
		}
	} else {
		btnDefenseReject.ShowWindow();
		btnDefenseConfirm.ShowWindow();
	}
}

function ClearTimeCombo ()
{
	m_SelectableTimeArray.Remove (0,m_SelectableTimeArray.Length);
	cboTime.Clear();
	cboTime.SYS_AddString(585);
	cboTime.SetSelectedNum(0);
	cboTime.HideWindow();
}

function ClearAttackButton ()
{
	btnAttackApply.HideWindow();
	btnAttackCancel.HideWindow();
}

function ClearDefenseButton ()
{
	btnDefenseApply.HideWindow();
	btnDefenseCancel.HideWindow();
	btnDefenseReject.HideWindow();
	btnDefenseConfirm.HideWindow();
}

