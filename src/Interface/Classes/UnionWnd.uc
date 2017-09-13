//================================================================================
// UnionWnd.
//================================================================================

class UnionWnd extends UICommonAPI;

var bool m_bChOpened;
var WindowHandle L2jBRVar12;
var WindowHandle PartyMemberWnd;
var TextBoxHandle txtOwner;
var TextBoxHandle txtRoutingType;
var TextBoxHandle txtCountInfo;
var ButtonHandle banBtn;
var ButtonHandle quitBtn;
var ListCtrlHandle lstParty;
var string m_UserName;
var int m_PartyNum;
var int m_PartyMemberNum;
var int m_SearchedMasterID;

function OnLoad ()
{
	RegisterEvent(1360);
	RegisterEvent(1370);
	RegisterEvent(1380);
	RegisterEvent(1390);
	RegisterEvent(1395);
	RegisterEvent(1400);
	m_bChOpened = False;
	m_PartyNum = 0;
	m_PartyMemberNum = 0;
	m_SearchedMasterID = 0;
	L2jBRVar12 = GetHandle("UnionWnd");
	PartyMemberWnd = GetHandle("UnionDetailWnd");
	txtOwner = TextBoxHandle(GetHandle("UnionWnd.txtOwner"));
	txtRoutingType = TextBoxHandle(GetHandle("UnionWnd.txtRoutingType"));
	txtCountInfo = TextBoxHandle(GetHandle("UnionWnd.txtCountInfo"));
	lstParty = ListCtrlHandle(GetHandle("UnionWnd.lstParty"));
	banBtn = ButtonHandle(GetHandle("UnionWnd.btnBan"));
	quitBtn = ButtonHandle(GetHandle("UnionWnd.btnOut"));
}

function OnShow ()
{
	local UserInfo a_UserInfo;

	GetPlayerInfo(a_UserInfo);
	m_UserName = a_UserInfo.Name;
	PartyMemberWnd.HideWindow();
}

function OnEnterState (name a_PreStateName)
{
	if ( m_bChOpened )
	{
		L2jBRVar12.ShowWindow();
	} else {
		L2jBRVar12.HideWindow();
	}
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,1360) )
	{
		HandleCommandChannelStart();
	} else {
		if ( UnknownFunction154(Event_ID,1370) )
		{
			HandleCommandChannelEnd();
		} else {
			if ( UnknownFunction154(Event_ID,1380) )
			{
				HandleCommandChannelInfo(L2jBRVar1);
			} else {
				if ( UnknownFunction154(Event_ID,1390) )
				{
					HandleCommandChannelPartyList(L2jBRVar1);
				} else {
					if ( UnknownFunction154(Event_ID,1395) )
					{
						HandleCommandChannelPartyUpdate(L2jBRVar1);
					} else {
						if ( UnknownFunction154(Event_ID,1400) )
						{
							HandleCommandChannelRoutingType(L2jBRVar1);
						}
					}
				}
			}
		}
	}
}

function OnDBClickListCtrlRecord (string strID)
{
	if ( UnknownFunction122(strID,"lstParty") )
	{
		RequestPartyMember(True);
	}
}

function Clear ()
{
	MemberClear();
	txtOwner.SetText("");
	txtRoutingType.SetText(GetSystemString(1383));
	txtCountInfo.SetText("");
}

function MemberClear ()
{
	lstParty.DeleteAllItem();
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnRefresh":
		OnRefreshClick();
		break;
		case "btnBan":
		OnBanClick();
		break;
		case "btnOut":
		OnOutClick();
		break;
		case "btnMemberInfo":
		OnMemberInfoClick();
		break;
		default:
	}
}

function OnRefreshClick ()
{
	RequestNewInfo();
}

function RequestNewInfo ()
{
	Class'CommandChannelAPI'.RequestCommandChannelInfo();
}

function OnBanClick ()
{
	local int L2jBRVar2;
	local LVDataRecord Record;
	local string PartyMasterName;

	L2jBRVar2 = lstParty.GetSelectedIndex();
	if ( UnknownFunction151(L2jBRVar2,-1) )
	{
		Record = lstParty.GetRecord(L2jBRVar2);
		PartyMasterName = Record.LVDataList[0].szData;
		if ( UnknownFunction151(UnknownFunction125(PartyMasterName),0) )
		{
			Class'CommandChannelAPI'.RequestCommandChannelBanParty(PartyMasterName);
		}
	}
}

