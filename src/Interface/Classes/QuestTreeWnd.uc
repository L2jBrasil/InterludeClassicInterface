//================================================================================
// QuestTreeWnd.
//================================================================================

class QuestTreeWnd extends UICommonAPI;

var string L2jBRVar13;
var int m_QuestNum;
var int m_OldQuestID;
var string m_CurNodeName;
var int m_DeleteQuestID;
var string m_DeleteNodeName;
var array<string> m_arrItemNodeName;
var array<string> m_arrItemString;
var array<int> m_arrItemClassID;
var TextureHandle m_QuestTooltip;
const QUESTTREEWND_MAX_COUNT= 25;

function OnLoad ()
{
	RegisterEvent(700);
	RegisterEvent(710);
	RegisterEvent(720);
	RegisterEvent(730);
	RegisterEvent(1710);
	RegisterEvent(2600);
	RegisterEvent(2610);
	RegisterEvent(1900);
	m_QuestTooltip = TextureHandle(GetHandle(UnknownFunction112(L2jBRVar13,".QuestToolTip")));
	InitQuestTooltip();
	m_QuestNum = 0;
}

function OnShow ()
{
	ShowQuestList();
	SetFocus();
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "BtnAbort":
		HandleQuestCancel();
		break;
		case "BtnClose":
		Class'UIAPI_WINDOW'.HideWindow("QuestTreeWnd");
		break;
		default:
	}
	if ( UnknownFunction122(UnknownFunction128(strID,4),"root") )
	{
		UpdateTargetInfo();
	}
}

function OnClickCheckBox (string strID)
{
	switch (strID)
	{
		case "chkNpcPosBox":
		UpdateTargetInfo();
		break;
		default:
	}
}

function Clear ()
{
	m_QuestNum = 0;
	UpdateQuestCount();
	m_OldQuestID = -1;
	m_CurNodeName = "";
	m_DeleteQuestID = 0;
	m_DeleteNodeName = "";
	m_arrItemNodeName.Remove (0,m_arrItemNodeName.Length);
	m_arrItemString.Remove (0,m_arrItemString.Length);
	m_arrItemClassID.Remove (0,m_arrItemClassID.Length);
	Class'UIAPI_TREECTRL'.Clear(UnknownFunction112(L2jBRVar13,".MainTree"));
}

function ShowQuestList ()
{
	Class'QuestAPI'.RequestQuestList();
}

function InitTree ()
{
	local XMLTreeNodeInfo infNode;
	local string strRetName;

	Clear();
	infNode.strName = "root";
	infNode.nOffSetX = 3;
	infNode.nOffSetY = 5;
	strRetName = Class'UIAPI_TREECTRL'.InsertNode(UnknownFunction112(L2jBRVar13,".MainTree"),"",infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		UnknownFunction231(UnknownFunction112("ERROR: Can't insert root node. Name: ",infNode.strName));
		return;
	}
}

function HandleQuestListStart ()
{
	InitTree();
}

function HandleQuestList (string _L2jBRVar17_)
{
	local int QuestID;
	local int Level;
	local int Completed;

	ParseInt(_L2jBRVar17_,"QuestID",QuestID);
	ParseInt(_L2jBRVar17_,"Level",Level);
	ParseInt(_L2jBRVar17_,"Completed",Completed);
	if ( UnknownFunction155(m_OldQuestID,QuestID) )
	{
		UnknownFunction165(m_QuestNum);
		AddQuestInfo("",QuestID,Level,Completed);
	} else {
		AddQuestInfo(m_CurNodeName,QuestID,Level,Completed);
	}
	m_OldQuestID = QuestID;
}

