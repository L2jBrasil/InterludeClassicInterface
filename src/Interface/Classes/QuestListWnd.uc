//================================================================================
// QuestListWnd.
//================================================================================

class QuestListWnd extends UIScript;

var WindowHandle L2jBRVar12;
var ListCtrlHandle lstQuest;
var TextureHandle QuestTooltip;

function OnLoad ()
{
	RegisterEvent(2840);
	RegisterEvent(2850);
	L2jBRVar12 = GetHandle("QuestListWnd");
	QuestTooltip = TextureHandle(GetHandle("QuestListWnd.QuestTooltip"));
	lstQuest = ListCtrlHandle(GetHandle("QuestListWnd.lstQuest"));
	InitQuestTooltip();
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 2840:
		HandleQuestInfoStart();
		break;
		case 2850:
		HandleQuestInfo(L2jBRVar1);
		break;
		default:
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnLoc":
		ShowQuestTarget();
		break;
		default:
	}
}

function HandleQuestInfoStart ()
{
	lstQuest.DeleteAllItem();
	L2jBRVar12.ShowWindow();
	L2jBRVar12.SetFocus();
}

function HandleQuestInfo (string L2jBRVar1)
{
	local int QuestID;
	local string QuestName;
	local string QuestRequirement;
	local string QuestLevel;
	local int QuestType;
	local string QuestNpcName;
	local string QuestDecription;
	local LVDataRecord Record;

	ParseInt(L2jBRVar1,"QuestID",QuestID);
	ParseString(L2jBRVar1,"QuestName",QuestName);
	ParseString(L2jBRVar1,"QuestRequirement",QuestRequirement);
	ParseString(L2jBRVar1,"QuestLevel",QuestLevel);
	ParseInt(L2jBRVar1,"QuestType",QuestType);
	ParseString(L2jBRVar1,"QuestNpcName",QuestNpcName);
	ParseString(L2jBRVar1,"QuestDecription",QuestDecription);
	Record.LVDataList.Length = 5;
	Record.LVDataList[0].szData = QuestName;
	Record.LVDataList[1].szData = QuestRequirement;
	Record.LVDataList[2].szData = QuestLevel;
	Record.LVDataList[3].nTextureWidth = 16;
	Record.LVDataList[3].nTextureHeight = 16;
	switch (QuestType)
	{
		case 0:
		case 2:
		Record.LVDataList[3].szTexture = "L2UI_CH3.QUESTWND.QuestWndInfoIcon_1";
		break;
		case 1:
		case 3:
		Record.LVDataList[3].szTexture = "L2UI_CH3.QUESTWND.QuestWndInfoIcon_2";
		break;
		default:
	}
	Record.LVDataList[3].szData = string(QuestType);
	Record.LVDataList[4].szData = QuestNpcName;
	Record.szReserved = QuestDecription;
	Record.nReserved1 = QuestID;
	lstQuest.InsertRecord(Record);
}

function ShowQuestTarget ()
{
	local int L2jBRVar2;
	local int QuestID;
	local int NpcID;
	local string strTargetName;
	local Vector vTargetPos;
	local LVDataRecord Record;

	L2jBRVar2 = lstQuest.GetSelectedIndex();
	if ( UnknownFunction151(L2jBRVar2,-1) )
	{
		Record = lstQuest.GetRecord(L2jBRVar2);
		QuestID = Record.nReserved1;
	}
	if ( UnknownFunction151(QuestID,0) )
	{
		NpcID = Class'UIDATA_QUEST'.GetStartNPCID(QuestID,1);
		strTargetName = Class'UIDATA_NPC'.GetNPCName(NpcID);
		vTargetPos = Class'UIDATA_QUEST'.GetStartNPCLoc(QuestID,1);
		Debug(UnknownFunction112("QuestID=",string(QuestID)));
		Debug(UnknownFunction112("strTargetName=",strTargetName));
		Debug(UnknownFunction112("vTargetPos.x=",string(vTargetPos.X)));
		Debug(UnknownFunction112("vTargetPos.y=",string(vTargetPos.Y)));
		Debug(UnknownFunction112("vTargetPos.z=",string(vTargetPos.Z)));
		if ( UnknownFunction151(UnknownFunction125(strTargetName),0) )
		{
			Class'QuestAPI'.SetQuestTargetInfo(True,True,True,strTargetName,vTargetPos,QuestID);
		}
	}
}

function InitQuestTooltip ()
{
	local CustomTooltip TooltipInfo;

	TooltipInfo.DrawList.Length = 4;
	TooltipInfo.DrawList[0].eType = 2;
	TooltipInfo.DrawList[0].u_nTextureWidth = 16;
	TooltipInfo.DrawList[0].u_nTextureHeight = 16;
	TooltipInfo.DrawList[0].u_strTexture = "L2UI_CH3.QuestWnd.QuestWndInfoIcon_1";
	TooltipInfo.DrawList[1].eType = 1;
	TooltipInfo.DrawList[1].nOffSetX = 5;
	TooltipInfo.DrawList[1].t_bDrawOneLine = True;
	TooltipInfo.DrawList[1].t_strText = GetSystemString(861);
	TooltipInfo.DrawList[2].eType = 2;
	TooltipInfo.DrawList[2].nOffSetY = 2;
	TooltipInfo.DrawList[2].u_nTextureWidth = 16;
	TooltipInfo.DrawList[2].u_nTextureHeight = 16;
	TooltipInfo.DrawList[2].u_strTexture = "L2UI_CH3.QuestWnd.QuestWndInfoIcon_2";
	TooltipInfo.DrawList[2].bLineBreak = True;
	TooltipInfo.DrawList[3].eType = 1;
	TooltipInfo.DrawList[3].nOffSetY = 2;
	TooltipInfo.DrawList[3].nOffSetX = 5;
	TooltipInfo.DrawList[3].t_bDrawOneLine = True;
	TooltipInfo.DrawList[3].t_strText = GetSystemString(862);
	QuestTooltip.SetTooltipCustomType(TooltipInfo);
}

