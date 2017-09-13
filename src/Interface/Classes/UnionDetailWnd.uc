//================================================================================
// UnionDetailWnd.
//================================================================================

class UnionDetailWnd extends UICommonAPI;

var int m_MasterID;
var WindowHandle L2jBRVar12;
var TextBoxHandle txtMasterName;
var ListCtrlHandle lstPartyMember;

function OnLoad ()
{
	RegisterEvent(1420);
	L2jBRVar12 = GetHandle("UnionDetailWnd");
	txtMasterName = TextBoxHandle(GetHandle("UnionDetailWnd.txtMasterName"));
	lstPartyMember = ListCtrlHandle(GetHandle("UnionDetailWnd.lstPartyMember"));
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,1420) )
	{
		HandleCommandChannelPartyMember(L2jBRVar1);
	}
}

function SetMasterInfo (string MasterName, int MasterID)
{
	txtMasterName.SetText(MasterName);
	m_MasterID = MasterID;
}

function int GetMasterID ()
{
	return m_MasterID;
}

function Clear ()
{
	lstPartyMember.DeleteAllItem();
	txtMasterName.SetText("");
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnClose":
		OnCloseClick();
		break;
		default:
	}
}

function OnCloseClick ()
{
	L2jBRVar12.HideWindow();
}

function OnDBClickListCtrlRecord (string strID)
{
	local UserInfo UserInfo;
	local LVDataRecord Record;
	local int ServerID;

	if ( UnknownFunction122(strID,"lstPartyMember") )
	{
		Record = lstPartyMember.GetSelectedRecord();
		ServerID = Record.nReserved1;
		if ( UnknownFunction151(ServerID,0) )
		{
			if ( GetPlayerInfo(UserInfo) )
			{
				if ( IsPKMode() )
				{
					RequestAttack(ServerID,UserInfo.Loc);
				} else {
					RequestAction(ServerID,UserInfo.Loc);
				}
			}
		}
	}
}

function HandleCommandChannelPartyMember (string L2jBRVar1)
{
	local LVDataRecord Record;
	local int L2jBRVar2;
	local int MemberCount;
	local string Name;
	local int ClassID;
	local int ServerID;
	local UnionWnd L2jBRVar21;

	lstPartyMember.DeleteAllItem();
	ParseInt(L2jBRVar1,"MemberCount",MemberCount);
	L2jBRVar2 = 0;
	if ( UnknownFunction150(L2jBRVar2,MemberCount) )
	{
		ParseString(L2jBRVar1,UnknownFunction112("Name_",string(L2jBRVar2)),Name);
		ParseInt(L2jBRVar1,UnknownFunction112("ClassID_",string(L2jBRVar2)),ClassID);
		ParseInt(L2jBRVar1,UnknownFunction112("ServerID_",string(L2jBRVar2)),ServerID);
		if ( UnknownFunction151(UnknownFunction125(Name),0) )
		{
			Record.LVDataList.Length = 2;
			Record.nReserved1 = ServerID;
			Record.LVDataList[0].szData = Name;
			Record.LVDataList[1].nTextureWidth = 11;
			Record.LVDataList[1].nTextureHeight = 11;
			Record.LVDataList[1].szData = string(ClassID);
			Record.LVDataList[1].szTexture = GetClassIconName(ClassID);
			lstPartyMember.InsertRecord(Record);
		}
		UnknownFunction165(L2jBRVar2);
		goto JL0033;
	}
	L2jBRVar21 = UnionWnd(GetScript("UnionWnd"));
	L2jBRVar21.UpdatePartyMemberCount(m_MasterID,MemberCount);
}