function HandleQuestListEnd ()
{
	UpdateQuestCount();
	UpdateItemCount(0);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	local int ClassID;

	if ( UnknownFunction154(Event_ID,700) )
	{
		HandleQuestListStart();
	} else {
		if ( UnknownFunction154(Event_ID,710) )
		{
			HandleQuestList(L2jBRVar1);
		} else {
			if ( UnknownFunction154(Event_ID,720) )
			{
				HandleQuestListEnd();
			} else {
				if ( UnknownFunction154(Event_ID,730) )
				{
					HandleQuestSetCurrentID(L2jBRVar1);
				} else {
					if ( UnknownFunction132(UnknownFunction154(Event_ID,2600),UnknownFunction154(Event_ID,2610)) )
					{
						ParseInt(L2jBRVar1,"classID",ClassID);
						UpdateItemCount(ClassID);
					} else {
						if ( UnknownFunction154(Event_ID,1710) )
						{
							if ( DialogIsMine() )
							{
								if ( UnknownFunction154(DialogGetID(),0) )
								{
									Class'QuestAPI'.RequestDestroyQuest(m_DeleteQuestID);
									SetQuestOff();
									Class'UIAPI_TREECTRL'.DeleteNode(UnknownFunction112(L2jBRVar13,".MainTree"),m_DeleteNodeName);
									m_DeleteQuestID = 0;
									m_DeleteNodeName = "";
								} else {
								}
							}
						} else {
							if ( UnknownFunction154(Event_ID,1900) )
							{
								__L2jBRFunction1();
							}
						}
					}
				}
			}
		}
	}
}

function HandleQuestSetCurrentID (string L2jBRVar1)
{
	local string strNodeName;
	local string strChildList;
	local int RecentlyAddedQuestID;
	local int SplitCount;
	local array<string> arrSplit;

	if ( UnknownFunction129(ParseInt(L2jBRVar1,"QuestID",RecentlyAddedQuestID)) )
	{
		return;
	}
	if ( UnknownFunction151(RecentlyAddedQuestID,0) )
	{
		strNodeName = UnknownFunction112("root.",string(RecentlyAddedQuestID));
		Class'UIAPI_TREECTRL'.SetExpandedNode(UnknownFunction112(L2jBRVar13,".MainTree"),strNodeName,True);
		strChildList = Class'UIAPI_TREECTRL'.GetChildNode(UnknownFunction112(L2jBRVar13,".MainTree"),strNodeName);
		if ( UnknownFunction151(UnknownFunction125(strChildList),0) )
		{
			SplitCount = Split(strChildList,"|",arrSplit);
			Class'UIAPI_TREECTRL'.SetExpandedNode(UnknownFunction112(L2jBRVar13,".MainTree"),arrSplit[UnknownFunction147(SplitCount,1)],True);
		}
		UpdateTargetInfo();
	}
}

function UpdateItemCount (int ClassID, optional int a_ItemCount)
{
	local int i;
	local int nPos;
	local int ItemCount;
	local string strTmp;

	i = 0;
	if ( UnknownFunction150(i,m_arrItemClassID.Length) )
	{
		if ( UnknownFunction132(UnknownFunction154(ClassID,0),UnknownFunction154(ClassID,m_arrItemClassID[i])) )
		{
			switch (a_ItemCount)
			{
				case -1:
				ItemCount = 0;
				break;
				case 0:
				ItemCount = GetInventoryItemCount(m_arrItemClassID[i]);
				break;
				default:
				ItemCount = a_ItemCount;
				break;
			}
			nPos = UnknownFunction126(m_arrItemString[i],"%s");
			if ( UnknownFunction151(nPos,-1) )
			{
				strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction128(m_arrItemString[i],nPos),string(ItemCount)),UnknownFunction127(m_arrItemString[i],UnknownFunction146(nPos,2)));
				Class'UIAPI_TREECTRL'.SetNodeItemText(UnknownFunction112(L2jBRVar13,".MainTree"),m_arrItemNodeName[i],UnknownFunction147(m_arrItemClassID.Length,i),strTmp);
			}
		}
		UnknownFunction165(i);
		goto JL0007;
	}
}

function UpdateQuestCount ()
{
	Class'UIAPI_TEXTBOX'.SetText(UnknownFunction112(L2jBRVar13,".txtQuestNum"),UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(m_QuestNum)),"/"),string(25)),")"));
}

