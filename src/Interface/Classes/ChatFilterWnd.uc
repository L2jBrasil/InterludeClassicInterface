//================================================================================
// ChatFilterWnd.
//================================================================================

class ChatFilterWnd extends UIScript;

function OnLoad ()
{
	Class'UIAPI_CHECKBOX'.SetTitle("ChatFilterWnd.CheckBoxCommand","Hide Cmd Chat");
	Class'UIAPI_CHECKBOX'.SetTitle("ChatFilterWnd.Cb_Transparency","Transparency");
	L2jBRFunction67();
}

function L2jBRFunction67 ()
{
	if ( UnknownFunction242(GetOptionBool("Neophron","ChatTransparency"),True) )
	{
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.Cb_Transparency",True);
		Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_Tab.Cb_ChatTransparency",True);
		Class'UIAPI_TEXTURECTRL'.SetTexture("ChatWnd.ChatWndHeadTexMy","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ChatWnd.ChatWndBodyTexMy","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ChatWnd.ChatWndBottomTexMy","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("SystemMsgWnd.Chat_Head","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("SystemMsgWnd.Chat_Tile","Interface.Null");
		Class'UIAPI_TEXTURECTRL'.SetTexture("SystemMsgWnd.Chat_Bottom","Interface.Null");
	} else {
		Class'UIAPI_CHECKBOX'.SetCheck("ChatFilterWnd.Cb_Transparency",False);
		Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_Tab.Cb_ChatTransparency",False);
		Class'UIAPI_TEXTURECTRL'.SetTexture("ChatWnd.ChatWndHeadTexMy","Interface.Chat_Head");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ChatWnd.ChatWndBodyTexMy","Interface.Chat_Tile");
		Class'UIAPI_TEXTURECTRL'.SetTexture("ChatWnd.ChatWndBottomTexMy","Interface.Chat_Bottom");
		Class'UIAPI_TEXTURECTRL'.SetTexture("SystemMsgWnd.Chat_Head","Interface.Chat_Head");
		Class'UIAPI_TEXTURECTRL'.SetTexture("SystemMsgWnd.Chat_Tile","Interface.Chat_Tile");
		Class'UIAPI_TEXTURECTRL'.SetTexture("SystemMsgWnd.Chat_Bottom","Interface.Chat_Bottom");
	}
}

function OnClickButton (string strID)
{
	if ( UnknownFunction122(strID,"ChatFilterOK") )
	{
		SaveChatFilterOption();
		Class'UIAPI_WINDOW'.HideWindow("ChatFilterWnd");
	} else {
		if ( UnknownFunction122(strID,"ChatFilterCancel") )
		{
			Class'UIAPI_WINDOW'.HideWindow("ChatFilterWnd");
		}
	}
}

function OnClickCheckBox (string strID)
{
	local ChatWnd L2jBRVar21;
	local int chatType;

	L2jBRVar21 = ChatWnd(GetScript("ChatWnd"));
	chatType = L2jBRVar21.m_chatType;
	if ( UnknownFunction122(strID,"Cb_Transparency") )
	{
		if ( Class'UIAPI_CHECKBOX'.IsChecked("ChatFilterWnd.Cb_Transparency") )
		{
			SetOptionBool("Neophron","ChatTransparency",True);
		} else {
			SetOptionBool("Neophron","ChatTransparency",False);
		}
		L2jBRFunction67();
	}
	if ( UnknownFunction122(strID,"CheckBoxSystem") )
	{
		if ( UnknownFunction129(Class'UIAPI_CHECKBOX'.IsChecked("ChatFilterWnd.CheckBoxSystem")) )
		{
			Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxDamage",True);
			Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxItem",True);
		} else {
			Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxDamage",False);
			Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxItem",False);
		}
	} else {
		if ( UnknownFunction122(strID,"SystemMsgBox") )
		{
			if ( Class'UIAPI_CHECKBOX'.IsChecked("ChatFilterWnd.SystemMsgBox") )
			{
				Class'UIAPI_CHECKBOX'.EnableWindow("ChatFilterWnd.DamageBox");
				Class'UIAPI_CHECKBOX'.EnableWindow("ChatFilterWnd.ItemBox");
			} else {
				Class'UIAPI_CHECKBOX'.DisableWindow("ChatFilterWnd.DamageBox");
				Class'UIAPI_CHECKBOX'.DisableWindow("ChatFilterWnd.ItemBox");
			}
		}
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
	switch (chatType)
	{
		case L2jBRVar21.1:
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxTrade",True);
		break;
		case L2jBRVar21.2:
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxParty",True);
		break;
		case L2jBRVar21.3:
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxPledge",True);
		break;
		case L2jBRVar21.4:
		Class'UIAPI_CHECKBOX'.SetDisable("ChatFilterWnd.CheckBoxAlly",True);
		break;
		default:
		break;
	}
}

function SaveChatFilterOption()
{
	local ChatWnd	script;
	local int chatType;
	local bool bChecked;
	
	script = ChatWnd( GetScript("ChatWnd") );
	chatType = script.m_chatType;
	script.m_filterInfo[chatType].bSystem = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxSystem" ) );
	script.m_filterInfo[chatType].bUseitem = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxItem" ) );
	script.m_filterInfo[chatType].bDamage = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxDamage" ) );
	script.m_filterInfo[chatType].bChat = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxChat" ) );
	script.m_filterInfo[chatType].bNormal = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxNormal" ) );
	script.m_filterInfo[chatType].bParty = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxParty" ) );
	script.m_filterInfo[chatType].bShout = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxShout" ) );
	script.m_filterInfo[chatType].bTrade = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxTrade" ) );
	script.m_filterInfo[chatType].bClan = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxPledge" ) );
	script.m_filterInfo[chatType].bWhisper = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxWhisper" ) );
	script.m_filterInfo[chatType].bAlly = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxAlly" ) );
	script.m_filterInfo[chatType].bHero = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxHero" ) );
	script.m_filterInfo[chatType].bUnion = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxUnion" ) );
	script.m_NoUnionCommanderMessage = int( class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.CheckBoxCommand" ) );

	// 시스템메시지전용창 - SystemMsgBox
	bChecked = class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.SystemMsgBox" );
	SetOptionBool( "Game", "SystemMsgWnd", bChecked );

	// 데미지 - DamageBox
	bChecked = class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.DamageBox" );
	SetOptionBool( "Game", "SystemMsgWndDamage", bChecked );

	// 소모성아이템사용 - ItemBox
	bChecked = class'UIAPI_CHECKBOX'.static.IsChecked( "ChatFilterWnd.ItemBox" );
	SetOptionBool( "Game", "SystemMsgWndExpendableItem", bChecked );
	
	if (GetOptionBool( "Game", "SystemMsgWnd" ) )
	{
		 class'UIAPI_WINDOW'.static.ShowWindow("SystemMsgWnd");
	} 
	else 
	{
		class'UIAPI_WINDOW'.static.HideWindow("SystemMsgWnd");
	}
	
	
	SetINIBool(script.m_sectionName[chatType],"system", bool(script.m_filterInfo[chatType].bSystem), "chatfilter.ini");
	SetINIBool(script.m_sectionName[chatType],"damage", bool(script.m_filterInfo[chatType].bDamage), "chatfilter.ini");
	SetINIBool(script.m_sectionName[chatType],"useitems", bool(script.m_filterInfo[chatType].bUseItem), "chatfilter.ini");
	SetINIBool(script.m_sectionName[chatType],"chat", bool(script.m_filterInfo[chatType].bChat), "chatfilter.ini");
	SetINIBool(script.m_sectionName[chatType],"normal", bool(script.m_filterInfo[chatType].bNormal), "chatfilter.ini");
	SetINIBool(script.m_sectionName[chatType],"party", bool(script.m_filterInfo[chatType].bParty), "chatfilter.ini");
	SetINIBool(script.m_sectionName[chatType],"shout", bool(script.m_filterInfo[chatType].bShout), "chatfilter.ini");
	SetINIBool(script.m_sectionName[chatType],"market", bool(script.m_filterInfo[chatType].bTrade), "chatfilter.ini");
	SetINIBool(script.m_sectionName[chatType],"pledge", bool(script.m_filterInfo[chatType].bClan), "chatfilter.ini");
	SetINIBool(script.m_sectionName[chatType],"tell", bool(script.m_filterInfo[chatType].bWhisper), "chatfilter.ini");
	SetINIBool(script.m_sectionName[chatType],"ally", bool(script.m_filterInfo[chatType].bAlly), "chatfilter.ini");	
	SetINIBool(script.m_sectionName[chatType],"hero", bool(script.m_filterInfo[chatType].bHero), "chatfilter.ini");
	SetINIBool(script.m_sectionName[chatType],"union", bool(script.m_filterInfo[chatType].bUnion), "chatfilter.ini");
	
	//Global Setting
	SetINIBool("global","command", bool(script.m_NoUnionCommanderMessage), "chatfilter.ini");	
}
