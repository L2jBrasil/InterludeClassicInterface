//================================================================================
// SSQMainBoard.
//================================================================================

class SSQMainBoard extends UIScript;

struct SSQMainEventInfo
{
	var int m_nSSQStatus;
	var int m_nEventType;
	var int m_nEventNo;
	var int m_nWinPoint;
	var int m_nTeam1Score;
	var int m_nTeam2Score;
	var string m_Team1MemberName[9];
	var string m_Team2MemberName[9];
};

struct SSQPreStatusInfo
{
	var int m_nWinner;
	var int m_nRoomNum;
	var array<int> m_nSealNumArray;
	var array<int> m_nWinnerArray;
	var array<int> m_nMsgArray;
};

struct SSQStatusInfo
{
	var int m_nSSQStatus;
	var int m_nSSQTeam;
	var int m_nSelectedSeal;
	var int m_nContribution;
	var int m_nTeam1HuntingMark;
	var int m_nTeam2HuntingMark;
	var int m_nTeam1MainEventMark;
	var int m_nTeam2MainEventMark;
	var int m_nTeam1Per;
	var int m_nTeam2Per;
	var int m_nTeam1TotalMark;
	var int m_nTeam2TotalMark;
	var int m_nPeriod;
	var int m_nMsgNum1;
	var int m_nMsgNum2;
	var int m_nSealStoneAdena;
};

var SSQStatusInfo g_sinfo;
var SSQPreStatusInfo g_sinfopre;
var bool m_bShowPreInfo;
var bool m_bRequest_SealStatus;
var bool m_bRequest_MainEvent;

const SSQS_STRIFE= 3;
const SSQS_REVEAL= 2;
const SSQS_GREED= 1;
const SSQS_NONE= 0;
const SSQE_TIMEATTACK= 0;
const SSQT_DAWN= 2;
const SSQT_DUSK= 1;
const SSQT_NONE= 0;
const SSQR_PREINFO= 4;
const SSQR_SEALSTATUS= 3;
const SSQR_MAINEVENT= 2;
const SSQR_STATUS= 1;
const NC_PARTYMEMBER_MAX= 9;

function OnLoad ()
{
	RegisterEvent(740);
	RegisterEvent(770);
	RegisterEvent(750);
	RegisterEvent(760);
	m_bRequest_SealStatus = False;
	m_bRequest_MainEvent = False;
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtSS",UnknownFunction112(GetSystemString(833)," - "));
	m_bShowPreInfo = False;
	SetSSQStatus();
}

function OnShow ()
{
	Class'UIAPI_TABCTRL'.SetTopOrder("SSQMainBoard.TabCtrl",0,True);
	PlayConsoleSound(5);
	SetSSQStatus();
}