function UpdateTargetInfo ()
{
	local int i;
	local array<string> arrSplit;
	local int SplitCount;
	local int QuestID;
	local int Level;
	local int Completed;
	local string strChildList;
	local string strTargetNode;
	local string strNodeName;
	local string strTargetName;
	local Vector vTargetPos;
	local bool bOnlyMinimap;

	if ( UnknownFunction129(Class'UIAPI_CHECKBOX'.IsChecked(UnknownFunction112(L2jBRVar13,".chkNpcPosBox"))) )
	{
		SetQuestOff();
		return;
	}
	strNodeName = GetExpandedNode();
	if ( UnknownFunction150(UnknownFunction125(strNodeName),1) )
	{
		SetQuestOff();
		return;
	}
	strChildList = Class'UIAPI_TREECTRL'.GetChildNode(UnknownFunction112(L2jBRVar13,".MainTree"),strNodeName);
	if ( UnknownFunction151(UnknownFunction125(strChildList),0) )
	{
		SplitCount = Split(strChildList,"|",arrSplit);
		strTargetNode = arrSplit[UnknownFunction147(SplitCount,1)];
	} else {
		SetQuestOff();
		return;
	}
	arrSplit.Remove (0,arrSplit.Length);
	SplitCount = Split(strTargetNode,".",arrSplit);
	i = 0;
	if ( UnknownFunction150(i,SplitCount) )
	{
		switch (i)
		{
			case 0:
			break;
			case 1:
			QuestID = int(arrSplit[i]);
			break;
			case 2:
			Level = int(arrSplit[i]);
			break;
			case 2:
			Completed = int(arrSplit[i]);
			break;
			default:
		}
		UnknownFunction165(i);
		goto JL00F1;
	}
	if ( UnknownFunction130(UnknownFunction151(QuestID,0),UnknownFunction151(Level,0)) )
	{
		strTargetName = Class'UIDATA_QUEST'.GetTargetName(QuestID,Level);
		vTargetPos = Class'UIDATA_QUEST'.GetTargetLoc(QuestID,Level);
		if ( UnknownFunction130(UnknownFunction154(Completed,0),UnknownFunction151(UnknownFunction125(strTargetName),0)) )
		{
			bOnlyMinimap = Class'UIDATA_QUEST'.IsMinimapOnly(QuestID,Level);
			if ( bOnlyMinimap )
			{
				Class'QuestAPI'.SetQuestTargetInfo(True,False,False,strTargetName,vTargetPos,QuestID);
			} else {
				Class'QuestAPI'.SetQuestTargetInfo(True,True,True,strTargetName,vTargetPos,QuestID);
			}
		} else {
			SetQuestOff();
		}
	}
}

function SetQuestOff ()
{
	local Vector vVector;

	Class'QuestAPI'.SetQuestTargetInfo(False,False,False,"",vVector,0);
}

function string GetExpandedNode ()
{
	local array<string> arrSplit;
	local int SplitCount;
	local string strNodeName;

	strNodeName = Class'UIAPI_TREECTRL'.GetExpandedNode(UnknownFunction112(L2jBRVar13,".MainTree"),"root");
	SplitCount = Split(strNodeName,"|",arrSplit);
	if ( UnknownFunction151(SplitCount,0) )
	{
		strNodeName = arrSplit[0];
	}
	return strNodeName;
}

function HandleQuestCancel ()
{
	local array<string> arrSplit;
	local int SplitCount;
	local string strNodeName;

	m_DeleteQuestID = 0;
	m_DeleteNodeName = "";
	strNodeName = GetExpandedNode();
	SplitCount = Split(strNodeName,"|",arrSplit);
	if ( UnknownFunction151(SplitCount,0) )
	{
		strNodeName = arrSplit[0];
		arrSplit.Remove (0,arrSplit.Length);
		SplitCount = Split(strNodeName,".",arrSplit);
		if ( UnknownFunction151(SplitCount,1) )
		{
			m_DeleteQuestID = int(arrSplit[1]);
			m_DeleteNodeName = strNodeName;
		}
	}
	if ( UnknownFunction150(UnknownFunction125(m_DeleteNodeName),1) )
	{
		DialogShow(5,GetSystemMessage(1201));
		DialogSetID(1);
	} else {
		DialogShow(4,GetSystemMessage(182));
		DialogSetID(0);
	}
}

