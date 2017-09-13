//================================================================================
// InviteClanPopWnd.
//================================================================================

class InviteClanPopWnd extends UIScript;

var string m_UserName;
var array<int> m_knighthoodIndex;

function OnLoad ()
{
	m_knighthoodIndex.Length = 8;
	m_knighthoodIndex[0] = 0;
	m_knighthoodIndex[1] = 100;
	m_knighthoodIndex[2] = 200;
	m_knighthoodIndex[3] = 1001;
	m_knighthoodIndex[4] = 1002;
	m_knighthoodIndex[5] = 2001;
	m_knighthoodIndex[6] = 2002;
	m_knighthoodIndex[7] = -1;
	RegisterEvent(160);
}

function OnShow ()
{
	InitializeComboBox();
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 160:
		Class'UIAPI_WINDOW'.HideWindow("InviteClanPopWnd");
		break;
		default:
		break;
	}
}

function OnClickButton (string strID)
{
	if ( UnknownFunction122(strID,"InviteClandPopOkBtn") )
	{
		AskJoin();
		Class'UIAPI_WINDOW'.HideWindow("InviteClanPopWnd");
	} else {
		if ( UnknownFunction122(strID,"InviteClandPopCancelBtn") )
		{
			Class'UIAPI_WINDOW'.HideWindow("InviteClanPopWnd");
		}
	}
}

function AskJoin ()
{
	local UserInfo User;
	local int Index;
	local int knighthoodID;

	if ( GetTargetInfo(User) )
	{
		if ( UnknownFunction151(User.nID,0) )
		{
			Index = Class'UIAPI_COMBOBOX'.GetSelectedNum("InviteClanPopWnd.ComboboxInviteClandPopWnd");
			if ( UnknownFunction153(Index,0) )
			{
				knighthoodID = Class'UIAPI_COMBOBOX'.GetReserved("InviteClanPopWnd.ComboboxInviteClandPopWnd",Index);
				Debug(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("AskJoin : id ",string(User.nID))," name "),User.Name)," clanType "),string(knighthoodID)));
				RequestClanAskJoin(User.nID,knighthoodID);
			}
		}
	}
}

function InitializeComboBox ()
{
	local int i;
	local ClanWnd L2jBRVar21;
	local int addedCount;
	local string countnum;
	local string countnum2;
	local int cnt1;
	local int cnt2;

	L2jBRVar21 = ClanWnd(GetScript("ClanWnd"));
	Class'UIAPI_COMBOBOX'.Clear("InviteClanPopWnd.ComboboxInviteClandPopWnd");
	countnum2 = UnknownFunction112("",string(L2jBRVar21.m_myClanType));
	Debug(countnum2);
	cnt1 = UnknownFunction125(countnum2);
	i = 0;
	if ( UnknownFunction150(i,8) )
	{
		countnum = UnknownFunction112("",string(m_knighthoodIndex[i]));
		Debug(countnum);
		cnt2 = UnknownFunction125(countnum);
		if ( UnknownFunction123(L2jBRVar21.m_memberList[i].m_sName,"") )
		{
			if ( UnknownFunction154(m_knighthoodIndex[i],-1) )
			{
				Class'UIAPI_COMBOBOX'.AddStringWithReserved("InviteClanPopWnd.ComboboxInviteClandPopWnd",L2jBRVar21.m_memberList[i].m_sName,m_knighthoodIndex[i]);
				UnknownFunction163(addedCount);
			} else {
				if ( UnknownFunction152(cnt1,cnt2) )
				{
					Class'UIAPI_COMBOBOX'.AddStringWithReserved("InviteClanPopWnd.ComboboxInviteClandPopWnd",L2jBRVar21.m_memberList[i].m_sName,m_knighthoodIndex[i]);
					UnknownFunction163(addedCount);
				}
			}
		}
		UnknownFunction163(i);
		goto JL008E;
	}
	if ( UnknownFunction151(addedCount,0) )
	{
		Class'UIAPI_COMBOBOX'.SetSelectedNum("InviteClanPopWnd.ComboboxInviteClandPopWnd",0);
	}
}