function OnOutClick ()
{
	Class'CommandChannelAPI'.RequestCommandChannelWithdraw();
}

function OnMemberInfoClick ()
{
	if ( PartyMemberWnd.IsShowWindow() )
	{
		PartyMemberWnd.HideWindow();
	} else {
		RequestPartyMember(True);
	}
}

function RequestPartyMember (bool bShowWindow)
{
	local LVDataRecord Record;
	local string PartyMasterName;
	local int MasterID;
	local UnionDetailWnd L2jBRVar21;

	L2jBRVar21 = UnionDetailWnd(GetScript("UnionDetailWnd"));
	m_SearchedMasterID = 0;
	Record = lstParty.GetSelectedRecord();
	PartyMasterName = Record.LVDataList[0].szData;
	MasterID = Record.nReserved1;
	if ( UnknownFunction130(UnknownFunction151(UnknownFunction125(PartyMasterName),0),UnknownFunction151(MasterID,0)) )
	{
		if ( bShowWindow )
		{
			if ( UnknownFunction129(PartyMemberWnd.IsShowWindow()) )
			{
				PartyMemberWnd.ShowWindow();
			}
		}
		m_SearchedMasterID = MasterID;
		L2jBRVar21.SetMasterInfo(PartyMasterName,MasterID);
		Class'CommandChannelAPI'.RequestCommandChannelPartyMembersInfo(MasterID);
	}
}

function HandleCommandChannelStart ()
{
	L2jBRVar12.ShowWindow();
	L2jBRVar12.SetFocus();
	m_bChOpened = True;
	RequestNewInfo();
	Class'UIAPI_WINDOW'.DisableWindow("UnionWnd.btnBan");
	Class'UIAPI_WINDOW'.DisableWindow("UnionWnd.btnOut");
}

function HandleCommandChannelEnd ()
{
	L2jBRVar12.HideWindow();
	Clear();
	m_bChOpened = False;
}

function HandleCommandChannelInfo (string L2jBRVar1)
{
	local string OwnerName;
	local int RoutingType;
	local int PartyNum;
	local int PartyMemberNum;

	MemberClear();
	ParseString(L2jBRVar1,"OwnerName",OwnerName);
	ParseInt(L2jBRVar1,"RoutingType",RoutingType);
	ParseInt(L2jBRVar1,"PartyNum",PartyNum);
	ParseInt(L2jBRVar1,"PartyMemberNum",PartyMemberNum);
	m_PartyNum = PartyNum;
	m_PartyMemberNum = PartyMemberNum;
	txtOwner.SetText(OwnerName);
	UpdateRoutingType(RoutingType);
	UpdateCountInfo();
	if ( UnknownFunction122(OwnerName,m_UserName) )
	{
		Class'UIAPI_WINDOW'.EnableWindow("UnionWnd.btnBan");
	}
}

function HandleCommandChannelPartyList (string L2jBRVar1)
{
	local LVDataRecord Record;
	local string MasterName;
	local int MasterID;
	local int PartyNum;
	local int TotalCount;

	ParseString(L2jBRVar1,"MasterName",MasterName);
	ParseInt(L2jBRVar1,"MasterID",MasterID);
	ParseInt(L2jBRVar1,"PartyNum",PartyNum);
	Record.LVDataList.Length = 2;
	Record.nReserved1 = MasterID;
	Record.LVDataList[0].szData = MasterName;
	Record.LVDataList[1].szData = string(PartyNum);
	lstParty.InsertRecord(Record);
	if ( UnknownFunction130(UnknownFunction151(m_SearchedMasterID,0),UnknownFunction154(m_SearchedMasterID,MasterID)) )
	{
		if ( PartyMemberWnd.IsShowWindow() )
		{
			TotalCount = lstParty.GetRecordCount();
			if ( UnknownFunction151(TotalCount,0) )
			{
				lstParty.SetSelectedIndex(UnknownFunction147(TotalCount,1),False);
			}
			RequestPartyMember(False);
		}
	}
	if ( UnknownFunction122(MasterName,m_UserName) )
	{
		Class'UIAPI_WINDOW'.EnableWindow("UnionWnd.btnOut");
	}
}