function OnHide ()
{
	m_bRequest_SealStatus = False;
	m_bRequest_MainEvent = False;
	m_bShowPreInfo = False;
	Class'UIAPI_TREECTRL'.Clear("SSQMainBoard.me_MainTree");
	Class'UIAPI_TREECTRL'.Clear("SSQMainBoard.ss_MainTree");
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local int i;
	local int j;
	local int k;
	local int L;
	local string strTmp;
	local int m_nSSQStatus;
	local int m_nNeedPoint1;
	local int m_nNeedPoint2;
	local int sealnum;
	local int m_nSealID;
	local int m_nOwnerTeamID;
	local int m_nTeam1Mark;
	local int m_nTeam2Mark;
	local SSQMainEventInfo Info;
	local int eventnum;
	local int nEventType;
	local int roomnum;
	local int team1num;
	local int team2num;

	if ( UnknownFunction154(Event_ID,740) )
	{
		ParseInt(L2jBRVar1,"SuccessRate",g_sinfo.m_nSSQStatus);
		ParseInt(L2jBRVar1,"Period",g_sinfo.m_nPeriod);
		ParseInt(L2jBRVar1,"MsgNum1",g_sinfo.m_nMsgNum1);
		ParseInt(L2jBRVar1,"MsgNum2",g_sinfo.m_nMsgNum2);
		ParseInt(L2jBRVar1,"SSQTeam",g_sinfo.m_nSSQTeam);
		ParseInt(L2jBRVar1,"SelectedSeal",g_sinfo.m_nSelectedSeal);
		ParseInt(L2jBRVar1,"Contribution",g_sinfo.m_nContribution);
		ParseInt(L2jBRVar1,"SealStoneAdena",g_sinfo.m_nSealStoneAdena);
		ParseInt(L2jBRVar1,"Team1HuntingMark",g_sinfo.m_nTeam1HuntingMark);
		ParseInt(L2jBRVar1,"Team1MainEventMark",g_sinfo.m_nTeam1MainEventMark);
		ParseInt(L2jBRVar1,"Team2HuntingMark",g_sinfo.m_nTeam2HuntingMark);
		ParseInt(L2jBRVar1,"Team2MainEventMark",g_sinfo.m_nTeam2MainEventMark);
		ParseInt(L2jBRVar1,"Team1Per",g_sinfo.m_nTeam1Per);
		ParseInt(L2jBRVar1,"Team2Per",g_sinfo.m_nTeam2Per);
		ParseInt(L2jBRVar1,"Team1TotalMark",g_sinfo.m_nTeam1TotalMark);
		ParseInt(L2jBRVar1,"Team2TotalMark",g_sinfo.m_nTeam2TotalMark);
		SetSSQStatusInfo();
		SetSSQPreInfo();
		Class'UIAPI_WINDOW'.ShowWindow("SSQMainBoard");
		Class'UIAPI_WINDOW'.SetFocus("SSQMainBoard");
	} else {
		if ( UnknownFunction154(Event_ID,770) )
		{
			ClearSSQPreInfo();
			ParseInt(L2jBRVar1,"Winner",g_sinfopre.m_nWinner);
			ParseInt(L2jBRVar1,"RoomNum",g_sinfopre.m_nRoomNum);
			i = 0;
			if ( UnknownFunction150(i,g_sinfopre.m_nRoomNum) )
			{
				byte(g_sinfopre.m_nSealNumArray)
				g_sinfopre.m_nSealNumArray.Length
				1
				ParseInt(L2jBRVar1,UnknownFunction112("SealNum_",string(i)),g_sinfopre.m_nSealNumArray[UnknownFunction147(g_sinfopre.m_nSealNumArray.Length,1)]);
				byte(g_sinfopre.m_nWinnerArray)
				g_sinfopre.m_nWinnerArray.Length
				1
				ParseInt(L2jBRVar1,UnknownFunction112("Winner_",string(i)),g_sinfopre.m_nWinnerArray[UnknownFunction147(g_sinfopre.m_nWinnerArray.Length,1)]);
				byte(g_sinfopre.m_nMsgArray)
				g_sinfopre.m_nMsgArray.Length
				1
				ParseInt(L2jBRVar1,UnknownFunction112("Msg_",string(i)),g_sinfopre.m_nMsgArray[UnknownFunction147(g_sinfopre.m_nMsgArray.Length,1)]);
				UnknownFunction165(i);
				goto JL02DB;
			}
			SetSSQPreInfo();
		} else {
			if ( UnknownFunction154(Event_ID,750) )
			{
				ParseInt(L2jBRVar1,"SSQStatus",m_nSSQStatus);
				Info.m_nSSQStatus = m_nSSQStatus;
				ParseInt(L2jBRVar1,"EventNum",eventnum);
				i = 0;
				if ( UnknownFunction150(i,eventnum) )
				{
					ParseInt(L2jBRVar1,UnknownFunction112("EventType_",string(i)),nEventType);
					Info.m_nEventType = nEventType;
					ParseInt(L2jBRVar1,UnknownFunction112("RoomNum_",string(i)),roomnum);
					j = 0;
					if ( UnknownFunction150(j,roomnum) )
					{
						ParseInt(L2jBRVar1,UnknownFunction112(UnknownFunction112(UnknownFunction112("EventNo_",string(i)),"_"),string(j)),Info.m_nEventNo);
						ParseInt(L2jBRVar1,UnknownFunction112(UnknownFunction112(UnknownFunction112("WinPoint_",string(i)),"_"),string(j)),Info.m_nWinPoint);
						ParseInt(L2jBRVar1,UnknownFunction112(UnknownFunction112(UnknownFunction112("Team2Score_",string(i)),"_"),string(j)),Info.m_nTeam2Score);
						ParseInt(L2jBRVar1,UnknownFunction112(UnknownFunction112(UnknownFunction112("Team2Num_",string(i)),"_"),string(j)),team2num);
						k = 0;
						if ( UnknownFunction150(k,team2num) )
						{
							ParseString(L2jBRVar1,UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("Team2MemberName_",string(i)),"_"),string(j)),"_"),string(k)),strTmp);
							if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
							{
								Info.m_Team2MemberName[k] = strTmp;
							}
							UnknownFunction165(k);
							goto JL059E;
						}
						ParseInt(L2jBRVar1,UnknownFunction112(UnknownFunction112(UnknownFunction112("Team1Score_",string(i)),"_"),string(j)),Info.m_nTeam1Score);
						ParseInt(L2jBRVar1,UnknownFunction112(UnknownFunction112(UnknownFunction112("Team1Num_",string(i)),"_"),string(j)),team1num);
						L = 0;
						if ( UnknownFunction150(L,team1num) )
						{
							ParseString(L2jBRVar1,UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("Team1MemberName_",string(i)),"_"),string(j)),"_"),string(L)),strTmp);
							if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
							{
								Info.m_Team1MemberName[L] = strTmp;
							}
							UnknownFunction165(L);
							goto JL0693;
						}
						AddSSQMainEvent(Info);
						ClearSSQMainEventInfo(Info);
						Info.m_nSSQStatus = m_nSSQStatus;
						Info.m_nEventType = nEventType;
						UnknownFunction165(j);
						goto JL04B0;
					}
					UnknownFunction165(i);
					goto JL0442;
				}
			} else {
				if ( UnknownFunction154(Event_ID,760) )
				{
					ParseInt(L2jBRVar1,"SSQStatus",m_nSSQStatus);
					ParseInt(L2jBRVar1,"NeedPoint1",m_nNeedPoint1);
					ParseInt(L2jBRVar1,"NeedPoint2",m_nNeedPoint2);
					ParseInt(L2jBRVar1,"SealNum",sealnum);
					i = 0;
					if ( UnknownFunction150(i,sealnum) )
					{
						ParseInt(L2jBRVar1,UnknownFunction112("SealID_",string(i)),m_nSealID);
						ParseInt(L2jBRVar1,UnknownFunction112("OwnerTeamID_",string(i)),m_nOwnerTeamID);
						ParseInt(L2jBRVar1,UnknownFunction112("Team2Mark_",string(i)),m_nTeam2Mark);
						ParseInt(L2jBRVar1,UnknownFunction112("Team1Mark_",string(i)),m_nTeam1Mark);
						AddSSQSealStatus(m_nSSQStatus,m_nNeedPoint1,m_nNeedPoint2,m_nSealID,m_nOwnerTeamID,m_nTeam1Mark,m_nTeam2Mark);
						UnknownFunction165(i);
						goto JL07E5;
					}
				}
			}
		}
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "s_btnRenew":
		if ( m_bShowPreInfo )
		{
			Class'SSQAPI'.RequestSSQStatus(4);
		} else {
			Class'SSQAPI'.RequestSSQStatus(1);
		}
		break;
		case "s_btnPreview":
		m_bShowPreInfo = UnknownFunction129(m_bShowPreInfo);
		if ( m_bShowPreInfo )
		{
			Class'SSQAPI'.RequestSSQStatus(4);
		}
		SetSSQStatus();
		break;
		case "ss_btnRenew":
		ShowSSQSealStatus();
		break;
		case "me_btnRenew":
		ShowSSQMainEvent();
		break;
		case "TabCtrl0":
		SetSSQStatus();
		break;
		case "TabCtrl1":
		if ( UnknownFunction129(m_bRequest_MainEvent) )
		{
			ShowSSQMainEvent();
			m_bRequest_MainEvent = True;
		}
		break;
		case "TabCtrl2":
		if ( UnknownFunction129(m_bRequest_SealStatus) )
		{
			ShowSSQSealStatus();
			m_bRequest_SealStatus = True;
		}
		break;
		default:
	}
}

