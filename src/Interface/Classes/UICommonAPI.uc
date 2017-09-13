//================================================================================
// UICommonAPI.
//================================================================================

class UICommonAPI extends UIScript;

var int Time;
var bool SuperRaceShop;
enum DialogDefaultAction {
	EDefaultNone,
	EDefaultOK,
	EDefaultCancel
};

enum EDialogType {
	DIALOG_OKCancel,
	DIALOG_OK,
	DIALOG_OKCancelInput,
	DIALOG_OKInput,
	DIALOG_Warning,
	DIALOG_Notice,
	DIALOG_NumberPad,
	DIALOG_Progress
};

const EV_TargetShotdown= 2960;
const EV_OpenDialogQuit= 2940;
const EV_OpenDialogRestart= 2930;

function bool IsValidItemID (ItemInfo Id)
{
	if ( UnknownFunction130(UnknownFunction150(Id.ClassID,1),UnknownFunction150(Id.ServerID,1)) )
	{
		return False;
	}
	return True;
}

function DialogShow (EDialogType dialogType, string strMessage)
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	L2jBRVar21.ShowDialog(dialogType,strMessage,string(self));
}

function DialogHide ()
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	L2jBRVar21.HideDialog();
}

function DialogSetDefaultOK ()
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	L2jBRVar21.SetDefaultAction(1);
}

function bool DialogIsMine ()
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	if ( UnknownFunction122(L2jBRVar21.GetTarget(),string(self)) )
	{
		return True;
	}
	return False;
}

function DialogSetID (int Id)
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	L2jBRVar21.SetID(Id);
}

function DialogSetEditType (string strType)
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	L2jBRVar21.SetEditType(strType);
}

function string DialogGetString ()
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	return L2jBRVar21.GetEditMessage();
}

function DialogSetString (string strInput)
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	L2jBRVar21.SetEditMessage(strInput);
}

function int DialogGetID ()
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	return L2jBRVar21.GetID();
}

function DialogSetParamInt (int L2jBRVar1)
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	L2jBRVar21.SetParamInt(L2jBRVar1);
}

function DialogSetReservedInt (int Value)
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	L2jBRVar21.SetReservedInt(Value);
}

function DialogSetReservedInt2 (int Value)
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	L2jBRVar21.SetReservedInt2(Value);
}

function DialogSetReservedInt3 (int Value)
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	L2jBRVar21.SetReservedInt3(Value);
}

function int DialogGetReservedInt ()
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	return L2jBRVar21.GetReservedInt();
}

function int DialogGetReservedInt2 ()
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	return L2jBRVar21.GetReservedInt2();
}

function int DialogGetReservedInt3 ()
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	return L2jBRVar21.GetReservedInt3();
}

function DialogSetEditBoxMaxLength (int maxLength)
{
	local DialogBox L2jBRVar21;

	L2jBRVar21 = DialogBox(GetScript("DialogBox"));
	L2jBRVar21.SetEditBoxMaxLength(maxLength);
}

function int Split (string strInput, string delim, out array<string> arrToken)
{
	local int arrSize;

	if ( UnknownFunction151(UnknownFunction126(strInput,delim),0) )
	{
		byte(arrToken)
		arrToken.Length
		1
		arrToken[UnknownFunction147(arrToken.Length,1)] = UnknownFunction128(strInput,UnknownFunction126(strInput,delim));
		strInput = UnknownFunction127(strInput,UnknownFunction146(UnknownFunction126(strInput,delim),1));
		arrSize = UnknownFunction146(arrSize,1);
		goto JL0000;
	}
	byte(arrToken)
	arrToken.Length
	1
	arrToken[UnknownFunction147(arrToken.Length,1)] = strInput;
	arrSize = UnknownFunction146(arrSize,1);
	return arrSize;
}

function bool L2jBRFunction7 (string L2jBRVar1, string _L2jBRVar17_)
{
	local bool L2jBRVar4;

	if ( UnknownFunction124(L2jBRVar1,_L2jBRVar17_) )
	{
		L2jBRVar4 = True;
	}
	return L2jBRVar4;
}

function JoinArray (array<string> StringArray, out string out_Result, string delim, bool bIgnoreBlanks)
{
	local int i;
	local string S;

	i = 0;
	if ( UnknownFunction150(i,StringArray.Length) )
	{
		if ( UnknownFunction132(UnknownFunction123(StringArray[i],""),UnknownFunction129(bIgnoreBlanks)) )
		{
			if ( UnknownFunction123(S,"") )
			{
				S = UnknownFunction112(S,delim);
			}
			S = UnknownFunction112(S,StringArray[i]);
		}
		UnknownFunction165(i);
		goto JL0007;
	}
	out_Result = S;
}

function ShowWindow (string a_ControlID)
{
	Class'UIAPI_WINDOW'.ShowWindow(a_ControlID);
}

function ShowWindowWithFocus (string a_ControlID)
{
	Class'UIAPI_WINDOW'.ShowWindow(a_ControlID);
	Class'UIAPI_WINDOW'.SetFocus(a_ControlID);
}

function HideWindow (string a_ControlID)
{
	Class'UIAPI_WINDOW'.HideWindow(a_ControlID);
}

function bool IsShowWindow (string a_ControlID)
{
	return Class'UIAPI_WINDOW'.IsShowWindow(a_ControlID);
}

function int Int64ToInt (INT64 int64Param)
{
	local int intParam;
	local string paramBuffer;

	ParamAddInt64(paramBuffer,"INT64buffer",int64Param);
	if ( ParseInt(paramBuffer,"INT64buffer",intParam) )
	{
		intParam = 0;
	}
	return intParam;
}

