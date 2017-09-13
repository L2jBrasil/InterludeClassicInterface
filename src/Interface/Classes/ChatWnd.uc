//================================================================================
// ChatWnd.
//================================================================================

class ChatWnd extends UICommonAPI;

const IntroTimer= 1;
const CHAT_UNION_MAX= 35;
const CHAT_WINDOW_SYSTEM= 5;
const CHAT_WINDOW_COUNT= 5;
const CHAT_WINDOW_ALLY= 4;
const CHAT_WINDOW_CLAN= 3;
const CHAT_WINDOW_PARTY= 2;
const CHAT_WINDOW_TRADE= 1;
const CHAT_WINDOW_NORMAL= 0;
var int m_NoUnionCommanderMessage;

var array<string> m_sectionName;
var int m_chatType;
var ChatWindowHandle NormalChat;
var ChatWindowHandle TradeChat;
var ChatWindowHandle PartyChat;
var ChatWindowHandle ClanChat;
var ChatWindowHandle AllyChat;
var ChatWindowHandle SystemMsg;
var TabHandle ChatTabCtrl;
var EditBoxHandle ChatEditBox;
var WindowHandle ChatWnd;
struct ChatFilterInfo
{
	var int bSystem;
	var int bChat;
	var int bDamage;
	var int bNormal;
	var int bShout;
	var int bClan;
	var int bParty;
	var int bTrade;
	var int bWhisper;
	var int bAlly;
	var int bUseitem;
	var int bHero;
	var int bUnion;
};
var array<ChatFilterInfo> m_filterInfo;

function OnLoad ()
{
	m_filterInfo.Length = UnknownFunction146(5,1);
	RegisterEvent(540);
	RegisterEvent(1500);
	RegisterEvent(550);
	RegisterEvent(560);
	RegisterEvent(570);
	RegisterEvent(571);
	RegisterEvent(572);
	m_sectionName.Length = 5;
	m_sectionName[0] = "entire_tab";
	m_sectionName[1] = "pledge_tab";
	m_sectionName[2] = "party_tab";
	m_sectionName[3] = "market_tab";
	m_sectionName[4] = "ally_tab";
	RegisterState("ChatWnd","OlympiadObserverState");
	L2jBRFunction2();
	InitFilterInfo();
	InitGlobalSetting();
	InitScrollBarPosition();
}

function OnDefaultPosition ()
{
	ChatTabCtrl.MergeTab(1);
	ChatTabCtrl.MergeTab(2);
	ChatTabCtrl.MergeTab(3);
	ChatTabCtrl.MergeTab(4);
	ChatTabCtrl.SetTopOrder(0,True);
	Class'UIAPI_WINDOW'.SetAnchor("ChatWnd","","BottomLeft","BottomLeft",0,-17);
	HandleTabClick("ChatTabCtrl0");
}

function InitGlobalSetting ()
{
	Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxCommand",bool(m_NoUnionCommanderMessage));
}

function L2jBRFunction2 ()
{
	NormalChat = ChatWindowHandle(GetHandle("ChatWnd.NormalChat"));
	TradeChat = ChatWindowHandle(GetHandle("ChatWnd.TradeChat"));
	PartyChat = ChatWindowHandle(GetHandle("ChatWnd.PartyChat"));
	ClanChat = ChatWindowHandle(GetHandle("ChatWnd.ClanChat"));
	AllyChat = ChatWindowHandle(GetHandle("ChatWnd.AllyChat"));
	SystemMsg = ChatWindowHandle(GetHandle("SystemMsgWnd.SystemMsgList"));
	ChatTabCtrl = TabHandle(GetHandle("ChatWnd.ChatTabCtrl"));
	ChatEditBox = EditBoxHandle(GetHandle("ChatWnd.ChatEditBox"));
	ChatWnd = GetHandle("ChatWnd");
}

function InitScrollBarPosition ()
{
	NormalChat.SetScrollBarPosition(5,10,-25);
	TradeChat.SetScrollBarPosition(5,10,-25);
	PartyChat.SetScrollBarPosition(5,10,-25);
	ClanChat.SetScrollBarPosition(5,10,-25);
	AllyChat.SetScrollBarPosition(5,10,-25);
}