function SetSSQStatus ()
{
	if ( m_bShowPreInfo )
	{
		Class'UIAPI_BUTTON'.SetButtonName("SSQMainBoard.s_btnPreview",939);
		Class'UIAPI_WINDOW'.ShowWindow("SSQMainBoard.SSQStatusWnd_Preview");
		Class'UIAPI_WINDOW'.HideWindow("SSQMainBoard.SSQStatusWnd_Status");
	} else {
		Class'UIAPI_BUTTON'.SetButtonName("SSQMainBoard.s_btnPreview",937);
		Class'UIAPI_WINDOW'.ShowWindow("SSQMainBoard.SSQStatusWnd_Status");
		Class'UIAPI_WINDOW'.HideWindow("SSQMainBoard.SSQStatusWnd_Preview");
	}
}

function SetSSQStatusInfo ()
{
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtTime",UnknownFunction112(UnknownFunction112(string(g_sinfo.m_nPeriod)," "),GetSystemString(934)));
	if ( UnknownFunction151(g_sinfo.m_nMsgNum1,0) )
	{
		Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtSta1",GetSystemMessage(g_sinfo.m_nMsgNum1));
	} else {
		Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtSta1","");
	}
	if ( UnknownFunction151(g_sinfo.m_nMsgNum2,0) )
	{
		Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtSta2",GetSystemMessage(g_sinfo.m_nMsgNum2));
	} else {
		Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtSta2","");
	}
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtMyTeamName",GetSSQTeamName(g_sinfo.m_nSSQTeam));
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtMySealName",GetSSQSealName(g_sinfo.m_nSelectedSeal));
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtMySealStoneCount",UnknownFunction112(string(g_sinfo.m_nContribution),GetSystemString(932)));
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtMySealStoneCountAdena",UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(g_sinfo.m_nSealStoneAdena)),GetSystemString(933)),")"));
	if ( UnknownFunction154(g_sinfo.m_nSSQStatus,3) )
	{
		Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtAllStaCur",UnknownFunction112(" - ",GetSystemString(838)));
	} else {
		Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtAllStaCur",UnknownFunction112(" - ",GetSystemString(837)));
	}
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtAllDawn",GetSSQTeamName(2));
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtAllDusk",GetSSQTeamName(1));
	Class'UIAPI_WINDOW'.SetWindowSize("SSQMainBoard.texDawnValue",int(UnknownFunction172(UnknownFunction171(g_sinfo.m_nTeam2Per,150.0),100.0)),11);
	Class'UIAPI_WINDOW'.SetWindowSize("SSQMainBoard.texDuskValue",int(UnknownFunction172(UnknownFunction171(g_sinfo.m_nTeam1Per,150.0),100.0)),11);
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtPointDawn",GetSSQTeamName(2));
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtPointDusk",GetSSQTeamName(1));
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtPointDawn1",UnknownFunction112("",string(g_sinfo.m_nTeam2HuntingMark)));
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtPointDawn2",UnknownFunction112("",string(g_sinfo.m_nTeam2MainEventMark)));
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtPointDawn3",UnknownFunction112("",string(g_sinfo.m_nTeam2TotalMark)));
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtPointDusk1",UnknownFunction112("",string(g_sinfo.m_nTeam1HuntingMark)));
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtPointDusk2",UnknownFunction112("",string(g_sinfo.m_nTeam1MainEventMark)));
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.txtPointDusk3",UnknownFunction112("",string(g_sinfo.m_nTeam1TotalMark)));
}

function ClearSSQPreInfo ()
{
	g_sinfopre.m_nWinner = 0;
	g_sinfopre.m_nRoomNum = 0;
	g_sinfopre.m_nSealNumArray.Remove (0,g_sinfopre.m_nSealNumArray.Length);
	g_sinfopre.m_nWinnerArray.Remove (0,g_sinfopre.m_nWinnerArray.Length);
	g_sinfopre.m_nMsgArray.Remove (0,g_sinfopre.m_nMsgArray.Length);
}

function SetSSQPreInfo ()
{
	local string strTmp;

	if ( UnknownFunction154(g_sinfopre.m_nWinner,1) )
	{
		strTmp = GetSSQTeamName(1);
		Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.pre_txtWinTeam",UnknownFunction112(UnknownFunction112(strTmp," "),GetSystemString(828)));
	} else {
		if ( UnknownFunction154(g_sinfopre.m_nWinner,2) )
		{
			strTmp = GetSSQTeamName(2);
			Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.pre_txtWinTeam",UnknownFunction112(UnknownFunction112(strTmp," "),GetSystemString(828)));
		} else {
			Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.pre_txtWinTeam","");
		}
	}
	if ( UnknownFunction155(g_sinfopre.m_nWinner,0) )
	{
		strTmp = MakeFullSystemMsg(GetSystemMessage(1288),strTmp,"");
	} else {
		strTmp = GetSystemMessage(1293);
	}
	Class'UIAPI_TEXTBOX'.SetText("SSQMainBoard.pre_txtWinText",strTmp);
	AddSSQPreInfoSealStatus();
}