function ParamToItemInfo (string L2jBRVar1, out ItemInfo Info)
{
	local int tmpInt;

	ParseInt(L2jBRVar1,"classID",Info.ClassID);
	ParseInt(L2jBRVar1,"level",Info.Level);
	ParseString(L2jBRVar1,"name",Info.Name);
	ParseString(L2jBRVar1,"additionalName",Info.AdditionalName);
	ParseString(L2jBRVar1,"iconName",Info.IconName);
	ParseString(L2jBRVar1,"description",Info.Description);
	ParseInt(L2jBRVar1,"itemType",Info.ItemType);
	ParseInt(L2jBRVar1,"serverID",Info.ServerID);
	ParseInt(L2jBRVar1,"itemNum",Info.ItemNum);
	ParseInt(L2jBRVar1,"slotBitType",Info.SlotBitType);
	ParseInt(L2jBRVar1,"enchanted",Info.Enchanted);
	ParseInt(L2jBRVar1,"blessed",Info.Blessed);
	ParseInt(L2jBRVar1,"damaged",Info.Damaged);
	if ( ParseInt(L2jBRVar1,"equipped",tmpInt) )
	{
		Info.bEquipped = bool(tmpInt);
	}
	ParseInt(L2jBRVar1,"price",Info.Price);
	ParseInt(L2jBRVar1,"reserved",Info.Reserved);
	ParseInt(L2jBRVar1,"defaultPrice",Info.DefaultPrice);
	ParseInt(L2jBRVar1,"refineryOp1",Info.RefineryOp1);
	ParseInt(L2jBRVar1,"refineryOp2",Info.RefineryOp2);
	ParseInt(L2jBRVar1,"currentDurability",Info.CurrentDurability);
	ParseInt(L2jBRVar1,"weight",Info.Weight);
	ParseInt(L2jBRVar1,"materialType",Info.MaterialType);
	ParseInt(L2jBRVar1,"weaponType",Info.WeaponType);
	ParseInt(L2jBRVar1,"physicalDamage",Info.PhysicalDamage);
	ParseInt(L2jBRVar1,"magicalDamage",Info.MagicalDamage);
	ParseInt(L2jBRVar1,"shieldDefense",Info.ShieldDefense);
	ParseInt(L2jBRVar1,"shieldDefenseRate",Info.ShieldDefenseRate);
	ParseInt(L2jBRVar1,"durability",Info.Durability);
	ParseInt(L2jBRVar1,"crystalType",Info.CrystalType);
	ParseInt(L2jBRVar1,"randomDamage",Info.RandomDamage);
	ParseInt(L2jBRVar1,"critical",Info.Critical);
	ParseInt(L2jBRVar1,"hitModify",Info.HitModify);
	ParseInt(L2jBRVar1,"attackSpeed",Info.AttackSpeed);
	ParseInt(L2jBRVar1,"mpConsume",Info.MpConsume);
	ParseInt(L2jBRVar1,"avoidModify",Info.AvoidModify);
	ParseInt(L2jBRVar1,"soulshotCount",Info.SoulshotCount);
	ParseInt(L2jBRVar1,"spiritshotCount",Info.SpiritshotCount);
	ParseInt(L2jBRVar1,"armorType",Info.ArmorType);
	ParseInt(L2jBRVar1,"physicalDefense",Info.PhysicalDefense);
	ParseInt(L2jBRVar1,"magicalDefense",Info.MagicalDefense);
	ParseInt(L2jBRVar1,"mpBonus",Info.MpBonus);
	ParseInt(L2jBRVar1,"consumeType",Info.ConsumeType);
	ParseInt(L2jBRVar1,"ItemSubType",Info.ItemSubType);
	ParseString(L2jBRVar1,"iconNameEx1",Info.IconNameEx1);
	ParseString(L2jBRVar1,"iconNameEx2",Info.IconNameEx2);
	ParseString(L2jBRVar1,"iconNameEx3",Info.IconNameEx3);
	ParseString(L2jBRVar1,"iconNameEx4",Info.IconNameEx4);
	if ( ParseInt(L2jBRVar1,"arrow",tmpInt) )
	{
		Info.bArrow = bool(tmpInt);
	}
	if ( ParseInt(L2jBRVar1,"recipe",tmpInt) )
	{
		Info.bRecipe = bool(tmpInt);
	}
}

function ParamToRecord (string L2jBRVar1, out LVDataRecord Record)
{
	local int L2jBRVar2;
	local int MaxColumn;

	ParseString(L2jBRVar1,"szReserved",Record.szReserved);
	ParseInt(L2jBRVar1,"nReserved1",Record.nReserved1);
	ParseInt(L2jBRVar1,"nReserved2",Record.nReserved2);
	ParseInt(L2jBRVar1,"nReserved3",Record.nReserved3);
	ParseInt(L2jBRVar1,"MaxColumn",MaxColumn);
	Record.LVDataList.Length = MaxColumn;
	L2jBRVar2 = 0;
	if ( UnknownFunction150(L2jBRVar2,MaxColumn) )
	{
		ParseString(L2jBRVar1,UnknownFunction112("szData_",string(L2jBRVar2)),Record.LVDataList[L2jBRVar2].szData);
		ParseString(L2jBRVar1,UnknownFunction112("szReserved_",string(L2jBRVar2)),Record.LVDataList[L2jBRVar2].szReserved);
		ParseInt(L2jBRVar1,UnknownFunction112("nReserved1_",string(L2jBRVar2)),Record.LVDataList[L2jBRVar2].nReserved1);
		ParseInt(L2jBRVar1,UnknownFunction112("nReserved2_",string(L2jBRVar2)),Record.LVDataList[L2jBRVar2].nReserved2);
		ParseInt(L2jBRVar1,UnknownFunction112("nReserved3_",string(L2jBRVar2)),Record.LVDataList[L2jBRVar2].nReserved3);
		UnknownFunction165(L2jBRVar2);
		goto JL00B7;
	}
}

function CustomTooltip MakeTooltipSimpleText (string Text)
{
	local CustomTooltip ToolTip;
	local DrawItemInfo Info;

	ToolTip.DrawList.Length = 1;
	Info.eType = 1;
	Info.t_bDrawOneLine = True;
	Info.t_strText = Text;
	ToolTip.DrawList[0] = Info;
	return ToolTip;
}

function int GetSecond ()
{
	local array<string> arrSplit;
	local int SplitCount;
	local string strNodeName;
	local int strCount;

	strNodeName = GetTimeString();
	SplitCount = Split(strNodeName,":",arrSplit);
	if ( UnknownFunction151(SplitCount,0) )
	{
		strNodeName = arrSplit[2];
		strCount = int(strNodeName);
	}
	return strCount;
}

function SetSuperRaceShop (bool L2jBRVar1)
{
	SuperRaceShop = L2jBRVar1;
}

function bool GetSuperRaceShop ()
{
	return SuperRaceShop;
}

function string GetSuperRace (string Text)
{
	local string Result;
	local int SplitCount;
	local int i;
	local array<string> temp;
	local array<string> texttemp;

	temp.Length = 0;
	texttemp.Length = 0;
	SplitCount = Split(Text,",",texttemp);
	i = 0;
	if ( UnknownFunction152(i,texttemp.Length) )
	{
		temp[i] = UnknownFunction236(int(texttemp[i]));
		Result = UnknownFunction112(Result,temp[i]);
		UnknownFunction163(i);
		goto JL0030;
	}
	return Result;
}

function L2jBRFunction41 ()
{
	SetOptionBool("Neophron","HoldTarget",False);
	SetOptionBool("Neophron","IgnoreAggr",False);
	SetOptionBool("Neophron","UseDoping",False);
	Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_Tab.Cb_HoldTarget",False);
	Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_Tab.Cb_IgnoreAggr",False);
	Class'UIAPI_CHECKBOX'.SetCheck("NPHRN_Tab.Cb_UseDoping",False);
	Class'UIAPI_CHECKBOX'.SetDisable("NPHRN_Tab.Cb_HoldTarget",True);
	Class'UIAPI_CHECKBOX'.SetDisable("NPHRN_Tab.Cb_IgnoreAggr",True);
	Class'UIAPI_CHECKBOX'.SetDisable("NPHRN_Tab.Cb_UseDoping",True);
	Class'UIAPI_WINDOW'.HideWindow("NPHRN_Tab.Cb_HoldTarget");
	Class'UIAPI_WINDOW'.HideWindow("NPHRN_Tab.Cb_IgnoreAggr");
	Class'UIAPI_WINDOW'.HideWindow("NPHRN_Tab.Cb_UseDoping");
	Class'UIAPI_WINDOW'.HideWindow("NPHRN_MagicSkillWnd");
	Class'UIAPI_WINDOW'.HideWindow("NPHRN_DopingWnd");
}