function AddQuestInfo (string strParentName, int QuestID, int Level, int Completed)
{
	local XMLTreeNodeInfo infNode;
	local XMLTreeNodeItemInfo infNodeItem;
	local XMLTreeNodeInfo infNodeClear;
	local XMLTreeNodeItemInfo infNodeItemClear;
	local string strRetName;
	local string strTmp;
	local int QuestMaxLevel;
	local int QuestMinLevel;
	local int nQuestType;
	local string strTexture1;
	local string strTexture2;
	local int ItemCount;
	local array<int> arrItemIDList;
	local array<int> arrItemNumList;
	local int i;
	local bool bShowCompletionItem;
	local bool bShowCompletionJournal;

	bShowCompletionItem = Class'UIDATA_QUEST'.IsShowableItemNumQuest(QuestID,Level);
	bShowCompletionJournal = Class'UIDATA_QUEST'.IsShowableJournalQuest(QuestID,Level);
	if ( UnknownFunction154(Level,1) )
	{
		strTmp = Class'UIDATA_QUEST'.GetQuestName(QuestID);
		infNode = infNodeClear;
		infNode.strName = UnknownFunction112("",string(QuestID));
		infNode.ToolTip = MakeTooltipSimpleText(strTmp);
		infNode.bFollowCursor = True;
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
		strRetName = Class'UIAPI_TREECTRL'.InsertNode(UnknownFunction112(L2jBRVar13,".MainTree"),"root",infNode);
		if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
		{
			UnknownFunction231(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
			return;
		}
		infNode.ToolTip.DrawList.Remove (0,infNode.ToolTip.DrawList.Length);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = strTmp;
		infNodeItem.nOffSetX = 5;
		infNodeItem.nOffSetY = 2;
		Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
		nQuestType = 0;
		nQuestType = Class'UIDATA_QUEST'.GetQuestType(QuestID,Level);
		if ( UnknownFunction154(nQuestType,0) )
		{
			strTexture1 = "L2UI_CH3.QUESTWND.QuestWndInfoIcon_4";
			strTexture2 = "L2UI_CH3.QUESTWND.QuestWndInfoIcon_1";
		} else {
			if ( UnknownFunction154(nQuestType,1) )
			{
				strTexture1 = "L2UI_CH3.QUESTWND.QuestWndInfoIcon_4";
				strTexture2 = "L2UI_CH3.QUESTWND.QuestWndInfoIcon_2";
			} else {
				if ( UnknownFunction154(nQuestType,2) )
				{
					strTexture1 = "L2UI_CH3.QUESTWND.QuestWndInfoIcon_3";
					strTexture2 = "L2UI_CH3.QUESTWND.QuestWndInfoIcon_1";
				} else {
					if ( UnknownFunction154(nQuestType,3) )
					{
						strTexture1 = "L2UI_CH3.QUESTWND.QuestWndInfoIcon_3";
						strTexture2 = "L2UI_CH3.QUESTWND.QuestWndInfoIcon_2";
					}
				}
			}
		}
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.bStopMouseFocus = True;
		infNodeItem.nOffSetX = 5;
		infNodeItem.nOffSetY = 0;
		infNodeItem.u_nTextureWidth = 11;
		infNodeItem.u_nTextureHeight = 11;
		infNodeItem.u_strTexture = strTexture1;
		if ( UnknownFunction151(UnknownFunction125(strTexture1),0) )
		{
			Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
		}
		infNodeItem.nOffSetX = 0;
		infNodeItem.u_strTexture = strTexture2;
		if ( UnknownFunction151(UnknownFunction125(strTexture2),0) )
		{
			Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
		}
		QuestMaxLevel = Class'UIDATA_QUEST'.GetMaxLevel(QuestID,Level);
		QuestMinLevel = Class'UIDATA_QUEST'.GetMinLevel(QuestID,Level);
		if ( UnknownFunction130(UnknownFunction151(QuestMaxLevel,0),UnknownFunction151(QuestMinLevel,0)) )
		{
			strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",GetSystemString(922)),":"),string(QuestMinLevel)),"~"),string(QuestMaxLevel)),")");
		} else {
			if ( UnknownFunction151(QuestMinLevel,0) )
			{
				strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",GetSystemString(922)),":"),string(QuestMinLevel))," "),GetSystemString(859)),")");
			} else {
				strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",GetSystemString(922)),":"),GetSystemString(866)),")");
			}
		}
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = strTmp;
		infNodeItem.t_color.R = 176;
		infNodeItem.t_color.G = 155;
		infNodeItem.t_color.B = 121;
		infNodeItem.t_color.A = 255;
		infNodeItem.bLineBreak = True;
		infNodeItem.nOffSetX = 22;
		infNodeItem.nOffSetY = 0;
		Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 0;
		infNodeItem.b_nHeight = 7;
		Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
		strParentName = strRetName;
		m_CurNodeName = strRetName;
	}
	strTmp = Class'UIDATA_QUEST'.GetQuestJournalName(QuestID,Level);
	infNode = infNodeClear;
	infNode.strName = UnknownFunction112(UnknownFunction112(UnknownFunction112("",string(Level)),"."),string(Completed));
	infNode.ToolTip = MakeTooltipSimpleText(strTmp);
	infNode.bFollowCursor = True;
	infNode.nOffSetX = 7;
	infNode.bShowButton = 1;
	infNode.nTexBtnWidth = 14;
	infNode.nTexBtnHeight = 14;
	infNode.strTexBtnExpand = "L2UI_CH3.QUESTWND.QuestWndDownBtn";
	infNode.strTexBtnCollapse = "L2UI_CH3.QUESTWND.QuestWndUpBtn";
	infNode.strTexBtnExpand_Over = "L2UI_CH3.QUESTWND.QuestWndDownBtn_over";
	infNode.strTexBtnCollapse_Over = "L2UI_CH3.QUESTWND.QuestWndUpBtn_over";
	strRetName = Class'UIAPI_TREECTRL'.InsertNode(UnknownFunction112(L2jBRVar13,".MainTree"),strParentName,infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		UnknownFunction231(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
		return;
	}
	infNode.ToolTip.DrawList.Remove (0,infNode.ToolTip.DrawList.Length);
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = strTmp;
	infNodeItem.nOffSetX = 5;
	Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
	strTmp = Class'UIDATA_QUEST'.GetTargetName(QuestID,Level);
	if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
	{
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 2;
		infNodeItem.bStopMouseFocus = True;
		infNodeItem.nOffSetX = 5;
		infNodeItem.nOffSetY = 0;
		infNodeItem.u_nTextureWidth = 11;
		infNodeItem.u_nTextureHeight = 11;
		infNodeItem.u_strTexture = "L2UI_CH3.QUESTWND.QuestWndInfoIcon_5";
		Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
	}
	if ( UnknownFunction130(UnknownFunction151(Completed,0),bShowCompletionJournal) )
	{
		infNodeItem = infNodeItemClear;
		infNodeItem.eType = 1;
		infNodeItem.t_strText = GetSystemString(898);
		infNodeItem.t_color.R = 176;
		infNodeItem.t_color.G = 155;
		infNodeItem.t_color.B = 121;
		infNodeItem.t_color.A = 255;
		infNodeItem.nOffSetX = 5;
		Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 0;
	infNodeItem.b_nHeight = 5;
	Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
	strTmp = Class'UIDATA_QUEST'.GetQuestDescription(QuestID,Level);
	infNode = infNodeClear;
	infNode.strName = "desc";
	infNode.nOffSetX = 2;
	infNode.bDrawBackground = 1;
	infNode.bTexBackHighlight = 0;
	infNode.nTexBackWidth = 211;
	infNode.nTexBackUWidth = 211;
	infNode.nTexBackOffSetY = -2;
	infNode.nTexBackOffSetBottom = -2;
	strRetName = Class'UIAPI_TREECTRL'.InsertNode(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNode);
	if ( UnknownFunction150(UnknownFunction125(strRetName),1) )
	{
		UnknownFunction231(UnknownFunction112("ERROR: Can't insert node. Name: ",infNode.strName));
		return;
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 1;
	infNodeItem.t_strText = strTmp;
	infNodeItem.t_color.R = 140;
	infNodeItem.t_color.G = 140;
	infNodeItem.t_color.B = 140;
	infNodeItem.t_color.A = 255;
	infNodeItem.nOffSetX = 5;
	Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
	strTmp = Class'UIDATA_QUEST'.GetQuestItem(QuestID,Level);
	ParseInt(strTmp,"Max",ItemCount);
	arrItemIDList.Length = ItemCount;
	arrItemNumList.Length = ItemCount;
	i = 0;
	if ( UnknownFunction150(i,ItemCount) )
	{
		ParseInt(strTmp,UnknownFunction112("ItemID_",string(i)),arrItemIDList[i]);
		ParseInt(strTmp,UnknownFunction112("ItemNum_",string(i)),arrItemNumList[i]);
		UnknownFunction165(i);
		goto JL0E69;
	}
	i = 0;
	if ( UnknownFunction150(i,ItemCount) )
	{
		strTmp = Class'UIDATA_ITEM'.GetItemTextureName(arrItemIDList[i]);
		if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
		{
			infNodeItem = infNodeItemClear;
			infNodeItem.eType = 0;
			infNodeItem.b_nHeight = 4;
			Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
			infNodeItem = infNodeItemClear;
			infNodeItem.eType = 2;
			infNodeItem.nOffSetX = 4;
			infNodeItem.u_nTextureWidth = 34;
			infNodeItem.u_nTextureHeight = 34;
			infNodeItem.u_strTexture = "L2UI_CH3.Etc.menu_outline";
			Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
			infNodeItem = infNodeItemClear;
			infNodeItem.eType = 2;
			infNodeItem.nOffSetX = -33;
			infNodeItem.nOffSetY = 1;
			infNodeItem.u_nTextureWidth = 32;
			infNodeItem.u_nTextureHeight = 32;
			infNodeItem.u_strTexture = strTmp;
			Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
			strTmp = Class'UIDATA_ITEM'.GetItemName(arrItemIDList[i]);
			infNodeItem = infNodeItemClear;
			infNodeItem.eType = 1;
			infNodeItem.t_strText = strTmp;
			infNodeItem.t_color.R = 176;
			infNodeItem.t_color.G = 155;
			infNodeItem.t_color.B = 121;
			infNodeItem.t_color.A = 255;
			infNodeItem.nOffSetX = 5;
			infNodeItem.nOffSetY = 1;
			Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
			infNodeItem = infNodeItemClear;
			infNodeItem.eType = 1;
			if ( UnknownFunction151(arrItemNumList[i],0) )
			{
				if ( UnknownFunction130(UnknownFunction151(Completed,0),bShowCompletionItem) )
				{
					strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",GetSystemString(898)),"/"),string(arrItemNumList[i])),")");
				} else {
					strTmp = UnknownFunction112(UnknownFunction112("(%s/",string(arrItemNumList[i])),")");
					byte(m_arrItemNodeName)
					0
					1
					m_arrItemNodeName[0] = strRetName;
					byte(m_arrItemClassID)
					0
					1
					m_arrItemClassID[0] = arrItemIDList[i];
					byte(m_arrItemString)
					0
					1
					m_arrItemString[0] = strTmp;
					infNodeItem.t_nTextID = m_arrItemClassID.Length;
				}
			} else {
				if ( UnknownFunction154(arrItemNumList[i],0) )
				{
					if ( UnknownFunction130(UnknownFunction151(Completed,0),bShowCompletionItem) )
					{
						strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",GetSystemString(898)),"/"),GetSystemString(858)),")");
					} else {
						strTmp = UnknownFunction112(UnknownFunction112("(%s/",GetSystemString(858)),")");
						byte(m_arrItemNodeName)
						0
						1
						m_arrItemNodeName[0] = strRetName;
						byte(m_arrItemClassID)
						0
						1
						m_arrItemClassID[0] = arrItemIDList[i];
						byte(m_arrItemString)
						0
						1
						m_arrItemString[0] = strTmp;
						infNodeItem.t_nTextID = m_arrItemClassID.Length;
					}
				} else {
					if ( UnknownFunction130(UnknownFunction151(Completed,0),bShowCompletionItem) )
					{
						strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",GetSystemString(898)),"/"),string(UnknownFunction143(arrItemNumList[i]))),GetSystemString(859)),")");
					} else {
						strTmp = UnknownFunction112(UnknownFunction112(UnknownFunction112("(%s/",string(UnknownFunction143(arrItemNumList[i]))),GetSystemString(859)),")");
						byte(m_arrItemNodeName)
						0
						1
						m_arrItemNodeName[0] = strRetName;
						byte(m_arrItemClassID)
						0
						1
						m_arrItemClassID[0] = arrItemIDList[i];
JL0E69:
						byte(m_arrItemString)
						0
						1
						m_arrItemString[0] = strTmp;
						infNodeItem.t_nTextID = m_arrItemClassID.Length;
					}
				}
			}
			infNodeItem.t_strText = strTmp;
			infNodeItem.bLineBreak = True;
			infNodeItem.nOffSetX = 42;
			infNodeItem.nOffSetY = -16;
			Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
		}
		UnknownFunction165(i);
		goto JL0EDA;
	}
	infNodeItem = infNodeItemClear;
	infNodeItem.eType = 0;