function AddSSQPreInfoSealStatus ()
{
	local int i;
	local int nSealNum;
	local int nWinner;
	local int nMsgNum;
	local XMLTreeNodeInfo infNode;
	local XMLTreeNodeItemInfo infNodeItem;
	local XMLTreeNodeInfo infNodeClear;
	local XMLTreeNodeItemInfo infNodeItemClear;
	local string strRetName;

	Class'UIAPI_TREECTRL'.Clear("SSQMainBoard.pre_MainTree");
	if ( UnknownFunction150(g_sinfopre.m_nSealNumArray.Length,1) )
	{
		Class'UIAPI_WINDOW'.HideWindow("SSQMainBoard.pre_MainTree");
		return;
	} else {
		Class'UIAPI_WINDOW'.ShowWindow("SSQMainBoard.pre_MainTree");
	}
	infNode.strName = "root";
	strRetName = Class'UIAPI_TREECTRL'.InsertNode("SSQMainBoard.pre_MainTree","",infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert root node. Name: ",infNode.strName));
		return;
	}
	infNode = infNodeClear;
	infNode.strName = "node";
	infNode.nOffSetX = 2;
	infNode.nOffSetY = 3;
	infNode.bShowButton = 0;
	infNode.bDrawBackground = 1;
	infNode.bTexBackHighlight = 1;
	infNode.nTexBackHighlightHeight = 17;
	infNode.nTexBackWidth = 240;
	infNode.nTexBackUWidth = 211;
	infNode.nTexBackOffSetX = -3;
	infNode.nTexBackOffSetY = -4;
	infNode.nTexBackOffSetBottom = 2;
	strRetName = Class'UIAPI_TREECTRL'.InsertNode("SSQMainBoard.pre_MainTree","root",infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
		return;
	}
	i = 0;
	if ( UnknownFunction150(i,g_sinfopre.m_nSealNumArray.Length) )
	{
		nSealNum = g_sinfopre.m_nSealNumArray[i];
		nWinner = g_sinfopre.m_nWinnerArray[i];
		nMsgNum = g_sinfopre.m_nMsgArray[i];
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = UnknownFunction112(GetSSQSealName(nSealNum)," : ");
		infNodeItem.nOffSetX = 4;
		infNodeItem.nOffSetY = 0;
		infNodeItem.t_color.R = 128;
		infNodeItem.t_color.G = 128;
		infNodeItem.t_color.B = 128;
		infNodeItem.t_color.A = 255;
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.pre_MainTree",strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		if ( UnknownFunction154(nWinner,1) )
		{
			infNodeItem.t_strText = GetSSQTeamName(1);
		} else {
			if ( UnknownFunction154(nWinner,2) )
			{
				infNodeItem.t_strText = GetSSQTeamName(2);
			} else {
				infNodeItem.t_strText = GetSystemString(936);
			}
		}
		infNodeItem.nOffSetX = 0;
		infNodeItem.nOffSetY = 0;
		infNodeItem.t_color.R = 176;
		infNodeItem.t_color.G = 155;
		infNodeItem.t_color.B = 121;
		infNodeItem.t_color.A = 255;
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.pre_MainTree",strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = GetSystemMessage(nMsgNum);
		infNodeItem.bLineBreak = True;
		infNodeItem.nOffSetX = 8;
		infNodeItem.nOffSetY = 6;
		infNodeItem.t_color.R = 128;
		infNodeItem.t_color.G = 128;
		infNodeItem.t_color.B = 128;
		infNodeItem.t_color.A = 255;
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.pre_MainTree",strRetName,infNodeItem);
		if ( UnknownFunction155(i,UnknownFunction147(g_sinfopre.m_nSealNumArray.Length,1)) )
		{
			infNodeItem = infNodeItemClear;
			infNodeItem.eType = 0;
			infNodeItem.b_nHeight = 20;
			Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.pre_MainTree",strRetName,infNodeItem);
		}
		UnknownFunction165(i);
		goto JL0257;
	}
}

function ClearSSQMainEventInfo (out SSQMainEventInfo Info)
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,9) )
	{
		Info.m_Team1MemberName[i] = "";
		Info.m_Team2MemberName[i] = "";
		UnknownFunction165(i);
		goto JL0007;
	}
}

function ShowSSQMainEvent ()
{
	local XMLTreeNodeInfo infNode;
	local string strRetName;

	Class'UIAPI_TREECTRL'.Clear("SSQMainBoard.me_MainTree");
	infNode.strName = "root";
	infNode.nOffSetX = 3;
	infNode.nOffSetY = 5;
	strRetName = Class'UIAPI_TREECTRL'.InsertNode("SSQMainBoard.me_MainTree","",infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert root node. Name: ",infNode.strName));
		return;
	}
	Class'SSQAPI'.RequestSSQStatus(2);
}