/*static final function string ReplaceText (coerce string Text, coerce string Replace, coerce string With)
{
	local int i;
	local string Output;
	
	i = UnknownFunction126(Text,Replace);
	
	if ( UnknownFunction155(i,-1) )
	{
		Output = UnknownFunction112(UnknownFunction112(Output,UnknownFunction128(Text,i)),With);
		Text = UnknownFunction127(Text,UnknownFunction146(i,UnknownFunction125(Replace)));
		i = UnknownFunction126(Text,Replace);
		goto JL0012;
	}
	Output = UnknownFunction112(Output,Text);
	return Output;
}*/

static final function string ReplaceText(coerce string Text, coerce string Replace, coerce string With)
{
	local int i;
	local string Output;
 
	i = InStr(Text, Replace);
	while (i != -1) {	
		Output = Output $ Left(Text, i) $ With;
		Text = Mid(Text, i + Len(Replace));	
		i = InStr(Text, Replace);
	}
	Output = Output $ Text;
	return Output;
}

function L2jBRFunction8 ()
{
	RequestExit();
}

function L2jBRFunction9 (int MsgType, int msgNo, int WindowType, int FontType, Color MsgColor, int Lifetime, string MessageText)
{
	local string out_Param;

	ParamAdd(out_Param,"MsgType",string(MsgType));
	ParamAdd(out_Param,"MsgNo",string(msgNo));
	ParamAdd(out_Param,"WindowType",string(WindowType));
	ParamAdd(out_Param,"FontSize","10");
	ParamAdd(out_Param,"FontType",string(FontType));
	ParamAdd(out_Param,"MsgColor","1");
	ParamAdd(out_Param,"MsgColorR",string(MsgColor.R));
	ParamAdd(out_Param,"MsgColorG",string(MsgColor.G));
	ParamAdd(out_Param,"MsgColorB",string(MsgColor.B));
	ParamAdd(out_Param,"ShadowType","0");
	ParamAdd(out_Param,"BackgroundType","1");
	ParamAdd(out_Param,"LifeTime",string(Lifetime));
	ParamAdd(out_Param,"AnimationType","0");
	ParamAdd(out_Param,"Msg",MessageText);
	ExecuteEvent(140,out_Param);
}

function Color L2jBRFunction10 (string m_Color)
{
	local Color MsnColor;

	switch (m_Color)
	{
		case "Yellow":
		MsnColor.R = 255;
		MsnColor.G = 255;
		MsnColor.B = 0;
		break;
		case "System":
		MsnColor.R = 176;
		MsnColor.G = 155;
		MsnColor.B = 121;
		break;
		case "Amber":
		MsnColor.R = 218;
		MsnColor.G = 165;
		MsnColor.B = 32;
		break;
		case "White":
		MsnColor.R = 255;
		MsnColor.G = 255;
		MsnColor.B = 255;
		break;
		case "Dim":
		MsnColor.R = 177;
		MsnColor.G = 173;
		MsnColor.B = 172;
		break;
		case "Magenta":
		MsnColor.R = 255;
		MsnColor.G = 0;
		MsnColor.B = 255;
		break;
		default:
	}
	return MsnColor;
}

function bool L2jBRFunction11 (int L2jBRVar5)
{
	local bool L2jBRVar4;

	switch (L2jBRVar5)
	{
		case 0:
		case 1:
		case 2:
		L2jBRVar4 = True;
		break;
		default:
	}
	return L2jBRVar4;
}

function bool L2jBRFunction12 (string L2jBRVar1)
{
	local bool L2jBRVar4;

	switch (L2jBRVar1)
	{
		case "Blessed Scroll: Enchant Weapon (Grade S)":
		case "Blessed Scroll: Enchant Weapon (Grade A)":
		case "Blessed Scroll: Enchant Weapon (Grade B)":
		case "Blessed Scroll: Enchant Weapon (Grade C)":
		case "Blessed Scroll: Enchant Weapon (Grade D)":
		case "Blessed Scroll: Enchant Armor (Grade S)":
		case "Blessed Scroll: Enchant Armor (Grade A)":
		case "Blessed Scroll: Enchant Armor (Grade B)":
		case "Blessed Scroll: Enchant Armor (Grade C)":
		case "Blessed Scroll: Enchant Armor (Grade D)":
		case "Scroll: Enchant Weapon (Grade S)":
		case "Scroll: Enchant Weapon (Grade A)":
		case "Scroll: Enchant Weapon (Grade B)":
		case "Scroll: Enchant Weapon (Grade C)":
		case "Scroll: Enchant Weapon (Grade D)":
		case "Scroll: Enchant Armor (Grade S)":
		case "Scroll: Enchant Armor (Grade A)":
		case "Scroll: Enchant Armor (Grade B)":
		case "Scroll: Enchant Armor (Grade C)":
		case "Scroll: Enchant Armor (Grade D)":
		L2jBRVar4 = True;
		default:
	}
	return L2jBRVar4;
}

function int L2jBRFunction13 (string Name)
{
	local int L2jBRVar4;

	L2jBRVar4 = -1;
	switch (Name)
	{
		case "Blessed Scroll: Enchant Weapon (Grade S)":
		case "Blessed Scroll: Enchant Armor (Grade S)":
		case "Scroll: Enchant Weapon (Grade S)":
		case "Scroll: Enchant Armor (Grade S)":
		L2jBRVar4 = 5;
		break;
		case "Blessed Scroll: Enchant Weapon (Grade A)":
		case "Blessed Scroll: Enchant Armor (Grade A)":
		case "Scroll: Enchant Weapon (Grade A)":
		case "Scroll: Enchant Armor (Grade A)":
		L2jBRVar4 = 4;
		break;
		case "Blessed Scroll: Enchant Weapon (Grade B)":
		case "Blessed Scroll: Enchant Armor (Grade B)":
		case "Scroll: Enchant Weapon (Grade B)":
		case "Scroll: Enchant Armor (Grade B)":
		L2jBRVar4 = 3;
		break;
		case "Blessed Scroll: Enchant Weapon (Grade C)":
		case "Blessed Scroll: Enchant Armor (Grade C)":
		case "Scroll: Enchant Weapon (Grade C)":
		case "Scroll: Enchant Armor (Grade C)":
		L2jBRVar4 = 2;
		break;
		case "Blessed Scroll: Enchant Weapon (Grade D)":
		case "Blessed Scroll: Enchant Armor (Grade D)":
		case "Scroll: Enchant Weapon (Grade D)":
		case "Scroll: Enchant Armor (Grade D)":
		L2jBRVar4 = 1;
		break;
		default:
	}
	return L2jBRVar4;
}

