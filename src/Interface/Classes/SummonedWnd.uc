//================================================================================
// SummonedWnd.
//================================================================================

class SummonedWnd extends UIScript;

const NPET_BARHEIGHT= 12;
const NPET_SMALLBARSIZE= 256;
var WindowHandle L2jBRVar12;
var int m_PetID;

function OnLoad ()
{
	L2jBRVar12 = GetHandle("SummonedWnd");
	RegisterEvent(250);
	RegisterEvent(1090);
	RegisterEvent(1130);
	RegisterEvent(1340);
	RegisterEvent(1350);
	RegisterEvent(1900);
	HideScrollBar();
}

function OnShow ()
{
	Class'ActionAPI'.RequestSummonedActionList();
	SetFocus();
}

function __L2jBRFunction1()
{
	Class'ActionAPI'.RequestSummonedActionList();
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
			if ( UnknownFunction154(Event_ID,1090) )
			{
				HandlePetShow();
			} else {
				if ( UnknownFunction154(Event_ID,1340) )
				{
					HandleActionSummonedListStart();
				} else {
					if ( UnknownFunction154(Event_ID,1350) )
					{
						HandleActionSummonedList(L2jBRVar1);
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

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "BtnClose":
		L2jBRVar12.HideWindow();
		break;
		default:
	}
}

function OnClickItem (string strID, int Index)
{
	local ItemInfo L2jBRVar3;

	if ( UnknownFunction130(UnknownFunction122(strID,"SummonedActionWnd"),UnknownFunction151(Index,-1)) )
	{
		if ( Class'UIAPI_ITEMWINDOW'.GetItem("SummonedWnd.SummonedWnd_Action.SummonedActionWnd",Index,L2jBRVar3) )
		{
			DoAction(L2jBRVar3.ClassID);
		}
	}
}

function HideScrollBar ()
{
	Class'UIAPI_ITEMWINDOW'.ShowScrollBar("SummonedWnd.SummonedWnd_Action.SummonedActionWnd",False);
}

function HandleActionSummonedListStart ()
{
	ClearActionWnd();
}

function Clear ()
{
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtLvName","");
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtHP","0/0");
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtMP","0/0");
	UpdateHPBar(0,0);
	UpdateMPBar(0,0);
}

function ClearActionWnd ()
{
	Class'UIAPI_ITEMWINDOW'.Clear("SummonedWnd.SummonedWnd_Action.SummonedActionWnd");
}

function HandlePetSummonedStatusClose ()
{
	Class'UIAPI_WINDOW'.HideWindow("SummonedWnd");
	PlayConsoleSound(6);
}

function HandlePetInfoUpdate ()
{
	local string Name;
	local int HP;
	local int maxHP;
	local int MP;
	local int maxMP;
	local int Level;
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
		Level = Info.nLevel;
		HP = Info.nCurHP;
		maxHP = Info.nMaxHP;
		MP = Info.nCurMP;
		maxMP = Info.nMaxMP;
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
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtLvName",UnknownFunction112(UnknownFunction112(string(Level)," "),Name));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtHP",UnknownFunction112(UnknownFunction112(string(HP),"/"),string(maxHP)));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtMP",UnknownFunction112(UnknownFunction112(string(MP),"/"),string(maxMP)));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtPhysicalAttack",string(PhysicalAttack));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtPhysicalDefense",string(PhysicalDefense));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtHitRate",string(HitRate));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtCriticalRate",string(CriticalRate));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtPhysicalAttackSpeed",string(PhysicalAttackSpeed));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtMagicalAttack",string(MagicalAttack));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtMagicDefense",string(MagicDefense));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtPhysicalAvoid",string(PhysicalAvoid));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtMovingSpeed",string(MovingSpeed));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtMagicCastingSpeed",string(MagicCastingSpeed));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtSoulShotCosume",string(SoulShotCosume));
	Class'UIAPI_TEXTBOX'.SetText("SummonedWnd.txtSpiritShotConsume",string(SpiritShotConsume));
	Class'UIAPI_TEXTURECTRL'.SetTexture("SummonedWnd.PetIcon",GetPetIcon(Name));
	UpdateHPBar(HP,maxHP);
	UpdateMPBar(MP,maxMP);
}

function HandlePetShow ()
{
	Clear();
	HandlePetInfoUpdate();
	PlayConsoleSound(5);
	Class'UIAPI_WINDOW'.ShowWindow("SummonedWnd");
	Class'UIAPI_WINDOW'.SetFocus("SummonedWnd");
}