function OnCompleteEditBox (string strID)
{
	local string strInput;
	local EChatType L2jBRVar5;

	if ( UnknownFunction122(strID,"ChatEditBox") )
	{
		strInput = ChatEditBox.GetString();
		if ( UnknownFunction150(UnknownFunction125(strInput),1) )
		{
			return;
		}
		ProcessChatMessage(strInput,m_chatType);
		ChatEditBox.SetString("");
		if ( UnknownFunction242(GetOptionBool("Game","OldChatting"),True) )
		{
			L2jBRVar5 = GetChatTypeByTabIndex(m_chatType);
			if ( UnknownFunction155(m_chatType,0) )
			{
				ChatEditBox.AddString(GetChatPrefix(L2jBRVar5));
			}
		}
		if ( UnknownFunction242(GetOptionBool("Game","EnterChatting"),True) )
		{
			ChatEditBox.ReleaseFocus();
		}
	}
}

function Clear ()
{
	ChatEditBox.Super(EditBoxHandle).Clear();
	NormalChat.Super(TextListBoxHandle).Clear();
	PartyChat.Super(TextListBoxHandle).Clear();
	ClanChat.Super(TextListBoxHandle).Clear();
	TradeChat.Super(TextListBoxHandle).Clear();
	AllyChat.Super(TextListBoxHandle).Clear();
	SystemMsg.Super(TextListBoxHandle).Clear();
}

function OnShow ()
{
	if ( GetOptionBool("Game","SystemMsgWnd") )
	{
		ShowWindow("SystemMsgWnd");
	} else {
		HideWindow("SystemMsgWnd");
	}
	HandleIMEStatusChange();
	L2jBRFunction29();
	ChatWnd.SetTimer(1,1000);
}

function OnTimer (int TimerID)
{
	if ( UnknownFunction154(TimerID,1) )
	{
		ChatWnd.KillTimer(1);
		AddSystemMessage("Interface developed by Neophron.",L2jBRFunction10("System"));
	}
	if ( UnknownFunction154(TimerID,2) )
	{
		ChatWnd.KillTimer(2);
		AddSystemMessage("Interface nulled by Grundor.",L2jBRFunction10("System"));
	}
}

function L2jBRFunction29 ()
{
	local ButtonHandle L2jBRVar38;

	L2jBRVar38 = ButtonHandle(GetHandle("ChatWnd.BtnAllBlock"));
	if ( UnknownFunction242(GetOptionBool("Neophron","AllBlock"),True) )
	{
		L2jBRVar38.SetTooltipCustomType(MakeTooltipSimpleText("Block All"));
	} else {
		L2jBRVar38.SetTooltipCustomType(MakeTooltipSimpleText("Stop Blocking"));
	}
}

function OnClickButton (string strID)
{
	local PartyMatchWnd L2jBRVar21;

	L2jBRVar21 = PartyMatchWnd(GetScript("PartyMatchWnd"));
	switch (strID)
	{
		case "ChatTabCtrl0":
		case "ChatTabCtrl1":
		case "ChatTabCtrl2":
		case "ChatTabCtrl3":
		case "ChatTabCtrl4":
		HandleTabClick(strID);
		break;
		case "ChatFilterBtn":
		if ( Class'UIAPI_WINDOW'.IsShowWindow("ChatFilterWnd") )
		{
			Class'UIAPI_WINDOW'.HideWindow("ChatFilterWnd");
		} else {
			SetChatFilterButton();
			Class'UIAPI_WINDOW'.ShowWindow("ChatFilterWnd");
		}
		break;
		case "MessengerBtn":
		ToggleMsnWindow();
		break;
		case "PartyMatchingBtn":
		if ( UnknownFunction242(Class'UIAPI_WINDOW'.IsShowWindow("PartyMatchWnd"),True) )
		{
			Class'UIAPI_WINDOW'.HideWindow("PartyMatchWnd");
			L2jBRVar21.OnSendPacketWhenHiding();
		} else {
			Class'PartyMatchAPI'.RequestOpenPartyMatch();
		}
		break;
		case "BtnAllBlock":
		GetAllBlock();
		break;
		default:
		break;
	}
}

function GetAllBlock ()
{
	local ButtonHandle L2jBRVar38;
	local bool AllBlock;

	L2jBRVar38 = ButtonHandle(GetHandle("ChatWnd.BtnAllBlock"));
	if ( UnknownFunction242(GetOptionBool("Neophron","AllBlock"),True) )
	{
		ExecuteCommand("/allunblock");
		AllBlock = False;
		L2jBRVar38.SetTooltipCustomType(MakeTooltipSimpleText("Block All"));
	} else {
		ExecuteCommand("/allblock");
		AllBlock = True;
		L2jBRVar38.SetTooltipCustomType(MakeTooltipSimpleText("Stop Blocking"));
	}
	SetOptionBool("Neophron","AllBlock",AllBlock);
}