function int L2jBRFunction14 (string Name)
{
	local int L2jBRVar4;

	L2jBRVar4 = -1;
	switch (Name)
	{
		case "Blessed Scroll: Enchant Weapon (Grade S)":
		case "Blessed Scroll: Enchant Weapon (Grade A)":
		case "Blessed Scroll: Enchant Weapon (Grade B)":
		case "Blessed Scroll: Enchant Weapon (Grade C)":
		case "Blessed Scroll: Enchant Weapon (Grade D)":
		case "Scroll: Enchant Weapon (Grade S)":
		case "Scroll: Enchant Weapon (Grade A)":
		case "Scroll: Enchant Weapon (Grade B)":
		case "Scroll: Enchant Weapon (Grade C)":
		case "Scroll: Enchant Weapon (Grade D)":
		L2jBRVar4 = 0;
		break;
		case "Blessed Scroll: Enchant Armor (Grade S)":
		case "Blessed Scroll: Enchant Armor (Grade A)":
		case "Blessed Scroll: Enchant Armor (Grade B)":
		case "Blessed Scroll: Enchant Armor (Grade C)":
		case "Blessed Scroll: Enchant Armor (Grade D)":
		case "Scroll: Enchant Armor (Grade S)":
		case "Scroll: Enchant Armor (Grade A)":
		case "Scroll: Enchant Armor (Grade B)":
		case "Scroll: Enchant Armor (Grade C)":
		case "Scroll: Enchant Armor (Grade D)":
		L2jBRVar4 = 1;
		break;
		default:
	}
	return L2jBRVar4;
}

function string L2jBRFunction15 (int L2jBRVar153)
{
	local string L2jBRVar23;

	L2jBRVar23 = "";
	switch (L2jBRVar153)
	{
		case 0:
		L2jBRVar23 = "Icon.skill0003";
		break;
		case 1:
		L2jBRVar23 = "Icon.skill0001";
		break;
		case 2:
		L2jBRVar23 = "Icon.skill0001";
		break;
		case 3:
		L2jBRVar23 = "Icon.skill0452";
		break;
		case 4:
		L2jBRVar23 = "Icon.skill0092";
		break;
		case 5:
		L2jBRVar23 = "Icon.skill0092";
		break;
		case 6:
		L2jBRVar23 = "Icon.skill0092";
		break;
		case 7:
		L2jBRVar23 = "Icon.skill0016";
		break;
		case 8:
		L2jBRVar23 = "Icon.skill0030";
		break;
		case 9:
		L2jBRVar23 = "Icon.skill0101";
		break;
		case 10:
		L2jBRVar23 = "Icon.skill1177";
		break;
		case 11:
		L2jBRVar23 = "Icon.skill1230";
		break;
		case 12:
		L2jBRVar23 = "Icon.skill1230";
		break;
		case 13:
		L2jBRVar23 = "Icon.skill1263";
		break;
		case 14:
		L2jBRVar23 = "Icon.skill1331";
		break;
		case 15:
		L2jBRVar23 = "Icon.skill1062";
		break;
		case 16:
		L2jBRVar23 = "Icon.skill1218";
		break;
		case 17:
		L2jBRVar23 = "Icon.skill1062";
		break;
		case 18:
		L2jBRVar23 = "Icon.skill0003";
		break;
		case 19:
		L2jBRVar23 = "Icon.skill0153";
		break;
		case 20:
		L2jBRVar23 = "Icon.skill0153";
		break;
		case 21:
		L2jBRVar23 = "Icon.skill0267";
		break;
		case 22:
		L2jBRVar23 = "Icon.skill0016";
		break;
		case 23:
		L2jBRVar23 = "Icon.skill0030";
		break;
		case 24:
		L2jBRVar23 = "Icon.skill0101";
		break;
		case 25:
		L2jBRVar23 = "Icon.skill1177";
		break;
		case 26:
		L2jBRVar23 = "Icon.skill1235";
		break;
		case 27:
		L2jBRVar23 = "Icon.skill1235";
		break;
		case 28:
		L2jBRVar23 = "Icon.skill1332";
		break;
		case 29:
		L2jBRVar23 = "Icon.skill1013";
		break;
		case 30:
		L2jBRVar23 = "Icon.skill1013";
		break;
		case 31:
		L2jBRVar23 = "Icon.skill0003";
		break;
		case 32:
		L2jBRVar23 = "Icon.skill0153";
		break;
		case 33:
		L2jBRVar23 = "Icon.skill0153";
		break;
		case 34:
		L2jBRVar23 = "Icon.skill0276";
		break;
		case 35:
		L2jBRVar23 = "Icon.skill0016";
		break;
		case 36:
		L2jBRVar23 = "Icon.skill0030";
		break;
		case 37:
		L2jBRVar23 = "Icon.skill0101";
		break;
		case 38:
		L2jBRVar23 = "Icon.skill1177";
		break;
		case 39:
		L2jBRVar23 = "Icon.skill1239";
		break;
		case 40:
		L2jBRVar23 = "Icon.skill1239";
		break;
		case 41:
		L2jBRVar23 = "Icon.skill1333";
		break;
		case 42:
		L2jBRVar23 = "Icon.skill1059";
		break;
		case 43:
		L2jBRVar23 = "Icon.skill1059";
		break;
		case 44:
		L2jBRVar23 = "Icon.skill0003";
		break;
		case 45:
		L2jBRVar23 = "Icon.skill0176";
		break;
		case 46:
		L2jBRVar23 = "Icon.skill0176";
		break;
		case 47:
		L2jBRVar23 = "Icon.skill0284";
		break;
		case 48:
		L2jBRVar23 = "Icon.skill0284";
		break;
		case 49:
		L2jBRVar23 = "Icon.skill1001";
		break;
		case 50:
		L2jBRVar23 = "Icon.skill1001";
		break;
		case 51:
		L2jBRVar23 = "Icon.skill1414";
		break;
		case 52:
		L2jBRVar23 = "Icon.skill1363";
		break;
		case 53:
		L2jBRVar23 = "Icon.skill0254";
		break;
		case 54:
		L2jBRVar23 = "Icon.skill0254";
		break;
		case 55:
		L2jBRVar23 = "Icon.skill0254";
		break;
		case 56:
		L2jBRVar23 = "Icon.skill0172";
		break;
		case 57:
		L2jBRVar23 = "Icon.skill0172";
		break;
		case 88:
		L2jBRVar23 = "Icon.skill0001";
		break;
		case 89:
		L2jBRVar23 = "Icon.skill0452";
		break;
		case 90:
		L2jBRVar23 = "Icon.skill0092";
		break;
		case 91:
		L2jBRVar23 = "Icon.skill0092";
		break;
		case 92:
		L2jBRVar23 = "Icon.skill0101";
		break;
		case 93:
		L2jBRVar23 = "Icon.skill0030";
		break;
		case 94:
		L2jBRVar23 = "Icon.skill1230";
		break;
		case 95:
		L2jBRVar23 = "Icon.skill1263";
		break;
		case 96:
		L2jBRVar23 = "Icon.skill1331";
		break;
		case 97:
		L2jBRVar23 = "Icon.skill1218";
		break;
		case 98:
		L2jBRVar23 = "Icon.skill1062";
		break;
		case 99:
		L2jBRVar23 = "Icon.skill0153";
		break;
		case 100:
		L2jBRVar23 = "Icon.skill0267";
		break;
		case 101:
		L2jBRVar23 = "Icon.skill0030";
		break;
		case 102:
		L2jBRVar23 = "Icon.skill0101";
		break;
		case 103:
		L2jBRVar23 = "Icon.skill1235";
		break;
		case 104:
		L2jBRVar23 = "Icon.skill1332";
		break;
		case 105:
		L2jBRVar23 = "Icon.skill1355";
		break;
		case 106:
		L2jBRVar23 = "Icon.skill0153";
		break;
		case 107:
		L2jBRVar23 = "Icon.skill0276";
		break;
		case 108:
		L2jBRVar23 = "Icon.skill0030";
		break;
		case 109:
		L2jBRVar23 = "Icon.skill0101";
		break;
		case 110:
		L2jBRVar23 = "Icon.skill1239";
		break;
		case 111:
		L2jBRVar23 = "Icon.skill1333";
		break;
		case 112:
		L2jBRVar23 = "Icon.skill1059";
		break;
		case 113:
		L2jBRVar23 = "Icon.skill0176";
		break;
		case 114:
		L2jBRVar23 = "Icon.skill0284";
		break;
		case 115:
		L2jBRVar23 = "Icon.skill1414";
		break;
		case 116:
		L2jBRVar23 = "Icon.skill1363";
		break;
		case 117:
		L2jBRVar23 = "Icon.skill0254";
		break;
		case 118:
		L2jBRVar23 = "Icon.skill0172";
		break;
		default:
	}
	return L2jBRVar23;
}

