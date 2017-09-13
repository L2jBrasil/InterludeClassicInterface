//================================================================================
// PetWnd.
//================================================================================

class PetWnd extends UICommonAPI;

var int m_PetID;
var bool m_bShowNameBtn;
var string m_LastInputPetName;
const NPET_BARHEIGHT= 12;
const NPET_LARGEBARSIZE= 206;
const NPET_SMALLBARSIZE= 85;
const DIALOG_GIVEITEMTOPET= 2222;
const DIALOG_PETNAME= 1111;
const PET_EQUIPPEDTEXTURE_NAME= "l2ui_ch3.PetWnd.petitem_click";

function OnLoad ()
{
	RegisterEvent(1710);
	RegisterEvent(250);
	RegisterEvent(1010);
	RegisterEvent(1020);
	RegisterEvent(1030);
	RegisterEvent(1130);
	RegisterEvent(1320);
	RegisterEvent(1330);
	RegisterEvent(1060);
	RegisterEvent(1070);
	RegisterEvent(1080);
	RegisterEvent(1900);
	m_bShowNameBtn = True;
	HideScrollBar();
}

function OnShow ()
{
	Class'PetAPI'.RequestPetInventoryItemList();
	Class'ActionAPI'.RequestPetActionList();
}

function OnDropItem (string strTarget, ItemInfo Info, int X, int Y)
{
	if ( UnknownFunction130(UnknownFunction122(strTarget,"PetInvenWnd"),UnknownFunction122(Info.DragSrcName,"InventoryItem")) )
	{
		if ( UnknownFunction130(IsStackableItem(Info.ConsumeType),UnknownFunction151(Info.ItemNum,1)) )
		{
			if ( UnknownFunction151(Info.AllItemCount,0) )
			{
				Class'PetAPI'.RequestGiveItemToPet(Info.ServerID,Info.AllItemCount);
			} else {
				DialogSetID(2222);
				DialogSetReservedInt(Info.ServerID);
				DialogSetParamInt(Info.ItemNum);
				DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),Info.Name));
			}
		} else {
			Class'PetAPI'.RequestGiveItemToPet(Info.ServerID,1);
		}
	}
}