function UpdateHPBar (int Value, int MaxValue)
{
	local int Size;

	Size = 0;
	if ( UnknownFunction151(MaxValue,0) )
	{
		Size = 256;
		if ( UnknownFunction150(Value,MaxValue) )
		{
			Size = UnknownFunction145(UnknownFunction144(256,Value),MaxValue);
		}
	}
	Class'UIAPI_WINDOW'.SetWindowSize("SummonedWnd.texHP",Size,12);
}

function UpdateMPBar (int Value, int MaxValue)
{
	local int Size;

	Size = 0;
	if ( UnknownFunction151(MaxValue,0) )
	{
		Size = 256;
		if ( UnknownFunction150(Value,MaxValue) )
		{
			Size = UnknownFunction145(UnknownFunction144(256,Value),MaxValue);
		}
	}
	Class'UIAPI_WINDOW'.SetWindowSize("SummonedWnd.texMP",Size,12);
}

function HandleActionSummonedList (string L2jBRVar1)
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
	L2jBRVar3.IconName = RedirectIconName(strIconName);
	L2jBRVar3.Description = strDescription;
	L2jBRVar3.ItemSubType = 3;
	L2jBRVar3.MacroCommand = strCommand;
	L2jBRVar5 = L2jBRVar4;
	if ( UnknownFunction154(L2jBRVar5,5) )
	{
		Class'UIAPI_ITEMWINDOW'.AddItem("SummonedWnd.SummonedWnd_Action.SummonedActionWnd",L2jBRVar3);
	}
}

function SetFocus ()
{
	Class'UIAPI_WINDOW'.SetFocus("SummonedWnd.SummonedWnd_Action.SummonedActionWnd");
	Class'UIAPI_WINDOW'.SetFocus("SummonedWnd.SummonedWnd_Status");
}

function string GetPetIcon (string Name)
{
	local string Text;

	switch (Name)
	{
		case "Feline Queen":
		Text = "Icon.Skill1331";
		break;
		case "Mew the Cat":
		Text = "Icon.Skill1225";
		break;
		case "Kat the Cat":
		Text = "Icon.Skill1111";
		break;
		case "Kai the Cat":
		Text = "Icon.Skill1276";
		break;
		case "Feline King":
		Text = "Icon.Skill1406";
		break;
		case "Unicorn Seraphim":
		Text = "Icon.Skill1332";
		break;
		case "Boxer the Unicorn":
		Text = "Icon.Skill1226";
		break;
		case "Mirage the Unicorn":
		Text = "Icon.Skill1227";
		break;
		case "Merrow the Unicorn":
		Text = "Icon.Skill1277";
		break;
		case "Magnus the Unicorn":
		Text = "Icon.Skill1407";
		break;
		case "Spectral Lord":
		Text = "Icon.Skill1408";
		break;
		case "Nightshade":
		Text = "Icon.Skill1333";
		break;
		case "Silhouette":
		Text = "Icon.Skill1228";
		break;
		case "Shadow":
		Text = "Icon.Skill1128";
		break;
		case "Soulless":
		Text = "Icon.Skill1278";
		break;
		case "Corrupted Man":
		Text = "Icon.Skill1154";
		break;
		case "Cursed man":
		Text = "Icon.Skill1334";
		break;
		case "Reanimated Man":
		Text = "Icon.Skill1129";
		break;
		case "Mechanic Golem":
		Text = "Icon.Skill0025";
		break;
		case "Siege Golem":
		Text = "Icon.Skill0013";
		break;
		case "Wild Hog Cannon":
		Text = "Icon.Skill0299";
		break;
		case "Big Boom":
		Text = "Icon.Skill0299";
		break;
		case "Swoop Cannon":
		Text = "Icon.Skill0448";
		break;
		default:
		Text = "L2UI_CH3.PetIcon";
	}
	return Text;
}

function string RedirectIconName (string Name)
{
	local string Text;

	switch (Name)
	{
		case "Icon.Action101":
		Text = "Interface.Action201";
		break;
		case "Icon.Action102":
		Text = "Interface.Action202";
		break;
		case "Icon.Action103":
		Text = "Interface.Action203";
		break;
		case "Icon.Action104":
		Text = "Interface.Action204";
		break;
		case "Icon.Action105":
		Text = "Interface.Action205";
		break;
		case "Icon.Action106":
		Text = "Interface.Action206";
		break;
		case "Icon.Action107":
		Text = "Interface.Action207";
		break;
		case "Icon.Action108":
		Text = "Interface.Action208";
		break;
		case "Icon.Action109":
		Text = "Interface.Action209";
		break;
		case "Icon.Action111":
		Text = "Interface.Action211";
		break;
		case "Icon.Action112":
		Text = "Interface.Action212";
		break;
		default:
	}
	return Text;
}