function bool L2jBRFunction51 (int L2jBRVar24)
{
	local bool L2jBRVar154;

	L2jBRVar154 = False;
	switch (L2jBRVar24)
	{
		case 1323:
		L2jBRVar154 = True;
		break;
		default:
	}
	return L2jBRVar154;
}

function bool L2jBRFunction16 (int L2jBRVar24)
{
	local bool L2jBRVar25;

	switch (L2jBRVar24)
	{
		case 1323:
		case 1047:
		case 1182:
		case 1191:
		case 1238:
		case 1232:
		case 1010:
		case 341:
		case 1040:
		case 1068:
		case 1035:
		case 1043:
		case 1044:
		case 1073:
		case 1077:
		case 1078:
		case 1085:
		case 1204:
		case 1032:
		case 1036:
		case 1045:
		case 1048:
		case 1086:
		case 1240:
		case 1242:
		case 1243:
		case 1388:
		case 1389:
		case 1062:
		case 1087:
		case 1059:
		case 1268:
		case 1303:
		case 1460:
		case 1257:
		case 1259:
		case 1304:
		case 1397:
		case 1352:
		case 1353:
		case 1354:
		case 1355:
		case 1357:
		case 1356:
		case 1411:
		case 1392:
		case 1393:
		case 1418:
		L2jBRVar25 = True;
		break;
		default:
	}
	return L2jBRVar25;
}

function bool _L2jBRFunction17 (int L2jBRVar24)
{
	local bool L2jBRVar26;

	switch (L2jBRVar24)
	{
		case 1307:
		case 1430:
		case 1311:
		case 94:
		case 139:
		case 420:
		case 176:
		case 287:
		case 297:
		case 451:
		case 121:
		case 78:
		case 282:
		case 292:
		case 425:
		case 298:
		case 76:
		case 83:
		case 109:
		case 441:
		case 443:
		case 130:
		case 421:
		case 181:
		case 317:
		case 406:
		case 82:
		case 112:
		case 110:
		case 368:
		case 72:
		case 86:
		case 351:
		case 4:
		case 411:
		case 445:
		case 99:
		case 355:
		case 356:
		case 357:
		case 111:
		case 446:
		case 447:
		case 415:
		case 416:
		case 303:
		case 313:
		case 77:
		case 91:
		case 123:
		case 230:
		case 414:
		case 359:
		case 75:
		case 80:
		case 87:
		case 88:
		case 104:
		case 1005:
		case 1007:
		case 1309:
		case 1252:
		case 1006:
		case 1002:
		case 1251:
		case 1229:
		case 1308:
		case 1461:
		case 1253:
		case 1009:
		case 1362:
		case 1310:
		case 1391:
		case 423:
		case 1413:
		case 1003:
		case 1282:
		case 1415:
		case 1364:
		case 1008:
		case 1365:
		case 1260:
		case 1249:
		case 1004:
		case 1414:
		case 1256:
		case 1390:
		case 1363:
		case 1416:
		case 1250:
		case 1261:
		L2jBRVar26 = True;
		break;
		default:
	}
	return L2jBRVar26;
}

function bool L2jBRFunction18 (int L2jBRVar24)
{
	local bool L2jBRVar155;

	switch (L2jBRVar24)
	{
		case 336:
		case 337:
		case 338:
		case 1262:
		case 256:
		case 424:
		case 312:
		case 339:
		case 340:
		case 422:
		case 318:
		case 322:
		case 196:
		case 197:
		case 335:
		case 334:
		case 288:
		case 221:
		case 222:
		case 1001:
		case 1283:
		L2jBRVar155 = True;
		break;
		default:
	}
	return L2jBRVar155;
}

function bool L2jBRFunction19 (int L2jBRVar24)
{
	local bool L2jBRVar27;

	switch (L2jBRVar24)
	{
		case 276:
		case 273:
		case 365:
		case 275:
		case 274:
		case 271:
		case 272:
		case 310:
		case 264:
		case 265:
		case 266:
		case 267:
		case 268:
		case 269:
		case 349:
		case 270:
		case 304:
		case 305:
		case 306:
		case 308:
		case 363:
		case 364:
		case 529:
		case 277:
		case 307:
		case 309:
		case 311:
		case 366:
		case 530:
		case 915:
		L2jBRVar27 = True;
		break;
		default:
	}
	return L2jBRVar27;
}