function HandleCommandChannelPartyUpdate (string L2jBRVar1)
{
	local LVDataRecord Record;
	local int SearchIdx;
	local string MasterName;
	local int MasterID;
	local int MemberCount;
	local int L2jBRVar5;
	local UnionDetailWnd L2jBRVar21;

	ParseString(L2jBRVar1,"MasterName",MasterName);
	ParseInt(L2jBRVar1,"MasterID",MasterID);
	ParseInt(L2jBRVar1,"MemberCount",MemberCount);
	ParseInt(L2jBRVar1,"Type",L2jBRVar5);
	if ( UnknownFunction150(MasterID,1) )
	{
		return;
	}
	switch (L2jBRVar5)
	{
		case 0:
		SearchIdx = FindMasterID(MasterID);
		if ( UnknownFunction151(SearchIdx,-1) )
		{
			Record = lstParty.GetRecord(SearchIdx);
			MemberCount = int(Record.LVDataList[1].szData);
			lstParty.DeleteRecord(SearchIdx);
			UnknownFunction166(m_PartyNum);
			m_PartyMemberNum = UnknownFunction147(m_PartyMemberNum,MemberCount);
			if ( PartyMemberWnd.IsShowWindow() )
			{
				L2jBRVar21 = UnionDetailWnd(GetScript("UnionDetailWnd"));
				if ( UnknownFunction154(MasterID,L2jBRVar21.GetMasterID()) )
				{
					L2jBRVar21.Clear();
					PartyMemberWnd.HideWindow();
				}
			}
		}
		break;
		case 1:
		Record.LVDataList.Length = 2;
		Record.nReserved1 = MasterID;
		Record.LVDataList[0].szData = MasterName;
		Record.LVDataList[1].szData = string(MemberCount);
		lstParty.InsertRecord(Record);
		UnknownFunction165(m_PartyNum);
		m_PartyMemberNum = UnknownFunction146(m_PartyMemberNum,MemberCount);
		break;
		default:
	}
	UpdateCountInfo();
	if ( UnknownFunction122(MasterName,m_UserName) )
	{
		Class'UIAPI_WINDOW'.EnableWindow("UnionWnd.btnOut");
	}
}

function HandleCommandChannelRoutingType (string L2jBRVar1)
{
	local int RoutingType;

	ParseInt(L2jBRVar1,"RoutingType",RoutingType);
	UpdateRoutingType(RoutingType);
}

function UpdateRoutingType (int L2jBRVar5)
{
	if ( UnknownFunction154(L2jBRVar5,0) )
	{
		txtRoutingType.SetText(GetSystemString(1383));
	} else {
		if ( UnknownFunction154(L2jBRVar5,1) )
		{
			txtRoutingType.SetText(GetSystemString(1384));
		}
	}
}

function int FindMasterID (int MasterID)
{
	local int L2jBRVar2;
	local LVDataRecord Record;
	local int SearchIdx;

	SearchIdx = -1;
	L2jBRVar2 = 0;
	if ( UnknownFunction150(L2jBRVar2,lstParty.GetRecordCount()) )
	{
		Record = lstParty.GetRecord(L2jBRVar2);
		if ( UnknownFunction154(Record.nReserved1,MasterID) )
		{
			SearchIdx = L2jBRVar2;
		} else {
			UnknownFunction165(L2jBRVar2);
			goto JL0012;
		}
	}
	return SearchIdx;
}

function UpdateCountInfo ()
{
	txtCountInfo.SetText(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(string(m_PartyNum),GetSystemString(440))," / "),string(m_PartyMemberNum)),GetSystemString(1013)));
}

function UpdatePartyMemberCount (int MasterID, int MemberCount)
{
	local int L2jBRVar2;
	local LVDataRecord Record;

	L2jBRVar2 = FindMasterID(MasterID);
	if ( UnknownFunction151(L2jBRVar2,-1) )
	{
		Record = lstParty.GetRecord(L2jBRVar2);
		m_PartyMemberNum = UnknownFunction147(m_PartyMemberNum,int(Record.LVDataList[1].szData));
		m_PartyMemberNum = UnknownFunction146(m_PartyMemberNum,MemberCount);
		Record.LVDataList[1].szData = string(MemberCount);
		lstParty.ModifyRecord(L2jBRVar2,Record);
	}
	UpdateCountInfo();
}

function OnExitState (name a_NextStateName)
{
	if ( UnknownFunction254(a_NextStateName,'LoadingState') )
	{
		HandleCommandChannelEnd();
	}
}