function __L2jBRFunction1()
{
	Class'PetAPI'.RequestPetInventoryItemList();
	Class'ActionAPI'.RequestPetActionList();
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,250) )
	{
		HandlePetInfoUpdate();
	} else {
		if ( UnknownFunction154(Event_ID,1130) )
		{
			HandlePetSummonedStatusClose();
		} else {
			if ( UnknownFunction154(Event_ID,1010) )
			{
				HandlePetShow();
			} else {
				if ( UnknownFunction154(Event_ID,1020) )
				{
					HandlePetShowNameBtn(L2jBRVar1);
				} else {
					if ( UnknownFunction154(Event_ID,1030) )
					{
						HandleRegPetName(L2jBRVar1);
					} else {
						if ( UnknownFunction154(Event_ID,1710) )
						{
							HandleDialogOK();
						} else {
							if ( UnknownFunction154(Event_ID,1320) )
							{
								HandleActionPetListStart();
							} else {
								if ( UnknownFunction154(Event_ID,1330) )
								{
									HandleActionPetList(L2jBRVar1);
								} else {
									if ( UnknownFunction154(Event_ID,1060) )
									{
										HandlePetInventoryItemStart();
									} else {
										if ( UnknownFunction154(Event_ID,1070) )
										{
											HandlePetInventoryItemList(L2jBRVar1);
										} else {
											if ( UnknownFunction154(Event_ID,1080) )
											{
												HandlePetInventoryItemUpdate(L2jBRVar1);
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
				}
			}
		}
	}
}

function HandleDialogOK ()
{
	local int Id;
	local int ServerID;
	local int L2jBRVar40;

	if ( DialogIsMine() )
	{
		Id = DialogGetID();
		ServerID = DialogGetReservedInt();
		L2jBRVar40 = int(DialogGetString());
		if ( UnknownFunction154(Id,1111) )
		{
			m_LastInputPetName = DialogGetString();
			RequestChangePetName(m_LastInputPetName);
		} else {
			if ( UnknownFunction154(Id,2222) )
			{
				Class'PetAPI'.RequestGiveItemToPet(ServerID,L2jBRVar40);
			}
		}
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnName":
		OnNameClick();
		break;
		default:
	}
}

function OnNameClick ()
{
	DialogSetID(1111);
	DialogShow(2,GetSystemMessage(535));
}

function OnClickItem (string strID, int Index)
{
	local ItemInfo L2jBRVar3;

	if ( UnknownFunction130(UnknownFunction122(strID,"PetActionWnd"),UnknownFunction151(Index,-1)) )
	{
		if ( Class'UIAPI_ITEMWINDOW'.GetItem("PetWnd.PetWnd_Action.PetActionWnd",Index,L2jBRVar3) )
		{
			DoAction(L2jBRVar3.ClassID);
		}
	}
}

function OnDBClickItem (string strID, int Index)
{
	local ItemInfo L2jBRVar3;

	if ( UnknownFunction130(UnknownFunction122(strID,"PetInvenWnd"),UnknownFunction151(Index,-1)) )
	{
		if ( Class'UIAPI_ITEMWINDOW'.GetItem("PetWnd.PetWnd_Inventory.PetInvenWnd",Index,L2jBRVar3) )
		{
			Class'PetAPI'.RequestPetUseItem(L2jBRVar3.ServerID);
		}
	}
}

function OnRClickItem (string strID, int Index)
{
	local ItemInfo L2jBRVar3;

	if ( UnknownFunction130(UnknownFunction122(strID,"PetInvenWnd"),UnknownFunction151(Index,-1)) )
	{
		if ( Class'UIAPI_ITEMWINDOW'.GetItem("PetWnd.PetWnd_Inventory.PetInvenWnd",Index,L2jBRVar3) )
		{
			Class'PetAPI'.RequestPetUseItem(L2jBRVar3.ServerID);
		}
	}
}

function HideScrollBar ()
{
	Class'UIAPI_ITEMWINDOW'.ShowScrollBar("PetWnd.PetWnd_Action.PetActionWnd",False);
}

function Clear ()
{
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtLvName","");
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtHP","0/0");
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtMP","0/0");
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtSP","0");
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtExp","0%");
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtFatigue","0%");
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtWeight","0%");
	UpdateHPBar(0,0);
	UpdateMPBar(0,0);
	UpdateFatigueBar(0,0);
	UpdateEXPBar(0,0);
	UpdateWeightBar(0,0);
}

function ClearActionWnd ()
{
	Class'UIAPI_ITEMWINDOW'.Clear("PetWnd.PetWnd_Action.PetActionWnd");
}

function ClearInvenWnd ()
{
	Class'UIAPI_ITEMWINDOW'.Clear("PetWnd.PetWnd_Inventory.PetInvenWnd");
}

function HandleRegPetName (string L2jBRVar1)
{
	local int msgNo;
	local Color MsgColor;

	ParseInt(L2jBRVar1,"ErrMsgNo",msgNo);
	MsgColor.R = 176;
	MsgColor.G = 155;
	MsgColor.B = 121;
	MsgColor.A = 255;
	AddSystemMessage(GetSystemMessage(msgNo),MsgColor);
	DialogShow(2,GetSystemMessage(535));
	if ( UnknownFunction154(msgNo,80) )
	{
		DialogSetString(m_LastInputPetName);
	}
}

function HandlePetShowNameBtn (string L2jBRVar1)
{
	local int ShowFlag;

	ParseInt(L2jBRVar1,"Show",ShowFlag);
	if ( UnknownFunction154(ShowFlag,1) )
	{
		SetVisibleNameBtn(True);
	} else {
		SetVisibleNameBtn(False);
	}
}

function SetVisibleNameBtn (bool bShow)
{
	if ( bShow )
	{
		Class'UIAPI_WINDOW'.ShowWindow("PetWnd.btnName");
	} else {
		Class'UIAPI_WINDOW'.HideWindow("PetWnd.btnName");
	}
	m_bShowNameBtn = bShow;
}

function HandlePetSummonedStatusClose ()
{
	Class'UIAPI_WINDOW'.HideWindow("PetWnd");
	PlayConsoleSound(6);
}

function HandlePetInfoUpdate ()
{
	local string Name;
	local int HP;
	local int maxHP;
	local int MP;
	local int maxMP;
	local int Fatigue;
	local int MaxFatigue;
	local int CarryWeight;
	local int CarringWeight;
	local int SP;
	local int Level;
	local float fExpRate;
	local float fTmp;
	local int PhysicalAttack;
	local int PhysicalDefense;
	local int HitRate;
	local int CriticalRate;
	local int PhysicalAttackSpeed;
	local int MagicalAttack;
	local int MagicDefense;
	local int PhysicalAvoid;
	local int MovingSpeed;
	local int MagicCastingSpeed;
	local int SoulShotCosume;
	local int SpiritShotConsume;
	local PetInfo Info;

	if ( GetPetInfo(Info) )
	{
		m_PetID = Info.nID;
		Name = Info.Name;
		SP = Info.nSP;
		Level = Info.nLevel;
		HP = Info.nCurHP;
		maxHP = Info.nMaxHP;
		MP = Info.nCurMP;
		maxMP = Info.nMaxMP;
		CarryWeight = Info.nCarryWeight;
		CarringWeight = Info.nCarringWeight;
		Fatigue = Info.nFatigue;
		MaxFatigue = Info.nMaxFatigue;
		fExpRate = Class'UIDATA_PET'.GetPetEXPRate();
		PhysicalAttack = Info.nPhysicalAttack;
		PhysicalDefense = Info.nPhysicalDefense;
		HitRate = Info.nHitRate;
		CriticalRate = Info.nCriticalRate;
		PhysicalAttackSpeed = Info.nPhysicalAttackSpeed;
		MagicalAttack = Info.nMagicalAttack;
		MagicDefense = Info.nMagicDefense;
		PhysicalAvoid = Info.nPhysicalAvoid;
		MovingSpeed = Info.nMovingSpeed;
		MagicCastingSpeed = Info.nMagicCastingSpeed;
		SoulShotCosume = Info.nSoulShotCosume;
		SpiritShotConsume = Info.nSpiritShotConsume;
	}
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtLvName",UnknownFunction112(UnknownFunction112(string(Level)," "),Name));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtHP",UnknownFunction112(UnknownFunction112(string(HP),"/"),string(maxHP)));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtMP",UnknownFunction112(UnknownFunction112(string(MP),"/"),string(maxMP)));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtSP",string(SP));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtExp",UnknownFunction112(string(fExpRate),"%"));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtPhysicalAttack",string(PhysicalAttack));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtPhysicalDefense",string(PhysicalDefense));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtHitRate",string(HitRate));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtCriticalRate",string(CriticalRate));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtPhysicalAttackSpeed",string(PhysicalAttackSpeed));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtMagicalAttack",string(MagicalAttack));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtMagicDefense",string(MagicDefense));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtPhysicalAvoid",string(PhysicalAvoid));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtMovingSpeed",string(MovingSpeed));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtMagicCastingSpeed",string(MagicCastingSpeed));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtSoulShotCosume",string(SoulShotCosume));
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtSpiritShotConsume",string(SpiritShotConsume));
	fTmp = UnknownFunction172(UnknownFunction171(100.0,Fatigue),MaxFatigue);
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtFatigue",UnknownFunction112(string(fTmp),"%"));
	fTmp = UnknownFunction172(UnknownFunction171(100.0,CarringWeight),CarryWeight);
	Class'UIAPI_TEXTBOX'.SetText("PetWnd.txtWeight",UnknownFunction112(string(fTmp),"%"));
	UpdateHPBar(HP,maxHP);
	UpdateMPBar(MP,maxMP);
	UpdateEXPBar(int(fExpRate),100);
	UpdateFatigueBar(Fatigue,MaxFatigue);
	UpdateWeightBar(CarringWeight,CarryWeight);
}