function bool L2jBRFunction20 (int L2jBRVar24)
{
	local bool L2jBRVar156;

	L2jBRVar156 = False;
	switch (L2jBRVar24)
	{
		case 28:
		case 92:
		case 101:
		case 102:
		case 105:
		case 115:
		case 129:
		case 1069:
		case 1083:
		case 1160:
		case 1164:
		case 1167:
		case 1168:
		case 1184:
		case 1201:
		case 1206:
		case 1222:
		case 1223:
		case 1224:
		case 100:
		case 95:
		case 96:
		case 120:
		case 223:
		case 1092:
		case 1095:
		case 1096:
		case 1097:
		case 1099:
		case 1100:
		case 1101:
		case 1102:
		case 1107:
		case 1208:
		case 1209:
		case 18:
		case 48:
		case 65:
		case 84:
		case 97:
		case 98:
		case 103:
		case 106:
		case 107:
		case 116:
		case 122:
		case 127:
		case 260:
		case 279:
		case 281:
		case 1042:
		case 1049:
		case 1064:
		case 1071:
		case 1072:
		case 1074:
		case 1104:
		case 1108:
		case 1169:
		case 1170:
		case 1183:
		case 1210:
		case 1231:
		case 1233:
		case 1236:
		case 1237:
		case 1244:
		case 1246:
		case 1247:
		case 1248:
		case 286:
		case 1263:
		case 1269:
		case 1272:
		case 1289:
		case 1290:
		case 1291:
		case 1298:
		case 342:
		case 352:
		case 353:
		case 354:
		case 358:
		case 361:
		case 362:
		case 367:
		case 1336:
		case 1337:
		case 1338:
		case 1339:
		case 1340:
		case 1341:
		case 1342:
		case 1343:
		case 1358:
		case 1359:
		case 1360:
		case 1361:
		case 1366:
		case 1367:
		case 1375:
		case 1376:
		case 400:
		case 401:
		case 402:
		case 403:
		case 404:
		case 407:
		case 408:
		case 412:
		case 1380:
		case 1381:
		case 1382:
		case 1383:
		case 1384:
		case 1385:
		case 1386:
		case 1394:
		case 1396:
		case 437:
		case 452:
		case 485:
		case 1435:
		case 494:
		case 495:
		case 501:
		case 1437:
		case 1445:
		case 1446:
		case 1447:
		case 1448:
		case 509:
		case 522:
		case 523:
		case 531:
		case 537:
		case 1452:
		case 1454:
		case 1455:
		case 1458:
		case 1462:
		case 1467:
		case 1468:
		case 559:
		case 564:
		case 571:
		case 573:
		case 578:
		case 581:
		case 582:
		case 588:
		case 1481:
		case 1482:
		case 1483:
		case 1484:
		case 1485:
		case 1486:
		case 627:
		case 680:
		case 681:
		case 682:
		case 683:
		case 686:
		case 688:
		case 692:
		case 695:
		case 696:
		case 708:
		case 716:
		case 730:
		case 732:
		case 736:
		case 741:
		case 747:
		case 749:
		case 752:
		case 762:
		case 763:
		case 774:
		case 775:
		case 776:
		case 1495:
		case 1508:
		case 1509:
		case 1511:
		case 1512:
		case 791:
		case 792:
		case 793:
		case 794:
		case 798:
		case 808:
		case 1524:
		case 1525:
		case 835:
		case 1529:
		case 877:
		case 879:
		case 883:
		case 886:
		case 887:
		case 899:
		case 904:
		case 905:
		case 909:
		case 910:
		case 927:
		case 1539:
		case 1540:
		case 1541:
		case 949:
		case 954:
		case 1546:
		case 969:
		case 973:
		case 974:
		case 977:
		case 978:
		case 979:
		case 980:
		case 981:
		case 985:
		case 991:
		case 1554:
		case 1555:
		case 995:
		case 996:
		case 997:
		case 2074:
		case 2234:
		case 2239:
		case 2399:
		case 2839:
		case 3005:
		case 3016:
		case 3020:
		case 3021:
		case 3024:
		case 3040:
		case 3041:
		case 3052:
		case 3053:
		case 3054:
		case 3055:
		case 3061:
		case 3062:
		case 3070:
		case 3074:
		case 3075:
		case 3078:
		case 3079:
		case 3571:
		case 3574:
		case 3577:
		case 3579:
		case 3584:
		case 3586:
		case 3588:
		case 3590:
		case 3594:
		case 3083:
		case 3084:
		case 3085:
		case 3086:
		case 3087:
		case 3088:
		case 3089:
		case 3090:
		case 3091:
		case 3092:
		case 3093:
		case 3094:
		case 3096:
		case 3097:
		case 3098:
		case 3099:
		case 3100:
		case 3101:
		case 3102:
		case 3103:
		case 3104:
		case 3105:
		case 3106:
		case 3107:
		case 3111:
		case 3112:
		case 3113:
		case 3114:
		case 3115:
		case 3116:
		case 3117:
		case 3118:
		case 3119:
		case 3120:
		case 3121:
		case 3122:
		case 3137:
		case 3187:
		case 3188:
		case 3189:
		case 3190:
		case 3191:
		case 3192:
		case 3193:
		case 3194:
		case 3195:
		case 3196:
		case 3197:
		case 3198:
		case 3331:
		case 8240:
		case 8276:
		case 8357:
		case 7007:
		case 4018:
		case 4019:
		case 4034:
		case 4035:
		case 4036:
		case 4037:
		case 4038:
		case 4046:
		case 4047:
		case 4052:
		case 4053:
		case 4054:
		case 4055:
		case 4063:
		case 4064:
		case 4070:
		case 4072:
		case 4073:
		case 4075:
		case 4076:
		case 4082:
		case 4088:
		case 4098:
		case 4102:
		case 4104:
		case 4106:
		case 4107:
		case 4108:
		case 4109:
		case 4111:
		case 4117:
		case 4118:
		case 4119:
		case 4120:
		case 4126:
		case 4131:
		case 4140:
		case 4145:
		case 4146:
		case 4148:
		case 4149:
		case 4150:
		case 4153:
		case 4162:
		case 4164:
		case 4165:
		case 4166:
		case 4167:
		case 4182:
		case 4183:
		case 4184:
		case 4185:
		case 4186:
		case 4187:
		case 4188:
		case 4189:
		case 4190:
		case 4196:
		case 4197:
		case 4198:
		case 4199:
		case 4200:
		case 4201:
		case 4202:
		case 4203:
		case 4204:
		case 4205:
		case 4206:
		case 4215:
		case 4219:
		case 4236:
		case 4237:
		case 4238:
		case 4243:
		case 4245:
		case 4249:
		case 4258:
		case 4259:
		case 4315:
		case 4319:
		case 4320:
		case 4321:
		case 4361:
		case 4362:
		case 4363:
		case 4382:
		case 4515:
		case 4533:
		case 4534:
		case 4535:
		case 4536:
		case 4537:
		case 4538:
		case 4539:
		case 4540:
		case 4541:
		case 4547:
		case 4551:
		case 4552:
		case 4553:
		case 4554:
		case 4577:
		case 4578:
		case 4579:
		case 4580:
		case 4581:
		case 4582:
		case 4583:
		case 4584:
		case 4586:
		case 4587:
		case 4589:
		case 4590:
		case 4591:
		case 4592:
		case 4593:
		case 4594:
		case 4596:
		case 4597:
		case 4598:
		case 4599:
		case 4600:
		case 4602:
		case 4603:
		case 4604:
		case 4605:
		case 4606:
		case 4615:
		case 4620:
		case 4624:
		case 4625:
		case 4640:
		case 4643:
		case 4649:
		case 4657:
		case 4658:
		case 4659:
		case 4660:
		case 4661:
		case 4662:
		case 4670:
		case 4683:
		case 4684:
		case 4688:
		case 4689:
		case 4694:
		case 4695:
		case 4696:
		case 4705:
		case 4706:
		case 4708:
		case 4710:
		case 4169:
		case 4724:
		case 4725:
		case 4726:
		case 4727:
		case 4728:
		case 4172:
		case 4180:
		case 4744:
		case 4745:
		case 4746:
		case 4747:
		case 4748:
		case 4208:
		case 4759:
		case 4760:
		case 4761:
		case 4762:
		case 4763:
		case 4496:
		case 4769:
		case 4770:
		case 4771:
		case 4772:
		case 4773:
		case 4463:
		case 4464:
		case 4465:
		case 4466:
		case 4467:
		case 4473:
		case 4480:
		case 4481:
		case 4482:
		case 4483:
		case 4486:
		case 4487:
		case 4488:
		case 4492:
		case 4991:
		case 4992:
		case 5004:
		case 5012:
		case 5016:
		case 5020:
		case 5022:
		case 5023:
		case 5024:
		case 5037:
		case 5068:
		case 5069:
		case 5070:
		case 5071:
		case 5072:
		case 5081:
		case 5083:
		case 5085:
		case 5086:
		case 5092:
		case 5112:
		case 5114:
		case 5116:
		case 5117:
		case 5120:
		case 5134:
		case 5137:
		case 5138:
		case 5140:
		case 5145:
		case 5160:
		case 5166:
		case 5167:
		case 5168:
		case 5169:
		case 5170:
		case 5171:
		case 5172:
		case 5173:
		case 5174:
		case 5175:
		case 5176:
		case 5177:
		case 5183:
		case 5196:
		case 5197:
		case 5198:
		case 5199:
		case 5202:
		case 5203:
		case 5206:
		case 5207:
		case 5219:
		case 5220:
		case 7066:
		case 7067:
		case 7076:
		case 7077:
		case 7080:
		case 5229:
		case 5230:
		case 5231:
		case 5232:
		case 5238:
		case 5240:
		case 5241:
		case 5242:
		case 5243:
		case 5247:
		case 5250:
		case 5251:
		case 5252:
		case 5253:
		case 5254:
		case 5255:
		case 5256:
		case 5258:
		case 5259:
		case 5260:
		case 5261:
		case 5264:
		case 5266:
		case 5268:
		case 5269:
		case 5270:
		case 5271:
		case 5301:
		case 5302:
		case 5303:
		case 5304:
		case 5305:
		case 5306:
		case 5307:
		case 5308:
		case 5309:
		case 5333:
		case 5362:
		case 5363:
		case 5364:
		case 5365:
		case 5366:
		case 5367:
		case 5368:
		case 5369:
		case 5370:
		case 5394:
		case 5399:
		case 5401:
		case 5422:
		case 5423:
		case 5424:
		case 5431:
		case 5434:
		case 5435:
		case 5443:
		case 5444:
		case 5447:
		case 5456:
		case 5459:
		case 5460:
		case 5481:
		case 5482:
		case 5495:
		case 5496:
		case 5497:
		case 5500:
		case 5501:
		case 5502:
		case 5505:
		case 5506:
		case 5507:
		case 5508:
		case 5509:
		case 5510:
		case 5511:
		case 5512:
		case 5523:
		case 5529:
		case 5530:
		case 5551:
		case 5565:
		case 5566:
		case 5567:
		case 5568:
		case 5569:
		case 5581:
		case 5583:
		case 5584:
		case 5585:
		case 5592:
		case 5594:
		case 5595:
		case 5596:
		case 5600:
		case 5602:
		case 5623:
		case 5624:
		case 5625:
		case 5660:
		case 5661:
		case 5665:
		case 5666:
		case 5667:
		case 5668:
		case 5669:
		case 5670:
		case 5671:
		case 5672:
		case 5673:
		case 5679:
		case 5683:
		case 5687:
		case 5688:
		case 5693:
		case 5696:
		case 5697:
		case 5703:
		case 5706:
		case 5707:
		case 5715:
		case 5716:
		case 5733:
		case 5735:
		case 5747:
		case 5764:
		case 5778:
		case 5794:
		case 5795:
		case 5796:
		case 5797:
		case 5798:
		case 5799:
		case 5800:
		case 5801:
		case 5802:
		case 5803:
		case 5804:
		case 5806:
		case 5807:
		case 5808:
		case 5809:
		case 5810:
		case 5811:
		case 5812:
		case 5813:
		case 5814:
		case 5831:
		case 5832:
		case 5843:
		case 5846:
		case 5849:
		case 5851:
		case 5854:
		case 5855:
		case 5860:
		case 5861:
		case 5866:
		case 5867:
		case 5868:
		case 5869:
		case 5870:
		case 5871:
		case 5872:
		case 5873:
		case 5874:
		case 5875:
		case 5876:
		case 5877:
		case 5878:
		case 5879:
		case 5880:
		case 5881:
		case 5882:
		case 5883:
		case 5884:
		case 5885:
		case 5886:
		case 5887:
		case 5888:
		case 5889:
		case 5890:
		case 5891:
		case 5892:
		case 5893:
		case 5894:
		case 5895:
		case 5896:
		case 5897:
		case 5898:
		case 5899:
		case 5900:
		case 5901:
		case 5903:
		case 5904:
		case 5905:
		case 5907:
		case 5908:
		case 5912:
		case 5914:
		case 5919:
		case 5921:
		case 5922:
		case 5937:
		case 5941:
		case 5942:
		case 5943:
		case 5944:
		case 5945:
		case 5960:
		case 5961:
		case 5967:
		case 5969:
		case 5981:
		case 5984:
		case 5992:
		case 5993:
		case 5994:
		case 6024:
		case 6033:
		case 6090:
		case 6091:
		case 6092:
		case 6095:
		case 6125:
		case 6126:
		case 6129:
		case 6130:
		case 6131:
		case 6132:
		case 6133:
		case 6134:
		case 6135:
		case 6140:
		case 6141:
		case 6142:
		case 6146:
		case 6148:
		case 6149:
		case 6150:
		case 6151:
		case 6152:
		case 6153:
		case 6154:
		case 6155:
		case 6166:
		case 6167:
		case 6168:
		case 6169:
		case 6187:
		case 6189:
		case 6190:
		case 6205:
		case 6206:
		case 6237:
		case 6238:
		case 6240:
		case 6250:
		case 6263:
		case 6266:
		case 6269:
		case 6273:
		case 6274:
		case 6275:
		case 6276:
		case 6280:
		case 6281:
		case 6283:
		case 6299:
		case 6300:
		case 6304:
		case 6306:
		case 6307:
		case 6308:
		case 6309:
		case 6312:
		case 6314:
		case 6320:
		case 6326:
		case 6328:
		case 6331:
		case 6332:
		case 6333:
		case 6334:
		case 6335:
		case 6336:
		case 6339:
		case 6340:
		case 6342:
		case 6370:
		case 6373:
		case 6374:
		case 6375:
		case 6378:
		case 6379:
		case 6380:
		case 6381:
		case 6382:
		case 6383:
		case 6384:
		case 6385:
		case 6386:
		case 6389:
		case 6390:
		case 6391:
		case 6392:
		case 6395:
		case 6396:
		case 6397:
		case 6398:
		case 6400:
		case 6402:
		case 6403:
		case 6404:
		case 6406:
		case 6407:
		case 6408:
		case 6410:
		case 6414:
		case 6416:
		case 6417:
		case 6418:
		case 6423:
		case 6428:
		case 6435:
		case 6436:
		case 6437:
		case 6438:
		case 6439:
		case 6440:
		case 6441:
		case 6618:
		case 6619:
		case 6622:
		case 6624:
		case 6650:
		case 6651:
		case 6662:
		case 6677:
		case 6688:
		case 6690:
		case 6697:
		case 6698:
		case 6705:
		case 6733:
		case 6734:
		case 6735:
		case 6738:
		case 6743:
		case 6744:
		case 6746:
		case 6748:
		case 6750:
		case 6751:
		case 6754:
		case 6757:
		case 6760:
		case 6761:
		case 6763:
		case 6768:
		case 6769:
		case 6772:
		case 6774:
		case 6775:
		case 6776:
		case 6777:
		case 6779:
		case 6815:
		case 6816:
		case 6819:
		case 6821:
		case 6822:
		case 6825:
		case 6827:
		case 6828:
		case 6830:
		case 6836:
		case 6840:
		case 6853:
		case 6854:
		case 6862:
		case 6863:
		case 6865:
		case 6873:
		case 6875:
		case 6878:
		case 6880:
		case 6882:
		case 6890:
		case 6897:
		case 6912:
		case 23069:
		case 23070:
		case 23071:
		case 23124:
		case 23169:
		case 23170:
		case 6921:
		case 23298:
		case 23299:
		case 23300:
		case 23319:
		case 23320:
		case 23321:
		case 23322:
		case 23323:
		L2jBRVar156 = True;
		case 1323:
		
			/*if ( UnknownFunction242(GetOptionBool("Neophron","ShowNoble"),True) )
			{
				L2jBRVar156 = True;
			}*/
			
			break;
		default:
	}
	return L2jBRVar156;
}

