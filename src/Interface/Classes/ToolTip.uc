//================================================================================
// ToolTip.
//================================================================================

class ToolTip extends UICommonAPI;

var CustomTooltip m_Tooltip;
var DrawItemInfo L2jBRVar28;
const TOOLTIP_SETITEM_MAX= 3;
const TOOLTIP_MINIMUM_WIDTH= 144;

function OnLoad ()
{
	RegisterEvent(2920);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 2920:
		HandleRequestTooltipInfo(L2jBRVar1);
		break;
		default:
	}
}

function HandleRequestTooltipInfo (string L2jBRVar1)
{
	local string TooltipType;
	local int SourceType;
	local ETooltipSourceType eSourceType;

	ClearTooltip();
	if ( UnknownFunction129(ParseString(L2jBRVar1,"TooltipType",TooltipType)) )
	{
		return;
	}
	if ( UnknownFunction129(ParseInt(L2jBRVar1,"SourceType",SourceType)) )
	{
		return;
	}
	eSourceType = SourceType;
	if ( UnknownFunction122(TooltipType,"Text") )
	{
		ReturnTooltip_NTT_TEXT(L2jBRVar1,eSourceType,False);
	} else {
		if ( UnknownFunction122(TooltipType,"Description") )
		{
			ReturnTooltip_NTT_TEXT(L2jBRVar1,eSourceType,True);
		} else {
			if ( UnknownFunction122(TooltipType,"Action") )
			{
				ReturnTooltip_NTT_ACTION(L2jBRVar1,eSourceType);
			} else {
				if ( UnknownFunction122(TooltipType,"Skill") )
				{
					ReturnTooltip_NTT_SKILL(L2jBRVar1,eSourceType);
				} else {
					if ( UnknownFunction122(TooltipType,"NormalItem") )
					{
						ReturnTooltip_NTT_NORMALITEM(L2jBRVar1,eSourceType);
					} else {
						if ( UnknownFunction122(TooltipType,"Shortcut") )
						{
							ReturnTooltip_NTT_SHORTCUT(L2jBRVar1,eSourceType);
						} else {
							if ( UnknownFunction122(TooltipType,"AbnormalStatus") )
							{
								ReturnTooltip_NTT_ABNORMALSTATUS(L2jBRVar1,eSourceType);
							} else {
								if ( UnknownFunction122(TooltipType,"RecipeManufacture") )
								{
									ReturnTooltip_NTT_RECIPE_MANUFACTURE(L2jBRVar1,eSourceType);
								} else {
									if ( UnknownFunction122(TooltipType,"Recipe") )
									{
										ReturnTooltip_NTT_RECIPE(L2jBRVar1,eSourceType,False);
									} else {
										if ( UnknownFunction122(TooltipType,"RecipePrice") )
										{
											ReturnTooltip_NTT_RECIPE(L2jBRVar1,eSourceType,True);
										} else {
											if ( UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction122(TooltipType,"Inventory"),UnknownFunction122(TooltipType,"InventoryPrice1")),UnknownFunction122(TooltipType,"InventoryPrice2")),UnknownFunction122(TooltipType,"InventoryPrice1HideEnchant")),UnknownFunction122(TooltipType,"InventoryPrice1HideEnchantStackable")),UnknownFunction122(TooltipType,"InventoryPrice2PrivateShop")) )
											{
												ReturnTooltip_NTT_ITEM(L2jBRVar1,TooltipType,eSourceType);
											} else {
												if ( UnknownFunction122(TooltipType,"PartyMatch") )
												{
													ReturnTooltip_NTT_PARTYMATCH(L2jBRVar1,eSourceType);
												} else {
													if ( UnknownFunction122(TooltipType,"QuestInfo") )
													{
														ReturnTooltip_NTT_QUESTINFO(L2jBRVar1,eSourceType);
													} else {
														if ( UnknownFunction122(TooltipType,"QuestList") )
														{
															ReturnTooltip_NTT_QUESTLIST(L2jBRVar1,eSourceType);
														} else {
															if ( UnknownFunction122(TooltipType,"RaidList") )
															{
																ReturnTooltip_NTT_RAIDLIST(L2jBRVar1,eSourceType);
															} else {
																if ( UnknownFunction122(TooltipType,"ClanInfo") )
																{
																	ReturnTooltip_NTT_CLANINFO(L2jBRVar1,eSourceType);
																} else {
																	if ( UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction122(TooltipType,"ManorSeedInfo"),UnknownFunction122(TooltipType,"ManorCropInfo")),UnknownFunction122(TooltipType,"ManorSeedSetting")),UnknownFunction122(TooltipType,"ManorCropSetting")),UnknownFunction122(TooltipType,"ManorDefaultInfo")),UnknownFunction122(TooltipType,"ManorCropSell")) )
																	{
																		ReturnTooltip_NTT_MANOR(L2jBRVar1,TooltipType,eSourceType);
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
				}
			}
		}
	}
}

function bool IsEnchantableItem (EItemParamType L2jBRVar5)
{
	return UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction154(L2jBRVar5,0),UnknownFunction154(L2jBRVar5,1)),UnknownFunction154(L2jBRVar5,3)),UnknownFunction154(L2jBRVar5,2));
}

function ClearTooltip ()
{
	m_Tooltip.SimpleLineCount = 0;
	m_Tooltip.MinimumWidth = 0;
	m_Tooltip.DrawList.Remove (0,m_Tooltip.DrawList.Length);
}

function StartItem ()
{
	local DrawItemInfo infoClear;

	L2jBRVar28 = infoClear;
}

function EndItem ()
{
	m_Tooltip.DrawList.Length = UnknownFunction146(m_Tooltip.DrawList.Length,1);
	m_Tooltip.DrawList[UnknownFunction147(m_Tooltip.DrawList.Length,1)] = L2jBRVar28;
}