function HandlePetShow ()
{
	Clear();
	HandlePetInfoUpdate();
	PlayConsoleSound(5);
	Class'UIAPI_WINDOW'.ShowWindow("PetWnd");
	Class'UIAPI_WINDOW'.SetFocus("PetWnd");
	SetVisibleNameBtn(m_bShowNameBtn);
}

function UpdateHPBar (int Value, int MaxValue)
{
	local int Size;

	Size = 0;
	if ( UnknownFunction151(MaxValue,0) )
	{
		Size = 85;
		if ( UnknownFunction150(Value,MaxValue) )
		{
			Size = UnknownFunction145(UnknownFunction144(85,Value),MaxValue);
		}
	}
	Class'UIAPI_WINDOW'.SetWindowSize("PetWnd.texHP",Size,12);
}

function UpdateMPBar (int Value, int MaxValue)
{
	local int Size;

	Size = 0;
	if ( UnknownFunction151(MaxValue,0) )
	{
		Size = 85;
		if ( UnknownFunction150(Value,MaxValue) )
		{
			Size = UnknownFunction145(UnknownFunction144(85,Value),MaxValue);
		}
	}
	Class'UIAPI_WINDOW'.SetWindowSize("PetWnd.texMP",Size,12);
}

function UpdateEXPBar (int Value, int MaxValue)
{
	local int Size;

	Size = 0;
	if ( UnknownFunction151(MaxValue,0) )
	{
		Size = 206;
		if ( UnknownFunction150(Value,MaxValue) )
		{
			Size = UnknownFunction145(UnknownFunction144(206,Value),MaxValue);
		}
	}
	Class'UIAPI_WINDOW'.SetWindowSize("PetWnd.texEXP",Size,12);
}