function OnTabSplit (string sTabButton)
{
	local ChatWindowHandle L2jBRVar38;

	switch (sTabButton)
	{
		case "ChatTabCtrl0":
		L2jBRVar38 = NormalChat;
		HandleTabClick(sTabButton);
		break;
		case "ChatTabCtrl1":
		L2jBRVar38 = TradeChat;
		HandleTabClick(sTabButton);
		break;
		case "ChatTabCtrl2":
		L2jBRVar38 = PartyChat;
		HandleTabClick(sTabButton);
		break;
		case "ChatTabCtrl3":
		L2jBRVar38 = ClanChat;
		HandleTabClick(sTabButton);
		break;
		case "ChatTabCtrl4":
		L2jBRVar38 = AllyChat;
		HandleTabClick(sTabButton);
		break;
		default:
		break;
	}
	if ( UnknownFunction119(L2jBRVar38,None) )
	{
		L2jBRVar38.SetWindowSizeRel(-1.0,-1.0,0,0);
		L2jBRVar38.SetSettledWnd(True);
		L2jBRVar38.EnableTexture(True);
	}
}

function OnTabMerge (string sTabButton)
{
	local ChatWindowHandle L2jBRVar38;
	local int Width;
	local int Height;
	local Rect rectWnd;

	switch (sTabButton)
	{
		case "ChatTabCtrl0":
		L2jBRVar38 = NormalChat;
		break;
		case "ChatTabCtrl1":
		L2jBRVar38 = TradeChat;
		break;
		case "ChatTabCtrl2":
		L2jBRVar38 = PartyChat;
		break;
		case "ChatTabCtrl3":
		L2jBRVar38 = ClanChat;
		break;
		case "ChatTabCtrl4":
		L2jBRVar38 = AllyChat;
		break;
		default:
		break;
	}
	if ( UnknownFunction119(L2jBRVar38,None) )
	{
		rectWnd = NormalChat.GetRect();
		NormalChat.GetWindowSize(Width,Height);
		L2jBRVar38.SetSettledWnd(False);
		L2jBRVar38.MoveTo(rectWnd.nX,rectWnd.nY);
		L2jBRVar38.SetWindowSize(Width,UnknownFunction147(Height,46));
		L2jBRVar38.SetWindowSizeRel(1.0,1.0,0,-46);
		L2jBRVar38.EnableTexture(False);
	}
}

function HandleTabClick (string strID)
{
	local string strInput;
	local string strPrefix;
	local int StrLen;

	m_chatType = ChatTabCtrl.GetTopIndex();
	SetChatFilterButton();
	if ( UnknownFunction242(GetOptionBool("Game","OldChatting"),True) )
	{
		strInput = ChatEditBox.GetString();
		StrLen = UnknownFunction125(strInput);
		strPrefix = UnknownFunction128(strInput,1);
		if ( UnknownFunction132(UnknownFunction132(UnknownFunction132(IsSameChatPrefix(8,strPrefix),IsSameChatPrefix(3,strPrefix)),IsSameChatPrefix(4,strPrefix)),IsSameChatPrefix(9,strPrefix)) )
		{
			strInput = UnknownFunction234(strInput,UnknownFunction147(StrLen,1));
		}
		if ( UnknownFunction155(m_chatType,0) )
		{
			strPrefix = GetChatPrefix(GetChatTypeByTabIndex(m_chatType));
			strInput = UnknownFunction112(strPrefix,strInput);
		}
		ChatEditBox.SetString(strInput);
	}
}

function OnEnterState (name a_PrevStateName)
{
	if ( UnknownFunction254(a_PrevStateName,'LoadingState') )
	{
		Clear();
	}
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 540:
		L2jBRFunction66(L2jBRVar1);
		case 1500:
		HandleIMEStatusChange();
		break;
		case 550:
		HandleChatWndStatusChange();
		break;
		case 570:
		HandleSetFocus();
		break;
		case 560:
		HandleSetString(L2jBRVar1);
		break;
		case 571:
		HandleMsnStatus(L2jBRVar1);
		break;
		case 572:
		HandleChatWndMacroCommand(L2jBRVar1);
		break;
		default:
		break;
	}
}