function ReturnTooltip_NTT_TEXT (string L2jBRVar1, ETooltipSourceType eSourceType, bool bDesc)
{
	local string strText;
	local int Id;

	if ( UnknownFunction154(eSourceType,0) )
	{
		if ( ParseString(L2jBRVar1,"Text",strText) )
		{
			if ( UnknownFunction151(UnknownFunction125(strText),0) )
			{
				if ( bDesc )
				{
					m_Tooltip.MinimumWidth = 144;
					StartItem();
					L2jBRVar28.eType = 1;
					L2jBRVar28.t_color.R = 178;
					L2jBRVar28.t_color.G = 190;
					L2jBRVar28.t_color.B = 207;
					L2jBRVar28.t_color.A = 255;
					L2jBRVar28.t_strText = strText;
					EndItem();
				} else {
					StartItem();
					L2jBRVar28.eType = 1;
					L2jBRVar28.t_bDrawOneLine = True;
					L2jBRVar28.t_strText = strText;
					EndItem();
				}
			}
		} else {
			if ( ParseInt(L2jBRVar1,"ID",Id) )
			{
				if ( UnknownFunction151(Id,0) )
				{
					StartItem();
					L2jBRVar28.eType = 1;
					L2jBRVar28.t_bDrawOneLine = True;
					L2jBRVar28.t_ID = Id;
					EndItem();
				}
			}
		}
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_ITEM (string L2jBRVar1, string TooltipType, ETooltipSourceType eSourceType)
{
	local ItemInfo item;
	local EItemType EItemType;
	local EEtcItemType EEtcItemType;
	local bool bLargeWidth;
	local string SlotString;
	local string strTmp;
	local int nTmp;
	local int L2jBRVar2;
	local string ItemName;
	local int Quality;
	local int ColorR;
	local int ColorG;
	local int ColorB;
	local string strDesc1;
	local string strDesc2;
	local string strDesc3;
	local array<int> arrID;
	local int SetID;
	local int ClassID;
	local string strAdena;
	local string strAdenaComma;
	local Color AdenaColor;

	if ( UnknownFunction154(eSourceType,1) )
	{
		ParamToItemInfo(L2jBRVar1,item);
		EItemType = item.ItemType;
		EEtcItemType = item.ItemSubType;
		ItemName = Class'UIDATA_ITEM'.GetRefineryItemName(item.Name,item.RefineryOp1,item.RefineryOp2);
		if ( UnknownFunction130(UnknownFunction123(TooltipType,"InventoryPrice1HideEnchant"),UnknownFunction123(TooltipType,"InventoryPrice1HideEnchantStackable")) )
		{
			AddTooltipItemEnchant(item);
		}
		AddTooltipItemName(ItemName,item);
		AddTooltipItemGrade(item);
		if ( UnknownFunction123(TooltipType,"InventoryPrice1HideEnchantStackable") )
		{
			AddTooltipItemCount(item);
		}
		if ( UnknownFunction154(item.ClassID,57) )
		{
			m_Tooltip.SimpleLineCount = 2;
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.bLineBreak = True;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_strText = UnknownFunction112(UnknownFunction112("(",ConvertNumToText(string(item.ItemNum))),")");
			EndItem();
		}
		if ( UnknownFunction132(UnknownFunction132(UnknownFunction122(TooltipType,"InventoryPrice1"),UnknownFunction122(TooltipType,"InventoryPrice1HideEnchant")),UnknownFunction122(TooltipType,"InventoryPrice1HideEnchantStackable")) )
		{
			strAdena = string(item.Price);
			strAdenaComma = MakeCostString(strAdena);
			AdenaColor = GetNumericColor(strAdenaComma);
			AddTooltipItemOption(322,UnknownFunction112(strAdenaComma," "),True,True,False);
			SetTooltipItemColor(AdenaColor.R,AdenaColor.G,AdenaColor.B,0);
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color = AdenaColor;
			L2jBRVar28.t_ID = 469;
			EndItem();
			m_Tooltip.SimpleLineCount = 2;
			if ( UnknownFunction151(item.Price,0) )
			{
				m_Tooltip.SimpleLineCount = 3;
				AddTooltipItemOption(0,UnknownFunction112(UnknownFunction112("(",ConvertNumToText(strAdena)),")"),False,True,False);
				SetTooltipItemColor(AdenaColor.R,AdenaColor.G,AdenaColor.B,0);
			}
		}
		if ( UnknownFunction132(UnknownFunction122(TooltipType,"InventoryPrice2"),UnknownFunction122(TooltipType,"InventoryPrice2PrivateShop")) )
		{
			strAdena = string(item.Price);
			strAdenaComma = MakeCostString(strAdena);
			AdenaColor = GetNumericColor(strAdenaComma);
			AddTooltipItemOption2(322,468,True,True,False);
			SetTooltipItemColor(AdenaColor.R,AdenaColor.G,AdenaColor.B,0);
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color = AdenaColor;
			L2jBRVar28.t_strText = UnknownFunction112(UnknownFunction112(" ",strAdenaComma)," ");
			EndItem();
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color = AdenaColor;
			L2jBRVar28.t_ID = 469;
			EndItem();
			m_Tooltip.SimpleLineCount = 2;
			if ( UnknownFunction151(item.Price,0) )
			{
				m_Tooltip.SimpleLineCount = 3;
				StartItem();
				L2jBRVar28.eType = 1;
				L2jBRVar28.nOffSetY = 6;
				L2jBRVar28.bLineBreak = True;
				L2jBRVar28.t_bDrawOneLine = True;
				L2jBRVar28.t_color = AdenaColor;
				L2jBRVar28.t_strText = "(";
				EndItem();
				StartItem();
				L2jBRVar28.eType = 1;
				L2jBRVar28.nOffSetY = 6;
				L2jBRVar28.t_bDrawOneLine = True;
				L2jBRVar28.t_color = AdenaColor;
				L2jBRVar28.t_ID = 468;
				EndItem();
				StartItem();
				L2jBRVar28.eType = 1;
				L2jBRVar28.nOffSetY = 6;
				L2jBRVar28.t_bDrawOneLine = True;
				L2jBRVar28.t_color = AdenaColor;
				L2jBRVar28.t_strText = UnknownFunction112(UnknownFunction112(" ",ConvertNumToText(strAdena)),")");
				EndItem();
			}
		}
		if ( UnknownFunction122(TooltipType,"InventoryPrice2PrivateShop") )
		{
			if ( UnknownFunction130(IsStackableItem(item.ConsumeType),UnknownFunction151(item.Reserved,0)) )
			{
				AddTooltipItemOption(808,string(item.Reserved),True,True,False);
			}
		}
		SlotString = GetSlotTypeString(item.ItemType,item.SlotBitType,item.ArmorType);
		switch (EItemType)
		{
			case 0:
			bLargeWidth = True;
			strTmp = GetWeaponTypeString(item.WeaponType);
			if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
			{
				AddTooltipItemOption(0,UnknownFunction112(UnknownFunction112(strTmp," / "),SlotString),False,True,False);
			}
			AddTooltipItemBlank(12);
			AddTooltipItemOption(1489,"",True,False,False);
			SetTooltipItemColor(255,255,255,0);
			AddTooltipItemOption(94,string(GetPhysicalDamage(item.WeaponType,item.SlotBitType,item.CrystalType,item.Enchanted,item.PhysicalDamage)),True,True,False);
			AddTooltipItemOption(98,string(GetMagicalDamage(item.WeaponType,item.SlotBitType,item.CrystalType,item.Enchanted,item.MagicalDamage)),True,True,False);
			AddTooltipItemOption(111,GetAttackSpeedString(item.AttackSpeed),True,True,False);
			if ( UnknownFunction151(item.SoulshotCount,0) )
			{
				AddTooltipItemOption(404,UnknownFunction112("X ",string(item.SoulshotCount)),True,True,False);
			}
			if ( UnknownFunction151(item.SpiritshotCount,0) )
			{
				AddTooltipItemOption(496,UnknownFunction112("X ",string(item.SpiritshotCount)),True,True,False);
			}
			AddTooltipItemOption(52,string(item.Weight),True,True,False);
			if ( UnknownFunction155(item.MpConsume,0) )
			{
				AddTooltipItemOption(320,string(item.MpConsume),True,True,False);
			}
			if ( UnknownFunction132(UnknownFunction155(item.RefineryOp1,0),UnknownFunction155(item.RefineryOp2,0)) )
			{
				AddTooltipItemBlank(12);
				AddTooltipItemOption(1490,"",True,False,False);
				SetTooltipItemColor(255,255,255,0);
				if ( UnknownFunction155(item.RefineryOp2,0) )
				{
					Quality = Class'UIDATA_REFINERYOPTION'.GetQuality(item.RefineryOp2);
					GetRefineryColor(Quality,ColorR,ColorG,ColorB);
				}
				if ( UnknownFunction155(item.RefineryOp1,0) )
				{
					strDesc1 = "";
					strDesc2 = "";
					strDesc3 = "";
					if ( Class'UIDATA_REFINERYOPTION'.GetOptionDescription(item.RefineryOp1,strDesc1,strDesc2,strDesc3) )
					{
						if ( UnknownFunction151(UnknownFunction125(strDesc1),0) )
						{
							AddTooltipItemOption(0,strDesc1,False,True,False);
							SetTooltipItemColor(ColorR,ColorG,ColorB,0);
						}
						if ( UnknownFunction151(UnknownFunction125(strDesc2),0) )
						{
							AddTooltipItemOption(0,strDesc2,False,True,False);
							SetTooltipItemColor(ColorR,ColorG,ColorB,0);
						}
						if ( UnknownFunction151(UnknownFunction125(strDesc3),0) )
						{
							AddTooltipItemOption(0,strDesc3,False,True,False);
							SetTooltipItemColor(ColorR,ColorG,ColorB,0);
						}
					}
				}
				if ( UnknownFunction155(item.RefineryOp2,0) )
				{
					strDesc1 = "";
					strDesc2 = "";
					strDesc3 = "";
					if ( Class'UIDATA_REFINERYOPTION'.GetOptionDescription(item.RefineryOp2,strDesc1,strDesc2,strDesc3) )
					{
						if ( UnknownFunction151(UnknownFunction125(strDesc1),0) )
						{
							AddTooltipItemOption(0,strDesc1,False,True,False);
							SetTooltipItemColor(ColorR,ColorG,ColorB,0);
						}
						if ( UnknownFunction151(UnknownFunction125(strDesc2),0) )
						{
							AddTooltipItemOption(0,strDesc2,False,True,False);
							SetTooltipItemColor(ColorR,ColorG,ColorB,0);
						}
						if ( UnknownFunction151(UnknownFunction125(strDesc3),0) )
						{
							AddTooltipItemOption(0,strDesc3,False,True,False);
							SetTooltipItemColor(ColorR,ColorG,ColorB,0);
						}
					}
				}
				AddTooltipItemOption(1491,"",True,False,False);
				SetTooltipItemColor(ColorR,ColorG,ColorB,0);
				if ( UnknownFunction151(UnknownFunction125(item.Description),0) )
				{
					AddTooltipItemBlank(12);
				}
			}
			break;
			case 1:
			bLargeWidth = True;
			if ( UnknownFunction132(UnknownFunction154(item.SlotBitType,256),UnknownFunction154(item.SlotBitType,128)) )
			{
				AddTooltipItemOption(95,string(GetShieldDefense(item.CrystalType,item.Enchanted,item.ShieldDefense)),True,True,False);
				AddTooltipItemOption(317,string(item.ShieldDefenseRate),True,True,False);
				AddTooltipItemOption(97,string(item.AvoidModify),True,True,False);
				AddTooltipItemOption(52,string(item.Weight),True,True,False);
			} else {
				if ( IsMagicalArmor(item.ClassID) )
				{
					if ( UnknownFunction151(UnknownFunction125(SlotString),0) )
					{
						AddTooltipItemOption(0,SlotString,False,True,False);
					}
					AddTooltipItemOption(388,string(item.MpBonus),True,True,False);
					AddTooltipItemOption(95,string(GetPhysicalDefense(item.CrystalType,item.Enchanted,item.PhysicalDefense)),True,True,False);
					AddTooltipItemOption(52,string(item.Weight),True,True,False);
				} else {
					if ( UnknownFunction151(UnknownFunction125(SlotString),0) )
					{
						AddTooltipItemOption(0,SlotString,False,True,False);
					}
					AddTooltipItemOption(95,string(GetPhysicalDefense(item.CrystalType,item.Enchanted,item.PhysicalDefense)),True,True,False);
					AddTooltipItemOption(52,string(item.Weight),True,True,False);
				}
			}
			break;
			case 2:
			bLargeWidth = True;
			if ( UnknownFunction151(UnknownFunction125(SlotString),0) )
			{
				AddTooltipItemOption(0,SlotString,False,True,False);
			}
			AddTooltipItemOption(99,string(GetMagicalDefense(item.CrystalType,item.Enchanted,item.MagicalDefense)),True,True,False);
			AddTooltipItemOption(52,string(item.Weight),True,True,False);
			break;
			case 3:
			bLargeWidth = True;
			if ( UnknownFunction151(UnknownFunction125(SlotString),0) )
			{
				AddTooltipItemOption(0,SlotString,False,True,False);
			}
			break;
			case 5:
			bLargeWidth = True;
			if ( UnknownFunction154(EEtcItemType,7) )
			{
				if ( UnknownFunction154(item.Damaged,0) )
				{
					nTmp = 971;
				} else {
					nTmp = 970;
				}
				AddTooltipItemOption2(969,nTmp,True,True,False);
				AddTooltipItemOption(88,string(item.Enchanted),True,True,False);
			} else {
				if ( UnknownFunction154(EEtcItemType,15) )
				{
					AddTooltipItemOption(972,string(item.Enchanted),True,True,False);
				} else {
					if ( UnknownFunction154(EEtcItemType,13) )
					{
						AddTooltipItemOption(670,string(item.Blessed),True,True,False);
						AddTooltipItemOption(671,GetLottoString(item.Enchanted,item.Damaged),True,True,False);
					} else {
						if ( UnknownFunction154(EEtcItemType,14) )
						{
							AddTooltipItemOption(670,string(item.Enchanted),True,True,False);
							AddTooltipItemOption(671,GetRaceTicketString(item.Blessed),True,True,False);
							AddTooltipItemOption(744,string(UnknownFunction144(item.Damaged,100)),True,True,False);
						}
					}
				}
			}
			AddTooltipItemOption(52,string(item.Weight),True,True,False);
			break;
			default:
		}
		if ( UnknownFunction151(item.CurrentDurability,0) )
		{
			bLargeWidth = True;
			AddTooltipItemBlank(12);
			AddTooltipItemOption(1501,"",True,False,False);
			SetTooltipItemColor(255,255,255,0);
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.bLineBreak = True;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color.R = 163;
			L2jBRVar28.t_color.G = 163;
			L2jBRVar28.t_color.B = 163;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_ID = 1505;
			EndItem();
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.t_bDrawOneLine = True;
			if ( UnknownFunction152(UnknownFunction146(item.CurrentDurability,1),100000) )
			{
				L2jBRVar28.t_color.R = 255;
				L2jBRVar28.t_color.G = 0;
				L2jBRVar28.t_color.B = 0;
			} else {
				L2jBRVar28.t_color.R = 176;
				L2jBRVar28.t_color.G = 155;
				L2jBRVar28.t_color.B = 121;
			}
			L2jBRVar28.t_color.A = 255;
			if ( UnknownFunction152(item.CurrentDurability,60) )
			{
				L2jBRVar28.t_strText = UnknownFunction112(UnknownFunction112(" ",string(item.CurrentDurability))," seconds.");
			}
			if ( UnknownFunction152(item.CurrentDurability,600) )
			{
				L2jBRVar28.t_strText = UnknownFunction112(UnknownFunction112(" ",string(UnknownFunction145(item.CurrentDurability,10)))," minutes.");
			}
			if ( UnknownFunction152(item.CurrentDurability,24000) )
			{
				L2jBRVar28.t_strText = UnknownFunction112(UnknownFunction112(" ",string(UnknownFunction145(item.CurrentDurability,10000)))," hours.");
			}
			if ( UnknownFunction153(item.CurrentDurability,24000) )
			{
				L2jBRVar28.t_strText = UnknownFunction112(UnknownFunction112(" ",string(UnknownFunction145(item.CurrentDurability,100000)))," days.");
			}
			EndItem();
			AddTooltipItemOption(1491,"",True,False,False);
			if ( UnknownFunction151(UnknownFunction125(item.Description),0) )
			{
				AddTooltipItemBlank(12);
			}
		}
		if ( UnknownFunction130(UnknownFunction153(item.CurrentDurability,0),UnknownFunction151(item.Durability,0)) )
		{
			bLargeWidth = True;
			AddTooltipItemBlank(12);
			AddTooltipItemOption(1492,"",True,False,False);
			SetTooltipItemColor(255,255,255,0);
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.bLineBreak = True;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color.R = 163;
			L2jBRVar28.t_color.G = 163;
			L2jBRVar28.t_color.B = 163;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_ID = 1493;
			EndItem();
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.t_bDrawOneLine = True;
			if ( UnknownFunction152(UnknownFunction146(item.CurrentDurability,1),5) )
			{
				L2jBRVar28.t_color.R = 255;
				L2jBRVar28.t_color.G = 0;
				L2jBRVar28.t_color.B = 0;
			} else {
				L2jBRVar28.t_color.R = 176;
				L2jBRVar28.t_color.G = 155;
				L2jBRVar28.t_color.B = 121;
			}
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = UnknownFunction112(UnknownFunction112(UnknownFunction112(" ",string(item.CurrentDurability)),"/"),string(item.Durability));
			EndItem();
			AddTooltipItemOption(1491,"",True,False,False);
			if ( UnknownFunction151(UnknownFunction125(item.Description),0) )
			{
				AddTooltipItemBlank(12);
			}
		}
		if ( UnknownFunction151(UnknownFunction125(item.Description),0) )
		{
			bLargeWidth = True;
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.bLineBreak = True;
			L2jBRVar28.t_color.R = 178;
			L2jBRVar28.t_color.G = 190;
			L2jBRVar28.t_color.B = 207;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = item.Description;
			EndItem();
		}
		if ( UnknownFunction151(item.ClassID,0) )
		{
			L2jBRVar2 = 0;
			if ( UnknownFunction150(L2jBRVar2,3) )
			{
				Class'UIDATA_ITEM'.GetSetItemIDList(item.ClassID,L2jBRVar2,arrID);
				SetID = 0;
				if ( UnknownFunction150(SetID,arrID.Length) )
				{
					bLargeWidth = True;
					ClassID = arrID[SetID];
					if ( UnknownFunction155(item.ClassID,ClassID) )
					{
						strTmp = Class'UIDATA_ITEM'.GetItemName(ClassID);
						if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
						{
							StartItem();
							L2jBRVar28.eType = 1;
							L2jBRVar28.nOffSetY = 6;
							L2jBRVar28.bLineBreak = True;
							L2jBRVar28.t_bDrawOneLine = True;
							L2jBRVar28.t_color.R = 112;
							L2jBRVar28.t_color.G = 115;
							L2jBRVar28.t_color.B = 123;
							L2jBRVar28.t_color.A = 255;
							L2jBRVar28.t_strText = strTmp;
							ParamAdd(L2jBRVar28.Condition,"Type","Equip");
							ParamAdd(L2jBRVar28.Condition,"ServerID",string(item.ServerID));
							ParamAdd(L2jBRVar28.Condition,"EquipID",string(ClassID));
							ParamAdd(L2jBRVar28.Condition,"NormalColor","112,115,123");
							ParamAdd(L2jBRVar28.Condition,"EnableColor","176,185,205");
							EndItem();
						}
					}
					UnknownFunction165(SetID);
					goto JL1485;
				}
				strTmp = Class'UIDATA_ITEM'.GetSetItemEffectDescription(item.ClassID,L2jBRVar2);
				if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
				{
					bLargeWidth = True;
					StartItem();
					L2jBRVar28.eType = 1;
					L2jBRVar28.nOffSetY = 6;
					L2jBRVar28.bLineBreak = True;
					L2jBRVar28.t_color.R = 128;
					L2jBRVar28.t_color.G = 127;
					L2jBRVar28.t_color.B = 103;
					L2jBRVar28.t_color.A = 255;
					L2jBRVar28.t_strText = strTmp;
					ParamAdd(L2jBRVar28.Condition,"Type","SetEffect");
					ParamAdd(L2jBRVar28.Condition,"ServerID",string(item.ServerID));
					ParamAdd(L2jBRVar28.Condition,"ClassID",string(item.ClassID));
					ParamAdd(L2jBRVar28.Condition,"EffectID",string(L2jBRVar2));
					ParamAdd(L2jBRVar28.Condition,"NormalColor","128,127,103");
					ParamAdd(L2jBRVar28.Condition,"EnableColor","183,178,122");
					EndItem();
				}
				UnknownFunction165(L2jBRVar2);
				goto JL144F;
			}
			strTmp = Class'UIDATA_ITEM'.GetSetItemEnchantEffectDescription(item.ClassID);
			if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
			{
				bLargeWidth = True;
				StartItem();
				L2jBRVar28.eType = 1;
				L2jBRVar28.nOffSetY = 6;
				L2jBRVar28.bLineBreak = True;
				L2jBRVar28.t_color.R = 74;
				L2jBRVar28.t_color.G = 92;
				L2jBRVar28.t_color.B = 104;
				L2jBRVar28.t_color.A = 255;
				L2jBRVar28.t_strText = strTmp;
				ParamAdd(L2jBRVar28.Condition,"Type","EnchantEffect");
				ParamAdd(L2jBRVar28.Condition,"ServerID",string(item.ServerID));
				ParamAdd(L2jBRVar28.Condition,"ClassID",string(item.ClassID));
				ParamAdd(L2jBRVar28.Condition,"NormalColor","74,92,104");
				ParamAdd(L2jBRVar28.Condition,"EnableColor","111,146,169");
				EndItem();
			}
		}
	} else {
		return;
	}
	if ( bLargeWidth )
	{
		m_Tooltip.MinimumWidth = 144;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_ACTION (string L2jBRVar1, ETooltipSourceType eSourceType)
{
	local ItemInfo item;

	if ( UnknownFunction154(eSourceType,1) )
	{
		ParseString(L2jBRVar1,"Name",item.Name);
		ParseString(L2jBRVar1,"Description",item.Description);
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_strText = item.Name;
		EndItem();
		if ( UnknownFunction151(UnknownFunction125(item.Description),0) )
		{
			m_Tooltip.MinimumWidth = 144;
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.t_bDrawOneLine = False;
			L2jBRVar28.bLineBreak = True;
			L2jBRVar28.t_color.R = 178;
			L2jBRVar28.t_color.G = 190;
			L2jBRVar28.t_color.B = 207;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = item.Description;
			EndItem();
		}
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_SKILL (string L2jBRVar1, ETooltipSourceType eSourceType)
{
	local ItemInfo item;
	local EItemParamType EItemParamType;
	local EShortCutItemType eShortCutType;
	local int nTmp;
	local int SkillLevel;

	if ( UnknownFunction154(eSourceType,1) )
	{
		ParseString(L2jBRVar1,"Name",item.Name);
		ParseString(L2jBRVar1,"AdditionalName",item.AdditionalName);
		ParseString(L2jBRVar1,"Description",item.Description);
		ParseInt(L2jBRVar1,"ClassID",item.ClassID);
		ParseInt(L2jBRVar1,"Level",item.Level);
		eShortCutType = item.ItemSubType;
		EItemParamType = item.ItemType;
		SkillLevel = item.Level;
		m_Tooltip.MinimumWidth = 144;
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_strText = item.Name;
		EndItem();
		if ( UnknownFunction151(UnknownFunction125(item.AdditionalName),0) )
		{
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetX = 5;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color.R = 255;
			L2jBRVar28.t_color.G = 217;
			L2jBRVar28.t_color.B = 105;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = item.AdditionalName;
			EndItem();
			SkillLevel = Class'UIDATA_SKILL'.GetEnchantSkillLevel(item.ClassID,item.Level);
		}
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_strText = " ";
		EndItem();
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_color.R = 163;
		L2jBRVar28.t_color.G = 163;
		L2jBRVar28.t_color.B = 163;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_ID = 88;
		EndItem();
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_color.R = 176;
		L2jBRVar28.t_color.G = 155;
		L2jBRVar28.t_color.B = 121;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_strText = UnknownFunction112(" ",string(SkillLevel));
		EndItem();
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.nOffSetY = 6;
		L2jBRVar28.bLineBreak = True;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_color.R = 176;
		L2jBRVar28.t_color.G = 155;
		L2jBRVar28.t_color.B = 121;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_strText = Class'UIDATA_SKILL'.GetOperateType(item.ClassID,item.Level);
		EndItem();
		nTmp = Class'UIDATA_SKILL'.GetHpConsume(item.ClassID,item.Level);
		if ( UnknownFunction151(nTmp,0) )
		{
			AddTooltipItemOption(1195,string(nTmp),True,True,False);
		}
		nTmp = Class'UIDATA_SKILL'.GetMpConsume(item.ClassID,item.Level);
		if ( UnknownFunction151(nTmp,0) )
		{
			AddTooltipItemOption(320,string(nTmp),True,True,False);
		}
		nTmp = Class'UIDATA_SKILL'.GetCastRange(item.ClassID,item.Level);
		if ( UnknownFunction153(nTmp,0) )
		{
			AddTooltipItemOption(321,string(nTmp),True,True,False);
		}
		if ( UnknownFunction151(UnknownFunction125(item.Description),0) )
		{
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.bLineBreak = True;
			L2jBRVar28.t_color.R = 178;
			L2jBRVar28.t_color.G = 190;
			L2jBRVar28.t_color.B = 207;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = item.Description;
			EndItem();
		}
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_ABNORMALSTATUS (string L2jBRVar1, ETooltipSourceType eSourceType)
{
	local ItemInfo item;
	local EItemParamType EItemParamType;
	local EShortCutItemType eShortCutType;

	if ( UnknownFunction154(eSourceType,1) )
	{
		ParseString(L2jBRVar1,"Name",item.Name);
		ParseString(L2jBRVar1,"AdditionalName",item.AdditionalName);
		ParseString(L2jBRVar1,"Description",item.Description);
		ParseInt(L2jBRVar1,"ClassID",item.ClassID);
		ParseInt(L2jBRVar1,"Level",item.Level);
		ParseInt(L2jBRVar1,"Reserved",item.Reserved);
		eShortCutType = item.ItemSubType;
		EItemParamType = item.ItemType;
		m_Tooltip.MinimumWidth = 144;
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_strText = item.Name;
		EndItem();
		if ( UnknownFunction151(UnknownFunction125(item.AdditionalName),0) )
		{
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetX = 5;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color.R = 255;
			L2jBRVar28.t_color.G = 217;
			L2jBRVar28.t_color.B = 105;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = item.AdditionalName;
			EndItem();
			item.Level = Class'UIDATA_SKILL'.GetEnchantSkillLevel(item.ClassID,item.Level);
		}
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_strText = " ";
		EndItem();
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_color.R = 163;
		L2jBRVar28.t_color.G = 163;
		L2jBRVar28.t_color.B = 163;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_ID = 88;
		EndItem();
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_color.R = 176;
		L2jBRVar28.t_color.G = 155;
		L2jBRVar28.t_color.B = 121;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_strText = UnknownFunction112(" ",string(item.Level));
		EndItem();
		if ( UnknownFunction130(UnknownFunction129(IsDebuff(item.ClassID,item.Level)),UnknownFunction153(item.Reserved,0)) )
		{
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.bLineBreak = True;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color.R = 163;
			L2jBRVar28.t_color.G = 163;
			L2jBRVar28.t_color.B = 163;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_ID = 1199;
			EndItem();
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color.R = 163;
			L2jBRVar28.t_color.G = 163;
			L2jBRVar28.t_color.B = 163;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = " : ";
			EndItem();
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color.R = 176;
			L2jBRVar28.t_color.G = 155;
			L2jBRVar28.t_color.B = 121;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = MakeBuffTimeStr(item.Reserved);
			ParamAdd(L2jBRVar28.Condition,"Type","RemainTime");
			EndItem();
		}
		if ( UnknownFunction151(UnknownFunction125(item.Description),0) )
		{
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.bLineBreak = True;
			L2jBRVar28.t_color.R = 178;
			L2jBRVar28.t_color.G = 190;
			L2jBRVar28.t_color.B = 207;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = item.Description;
			EndItem();
		}
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_NORMALITEM (string L2jBRVar1, ETooltipSourceType eSourceType)
{
	local ItemInfo item;

	if ( UnknownFunction154(eSourceType,1) )
	{
		ParseString(L2jBRVar1,"Name",item.Name);
		ParseString(L2jBRVar1,"Description",item.Description);
		ParseString(L2jBRVar1,"AdditionalName",item.AdditionalName);
		ParseInt(L2jBRVar1,"CrystalType",item.CrystalType);
		AddTooltipItemName(item.Name,item);
		AddTooltipItemGrade(item);
		if ( UnknownFunction151(UnknownFunction125(item.Description),0) )
		{
			m_Tooltip.MinimumWidth = 144;
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.bLineBreak = True;
			L2jBRVar28.t_color.R = 178;
			L2jBRVar28.t_color.G = 190;
			L2jBRVar28.t_color.B = 207;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = item.Description;
			EndItem();
		}
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_RECIPE (string L2jBRVar1, ETooltipSourceType eSourceType, bool bShowPrice)
{
	local ItemInfo item;
	local string strAdena;
	local string strAdenaComma;
	local Color AdenaColor;

	if ( UnknownFunction154(eSourceType,1) )
	{
		ParseString(L2jBRVar1,"Name",item.Name);
		ParseString(L2jBRVar1,"Description",item.Description);
		ParseString(L2jBRVar1,"AdditionalName",item.AdditionalName);
		ParseInt(L2jBRVar1,"CrystalType",item.CrystalType);
		ParseInt(L2jBRVar1,"Weight",item.Weight);
		ParseInt(L2jBRVar1,"Price",item.Price);
		AddTooltipItemName(item.Name,item);
		AddTooltipItemGrade(item);
		if ( bShowPrice )
		{
			strAdena = string(item.Price);
			strAdenaComma = MakeCostString(strAdena);
			AdenaColor = GetNumericColor(strAdenaComma);
			AddTooltipItemOption(641,UnknownFunction112(strAdenaComma," "),True,True,False);
			SetTooltipItemColor(AdenaColor.R,AdenaColor.G,AdenaColor.B,0);
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color = AdenaColor;
			L2jBRVar28.t_ID = 469;
			EndItem();
			AddTooltipItemOption(0,UnknownFunction112(UnknownFunction112("(",ConvertNumToText(strAdena)),")"),False,True,False);
			SetTooltipItemColor(AdenaColor.R,AdenaColor.G,AdenaColor.B,0);
		}
		AddTooltipItemOption(52,string(item.Weight),True,True,False);
		if ( UnknownFunction151(UnknownFunction125(item.Description),0) )
		{
			m_Tooltip.MinimumWidth = 144;
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.bLineBreak = True;
			L2jBRVar28.t_color.R = 178;
			L2jBRVar28.t_color.G = 190;
			L2jBRVar28.t_color.B = 207;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = item.Description;
			EndItem();
		}
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_SHORTCUT (string L2jBRVar1, ETooltipSourceType eSourceType)
{
	local ItemInfo item;
	local EItemParamType EItemParamType;
	local EShortCutItemType eShortCutType;
	local string ItemName;

	if ( UnknownFunction154(eSourceType,1) )
	{
		ParseString(L2jBRVar1,"Name",item.Name);
		ParseString(L2jBRVar1,"AdditionalName",item.AdditionalName);
		ParseInt(L2jBRVar1,"ClassID",item.ClassID);
		ParseInt(L2jBRVar1,"Level",item.Level);
		ParseInt(L2jBRVar1,"Reserved",item.Reserved);
		ParseInt(L2jBRVar1,"Enchanted",item.Enchanted);
		ParseInt(L2jBRVar1,"ItemType",item.ItemType);
		ParseInt(L2jBRVar1,"ItemSubType",item.ItemSubType);
		ParseInt(L2jBRVar1,"CrystalType",item.CrystalType);
		ParseInt(L2jBRVar1,"ConsumeType",item.ConsumeType);
		ParseInt(L2jBRVar1,"RefineryOp1",item.RefineryOp1);
		ParseInt(L2jBRVar1,"RefineryOp2",item.RefineryOp2);
		ParseInt(L2jBRVar1,"ItemNum",item.ItemNum);
		ParseInt(L2jBRVar1,"MpConsume",item.MpConsume);
		eShortCutType = item.ItemSubType;
		EItemParamType = item.ItemType;
		ItemName = Class'UIDATA_ITEM'.GetRefineryItemName(item.Name,item.RefineryOp1,item.RefineryOp2);
		switch (eShortCutType)
		{
			case 1:
			AddTooltipItemEnchant(item);
			AddTooltipItemName(ItemName,item);
			AddTooltipItemGrade(item);
			AddTooltipItemCount(item);
			break;
			case 2:
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_strText = ItemName;
			EndItem();
			if ( UnknownFunction151(UnknownFunction125(item.AdditionalName),0) )
			{
				StartItem();
				L2jBRVar28.eType = 1;
				L2jBRVar28.nOffSetX = 5;
				L2jBRVar28.t_bDrawOneLine = True;
				L2jBRVar28.t_color.R = 255;
				L2jBRVar28.t_color.G = 217;
				L2jBRVar28.t_color.B = 105;
				L2jBRVar28.t_color.A = 255;
				L2jBRVar28.t_strText = item.AdditionalName;
				EndItem();
				item.Level = Class'UIDATA_SKILL'.GetEnchantSkillLevel(item.ClassID,item.Level);
			}
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_strText = " ";
			EndItem();
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color.R = 163;
			L2jBRVar28.t_color.G = 163;
			L2jBRVar28.t_color.B = 163;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_ID = 88;
			EndItem();
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color.R = 176;
			L2jBRVar28.t_color.G = 155;
			L2jBRVar28.t_color.B = 121;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = UnknownFunction112(" ",string(item.Level));
			EndItem();
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_strText = " (";
			EndItem();
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_ID = 91;
			EndItem();
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_strText = UnknownFunction112(UnknownFunction112(":",string(item.MpConsume)),")");
			EndItem();
			break;
			case 3:
			case 4:
			case 5:
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_strText = ItemName;
			EndItem();
			break;
			default:
		}
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_RECIPE_MANUFACTURE (string L2jBRVar1, ETooltipSourceType eSourceType)
{
	local ItemInfo item;

	if ( UnknownFunction154(eSourceType,1) )
	{
		ParseString(L2jBRVar1,"Name",item.Name);
		ParseString(L2jBRVar1,"Description",item.Description);
		ParseString(L2jBRVar1,"AdditionalName",item.AdditionalName);
		ParseInt(L2jBRVar1,"Reserved",item.Reserved);
		ParseInt(L2jBRVar1,"CrystalType",item.CrystalType);
		ParseInt(L2jBRVar1,"ItemNum",item.ItemNum);
		m_Tooltip.MinimumWidth = 144;
		AddTooltipItemName(item.Name,item);
		AddTooltipItemGrade(item);
		AddTooltipItemOption(736,string(item.Reserved),True,True,False);
		AddTooltipItemOption(737,string(item.ItemNum),True,True,False);
		if ( UnknownFunction151(UnknownFunction125(item.Description),0) )
		{
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.nOffSetY = 6;
			L2jBRVar28.bLineBreak = True;
			L2jBRVar28.t_color.R = 178;
			L2jBRVar28.t_color.G = 190;
			L2jBRVar28.t_color.B = 207;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = item.Description;
			EndItem();
		}
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_CLANINFO (string L2jBRVar1, ETooltipSourceType eSourceType)
{
	local LVDataRecord Record;

	if ( UnknownFunction154(eSourceType,2) )
	{
		ParamToRecord(L2jBRVar1,Record);
		AddTooltipItemOption(391,GetClassType(int(Record.LVDataList[2].szData)),True,True,True);
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_PARTYMATCH (string L2jBRVar1, ETooltipSourceType eSourceType)
{
	local LVDataRecord Record;

	if ( UnknownFunction154(eSourceType,2) )
	{
		ParamToRecord(L2jBRVar1,Record);
		AddTooltipItemOption(391,GetClassType(int(Record.LVDataList[1].szData)),True,True,True);
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_QUESTLIST (string L2jBRVar1, ETooltipSourceType eSourceType)
{
	local LVDataRecord Record;
	local int nTmp;

	if ( UnknownFunction154(eSourceType,2) )
	{
		ParamToRecord(L2jBRVar1,Record);
		AddTooltipItemOption(1200,Record.LVDataList[0].szData,True,True,True);
		switch (Record.LVDataList[3].nReserved1)
		{
			case 0:
			case 2:
			nTmp = 861;
			break;
			case 1:
			case 3:
			nTmp = 862;
			break;
			default:
		}
		AddTooltipItemOption2(1202,nTmp,True,True,False);
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_RAIDLIST (string L2jBRVar1, ETooltipSourceType eSourceType)
{
	local LVDataRecord Record;

	if ( UnknownFunction154(eSourceType,2) )
	{
		ParamToRecord(L2jBRVar1,Record);
		if ( UnknownFunction150(UnknownFunction125(Record.szReserved),1) )
		{
			return;
		}
		m_Tooltip.MinimumWidth = 144;
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = False;
		L2jBRVar28.t_color.R = 178;
		L2jBRVar28.t_color.G = 190;
		L2jBRVar28.t_color.B = 207;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_strText = Record.szReserved;
		EndItem();
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_QUESTINFO (string L2jBRVar1, ETooltipSourceType eSourceType)
{
	local LVDataRecord Record;
	local int nTmp;
	local int Width1;
	local int Width2;
	local int Height;

	if ( UnknownFunction154(eSourceType,2) )
	{
		ParamToRecord(L2jBRVar1,Record);
		AddTooltipItemOption(1200,Record.LVDataList[0].szData,True,True,True);
		AddTooltipItemOption(1201,Record.LVDataList[1].szData,True,True,False);
		GetTextSize(UnknownFunction112(UnknownFunction112(GetSystemString(1200)," : "),Record.LVDataList[0].szData),Width1,Height);
		GetTextSize(UnknownFunction112(UnknownFunction112(GetSystemString(1201)," : "),Record.LVDataList[1].szData),Width2,Height);
		if ( UnknownFunction151(Width2,Width1) )
		{
			Width1 = Width2;
		}
		if ( UnknownFunction151(144,Width1) )
		{
			Width1 = 144;
		}
		m_Tooltip.MinimumWidth = UnknownFunction146(Width1,30);
		AddTooltipItemOption(922,Record.LVDataList[2].szData,True,True,False);
		switch (Record.LVDataList[3].nReserved1)
		{
			case 0:
			case 2:
			nTmp = 861;
			break;
			case 1:
			case 3:
			nTmp = 862;
			break;
			default:
		}
		AddTooltipItemOption2(1202,nTmp,True,True,False);
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.nOffSetY = 6;
		L2jBRVar28.t_bDrawOneLine = False;
		L2jBRVar28.bLineBreak = True;
		L2jBRVar28.t_color.R = 178;
		L2jBRVar28.t_color.G = 190;
		L2jBRVar28.t_color.B = 207;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_strText = Record.szReserved;
		EndItem();
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function ReturnTooltip_NTT_MANOR (string L2jBRVar1, string TooltipType, ETooltipSourceType eSourceType)
{
	local LVDataRecord Record;
	local int idx1;
	local int idx2;
	local int idx3;

	if ( UnknownFunction154(eSourceType,2) )
	{
		ParamToRecord(L2jBRVar1,Record);
		if ( UnknownFunction122(TooltipType,"ManorSeedInfo") )
		{
			idx1 = 4;
			idx2 = 5;
			idx3 = 6;
		} else {
			if ( UnknownFunction122(TooltipType,"ManorCropInfo") )
			{
				idx1 = 5;
				idx2 = 6;
				idx3 = 7;
			} else {
				if ( UnknownFunction122(TooltipType,"ManorSeedSetting") )
				{
					idx1 = 7;
					idx2 = 8;
					idx3 = 9;
				} else {
					if ( UnknownFunction122(TooltipType,"ManorCropSetting") )
					{
						idx1 = 9;
						idx2 = 10;
						idx3 = 11;
					} else {
						if ( UnknownFunction122(TooltipType,"ManorDefaultInfo") )
						{
							idx1 = 1;
							idx2 = 4;
							idx3 = 5;
						} else {
							if ( UnknownFunction122(TooltipType,"ManorCropSell") )
							{
								idx1 = 7;
								idx2 = 8;
								idx3 = 9;
							}
						}
					}
				}
			}
		}
		AddTooltipItemOption(0,Record.LVDataList[0].szData,False,True,True);
		AddTooltipItemOption(537,Record.LVDataList[idx1].szData,True,True,False);
		AddTooltipItemOption(1134,Record.LVDataList[idx2].szData,True,True,False);
		AddTooltipItemOption(1135,Record.LVDataList[idx3].szData,True,True,False);
	} else {
		return;
	}
	ReturnTooltipInfo(m_Tooltip);
}

function AddTooltipItemOption (int TitleID, string Content, bool bTitle, bool bContent, bool IamFirst)
{
	if ( bTitle )
	{
		StartItem();
		L2jBRVar28.eType = 1;
		if ( UnknownFunction129(IamFirst) )
		{
			L2jBRVar28.nOffSetY = 6;
		}
		L2jBRVar28.bLineBreak = True;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_color.R = 163;
		L2jBRVar28.t_color.G = 163;
		L2jBRVar28.t_color.B = 163;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_ID = TitleID;
		EndItem();
	}
	if ( bContent )
	{
		if ( bTitle )
		{
			StartItem();
			L2jBRVar28.eType = 1;
			if ( UnknownFunction129(IamFirst) )
			{
				L2jBRVar28.nOffSetY = 6;
			}
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color.R = 163;
			L2jBRVar28.t_color.G = 163;
			L2jBRVar28.t_color.B = 163;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = " : ";
			EndItem();
		}
		StartItem();
		L2jBRVar28.eType = 1;
		if ( UnknownFunction129(IamFirst) )
		{
			L2jBRVar28.nOffSetY = 6;
		}
		if ( UnknownFunction129(bTitle) )
		{
			L2jBRVar28.bLineBreak = True;
		}
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_color.R = 176;
		L2jBRVar28.t_color.G = 155;
		L2jBRVar28.t_color.B = 121;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_strText = Content;
		EndItem();
	}
}

function AddTooltipItemOption2 (int TitleID, int ContentID, bool bTitle, bool bContent, bool IamFirst)
{
	if ( bTitle )
	{
		StartItem();
		L2jBRVar28.eType = 1;
		if ( UnknownFunction129(IamFirst) )
		{
			L2jBRVar28.nOffSetY = 6;
		}
		L2jBRVar28.bLineBreak = True;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_color.R = 163;
		L2jBRVar28.t_color.G = 163;
		L2jBRVar28.t_color.B = 163;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_ID = TitleID;
		EndItem();
	}
	if ( bContent )
	{
		if ( bTitle )
		{
			StartItem();
			L2jBRVar28.eType = 1;
			if ( UnknownFunction129(IamFirst) )
			{
				L2jBRVar28.nOffSetY = 6;
			}
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_color.R = 163;
			L2jBRVar28.t_color.G = 163;
			L2jBRVar28.t_color.B = 163;
			L2jBRVar28.t_color.A = 255;
			L2jBRVar28.t_strText = " : ";
			EndItem();
		}
		StartItem();
		L2jBRVar28.eType = 1;
		if ( UnknownFunction129(IamFirst) )
		{
			L2jBRVar28.nOffSetY = 6;
		}
		if ( UnknownFunction129(bTitle) )
		{
			L2jBRVar28.bLineBreak = True;
		}
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_color.R = 176;
		L2jBRVar28.t_color.G = 155;
		L2jBRVar28.t_color.B = 121;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_ID = ContentID;
		EndItem();
	}
}

function SetTooltipItemColor (int R, int G, int B, int offset)
{
	local int L2jBRVar2;

	L2jBRVar2 = UnknownFunction147(UnknownFunction147(m_Tooltip.DrawList.Length,1),offset);
	m_Tooltip.DrawList[L2jBRVar2].t_color.R = R;
	m_Tooltip.DrawList[L2jBRVar2].t_color.G = G;
	m_Tooltip.DrawList[L2jBRVar2].t_color.B = B;
	m_Tooltip.DrawList[L2jBRVar2].t_color.A = 255;
}

function AddTooltipItemBlank (int Height)
{
	StartItem();
	L2jBRVar28.eType = 0;
	L2jBRVar28.b_nHeight = Height;
	EndItem();
}

function AddTooltipItemEnchant (ItemInfo item)
{
	local EItemParamType EItemParamType;

	EItemParamType = item.ItemType;
	if ( UnknownFunction130(UnknownFunction151(item.Enchanted,0),IsEnchantableItem(EItemParamType)) )
	{
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_color.R = 176;
		L2jBRVar28.t_color.G = 155;
		L2jBRVar28.t_color.B = 121;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_strText = UnknownFunction112(UnknownFunction112("+",string(item.Enchanted))," ");
		EndItem();
	}
}

function AddTooltipItemName (string Name, ItemInfo item)
{
	StartItem();
	L2jBRVar28.eType = 1;
	L2jBRVar28.t_bDrawOneLine = True;
	L2jBRVar28.t_strText = Name;
	EndItem();
	if ( UnknownFunction151(UnknownFunction125(item.AdditionalName),0) )
	{
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_color.R = 255;
		L2jBRVar28.t_color.G = 217;
		L2jBRVar28.t_color.B = 105;
		L2jBRVar28.t_color.A = 255;
		L2jBRVar28.t_strText = UnknownFunction112(" ",item.AdditionalName);
		EndItem();
	}
}

function AddTooltipItemGrade (ItemInfo item)
{
	local string strTmp;

	strTmp = GetItemGradeString(item.CrystalType);
	if ( UnknownFunction151(item.CrystalType,5) )
	{
		StartItem();
		L2jBRVar28.eType = 2;
		L2jBRVar28.nOffSetX = 2;
		L2jBRVar28.nOffSetY = -2;
		L2jBRVar28.u_nTextureWidth = 28;
		L2jBRVar28.u_nTextureHeight = 16;
		switch (item.CrystalType)
		{
			case 6:
			L2jBRVar28.u_strTexture = "WindBlood.Grade_S80";
			break;
			case 7:
			L2jBRVar28.u_strTexture = "WindBlood.Grade_S84";
			break;
			case 8:
			L2jBRVar28.u_strTexture = "WindBlood.Grade_R";
			L2jBRVar28.u_nTextureWidth = 14;
			break;
			case 9:
			L2jBRVar28.u_strTexture = "WindBlood.Grade_R95";
			break;
			case 10:
			L2jBRVar28.u_strTexture = "WindBlood.Grade_R99";
			break;
			default:
			L2jBRVar28.u_strTexture = UnknownFunction112(UnknownFunction112("WindBlood.",string(item.CrystalType)),"");
			break;
		}
		EndItem();
	} else {
		if ( UnknownFunction151(UnknownFunction125(strTmp),0) )
		{
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_strText = " ";
			EndItem();
			StartItem();
			L2jBRVar28.eType = 1;
			L2jBRVar28.t_bDrawOneLine = True;
			L2jBRVar28.t_strText = UnknownFunction112(UnknownFunction112("`",strTmp),"`");
			EndItem();
		}
	}
}

function AddTooltipItemCount (ItemInfo item)
{
	if ( IsStackableItem(item.ConsumeType) )
	{
		StartItem();
		L2jBRVar28.eType = 1;
		L2jBRVar28.t_bDrawOneLine = True;
		L2jBRVar28.t_strText = UnknownFunction112(UnknownFunction112(" (",MakeCostString(string(item.ItemNum))),")");
		EndItem();
	}
}

function GetRefineryColor (int Quality, out int R, out int G, out int B)
{
	switch (Quality)
	{
		case 1:
		R = 187;
		G = 181;
		B = 138;
		break;
		case 2:
		R = 132;
		G = 174;
		B = 216;
		break;
		case 3:
		R = 193;
		G = 112;
		B = 202;
		break;
		case 4:
		R = 225;
		G = 109;
		B = 109;
		break;
		default:
		R = 187;
		G = 181;
		B = 138;
		break;
	}
}