function bool L2jBRFunction75 (int L2jBRVar24)
{
	local bool bIsNotDisplaySkill;

	bIsNotDisplaySkill = False;
	switch (L2jBRVar24)
	{
		case 2039:
		case 2150:
		case 2151:
		case 2152:
		case 2153:
		case 2154:
		case 2047:
		case 2155:
		case 2156:
		case 2157:
		case 2158:
		case 2159:
		case 2061:
		case 2160:
		case 2161:
		case 2162:
		case 2163:
		case 2164:
		case 26060:
		case 26061:
		case 26062:
		case 26063:
		case 26064:
		case 22036:
		case 22037:
		case 22038:
		case 2033:
		case 2008:
		case 2009:
		case 26050:
		case 26051:
		case 26052:
		case 26053:
		case 26054:
		case 26055:
		case 26056:
		case 26057:
		case 26058:
		case 26059:
		case 22369:
		case 2498:
		case 2499:
		case 2359:
		case 2166:
		case 2034:
		case 2037:
		case 2035:
		case 2036:
		case 2011:
		case 2032:
		case 2864:
		case 2398:
		case 2402:
		case 2403:
		case 2395:
		case 2401:
		case 2169:
		case 2397:
		case 2396:
		case 2012:
		case 2074:
		case 2077:
		case 2592:
		case 2038:
		case 2627:
		case 2289:
		case 2287:
		case 2288:
		case 2169:
		case 2076:
		case 22042:
		case 2903:
		case 2901:
		case 2900:
		case 2902:
		case 2897:
		case 22029:
		case 2899:
		case 22031:
		case 22164:
		case 2898:
		case 22030:
		case 22163:
		case 22162:
		case 22158:
		case 2282:
		case 2283:
		case 2284:
		case 2514:
		case 2513:
		case 2244:
		case 2278:
		case 2485:
		case 2247:
		case 2281:
		case 2486:
		case 2245:
		case 2279:
		case 2246:
		case 2280:
		case 2285:
		case 2512:
		case 2580:
		bIsNotDisplaySkill = True;
		break;
		default:
	}
	return bIsNotDisplaySkill;
}