function UpdateFatigueBar (int Value, int MaxValue)
{
	local int Size;

	Size = 0;
	if ( UnknownFunction151(MaxValue,0) )
	{
		Size = 206;
		if ( UnknownFunction150(Value,MaxValue) )
		{
			Size = UnknownFunction145(UnknownFunction144(206,Value),MaxValue);
		}
	}
	Class'UIAPI_WINDOW'.SetWindowSize("PetWnd.texFatigue",Size,12);
}

function UpdateWeightBar (int Value, int MaxValue)
{
	local int Size;
	local float fTmp;
	local string strName;

	Size = 0;
	if ( UnknownFunction151(MaxValue,0) )
	{
		fTmp = UnknownFunction172(UnknownFunction171(100.0,Value),MaxValue);
		if ( UnknownFunction178(fTmp,50.0) )
		{
			strName = "L2UI_CH3.PlayerStatusWnd.ps_weightbar1";
		} else {
			if ( UnknownFunction130(UnknownFunction177(fTmp,50.0),UnknownFunction178(fTmp,66.66366)) )
			{
				strName = "L2UI_CH3.PlayerStatusWnd.ps_weightbar2";
			} else {
				if ( UnknownFunction130(UnknownFunction177(fTmp,66.66366),UnknownFunction178(fTmp,80.0)) )
				{
					strName = "L2UI_CH3.PlayerStatusWnd.ps_weightbar3";
				} else {
					if ( UnknownFunction177(fTmp,80.0) )
					{
						strName = "L2UI_CH3.PlayerStatusWnd.ps_weightbar4";
					}
				}
			}
		}
		Size = 85;
		if ( UnknownFunction150(Value,MaxValue) )
		{
			Size = UnknownFunction145(UnknownFunction144(85,Value),MaxValue);
		}
	}
	Class'UIAPI_TEXTURECTRL'.SetTexture("PetWnd.texWeight",strName);
	Class'UIAPI_WINDOW'.SetWindowSize("PetWnd.texWeight",Size,12);
}