JL0EDA:
	infNodeItem.b_nHeight = 9;
	Class'UIAPI_TREECTRL'.InsertNodeItem(UnknownFunction112(L2jBRVar13,".MainTree"),strRetName,infNodeItem);
}

function InitQuestTooltip ()
{
	local CustomTooltip TooltipInfo;

	TooltipInfo.DrawList.Length = 10;
	TooltipInfo.DrawList[0].eType = 2;
	TooltipInfo.DrawList[0].u_nTextureWidth = 16;
	TooltipInfo.DrawList[0].u_nTextureHeight = 16;
	TooltipInfo.DrawList[0].u_strTexture = "L2UI_CH3.QuestWnd.QuestWndInfoIcon_1";
	TooltipInfo.DrawList[1].eType = 1;
	TooltipInfo.DrawList[1].nOffSetX = 5;
	TooltipInfo.DrawList[1].t_bDrawOneLine = True;
	TooltipInfo.DrawList[1].t_ID = 861;
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
	TooltipInfo.DrawList[3].t_ID = 862;
	TooltipInfo.DrawList[4].eType = 2;
	TooltipInfo.DrawList[4].nOffSetY = 2;
	TooltipInfo.DrawList[4].u_nTextureWidth = 16;
	TooltipInfo.DrawList[4].u_nTextureHeight = 16;
	TooltipInfo.DrawList[4].u_strTexture = "L2UI_CH3.QuestWnd.QuestWndInfoIcon_3";
	TooltipInfo.DrawList[4].bLineBreak = True;
	TooltipInfo.DrawList[5].eType = 1;
	TooltipInfo.DrawList[5].nOffSetY = 2;
	TooltipInfo.DrawList[5].nOffSetX = 5;
	TooltipInfo.DrawList[5].t_bDrawOneLine = True;
	TooltipInfo.DrawList[5].t_ID = 863;
	TooltipInfo.DrawList[6].eType = 2;
	TooltipInfo.DrawList[6].nOffSetY = 2;
	TooltipInfo.DrawList[6].u_nTextureWidth = 16;
	TooltipInfo.DrawList[6].u_nTextureHeight = 16;
	TooltipInfo.DrawList[6].u_strTexture = "L2UI_CH3.QuestWnd.QuestWndInfoIcon_4";
	TooltipInfo.DrawList[6].bLineBreak = True;
	TooltipInfo.DrawList[7].eType = 1;
	TooltipInfo.DrawList[7].nOffSetY = 2;
	TooltipInfo.DrawList[7].nOffSetX = 5;
	TooltipInfo.DrawList[7].t_bDrawOneLine = True;
	TooltipInfo.DrawList[7].t_ID = 864;
	TooltipInfo.DrawList[8].eType = 2;
	TooltipInfo.DrawList[8].nOffSetY = 2;
	TooltipInfo.DrawList[8].u_nTextureWidth = 16;
	TooltipInfo.DrawList[8].u_nTextureHeight = 16;
	TooltipInfo.DrawList[8].u_strTexture = "L2UI_CH3.QuestWnd.QuestWndInfoIcon_5";
	TooltipInfo.DrawList[8].bLineBreak = True;
	TooltipInfo.DrawList[9].eType = 1;
	TooltipInfo.DrawList[9].nOffSetY = 2;
	TooltipInfo.DrawList[9].nOffSetX = 5;
	TooltipInfo.DrawList[9].t_bDrawOneLine = True;
	TooltipInfo.DrawList[9].t_ID = 865;
	m_QuestTooltip.SetTooltipCustomType(TooltipInfo);
}

function __L2jBRFunction1()
{
	if ( Class'UIAPI_WINDOW'.IsShowWindow(L2jBRVar13) )
	{
		ShowQuestList();
	}
}

function SetFocus ()
{
	Class'UIAPI_WINDOW'.SetFocus("QuestTreeWnd.MainTree");
	Class'UIAPI_WINDOW'.SetFocus("QuestTreeWnd.btnAbort");
	Class'UIAPI_WINDOW'.SetFocus("QuestTreeWnd.chkNpcPosBox");
	Class'UIAPI_WINDOW'.SetFocus("QuestTreeWnd.txt324");
	Class'UIAPI_WINDOW'.SetFocus("QuestTreeWnd.txtQuestNum");
	Class'UIAPI_WINDOW'.SetFocus("QuestTreeWnd.QuestToolTip");
}

defaultproperties
{
    L2jBRVar13="QuestTreeWnd"

}