function AddSSQMainEvent (SSQMainEventInfo Info)
{
	local int i;
	local XMLTreeNodeInfo infNode;
	local XMLTreeNodeItemInfo infNodeItem;
	local XMLTreeNodeInfo infNodeClear;
	local XMLTreeNodeItemInfo infNodeItemClear;
	local string strRetName;
	local string strNodeName;
	local string strTmp;

	strNodeName = UnknownFunction112("root.",string(Info.m_nEventType));
	if ( Class'UIAPI_TREECTRL'.IsNodeNameExist("SSQMainBoard.me_MainTree",strNodeName) )
	{
		strRetName = strNodeName;
	} else {
		infNode = infNodeClear;
		infNode.strName = UnknownFunction112("",string(Info.m_nEventType));
		infNode.bShowButton = 1;
		infNode.nTexBtnWidth = 14;
		infNode.nTexBtnHeight = 14;
		infNode.strTexBtnExpand = "L2UI_CH3.QUESTWND.QuestWndPlusBtn";
		infNode.strTexBtnCollapse = "L2UI_CH3.QUESTWND.QuestWndMinusBtn";
		infNode.strTexBtnExpand_Over = "L2UI_CH3.QUESTWND.QuestWndPlusBtn_over";
		infNode.strTexBtnCollapse_Over = "L2UI_CH3.QUESTWND.QuestWndMinusBtn_over";
		infNode.nTexExpandedOffSetY = 1;
		infNode.nTexExpandedHeight = 13;
		infNode.nTexExpandedRightWidth = 32;
		infNode.nTexExpandedLeftUWidth = 16;
		infNode.nTexExpandedLeftUHeight = 13;
		infNode.nTexExpandedRightUWidth = 32;
		infNode.nTexExpandedRightUHeight = 13;
		infNode.strTexExpandedLeft = "L2UI_CH3.ListCtrl.TextSelect";
		infNode.strTexExpandedRight = "L2UI_CH3.ListCtrl.TextSelect2";
		strRetName = Class'UIAPI_TREECTRL'.InsertNode("SSQMainBoard.me_MainTree","root",infNode);
		if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
		{
			Debug(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
			return;
		}
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		if ( UnknownFunction154(Info.m_nEventType,0) )
		{
			infNodeItem.t_strText = GetSystemString(845);
		} else {
			infNodeItem.t_strText = GetSystemString(27);
		}
		infNodeItem.nOffSetX = 4;
		infNodeItem.nOffSetY = 2;
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 0;
		infNodeItem.b_nHeight = 8;
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	}
	infNode = infNodeClear;
	infNode.strName = UnknownFunction112("",string(Info.m_nEventNo));
	infNode.nOffSetX = 7;
	infNode.nOffSetY = 0;
	infNode.bShowButton = 1;
	infNode.nTexBtnWidth = 14;
	infNode.nTexBtnHeight = 14;
	infNode.strTexBtnExpand = "L2UI_CH3.QUESTWND.QuestWndDownBtn";
	infNode.strTexBtnCollapse = "L2UI_CH3.QUESTWND.QuestWndUpBtn";
	infNode.strTexBtnExpand_Over = "L2UI_CH3.QUESTWND.QuestWndDownBtn_over";
	infNode.strTexBtnCollapse_Over = "L2UI_CH3.QUESTWND.QuestWndUpBtn_over";
	strRetName = Class'UIAPI_TREECTRL'.InsertNode("SSQMainBoard.me_MainTree",strRetName,infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		UnknownFunction231(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
		return;
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSSQTimeAttackEventRoomName(Info.m_nEventNo);
	infNodeItem.nOffSetX = 5;
	infNodeItem.nOffSetY = 2;
	infNodeItem.t_color.R = 128;
	infNodeItem.t_color.G = 128;
	infNodeItem.t_color.B = 128;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	if ( UnknownFunction154(Info.m_nSSQStatus,1) )
	{
		infNodeItem.t_strText = GetSystemString(829);
	} else {
		if ( UnknownFunction151(Info.m_nTeam1Score,Info.m_nTeam2Score) )
		{
			infNodeItem.t_strText = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",GetSystemString(923))," "),GetSystemString(828)),")");
		} else {
			if ( UnknownFunction150(Info.m_nTeam1Score,Info.m_nTeam2Score) )
			{
				infNodeItem.t_strText = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",GetSystemString(924))," "),GetSystemString(828)),")");
			} else {
				infNodeItem.t_strText = UnknownFunction112(UnknownFunction112("(",GetSystemString(846)),")");
			}
		}
	}
	infNodeItem.nOffSetX = 5;
	infNodeItem.nOffSetY = 2;
	infNodeItem.t_color.R = 176;
	infNodeItem.t_color.G = 155;
	infNodeItem.t_color.B = 121;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = UnknownFunction112(GetSystemString(831)," : ");
	infNodeItem.bLineBreak = True;
	infNodeItem.nOffSetX = 19;
	infNodeItem.nOffSetY = 4;
	infNodeItem.t_color.R = 128;
	infNodeItem.t_color.G = 128;
	infNodeItem.t_color.B = 128;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = UnknownFunction112("",string(Info.m_nWinPoint));
	infNodeItem.nOffSetX = 0;
	infNodeItem.nOffSetY = 4;
	infNodeItem.t_color.R = 176;
	infNodeItem.t_color.G = 155;
	infNodeItem.t_color.B = 121;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 0;
	infNodeItem.b_nHeight = 8;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	infNode = infNodeClear;
	infNode.strName = "member";
	infNode.nOffSetX = 2;
	infNode.nOffSetY = 0;
	infNode.bShowButton = 0;
	infNode.bDrawBackground = 1;
	infNode.bTexBackHighlight = 1;
	infNode.nTexBackHighlightHeight = 16;
	infNode.nTexBackWidth = 218;
	infNode.nTexBackUWidth = 211;
	infNode.nTexBackOffSetX = 0;
	infNode.nTexBackOffSetY = -3;
	infNode.nTexBackOffSetBottom = -2;
	strRetName = Class'UIAPI_TREECTRL'.InsertNode("SSQMainBoard.me_MainTree",strRetName,infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
		return;
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSSQTeamName(2);
	infNodeItem.nOffSetX = 5;
	infNodeItem.nOffSetY = 0;
	infNodeItem.t_color.R = 128;
	infNodeItem.t_color.G = 128;
	infNodeItem.t_color.B = 128;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSystemString(830);
	infNodeItem.bLineBreak = True;
	infNodeItem.nOffSetX = 5;
	infNodeItem.nOffSetY = 4;
	infNodeItem.t_color.R = 128;
	infNodeItem.t_color.G = 128;
	infNodeItem.t_color.B = 128;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = UnknownFunction112("",string(Info.m_nTeam1Score));
	infNodeItem.nOffSetX = 5;
	infNodeItem.nOffSetY = 4;
	infNodeItem.t_color.R = 176;
	infNodeItem.t_color.G = 155;
	infNodeItem.t_color.B = 121;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSystemString(832);
	infNodeItem.bLineBreak = True;
	infNodeItem.nOffSetX = 5;
	infNodeItem.nOffSetY = 4;
	infNodeItem.t_color.R = 128;
	infNodeItem.t_color.G = 128;
	infNodeItem.t_color.B = 128;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	i = 0;
	if ( UnknownFunction150(i,9) )
	{
		strTmp = Info.m_Team1MemberName[i];
		if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
		{
			infNodeItem = infNodeItemClear;
			infNodeItem.eType = 1;
			infNodeItem.t_strText = strTmp;
			infNodeItem.bLineBreak = True;
			infNodeItem.nOffSetX = 5;
			infNodeItem.nOffSetY = 4;
			infNodeItem.t_color.R = 176;
			infNodeItem.t_color.G = 155;
			infNodeItem.t_color.B = 121;
			infNodeItem.t_color.A = 255;
			Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
		}
		UnknownFunction165(i);
		goto JL0DD0;
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 0;
	infNodeItem.b_nHeight = 20;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSSQTeamName(1);
	infNodeItem.nOffSetX = 5;
	infNodeItem.nOffSetY = 0;
	infNodeItem.t_color.R = 128;
	infNodeItem.t_color.G = 128;
	infNodeItem.t_color.B = 128;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSystemString(830);
	infNodeItem.bLineBreak = True;
	infNodeItem.nOffSetX = 5;
	infNodeItem.nOffSetY = 4;
	infNodeItem.t_color.R = 128;
	infNodeItem.t_color.G = 128;
	infNodeItem.t_color.B = 128;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = UnknownFunction112("",string(Info.m_nTeam2Score));
	infNodeItem.nOffSetX = 5;
	infNodeItem.nOffSetY = 4;
	infNodeItem.t_color.R = 176;
	infNodeItem.t_color.G = 155;
	infNodeItem.t_color.B = 121;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSystemString(832);
	infNodeItem.bLineBreak = True;
	infNodeItem.nOffSetX = 5;
	infNodeItem.nOffSetY = 4;
	infNodeItem.t_color.R = 128;
	infNodeItem.t_color.G = 128;
	infNodeItem.t_color.B = 128;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
	i = 0;
	if ( UnknownFunction150(i,9) )
	{
		strTmp = Info.m_Team2MemberName[i];
		if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
		{
			infNodeItem = infNodeItemClear;
			infNodeItem.eType = 1;
			infNodeItem.t_strText = strTmp;
			infNodeItem.bLineBreak = True;
			infNodeItem.nOffSetX = 5;
			infNodeItem.nOffSetY = 4;
			infNodeItem.t_color.R = 176;
			infNodeItem.t_color.G = 155;
			infNodeItem.t_color.B = 121;
			infNodeItem.t_color.A = 255;
			Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
		}
		UnknownFunction165(i);
		goto JL1258;
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 0;
	infNodeItem.b_nHeight = 4;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.me_MainTree",strRetName,infNodeItem);
}

function ShowSSQSealStatus ()
{
	local XMLTreeNodeInfo infNode;
	local string strRetName;

	Class'UIAPI_TREECTRL'.Clear("SSQMainBoard.ss_MainTree");
	infNode.strName = "root";
	infNode.nOffSetX = 3;
	infNode.nOffSetY = 5;
	strRetName = Class'UIAPI_TREECTRL'.InsertNode("SSQMainBoard.ss_MainTree","",infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert root node. Name: ",infNode.strName));
		return;
	}
	if ( UnknownFunction154(g_sinfo.m_nMsgNum1,1183) )
	{
		AddSSQSealStatus(1,10,35,1,0,0,0);
		AddSSQSealStatus(1,10,35,2,0,0,0);
		AddSSQSealStatus(1,10,35,3,0,0,0);
	} else {
		Class'SSQAPI'.RequestSSQStatus(3);
	}
}

function AddSSQSealStatus (int m_nSSQStatus, int m_nNeedPoint1, int m_nNeedPoint2, int m_nSealID, int m_nOwnerTeamID, int m_nTeam1Mark, int m_nTeam2Mark)
{
	local int i;
	local int nMax;
	local int nStrID;
	local int nNeedPoint;
	local int nTmp;
	local float fBarX;
	local float fBarWidth;
	local int nWidth;
	local int nHeight;
	local XMLTreeNodeInfo infNode;
	local XMLTreeNodeItemInfo infNodeItem;
	local XMLTreeNodeInfo infNodeClear;
	local XMLTreeNodeItemInfo infNodeItemClear;
	local string strRetName;
	local string strTmp;

	strTmp = GetSSQSealName(m_nSealID);
	infNode = infNodeClear;
	infNode.strName = UnknownFunction112("",string(m_nSealID));
	infNode.bShowButton = 1;
	infNode.nTexBtnWidth = 14;
	infNode.nTexBtnHeight = 14;
	infNode.strTexBtnExpand = "L2UI_CH3.QUESTWND.QuestWndPlusBtn";
	infNode.strTexBtnCollapse = "L2UI_CH3.QUESTWND.QuestWndMinusBtn";
	infNode.strTexBtnExpand_Over = "L2UI_CH3.QUESTWND.QuestWndPlusBtn_over";
	infNode.strTexBtnCollapse_Over = "L2UI_CH3.QUESTWND.QuestWndMinusBtn_over";
	infNode.nTexExpandedOffSetY = 1;
	infNode.nTexExpandedHeight = 13;
	infNode.nTexExpandedRightWidth = 32;
	infNode.nTexExpandedLeftUWidth = 16;
	infNode.nTexExpandedLeftUHeight = 13;
	infNode.nTexExpandedRightUWidth = 32;
	infNode.nTexExpandedRightUHeight = 13;
	infNode.strTexExpandedLeft = "L2UI_CH3.ListCtrl.TextSelect";
	infNode.strTexExpandedRight = "L2UI_CH3.ListCtrl.TextSelect2";
	strRetName = Class'UIAPI_TREECTRL'.InsertNode("SSQMainBoard.ss_MainTree","root",infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
		return;
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = strTmp;
	infNodeItem.nOffSetX = 4;
	infNodeItem.nOffSetY = 2;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSystemString(823);
	infNodeItem.nOffSetX = 0;
	infNodeItem.nOffSetY = 5;
	infNodeItem.bLineBreak = True;
	infNodeItem.bStopMouseFocus = True;
	infNodeItem.t_color.R = 128;
	infNodeItem.t_color.G = 128;
	infNodeItem.t_color.B = 128;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSSQTeamName(m_nOwnerTeamID);
	infNodeItem.nOffSetX = 4;
	infNodeItem.nOffSetY = 5;
	infNodeItem.t_color.R = 176;
	infNodeItem.t_color.G = 155;
	infNodeItem.t_color.B = 121;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSSQTeamName(2);
	infNodeItem.nOffSetX = 0;
	infNodeItem.nOffSetY = 7;
	infNodeItem.bLineBreak = True;
	infNodeItem.t_color.R = 128;
	infNodeItem.t_color.G = 128;
	infNodeItem.t_color.B = 128;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	fBarX = 80.0;
	fBarWidth = 140.0;
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 2;
	infNodeItem.nOffSetX = 2;
	infNodeItem.nOffSetY = 7;
	infNodeItem.u_nTextureWidth = int(fBarWidth);
	infNodeItem.u_nTextureHeight = 11;
	infNodeItem.u_nTextureUWidth = 8;
	infNodeItem.u_nTextureUHeight = 11;
	infNodeItem.u_strTexture = "L2UI_CH3.SSQWnd.ssq_bar2back";
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	if ( UnknownFunction154(m_nOwnerTeamID,2) )
	{
		nNeedPoint = m_nNeedPoint1;
	} else {
		nNeedPoint = m_nNeedPoint2;
	}
	if ( UnknownFunction151(m_nTeam1Mark,nNeedPoint) )
	{
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.nOffSetX = int(UnknownFunction169(fBarWidth));
		infNodeItem.nOffSetY = 7;
		infNodeItem.u_nTextureWidth = int(UnknownFunction171(fBarWidth,UnknownFunction172(nNeedPoint,100.0)));
		nTmp = infNodeItem.u_nTextureWidth;
		infNodeItem.u_nTextureHeight = 11;
		infNodeItem.u_nTextureUWidth = 8;
		infNodeItem.u_nTextureUHeight = 11;
		infNodeItem.u_strTexture = "L2UI_CH3.SSQWnd.ssq_bar21";
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.nOffSetX = 0;
		infNodeItem.nOffSetY = 7;
		infNodeItem.u_nTextureWidth = int(UnknownFunction171(fBarWidth,UnknownFunction172(UnknownFunction147(m_nTeam1Mark,nNeedPoint),100.0)));
		nTmp = UnknownFunction146(nTmp,infNodeItem.u_nTextureWidth);
		infNodeItem.u_nTextureHeight = 11;
		infNodeItem.u_nTextureUWidth = 8;
		infNodeItem.u_nTextureUHeight = 11;
		infNodeItem.u_strTexture = "L2UI_CH3.SSQWnd.ssq_bar22";
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	} else {
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.nOffSetX = int(UnknownFunction169(fBarWidth));
		infNodeItem.nOffSetY = 7;
		infNodeItem.u_nTextureWidth = int(UnknownFunction171(fBarWidth,UnknownFunction172(m_nTeam1Mark,100.0)));
		nTmp = infNodeItem.u_nTextureWidth;
		infNodeItem.u_nTextureHeight = 11;
		infNodeItem.u_nTextureUWidth = 8;
		infNodeItem.u_nTextureUHeight = 11;
		infNodeItem.u_strTexture = "L2UI_CH3.SSQWnd.ssq_bar21";
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 2;
	infNodeItem.nOffSetX = int(UnknownFunction174(UnknownFunction143(nTmp),UnknownFunction171(fBarWidth,UnknownFunction172(nNeedPoint,100.0))));
	infNodeItem.nOffSetY = 7;
	infNodeItem.u_nTextureWidth = 1;
	nTmp = int(UnknownFunction174(UnknownFunction171(fBarWidth,UnknownFunction172(nNeedPoint,100.0)),1));
	infNodeItem.u_nTextureHeight = 11;
	infNodeItem.u_nTextureUWidth = 1;
	infNodeItem.u_nTextureUHeight = 11;
	infNodeItem.u_strTexture = "L2UI_CH3.SSQWnd.ssq_barline";
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = UnknownFunction112(string(m_nTeam1Mark),"%");
	GetTextSize(infNodeItem.t_strText,nWidth,nHeight);
	infNodeItem.nOffSetX = int(UnknownFunction175(UnknownFunction174(UnknownFunction143(nTmp),UnknownFunction172(fBarWidth,2)),UnknownFunction145(nWidth,2)));
	infNodeItem.nOffSetY = 8;
	infNodeItem.t_color.R = 255;
	infNodeItem.t_color.G = 255;
	infNodeItem.t_color.B = 255;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSSQTeamName(1);
	infNodeItem.nOffSetX = 0;
	infNodeItem.nOffSetY = 6;
	infNodeItem.bLineBreak = True;
	infNodeItem.t_color.R = 128;
	infNodeItem.t_color.G = 128;
	infNodeItem.t_color.B = 128;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 2;
	infNodeItem.nOffSetX = 2;
	infNodeItem.nOffSetY = 6;
	infNodeItem.u_nTextureWidth = int(fBarWidth);
	infNodeItem.u_nTextureHeight = 11;
	infNodeItem.u_nTextureUWidth = 8;
	infNodeItem.u_nTextureUHeight = 11;
	infNodeItem.u_strTexture = "L2UI_CH3.SSQWnd.ssq_bar1back";
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	if ( UnknownFunction154(m_nOwnerTeamID,1) )
	{
		nNeedPoint = m_nNeedPoint1;
	} else {
		nNeedPoint = m_nNeedPoint2;
	}
	if ( UnknownFunction151(m_nTeam2Mark,nNeedPoint) )
	{
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.nOffSetX = int(UnknownFunction169(fBarWidth));
		infNodeItem.nOffSetY = 6;
		infNodeItem.u_nTextureWidth = int(UnknownFunction171(fBarWidth,UnknownFunction172(nNeedPoint,100.0)));
		nTmp = infNodeItem.u_nTextureWidth;
		infNodeItem.u_nTextureHeight = 11;
		infNodeItem.u_nTextureUWidth = 8;
		infNodeItem.u_nTextureUHeight = 11;
		infNodeItem.u_strTexture = "L2UI_CH3.SSQWnd.ssq_bar11";
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.nOffSetX = 0;
		infNodeItem.nOffSetY = 6;
		infNodeItem.u_nTextureWidth = int(UnknownFunction171(fBarWidth,UnknownFunction172(UnknownFunction147(m_nTeam2Mark,nNeedPoint),100.0)));
		nTmp = UnknownFunction146(nTmp,infNodeItem.u_nTextureWidth);
		infNodeItem.u_nTextureHeight = 11;
		infNodeItem.u_nTextureUWidth = 8;
		infNodeItem.u_nTextureUHeight = 11;
		infNodeItem.u_strTexture = "L2UI_CH3.SSQWnd.ssq_bar12";
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	} else {
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.nOffSetX = int(UnknownFunction169(fBarWidth));
		infNodeItem.nOffSetY = 6;
		infNodeItem.u_nTextureWidth = int(UnknownFunction171(fBarWidth,UnknownFunction172(m_nTeam2Mark,100.0)));
		nTmp = infNodeItem.u_nTextureWidth;
		infNodeItem.u_nTextureHeight = 11;
		infNodeItem.u_nTextureUWidth = 8;
		infNodeItem.u_nTextureUHeight = 11;
		infNodeItem.u_strTexture = "L2UI_CH3.SSQWnd.ssq_bar11";
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 2;
	infNodeItem.nOffSetX = int(UnknownFunction174(UnknownFunction143(nTmp),UnknownFunction171(fBarWidth,UnknownFunction172(nNeedPoint,100.0))));
	infNodeItem.nOffSetY = 6;
	infNodeItem.u_nTextureWidth = 1;
	nTmp = int(UnknownFunction174(UnknownFunction171(fBarWidth,UnknownFunction172(nNeedPoint,100.0)),1));
	infNodeItem.u_nTextureHeight = 11;
	infNodeItem.u_nTextureUWidth = 1;
	infNodeItem.u_nTextureUHeight = 11;
	infNodeItem.u_strTexture = "L2UI_CH3.SSQWnd.ssq_barline";
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = UnknownFunction112(string(m_nTeam2Mark),"%");
	GetTextSize(infNodeItem.t_strText,nWidth,nHeight);
	infNodeItem.nOffSetX = int(UnknownFunction175(UnknownFunction174(UnknownFunction143(nTmp),UnknownFunction172(fBarWidth,2)),UnknownFunction145(nWidth,2)));
	infNodeItem.nOffSetY = 6;
	infNodeItem.t_color.R = 255;
	infNodeItem.t_color.G = 255;
	infNodeItem.t_color.B = 255;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 0;
	infNodeItem.b_nHeight = 12;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	infNode = infNodeClear;
	infNode.strName = "desc";
	infNode.bShowButton = 0;
	infNode.bDrawBackground = 1;
	infNode.bTexBackHighlight = 1;
	infNode.nTexBackHighlightHeight = 18;
	infNode.nTexBackWidth = 218;
	infNode.nTexBackUWidth = 211;
	infNode.nTexBackOffSetX = -4;
	infNode.nTexBackOffSetY = -3;
	infNode.nTexBackOffSetBottom = -3;
	strRetName = Class'UIAPI_TREECTRL'.InsertNode("SSQMainBoard.ss_MainTree",strRetName,infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		Debug(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
		return;
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = GetSSQSealDesc(m_nSealID);
	infNodeItem.t_color.R = 128;
	infNodeItem.t_color.G = 128;
	infNodeItem.t_color.B = 128;
	infNodeItem.t_color.A = 255;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 0;
	infNodeItem.b_nHeight = 18;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
	if ( UnknownFunction154(m_nSealID,1) )
	{
		nMax = 16;
		nStrID = 941;
	} else {
		if ( UnknownFunction154(m_nSealID,2) )
		{
			nMax = 12;
			nStrID = 957;
		} else {
			nMax = 0;
		}
	}
	i = 0;
	if ( UnknownFunction150(i,nMax) )
	{
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = GetSystemString(UnknownFunction146(nStrID,i));
		infNodeItem.bLineBreak = True;
		infNodeItem.nOffSetY = 6;
		infNodeItem.t_color.R = 128;
		infNodeItem.t_color.G = 128;
		infNodeItem.t_color.B = 128;
		infNodeItem.t_color.A = 255;
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = ":";
		infNodeItem.bLineBreak = True;
		infNodeItem.nOffSetY = 6;
		infNodeItem.t_color.R = 128;
		infNodeItem.t_color.G = 128;
		infNodeItem.t_color.B = 128;
		infNodeItem.t_color.A = 255;
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = GetSystemString(UnknownFunction146(UnknownFunction146(nStrID,i),1));
		infNodeItem.nOffSetY = 6;
		infNodeItem.t_color.R = 176;
		infNodeItem.t_color.G = 155;
		infNodeItem.t_color.B = 121;
		infNodeItem.t_color.A = 255;
		Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
		UnknownFunction161(i,2);
		goto JL1451;
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 0;
	infNodeItem.b_nHeight = 6;
	Class'UIAPI_TREECTRL'.InsertNodeItem("SSQMainBoard.ss_MainTree",strRetName,infNodeItem);
}

function string GetSSQSealName (int nID)
{
	local int nStrID;

	if ( UnknownFunction154(nID,1) )
	{
		nStrID = 816;
	} else {
		if ( UnknownFunction154(nID,2) )
		{
			nStrID = 817;
		} else {
			if ( UnknownFunction154(nID,3) )
			{
				nStrID = 818;
			} else {
				nStrID = 27;
			}
		}
	}
	return GetSystemString(nStrID);
}

function string GetSSQTeamName (int nID)
{
	local int nStrID;

	if ( UnknownFunction154(nID,1) )
	{
		nStrID = 815;
	} else {
		if ( UnknownFunction154(nID,2) )
		{
			nStrID = 814;
		} else {
			nStrID = 27;
		}
	}
	return GetSystemString(nStrID);
}

function string GetSSQSealDesc (int nID)
{
	local int nStrID;

	if ( UnknownFunction154(nID,1) )
	{
		nStrID = 1178;
	} else {
		if ( UnknownFunction154(nID,2) )
		{
			nStrID = 1179;
		} else {
			if ( UnknownFunction154(nID,3) )
			{
				nStrID = 1180;
			} else {
				nStrID = 27;
			}
		}
	}
	return GetSystemMessage(nStrID);
}

function string GetSSQTimeAttackEventRoomName (int nID)
{
	local int nStrID;

	if ( UnknownFunction154(nID,1) )
	{
		nStrID = 819;
	} else {
		if ( UnknownFunction154(nID,2) )
		{
			nStrID = 820;
		} else {
			if ( UnknownFunction154(nID,3) )
			{
				nStrID = 821;
			} else {
				if ( UnknownFunction154(nID,4) )
				{
					nStrID = 844;
				} else {
					if ( UnknownFunction154(nID,5) )
					{
						nStrID = 822;
					} else {
						nStrID = 27;
					}
				}
			}
		}
	}
	return GetSystemString(nStrID);
}