function HandleActionPetListStart ()
{
	ClearActionWnd();
}

function HandleActionPetList (string L2jBRVar1)
{
	local int L2jBRVar4;
	local EActionCategory L2jBRVar5;
	local int ActionID;
	local string strActionName;
	local string strIconName;
	local string strDescription;
	local string strCommand;
	local ItemInfo L2jBRVar3;

	ParseInt(L2jBRVar1,"Type",L2jBRVar4);
	ParseInt(L2jBRVar1,"ActionID",ActionID);
	ParseString(L2jBRVar1,"Name",strActionName);
	ParseString(L2jBRVar1,"IconName",strIconName);
	ParseString(L2jBRVar1,"Description",strDescription);
	ParseString(L2jBRVar1,"Command",strCommand);
	L2jBRVar3.ClassID = ActionID;
	L2jBRVar3.Name = strActionName;
	L2jBRVar3.IconName = strIconName;
	L2jBRVar3.Description = strDescription;
	L2jBRVar3.ItemSubType = 3;
	L2jBRVar3.MacroCommand = strCommand;
	L2jBRVar5 = L2jBRVar4;
	if ( UnknownFunction154(L2jBRVar5,4) )
	{
		Class'UIAPI_ITEMWINDOW'.AddItem("PetWnd.PetWnd_Action.PetActionWnd",L2jBRVar3);
	}
}

function HandlePetInventoryItemStart ()
{
	ClearInvenWnd();
}

function HandlePetInventoryItemList (string L2jBRVar1)
{
	local ItemInfo L2jBRVar3;

	ParamToItemInfo(L2jBRVar1,L2jBRVar3);
	if ( L2jBRVar3.bEquipped )
	{
		L2jBRVar3.ForeTexture = "l2ui_ch3.PetWnd.petitem_click";
	}
	Class'UIAPI_ITEMWINDOW'.AddItem("PetWnd.PetWnd_Inventory.PetInvenWnd",L2jBRVar3);
}

function HandlePetInventoryItemUpdate (string L2jBRVar1)
{
	local ItemInfo L2jBRVar3;
	local int L2jBRVar4;
	local int Index;
	local EInventoryUpdateType WorkType;

	ParamToItemInfo(L2jBRVar1,L2jBRVar3);
	ParseInt(L2jBRVar1,"WorkType",L2jBRVar4);
	WorkType = L2jBRVar4;
	if ( UnknownFunction150(L2jBRVar3.ClassID,1) )
	{
		return;
	}
	if ( L2jBRVar3.bEquipped )
	{
		L2jBRVar3.ForeTexture = "l2ui_ch3.PetWnd.petitem_click";
	}
	switch (WorkType)
	{
		case 1:
		Class'UIAPI_ITEMWINDOW'.AddItem("PetWnd.PetWnd_Inventory.PetInvenWnd",L2jBRVar3);
		break;
		case 2:
		Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PetWnd.PetWnd_Inventory.PetInvenWnd",L2jBRVar3.ClassID);
		if ( UnknownFunction150(Index,0) )
		{
			return;
		}
		Class'UIAPI_ITEMWINDOW'.SetItem("PetWnd.PetWnd_Inventory.PetInvenWnd",Index,L2jBRVar3);
		break;
		case 3:
		Index = Class'UIAPI_ITEMWINDOW'.FindItemWithClassID("PetWnd.PetWnd_Inventory.PetInvenWnd",L2jBRVar3.ClassID);
		if ( UnknownFunction150(Index,0) )
		{
			return;
		}
		Class'UIAPI_ITEMWINDOW'.DeleteItem("PetWnd.PetWnd_Inventory.PetInvenWnd",Index);
		break;
		default:
	}
}