function HandleChatWndMacroCommand (string L2jBRVar1)
{
	local string Command;

	if ( UnknownFunction129(ParseString(L2jBRVar1,"Command",Command)) )
	{
		return;
	}
	ProcessChatMessage(Command,m_chatType);
}

function L2jBRFunction66 (string L2jBRVar1)
{
	local int nTmp;
	local EChatType L2jBRVar5;
	local ESystemMsgType systemType;
	local string Text;
	local Color Color;

	ParseInt(L2jBRVar1,"Type",nTmp);
	L2jBRVar5 = nTmp;
	ParseString(L2jBRVar1,"Msg",Text);
	ParseInt(L2jBRVar1,"ColorR",nTmp);
	Color.R = nTmp;
	ParseInt(L2jBRVar1,"ColorG",nTmp);
	Color.G = nTmp;
	ParseInt(L2jBRVar1,"ColorB",nTmp);
	Color.B = nTmp;
	Color.A = 255;
	if ( UnknownFunction154(L2jBRVar5,5) )
	{
		ParseInt(L2jBRVar1,"SysType",nTmp);
		systemType = nTmp;
	} else {
		systemType = 0;
	}
	if ( CheckFilter(L2jBRVar5,0,systemType) )
	{
		NormalChat.AddString(Text,Color);
	}
	if ( CheckFilter(L2jBRVar5,2,systemType) )
	{
		PartyChat.AddString(Text,Color);
	}
	if ( CheckFilter(L2jBRVar5,3,systemType) )
	{
		ClanChat.AddString(Text,Color);
	}
	if ( CheckFilter(L2jBRVar5,1,systemType) )
	{
		TradeChat.AddString(Text,Color);
	}
	if ( CheckFilter(L2jBRVar5,4,systemType) )
	{
		AllyChat.AddString(Text,Color);
	}
	if ( CheckFilter(L2jBRVar5,5,systemType) )
	{
		SystemMsg.AddString(Text,Color);
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar5,15),UnknownFunction154(m_NoUnionCommanderMessage,0)) )
	{
		ShowUnionCommanderMessgage(Text);
	}
}

function ShowUnionCommanderMessgage (string Msg)
{
	local string strParam;
	local string MsgTemp;
	local string MsgTemp2;
	local int maxLength;

	maxLength = UnknownFunction125(Msg);
	if ( UnknownFunction151(maxLength,35) )
	{
		MsgTemp = UnknownFunction128(Msg,35);
		MsgTemp2 = UnknownFunction234(Msg,UnknownFunction147(maxLength,35));
		Msg = UnknownFunction112(UnknownFunction112(MsgTemp,"#"),MsgTemp2);
	}
	Debug(Msg);
	if ( UnknownFunction151(UnknownFunction125(Msg),0) )
	{
		ParamAdd(strParam,"MsgType",string(1));
		ParamAdd(strParam,"WindowType",string(8));
		ParamAdd(strParam,"FontType",string(0));
		ParamAdd(strParam,"BackgroundType",string(0));
		ParamAdd(strParam,"LifeTime",string(5000));
		ParamAdd(strParam,"AnimationType",string(1));
		ParamAdd(strParam,"Msg",Msg);
		ParamAdd(strParam,"MsgColorR",string(255));
		ParamAdd(strParam,"MsgColorG",string(150));
		ParamAdd(strParam,"MsgColorB",string(149));
		ExecuteEvent(140,strParam);
	}
}

function HandleIMEStatusChange ()
{
	local string Texture;
	local EIMEType imeType;

	imeType = GetCurrentIMELang();
	switch (imeType)
	{
		case 1:
		Texture = "L2UI.ChatWnd.IME_kr";
		break;
		case 2:
		Texture = "L2UI.ChatWnd.IME_en";
		break;
		case 3:
		Texture = "L2UI.ChatWnd.IME_jp";
		break;
		case 4:
		Texture = "L2UI.ChatWnd.IME_jp";
		break;
		case 5:
		Texture = "L2UI.ChatWnd.IME_tw2";
		break;
		case 6:
		Texture = "L2UI.ChatWnd.IME_tw3";
		break;
		case 7:
		Texture = "L2UI.ChatWnd.IME_tw1";
		break;
		case 9:
		Texture = "L2UI.ChatWnd.IME_cn1";
		break;
		case 10:
		Texture = "L2UI.ChatWnd.IME_cn2";
		break;
		case 11:
		Texture = "L2UI.ChatWnd.IME_cn3";
		break;
		case 12:
		Texture = "L2UI.ChatWnd.IME_cn4";
		break;
		case 13:
		Texture = "L2UI.ChatWnd.IME_cn4";
		break;
		case 14:
		Texture = "L2UI.ChatWnd.IME_th";
		break;
		default:
		Texture = "L2UI.ChatWnd.IME_en";
		break;
	}
	Class'UIAPI_TEXTURECTRL'.SetTexture("ChatWnd.LanguageTexture",Texture);
}