function bool L2jBRFunction74(int L2jBRVar24)
{
	local bool bIsNotDisplaySkill;

	bIsNotDisplaySkill = False;
	switch (L2jBRVar24)
	{
		case 2039:
		case 2150:
		case 2151:
		case 2152:
		case 2153:
		case 2154:
		case 2047:
		case 2155:
		case 2156:
		case 2157:
		case 2158:
		case 2159:
		case 2061:
		case 2160:
		case 2161:
		case 2162:
		case 2163:
		case 2164:
		case 26060:
		case 26061:
		case 26062:
		case 26063:
		case 26064:
		case 26050:
		case 26051:
		case 26052:
		case 26053:
		case 26054:
		case 26055:
		case 26056:
		case 26057:
		case 26058:
		case 26059:
		case 22369:
		bIsNotDisplaySkill = True;
		break;
		default:
	}
	return bIsNotDisplaySkill;
}

function string L2jBRFunction25 (int L2jBRVar157)
{
	local string Text;

	switch (L2jBRVar157)
	{
		case 1:
		Text = "q";
		break;
		case 2:
		Text = "w";
		break;
		case 3:
		Text = "e";
		break;
		case 4:
		Text = "r";
		break;
		case 5:
		Text = "t";
		break;
		case 6:
		Text = "y";
		break;
		case 7:
		Text = "u";
		break;
		case 8:
		Text = "i";
		break;
		case 9:
		Text = "o";
		break;
		case 10:
		Text = "p";
		break;
		case 11:
		Text = "a";
		break;
		case 12:
		Text = "s";
		break;
		case 13:
		Text = "d";
		break;
		case 14:
		Text = "f";
		break;
		case 15:
		Text = "g";
		break;
		case 16:
		Text = "h";
		break;
		case 17:
		Text = "j";
		break;
		case 18:
		Text = "k";
		break;
		case 19:
		Text = "l";
		break;
		case 20:
		Text = "z";
		break;
		case 21:
		Text = "x";
		break;
		case 22:
		Text = "c";
		break;
		case 23:
		Text = "v";
		break;
		case 24:
		Text = "b";
		break;
		case 25:
		Text = "n";
		break;
		case 26:
		Text = "m";
		break;
		case 27:
		Text = "1";
		break;
		case 28:
		Text = "2";
		break;
		case 29:
		Text = "3";
		break;
		case 30:
		Text = "4";
		break;
		case 31:
		Text = "5";
		break;
		case 32:
		Text = "6";
		break;
		case 33:
		Text = "7";
		break;
		case 34:
		Text = "8";
		break;
		case 35:
		Text = "9";
		break;
		case 36:
		Text = "0";
		break;
		case 37:
		Text = ".";
		break;
		case 38:
		Text = " ";
		break;
		case 39:
		Text = ":";
		break;
		default:
	}
	return Text;
}

function string L2jBRFunction21 (int L2jBRVar157)
{
	local string Text;

	switch (L2jBRVar157)
	{
		case 1:
		Text = "Q";
		break;
		case 2:
		Text = "W";
		break;
		case 3:
		Text = "E";
		break;
		case 4:
		Text = "R";
		break;
		case 5:
		Text = "T";
		break;
		case 6:
		Text = "Y";
		break;
		case 7:
		Text = "U";
		break;
		case 8:
		Text = "I";
		break;
		case 9:
		Text = "O";
		break;
		case 10:
		Text = "P";
		break;
		case 11:
		Text = "A";
		break;
		case 12:
		Text = "S";
		break;
		case 13:
		Text = "D";
		break;
		case 14:
		Text = "F";
		break;
		case 15:
		Text = "G";
		break;
		case 16:
		Text = "H";
		break;
		case 17:
		Text = "J";
		break;
		case 18:
		Text = "K";
		break;
		case 19:
		Text = "L";
		break;
		case 20:
		Text = "Z";
		break;
		case 21:
		Text = "X";
		break;
		case 22:
		Text = "C";
		break;
		case 23:
		Text = "V";
		break;
		case 24:
		Text = "B";
		break;
		case 25:
		Text = "N";
		break;
		case 26:
		Text = "M";
		break;
		default:
	}
	return Text;
}