function bool CheckFilter (EChatType L2jBRVar5, int WindowType, ESystemMsgType systemType)
{
	if ( UnknownFunction130(UnknownFunction129(UnknownFunction130(UnknownFunction153(WindowType,0),UnknownFunction150(WindowType,5))),UnknownFunction155(WindowType,5)) )
	{
		Debug(UnknownFunction112("ChatWnd: Error invalid windowType ",string(WindowType)));
		return False;
	}
	if ( UnknownFunction130(UnknownFunction154(L2jBRVar5,8),UnknownFunction155(m_filterInfo[WindowType].bTrade,0)) )
	{
		return True;
	} else {
		if ( UnknownFunction130(UnknownFunction154(L2jBRVar5,0),UnknownFunction155(m_filterInfo[WindowType].bNormal,0)) )
		{
			return True;
		} else {
			if ( UnknownFunction130(UnknownFunction154(L2jBRVar5,4),UnknownFunction155(m_filterInfo[WindowType].bClan,0)) )
			{
				return True;
			} else {
				if ( UnknownFunction130(UnknownFunction154(L2jBRVar5,3),UnknownFunction155(m_filterInfo[WindowType].bParty,0)) )
				{
					return True;
				} else {
					if ( UnknownFunction130(UnknownFunction154(L2jBRVar5,1),UnknownFunction155(m_filterInfo[WindowType].bShout,0)) )
					{
						return True;
					} else {
						if ( UnknownFunction130(UnknownFunction154(L2jBRVar5,2),UnknownFunction155(m_filterInfo[WindowType].bWhisper,0)) )
						{
							return True;
						} else {
							if ( UnknownFunction130(UnknownFunction154(L2jBRVar5,9),UnknownFunction155(m_filterInfo[WindowType].bAlly,0)) )
							{
								return True;
							} else {
								if ( UnknownFunction130(UnknownFunction154(L2jBRVar5,17),UnknownFunction155(m_filterInfo[WindowType].bHero,0)) )
								{
									return True;
								} else {
									if ( UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction154(L2jBRVar5,10),UnknownFunction154(L2jBRVar5,18)),UnknownFunction154(L2jBRVar5,6)),UnknownFunction154(L2jBRVar5,7)) )
									{
										return True;
									} else {
										if ( UnknownFunction130(UnknownFunction132(UnknownFunction154(L2jBRVar5,16),UnknownFunction154(L2jBRVar5,15)),UnknownFunction155(m_filterInfo[WindowType].bUnion,0)) )
										{
											return True;
										} else {
											if ( UnknownFunction154(L2jBRVar5,5) )
											{
												if ( UnknownFunction132(UnknownFunction154(systemType,2),UnknownFunction154(systemType,6)) )
												{
													return True;
												} else {
													if ( UnknownFunction154(WindowType,5) )
													{
														if ( UnknownFunction154(systemType,3) )
														{
															if ( GetOptionBool("Game","SystemMsgWndDamage") )
															{
																return True;
															} else {
																return False;
															}
														} else {
															if ( UnknownFunction154(systemType,7) )
															{
																if ( GetOptionBool("Game","SystemMsgWndExpendableItem") )
																{
																	return True;
																} else {
																	return False;
																}
															} else {
																if ( UnknownFunction132(UnknownFunction154(systemType,1),UnknownFunction154(systemType,0)) )
																{
																	return True;
																}
															}
														}
														return False;
													} else {
														if ( UnknownFunction155(m_filterInfo[WindowType].bSystem,0) )
														{
															if ( UnknownFunction154(systemType,3) )
															{
																if ( UnknownFunction155(m_filterInfo[WindowType].bDamage,0) )
																{
																	return True;
																} else {
																	return False;
																}
															} else {
																if ( UnknownFunction154(systemType,7) )
																{
																	if ( UnknownFunction155(m_filterInfo[WindowType].bUseitem,0) )
																	{
																		return True;
																	} else {
																		return False;
																	}
																}
															}
															return True;
														}
													}
												}
												return False;
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
	return False;
}

function InitFilterInfo ()
{
	local int i;
	local int tempVal;

	SetDefaultFilterValue();
	i = 0;
	if ( UnknownFunction150(i,5) )
	{
		if ( GetINIBool(m_sectionName[i],"system",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bSystem = tempVal;
		}
		if ( GetINIBool(m_sectionName[i],"chat",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bChat = tempVal;
		}
		if ( GetINIBool(m_sectionName[i],"normal",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bNormal = tempVal;
		}
		if ( GetINIBool(m_sectionName[i],"shout",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bShout = tempVal;
		}
		if ( GetINIBool(m_sectionName[i],"pledge",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bClan = tempVal;
		}
		if ( GetINIBool(m_sectionName[i],"party",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bParty = tempVal;
		}
		if ( GetINIBool(m_sectionName[i],"market",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bTrade = tempVal;
		}
		if ( GetINIBool(m_sectionName[i],"tell",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bWhisper = tempVal;
		}
		if ( GetINIBool(m_sectionName[i],"damage",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bDamage = tempVal;
		}
		if ( GetINIBool(m_sectionName[i],"ally",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bAlly = tempVal;
		}
		if ( GetINIBool(m_sectionName[i],"useitems",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bUseitem = tempVal;
		}
		if ( GetINIBool(m_sectionName[i],"hero",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bHero = tempVal;
		}
		if ( GetINIBool(m_sectionName[i],"union",tempVal,"chatfilter.ini") )
		{
			m_filterInfo[i].bUnion = tempVal;
		}
		UnknownFunction163(i);
		goto JL000D;
	}
	SetDefaultFilterOn();
	if ( GetINIBool("global","command",tempVal,"chatfilter.ini") )
	{
		m_NoUnionCommanderMessage = tempVal;
	}
}

function SetDefaultFilterOn ()
{
	m_filterInfo[1].bTrade = 1;
	m_filterInfo[2].bParty = 1;
	m_filterInfo[3].bClan = 1;
	m_filterInfo[4].bAlly = 1;
}

function SetDefaultFilterValue ()
{
	m_filterInfo[0].bSystem = 1;
	m_filterInfo[0].bChat = 1;
	m_filterInfo[0].bNormal = 1;
	m_filterInfo[0].bShout = 1;
	m_filterInfo[0].bClan = 1;
	m_filterInfo[0].bParty = 1;
	m_filterInfo[0].bTrade = 0;
	m_filterInfo[0].bWhisper = 1;
	m_filterInfo[0].bDamage = 1;
	m_filterInfo[0].bAlly = 0;
	m_filterInfo[0].bUseitem = 0;
	m_filterInfo[0].bHero = 0;
	m_filterInfo[0].bUnion = 1;
	m_filterInfo[1].bSystem = 1;
	m_filterInfo[1].bChat = 1;
	m_filterInfo[1].bNormal = 0;
	m_filterInfo[1].bShout = 1;
	m_filterInfo[1].bClan = 0;
	m_filterInfo[1].bParty = 0;
	m_filterInfo[1].bTrade = 1;
	m_filterInfo[1].bWhisper = 1;
	m_filterInfo[1].bDamage = 1;
	m_filterInfo[1].bAlly = 0;
	m_filterInfo[1].bUseitem = 0;
	m_filterInfo[1].bHero = 0;
	m_filterInfo[1].bUnion = 0;
	m_filterInfo[2].bSystem = 1;
	m_filterInfo[2].bChat = 1;
	m_filterInfo[2].bNormal = 0;
	m_filterInfo[2].bShout = 1;
	m_filterInfo[2].bClan = 0;
	m_filterInfo[2].bParty = 1;
	m_filterInfo[2].bTrade = 0;
	m_filterInfo[2].bWhisper = 1;
	m_filterInfo[2].bDamage = 1;
	m_filterInfo[2].bAlly = 0;
	m_filterInfo[2].bUseitem = 0;
	m_filterInfo[2].bHero = 0;
	m_filterInfo[2].bUnion = 0;
	m_filterInfo[3].bSystem = 1;
	m_filterInfo[3].bChat = 1;
	m_filterInfo[3].bNormal = 0;
	m_filterInfo[3].bShout = 1;
	m_filterInfo[3].bClan = 1;
	m_filterInfo[3].bParty = 0;
	m_filterInfo[3].bTrade = 0;
	m_filterInfo[3].bWhisper = 1;
	m_filterInfo[3].bDamage = 1;
	m_filterInfo[3].bAlly = 0;
	m_filterInfo[3].bUseitem = 0;
	m_filterInfo[3].bHero = 0;
	m_filterInfo[3].bUnion = 0;
	m_filterInfo[4].bSystem = 1;
	m_filterInfo[4].bChat = 1;
	m_filterInfo[4].bNormal = 0;
	m_filterInfo[4].bShout = 1;
	m_filterInfo[4].bClan = 0;
	m_filterInfo[4].bParty = 0;
	m_filterInfo[4].bTrade = 0;
	m_filterInfo[4].bWhisper = 1;
	m_filterInfo[4].bDamage = 1;
	m_filterInfo[4].bAlly = 1;
	m_filterInfo[4].bUseitem = 0;
	m_filterInfo[4].bHero = 0;
	m_filterInfo[4].bUnion = 0;
	m_filterInfo[5].bSystem = 0;
	m_filterInfo[5].bChat = 0;
	m_filterInfo[5].bNormal = 0;
	m_filterInfo[5].bShout = 0;
	m_filterInfo[5].bClan = 0;
	m_filterInfo[5].bParty = 0;
	m_filterInfo[5].bTrade = 0;
	m_filterInfo[5].bWhisper = 0;
	m_filterInfo[5].bDamage = 0;
	m_filterInfo[5].bAlly = 0;
	m_filterInfo[5].bUseitem = 0;
	m_filterInfo[5].bHero = 0;
	m_filterInfo[5].bUnion = 0;
	m_NoUnionCommanderMessage = 0;
}

function SetChatFilterButton ()
{
	local bool bSystemMsgWnd;
	local bool bOption;

	bSystemMsgWnd = GetOptionBool("Game","SystemMsgWnd");
	Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.SystemMsgBox",bSystemMsgWnd);
	bOption = GetOptionBool("Game","SystemMsgWndDamage");
	Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.DamageBox",bOption);
	bOption = GetOptionBool("Game","SystemMsgWndExpendableItem");
	Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.ItemBox",bOption);
	if ( UnknownFunction130(UnknownFunction153(m_chatType,0),UnknownFunction150(m_chatType,5)) )
	{
		switch (m_chatType)
		{
			case 0:
			Class'UIAPI_TEXTBOX'.SetText("ChatFilterWnd.CurrentText",MakeFullSystemMsg(GetSystemMessage(1995),GetSystemString(144),""));
			break;
			case 1:
			Class'UIAPI_TEXTBOX'.SetText("ChatFilterWnd.CurrentText",MakeFullSystemMsg(GetSystemMessage(1995),GetSystemString(355),""));
			break;
			case 2:
			Class'UIAPI_TEXTBOX'.SetText("ChatFilterWnd.CurrentText",MakeFullSystemMsg(GetSystemMessage(1995),GetSystemString(188),""));
			break;
			case 3:
			Class'UIAPI_TEXTBOX'.SetText("ChatFilterWnd.CurrentText",MakeFullSystemMsg(GetSystemMessage(1995),GetSystemString(128),""));
			break;
			case 4:
			Class'UIAPI_TEXTBOX'.SetText("ChatFilterWnd.CurrentText",MakeFullSystemMsg(GetSystemMessage(1995),GetSystemString(559),""));
			break;
			default:
		}
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxSystem",bool(m_filterInfo[m_chatType].bSystem));
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxNormal",bool(m_filterInfo[m_chatType].bNormal));
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxShout",bool(m_filterInfo[m_chatType].bShout));
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxPledge",bool(m_filterInfo[m_chatType].bClan));
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxParty",bool(m_filterInfo[m_chatType].bParty));
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxTrade",bool(m_filterInfo[m_chatType].bTrade));
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxWhisper",bool(m_filterInfo[m_chatType].bWhisper));
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxDamage",bool(m_filterInfo[m_chatType].bDamage));
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxAlly",bool(m_filterInfo[m_chatType].bAlly));
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxItem",bool(m_filterInfo[m_chatType].bUseitem));
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxHero",bool(m_filterInfo[m_chatType].bHero));
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.CheckBoxUnion",bool(m_filterInfo[m_chatType].bUnion));
		if ( UnknownFunction129(Class'UIAPI_CHECKBOX'.IsChecked("ChatFilterWnd.CheckBoxSystem")) )
		{
			Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxDamage",True);
			Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxItem",True);
		} else {
			Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxDamage",False);
			Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxItem",False);
		}
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxNormal",False);
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxShout",False);
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxPledge",False);
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxParty",False);
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxTrade",False);
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxWhisper",False);
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxAlly",False);
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxHero",False);
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxUnion",False);
		switch (m_chatType)
		{
			case 1:
			Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxTrade",True);
			break;
			case 2:
			Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxParty",True);
			break;
			case 3:
			Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxPledge",True);
			break;
			case 4:
			Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxAlly",True);
			break;
			default:
		}
	} else {
	}
}

function HandleChatWndStatusChange ()
{
	local UserInfo UserInfo;

	GetPlayerInfo(UserInfo);
	if ( UnknownFunction151(UserInfo.nClanID,0) )
	{
		ChatTabCtrl.SetDisable(3,False);
	} else {
		ChatTabCtrl.SetDisable(3,True);
	}
	if ( UnknownFunction151(UserInfo.nAllianceID,0) )
	{
		ChatTabCtrl.SetDisable(4,False);
	} else {
		ChatTabCtrl.SetDisable(4,True);
	}
}

function HandleSetString (string _L2jBRVar17_)
{
	local string tmpString;

	if ( ParseString(_L2jBRVar17_,"String",tmpString) )
	{
		ChatEditBox.SetString(tmpString);
	}
}

function HandleSetFocus ()
{
	if ( UnknownFunction129(ChatEditBox.IsFocused()) )
	{
		ChatEditBox.SetFocus();
	}
}

function Print (int Index)
{
	Debug(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("Print type(",string(Index)),"), system :"),string(m_filterInfo[Index].bSystem)),", chat:"),string(m_filterInfo[Index].bChat)),",Normal:"),string(m_filterInfo[Index].bNormal)),", shout:"),string(m_filterInfo[Index].bShout)),",pledge:"),string(m_filterInfo[Index].bClan)),", party:"),string(m_filterInfo[Index].bParty)),", trade:"),string(m_filterInfo[Index].bTrade)),", whisper:"),string(m_filterInfo[Index].bWhisper)),", damage:"),string(m_filterInfo[Index].bDamage)),", ally:"),string(m_filterInfo[Index].bAlly)),",useitem:"),string(m_filterInfo[Index].bUseitem)),", hero:"),string(m_filterInfo[Index].bHero)));
}

function HandleMsnStatus (string L2jBRVar1)
{
	local string Status;
	local ButtonHandle L2jBRVar38;

	L2jBRVar38 = ButtonHandle(GetHandle("Chatwnd.MessengerBtn"));
	ParseString(L2jBRVar1,"status",Status);
	if ( UnknownFunction122(Status,"online") )
	{
		L2jBRVar38.SetTexture("L2UI_CH3.Msn.chatting_msn1","L2UI_CH3.Msn.chatting_msn1_down","");
	} else {
		if ( UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction122(Status,"berightback"),UnknownFunction122(Status,"idle")),UnknownFunction122(Status,"away")),UnknownFunction122(Status,"lunch")) )
		{
			L2jBRVar38.SetTexture("L2UI_CH3.Msn.chatting_msn2","L2UI_CH3.Msn.chatting_msn2_down","");
		} else {
			if ( UnknownFunction132(UnknownFunction122(Status,"busy"),UnknownFunction122(Status,"onthephone")) )
			{
				L2jBRVar38.SetTexture("L2UI_CH3.Msn.chatting_msn3","L2UI_CH3.Msn.chatting_msn3_down","");
			} else {
				if ( UnknownFunction132(UnknownFunction122(Status,"offline"),UnknownFunction122(Status,"invisible")) )
				{
					L2jBRVar38.SetTexture("L2UI_CH3.Msn.chatting_msn4","L2UI_CH3.Msn.chatting_msn4_down","");
				} else {
					if ( UnknownFunction122(Status,"none") )
					{
						L2jBRVar38.SetTexture("L2UI_CH3.Msn.chatting_msn5","L2UI_CH3.Msn.chatting_msn5_down","");
					}
				}
			}
		}
	}
}

function EChatType GetChatTypeByTabIndex (int Index)
{
	local EChatType L2jBRVar5;

	L2jBRVar5 = 0;
	switch (m_chatType)
	{
		case 0:
		L2jBRVar5 = 0;
		break;
		case 1:
		L2jBRVar5 = 8;
		break;
		case 2:
		L2jBRVar5 = 3;
		break;
		case 3:
		L2jBRVar5 = 4;
		break;
		case 4:
		L2jBRVar5 = 9;
		break;
		default:
		break;
	}
	return L2jBRVar5;
}

