//================================================================================
// InventoryWnd.
//================================================================================

class InventoryWnd extends UICommonAPI;

var string L2jBRVar13;
var ItemWindowHandle m_invenItem;
var ItemWindowHandle m_questItem;
var ItemWindowHandle m_equipItem[15];
var ItemWindowHandle m_hHennaItemWindow;
var TextBoxHandle L2jBRVar143;
var ButtonHandle b_Sort;
var ButtonHandle b_Ench;
var array<int> m_itemOrder;
var Vector m_clickLocation;
var array<ItemInfo> m_EarItemList;
var array<ItemInfo> m_FingerItemLIst;
var NPHRN_ItemEnchantWnd L2jBRVar21;
const L2jBRVar142 = 15;
const EQUIPITEM_LFinger= 14;
const EQUIPITEM_RFinger= 13;
const EQUIPITEM_Feet= 12;
const EQUIPITEM_Legs= 11;
const EQUIPITEM_Gloves= 10;
const EQUIPITEM_LEar= 9;
const EQUIPITEM_REar= 8;
const EQUIPITEM_LHand= 7;
const EQUIPITEM_Chest= 6;
const EQUIPITEM_RHand= 5;
const EQUIPITEM_Neck= 4;
const EQUIPITEM_Hair2= 3;
const EQUIPITEM_Hair= 2;
const EQUIPITEM_Head= 1;
const EQUIPITEM_Underwear= 0;
const DIALOG_DROPITEM_PETASKCOUNT= 10000;
const DIALOG_CRYSTALLIZE= 9999;
const DIALOG_DESTROYITEM_ASKCOUNT= 8888;
const DIALOG_DESTROYITEM_ALL= 7777;
const DIALOG_DESTROYITEM= 6666;
const DIALOG_DROPITEM_ALL= 5555;
const DIALOG_DROPITEM_ASKCOUNT= 4444;
const DIALOG_DROPITEM= 3333;
const DIALOG_POPUP= 2222;
const DIALOG_USE_RECIPE= 1111;

function OnLoad ()
{
	RegisterEvent(2570);
	RegisterEvent(2580);
	RegisterEvent(2590);
	RegisterEvent(2600);
	RegisterEvent(2610);
	RegisterEvent(2620);
	RegisterEvent(2630);
	RegisterEvent(2631);
	RegisterEvent(260);
	RegisterEvent(180);
	RegisterEvent(1710);
	L2jBRFunction2();
}

function L2jBRFunction2 ()
{
	m_invenItem = ItemWindowHandle(GetHandle(UnknownFunction112(L2jBRVar13,".InventoryItem")));
	m_questItem = ItemWindowHandle(GetHandle(UnknownFunction112(L2jBRVar13,".QuestItem")));
	L2jBRVar143
	_iƒ
	 = TextBoxHandle(GetHandle(UnknownFunction112(L2jBRVar13,".AdenaText")));
	m_equipItem[0] = ItemWindowHandle(GetHandle("EquipItem_Underwear"));
	m_equipItem[1] = ItemWindowHandle(GetHandle("EquipItem_Head"));
	m_equipItem[2] = ItemWindowHandle(GetHandle("EquipItem_Hair"));
	m_equipItem[3] = ItemWindowHandle(GetHandle("EquipItem_Hair2"));
	m_equipItem[4] = ItemWindowHandle(GetHandle("EquipItem_Neck"));
	m_equipItem[5] = ItemWindowHandle(GetHandle("EquipItem_RHand"));
	m_equipItem[6] = ItemWindowHandle(GetHandle("EquipItem_Chest"));
	m_equipItem[7] = ItemWindowHandle(GetHandle("EquipItem_LHand"));
	m_equipItem[8] = ItemWindowHandle(GetHandle("EquipItem_REar"));
	m_equipItem[9] = ItemWindowHandle(GetHandle("EquipItem_LEar"));
	m_equipItem[10] = ItemWindowHandle(GetHandle("EquipItem_Gloves"));
	m_equipItem[11] = ItemWindowHandle(GetHandle("EquipItem_Legs"));
	m_equipItem[12] = ItemWindowHandle(GetHandle("EquipItem_Feet"));
	m_equipItem[13] = ItemWindowHandle(GetHandle("EquipItem_RFinger"));
	m_equipItem[14] = ItemWindowHandle(GetHandle("EquipItem_LFinger"));
	m_equipItem[7].SetDisableTex("L2UI.InventoryWnd.Icon_dualcap");
	m_equipItem[1].SetDisableTex("L2UI.InventoryWnd.Icon_dualcap");
	m_equipItem[10].SetDisableTex("L2UI.InventoryWnd.Icon_dualcap");
	m_equipItem[11].SetDisableTex("L2UI.InventoryWnd.Icon_dualcap");
	m_equipItem[12].SetDisableTex("L2UI.InventoryWnd.Icon_dualcap");
	m_equipItem[3].SetDisableTex("L2UI.InventoryWnd.Icon_dualcap");
	m_hHennaItemWindow = ItemWindowHandle(GetHandle("HennaItem"));
	b_Sort = ButtonHandle(GetHandle("InventoryWnd.SortButton"));
	b_Ench = ButtonHandle(GetHandle("InventoryWnd.EnchantButton"));
	b_Sort.SetTooltipCustomType(L2jBRFunction29("Sorting"));
	b_Ench.SetTooltipCustomType(L2jBRFunction29("Enchant Item"));
	L2jBRVar21 = NPHRN_ItemEnchantWnd(GetScript("NPHRN_ItemEnchantWnd"));
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction129(L2jBRVar21.L2jBRVar141) )
	{
		return;
	}
	switch (Event_ID)
	{
		case 2570:
		HandleClear();
		break;
		case 2580:
		
		L2jBRFunction6();
		break;
		case 2590:
		
		L2jBRFunction63();
		break;
		case 2600:
		HandleAddItem(L2jBRVar1);
		break;
		case 2610:
		HandleUpdateItem(L2jBRVar1);
		break;
		case 2620:
		HandleItemListEnd();
		break;
		case 2630:
		HandleAddHennaInfo(L2jBRVar1);
		break;
		case 260:
		HandleUpdateHennaInfo(L2jBRVar1);
		break;
		case 2631:
		HandleToggleWindow();
		break;
		case 1710:
		HandleDialogOK();
		break;
		case 180:
		HandleUpdateUserInfo();
		break;
		default:
		break;
	}
}

function OnShow ()
{
	if ( Class'UIDATA_PLAYER'.HasCrystallizeAbility() )
	{
		ShowWindow(UnknownFunction112(L2jBRVar13,".CrystallizeButton"));
	} else {
		HideWindow(UnknownFunction112(L2jBRVar13,".CrystallizeButton"));
	}
	SetAdenaText();
	L2jBRFunction42();
	UpdateHennaInfo();
	Class'UIAPI_WINDOW'.ShowWindow("InventoryWnd.SortButton");
	SetFocus();
}

function OnHide ()
{
	SaveItemOrder();
}

function OnDBClickItemWithHandle (ItemWindowHandle a_hItemWindow, int Index)
{
	UseItem(a_hItemWindow,Index);
}

function OnRClickItemWithHandle (ItemWindowHandle a_hItemWindow, int Index)
{
	UseItem(a_hItemWindow,Index);
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "SortButton":
		SortItem();
		break;
		case "BtnClose":
		Class'UIAPI_WINDOW'.HideWindow("InventoryWnd");
		break;
		case "BtnMin":
		Class'UIAPI_WINDOW'.Iconize("InventoryWnd","Interface.Icon_df_MenuWnd_Inventory",195);
		break;
		case "EnchantButton":
		OnClickEnchantButton();
		break;
		default:
	}
}

function OnClickEnchantButton ()
{
	if ( UnknownFunction242(UnknownFunction129(IsShowWindow("NPHRN_ItemEnchantWnd")),True) )
	{
		Class'UIAPI_WINDOW'.ShowWindow("NPHRN_ItemEnchantWnd");
	} else {
		Class'UIAPI_WINDOW'.HideWindow("NPHRN_ItemEnchantWnd");
	}
}

function SortItem ()
{
	local int i;
	local int j;
	local int invenLimit;
	local ItemInfo item;
	local EItemType EItemType;
	local int numAsset;
	local int numWeapon;
	local int numArmor;
	local int numAccessary;
	local int numEtcItem;
	local int numAncientCrystalEnchantAm;
	local int numAncientCrystalEnchantWp;
	local int numCrystalEnchantAm;
	local int numCrystalEnchantWp;
	local int numBlessEnchantAm;
	local int numBlessEnchantWp;
	local int numEnchantAm;
	local int numEnchantWp;
	local int numIncEnchantPropAm;
	local int numIncEnchantPropWp;
	local int numPotion;
	local int numElixir;
	local int numArrow;
	local int numBolt;
	local int numRecipe;
	local int nextSlot;
	local int testInt;
	local array<ItemInfo> AssetList;
	local array<ItemInfo> WeaponList;
	local array<ItemInfo> ArmorList;
	local array<ItemInfo> AccesaryList;
	local array<ItemInfo> EtcItemList;
	local array<ItemInfo> AncientCrystalEnchantAmList;
	local array<ItemInfo> AncientCrystalEnchantWpList;
	local array<ItemInfo> CrystalEnchantAmList;
	local array<ItemInfo> CrystalEnchantWpList;
	local array<ItemInfo> BlessEnchantAmList;
	local array<ItemInfo> BlessEnchantWpList;
	local array<ItemInfo> EnchantAmList;
	local array<ItemInfo> EnchantWpList;
	local array<ItemInfo> IncEnchantPropAmList;
	local array<ItemInfo> IncEnchantPropWpList;
	local array<ItemInfo> PotionList;
	local array<ItemInfo> ElixirList;
	local array<ItemInfo> ArrowList;
	local array<ItemInfo> BoltList;
	local array<ItemInfo> RecipeList;
	local ItemInfo temp;

	Debug("Sorting Inven Item");
	numAsset = 0;
	numWeapon = 0;
	numArmor = 0;
	numAccessary = 0;
	numPotion = 0;
	numEtcItem = 0;
	numAncientCrystalEnchantAm = 0;
	numAncientCrystalEnchantWp = 0;
	numCrystalEnchantAm = 0;
	numCrystalEnchantWp = 0;
	numBlessEnchantAm = 0;
	numBlessEnchantWp = 0;
	numIncEnchantPropAm = 0;
	numIncEnchantPropWp = 0;
	numEnchantAm = 0;
	numEnchantWp = 0;
	numPotion = 0;
	numElixir = 0;
	numArrow = 0;
	numBolt = 0;
	numRecipe = 0;
	nextSlot = 0;
	invenLimit = m_invenItem.GetItemNum();
	i = 0;
	if ( UnknownFunction150(i,invenLimit) )
	{
		m_invenItem.GetItem(i,item);
		EItemType = item.ItemType;
		switch (EItemType)
		{
			case 4:
			AssetList[numAsset] = item;
			numAsset = UnknownFunction146(numAsset,1);
			break;
			case 0:
			WeaponList[numWeapon] = item;
			numWeapon = UnknownFunction146(numWeapon,1);
			break;
			case 1:
			ArmorList[numArmor] = item;
			numArmor = UnknownFunction146(numArmor,1);
			break;
			case 2:
			AccesaryList[numAccessary] = item;
			numAccessary = UnknownFunction146(numAccessary,1);
			break;
			case 5:
			testInt = item.ItemSubType;
			switch (item.ItemSubType)
			{
				case 22:
				BlessEnchantAmList[numBlessEnchantAm] = item;
				numBlessEnchantAm = UnknownFunction146(numBlessEnchantAm,1);
				break;
				case 21:
				BlessEnchantWpList[numBlessEnchantWp] = item;
				numBlessEnchantWp = UnknownFunction146(numBlessEnchantWp,1);
				break;
				case 20:
				EnchantAmList[numEnchantAm] = item;
				numEnchantAm = UnknownFunction146(numEnchantAm,1);
				break;
				case 19:
				EnchantWpList[numEnchantWp] = item;
				numEnchantWp = UnknownFunction146(numEnchantWp,1);
				break;
				case 3:
				PotionList[numPotion] = item;
				numPotion = UnknownFunction146(numPotion,1);
				break;
				case 24:
				ElixirList[numElixir] = item;
				numElixir = UnknownFunction146(numElixir,1);
				break;
				case 2:
				ArrowList[numArrow] = item;
				numArrow = UnknownFunction146(numArrow,1);
				break;
				case 5:
				RecipeList[numRecipe] = item;
				numRecipe = UnknownFunction146(numRecipe,1);
				break;
				default:
				EtcItemList[numEtcItem] = item;
				numEtcItem = UnknownFunction146(numEtcItem,1);
				break;
			}
			break;
			default:
			Debug("huh???");
			EtcItemList[numEtcItem] = item;
			numEtcItem = UnknownFunction146(numEtcItem,1);
			break;
		}
		UnknownFunction163(i);
		goto JL00D0;
	}
	i = 0;
	if ( UnknownFunction150(i,numAsset) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numAsset,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numAsset,1)) )
			{
				if ( UnknownFunction150(AssetList[j].Weight,AssetList[UnknownFunction146(j,1)].Weight) )
				{
					temp = AssetList[j];
					AssetList[j] = AssetList[UnknownFunction146(j,1)];
					AssetList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL038A;
		}
		UnknownFunction163(i);
		goto JL0374;
	}
	i = 0;
	if ( UnknownFunction150(i,numWeapon) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numWeapon,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numWeapon,1)) )
			{
				if ( UnknownFunction150(WeaponList[j].Weight,WeaponList[UnknownFunction146(j,1)].Weight) )
				{
					temp = WeaponList[j];
					WeaponList[j] = WeaponList[UnknownFunction146(j,1)];
					WeaponList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL044A;
		}
		UnknownFunction163(i);
		goto JL0434;
	}
	i = 0;
	if ( UnknownFunction150(i,numArmor) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numArmor,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numArmor,1)) )
			{
				if ( UnknownFunction150(ArmorList[j].Weight,ArmorList[UnknownFunction146(j,1)].Weight) )
				{
					temp = ArmorList[j];
					ArmorList[j] = ArmorList[UnknownFunction146(j,1)];
					ArmorList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL050A;
		}
		UnknownFunction163(i);
		goto JL04F4;
	}
	i = 0;
	if ( UnknownFunction150(i,numAccessary) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numAccessary,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numAccessary,1)) )
			{
				if ( UnknownFunction150(AccesaryList[j].Weight,AccesaryList[UnknownFunction146(j,1)].Weight) )
				{
					temp = AccesaryList[j];
					AccesaryList[j] = AccesaryList[UnknownFunction146(j,1)];
					AccesaryList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL05CA;
		}
		UnknownFunction163(i);
		goto JL05B4;
	}
	i = 0;
	if ( UnknownFunction150(i,numAncientCrystalEnchantAm) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numAncientCrystalEnchantAm,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numAncientCrystalEnchantAm,1)) )
			{
				if ( UnknownFunction150(AncientCrystalEnchantAmList[j].Weight,AncientCrystalEnchantAmList[UnknownFunction146(j,1)].Weight) )
				{
					temp = AncientCrystalEnchantAmList[j];
					AncientCrystalEnchantAmList[j] = AncientCrystalEnchantAmList[UnknownFunction146(j,1)];
					AncientCrystalEnchantAmList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL068A;
		}
		UnknownFunction163(i);
		goto JL0674;
	}
	i = 0;
	if ( UnknownFunction150(i,numAncientCrystalEnchantWp) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numAncientCrystalEnchantWp,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numAncientCrystalEnchantWp,1)) )
			{
				if ( UnknownFunction150(AncientCrystalEnchantWpList[j].Weight,AncientCrystalEnchantWpList[UnknownFunction146(j,1)].Weight) )
				{
					temp = AncientCrystalEnchantWpList[j];
					AncientCrystalEnchantWpList[j] = AncientCrystalEnchantWpList[UnknownFunction146(j,1)];
					AncientCrystalEnchantWpList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL074A;
		}
		UnknownFunction163(i);
		goto JL0734;
	}
	i = 0;
	if ( UnknownFunction150(i,numCrystalEnchantAm) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numCrystalEnchantAm,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numCrystalEnchantAm,1)) )
			{
				if ( UnknownFunction150(CrystalEnchantAmList[j].Weight,CrystalEnchantAmList[UnknownFunction146(j,1)].Weight) )
				{
					temp = CrystalEnchantAmList[j];
					CrystalEnchantAmList[j] = CrystalEnchantAmList[UnknownFunction146(j,1)];
					CrystalEnchantAmList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL080A;
		}
		UnknownFunction163(i);
		goto JL07F4;
	}
	i = 0;
	if ( UnknownFunction150(i,numCrystalEnchantWp) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numCrystalEnchantWp,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numCrystalEnchantWp,1)) )
			{
				if ( UnknownFunction150(CrystalEnchantWpList[j].Weight,CrystalEnchantWpList[UnknownFunction146(j,1)].Weight) )
				{
					temp = CrystalEnchantWpList[j];
					CrystalEnchantWpList[j] = CrystalEnchantWpList[UnknownFunction146(j,1)];
					CrystalEnchantWpList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL08CA;
		}
		UnknownFunction163(i);
		goto JL08B4;
	}
	i = 0;
	if ( UnknownFunction150(i,numBlessEnchantAm) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numBlessEnchantAm,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numBlessEnchantAm,1)) )
			{
				if ( UnknownFunction150(BlessEnchantAmList[j].Weight,BlessEnchantAmList[UnknownFunction146(j,1)].Weight) )
				{
					temp = BlessEnchantAmList[j];
					BlessEnchantAmList[j] = BlessEnchantAmList[UnknownFunction146(j,1)];
					BlessEnchantAmList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL098A;
		}
		UnknownFunction163(i);
		goto JL0974;
	}
	i = 0;
	if ( UnknownFunction150(i,numBlessEnchantWp) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numBlessEnchantWp,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numBlessEnchantWp,1)) )
			{
				if ( UnknownFunction150(BlessEnchantWpList[j].Weight,BlessEnchantWpList[UnknownFunction146(j,1)].Weight) )
				{
					temp = BlessEnchantWpList[j];
					BlessEnchantWpList[j] = BlessEnchantWpList[UnknownFunction146(j,1)];
					BlessEnchantWpList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL0A4A;
		}
		UnknownFunction163(i);
		goto JL0A34;
	}
	i = 0;
	if ( UnknownFunction150(i,numEnchantAm) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numEnchantAm,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numEnchantAm,1)) )
			{
				if ( UnknownFunction150(EnchantAmList[j].Weight,EnchantAmList[UnknownFunction146(j,1)].Weight) )
				{
					temp = EnchantAmList[j];
					EnchantAmList[j] = EnchantAmList[UnknownFunction146(j,1)];
					EnchantAmList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL0B0A;
		}
		UnknownFunction163(i);
		goto JL0AF4;
	}
	i = 0;
	if ( UnknownFunction150(i,numEnchantWp) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numEnchantWp,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numEnchantWp,1)) )
			{
				if ( UnknownFunction150(EnchantWpList[j].Weight,EnchantWpList[UnknownFunction146(j,1)].Weight) )
				{
					temp = EnchantWpList[j];
					EnchantWpList[j] = EnchantWpList[UnknownFunction146(j,1)];
					EnchantWpList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL0BCA;
		}
		UnknownFunction163(i);
		goto JL0BB4;
	}
	i = 0;
	if ( UnknownFunction150(i,numIncEnchantPropAm) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numIncEnchantPropAm,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numIncEnchantPropAm,1)) )
			{
				if ( UnknownFunction150(IncEnchantPropAmList[j].Weight,IncEnchantPropAmList[UnknownFunction146(j,1)].Weight) )
				{
					temp = IncEnchantPropAmList[j];
					IncEnchantPropAmList[j] = IncEnchantPropAmList[UnknownFunction146(j,1)];
					IncEnchantPropAmList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL0C8A;
		}
		UnknownFunction163(i);
		goto JL0C74;
	}
	i = 0;
	if ( UnknownFunction150(i,numIncEnchantPropWp) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numIncEnchantPropWp,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numIncEnchantPropWp,1)) )
			{
				if ( UnknownFunction150(IncEnchantPropWpList[j].Weight,IncEnchantPropWpList[UnknownFunction146(j,1)].Weight) )
				{
					temp = IncEnchantPropWpList[j];
					IncEnchantPropWpList[j] = IncEnchantPropWpList[UnknownFunction146(j,1)];
					IncEnchantPropWpList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL0D4A;
		}
		UnknownFunction163(i);
		goto JL0D34;
	}
	i = 0;
	if ( UnknownFunction150(i,numPotion) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numPotion,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numPotion,1)) )
			{
				if ( UnknownFunction150(PotionList[j].Weight,PotionList[UnknownFunction146(j,1)].Weight) )
				{
					temp = PotionList[j];
					PotionList[j] = PotionList[UnknownFunction146(j,1)];
					PotionList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL0E0A;
		}
		UnknownFunction163(i);
		goto JL0DF4;
	}
	i = 0;
	if ( UnknownFunction150(i,numElixir) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numElixir,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numElixir,1)) )
			{
				if ( UnknownFunction150(ElixirList[j].Weight,ElixirList[UnknownFunction146(j,1)].Weight) )
				{
					temp = ElixirList[j];
					ElixirList[j] = ElixirList[UnknownFunction146(j,1)];
					ElixirList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL0ECA;
		}
		UnknownFunction163(i);
		goto JL0EB4;
	}
	i = 0;
	if ( UnknownFunction150(i,numArrow) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numArrow,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numArrow,1)) )
			{
				if ( UnknownFunction150(ArrowList[j].Weight,ArrowList[UnknownFunction146(j,1)].Weight) )
				{
					temp = ArrowList[j];
					ArrowList[j] = ArrowList[UnknownFunction146(j,1)];
					ArrowList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL0F8A;
		}
		UnknownFunction163(i);
		goto JL0F74;
	}
	i = 0;
	if ( UnknownFunction150(i,numBolt) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numBolt,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numBolt,1)) )
			{
				if ( UnknownFunction150(BoltList[j].Weight,BoltList[UnknownFunction146(j,1)].Weight) )
				{
JL0AF4:
					temp = BoltList[j];
					BoltList[j] = BoltList[UnknownFunction146(j,1)];
					BoltList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL104A;
		}
		UnknownFunction163(i);
		goto JL1034;
	}
	i = 0;
	if ( UnknownFunction150(i,numRecipe) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numRecipe,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numRecipe,1)) )
			{
				if ( UnknownFunction150(RecipeList[j].Weight,RecipeList[UnknownFunction146(j,1)].Weight) )
				{
					temp = BoltList[j];
					RecipeList[j] = RecipeList[UnknownFunction146(j,1)];
					RecipeList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL110A;
		}
		UnknownFunction163(i);
		goto JL10F4;
	}
	i = 0;
	if ( UnknownFunction150(i,numEtcItem) )
	{
		j = 0;
		if ( UnknownFunction150(j,UnknownFunction147(numEtcItem,i)) )
		{
			if ( UnknownFunction150(j,UnknownFunction147(numEtcItem,1)) )
			{
				if ( UnknownFunction150(EtcItemList[j].Weight,EtcItemList[UnknownFunction146(j,1)].Weight) )
				{
					temp = EtcItemList[j];
					EtcItemList[j] = EtcItemList[UnknownFunction146(j,1)];
					EtcItemList[UnknownFunction146(j,1)] = temp;
				}
			}
			UnknownFunction163(j);
			goto JL11CA;
		}
		UnknownFunction163(i);
		goto JL11B4;
	}
	i = 0;
	if ( UnknownFunction150(i,numAsset) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),AssetList[i]);
		UnknownFunction163(i);
		goto JL1274;
	}
	nextSlot = UnknownFunction146(nextSlot,numAsset);
	i = 0;
	if ( UnknownFunction150(i,numWeapon) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),WeaponList[i]);
		UnknownFunction163(i);
		goto JL12CC;
	}
	nextSlot = UnknownFunction146(nextSlot,numWeapon);
	i = 0;
	if ( UnknownFunction150(i,numArmor) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),ArmorList[i]);
		UnknownFunction163(i);
		goto JL1324;
	}
	nextSlot = UnknownFunction146(nextSlot,numArmor);
	i = 0;
	if ( UnknownFunction150(i,numAccessary) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),AccesaryList[i]);
		UnknownFunction163(i);
		goto JL137C;
	}
	nextSlot = UnknownFunction146(nextSlot,numAccessary);
	i = 0;
	if ( UnknownFunction150(i,numCrystalEnchantAm) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),CrystalEnchantAmList[i]);
		UnknownFunction163(i);
		goto JL13D4;
	}
	nextSlot = UnknownFunction146(nextSlot,numCrystalEnchantAm);
	i = 0;
	if ( UnknownFunction150(i,numCrystalEnchantWp) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),CrystalEnchantWpList[i]);
		UnknownFunction163(i);
		goto JL142C;
	}
	nextSlot = UnknownFunction146(nextSlot,numCrystalEnchantWp);
	i = 0;
	if ( UnknownFunction150(i,numBlessEnchantAm) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),BlessEnchantAmList[i]);
		UnknownFunction163(i);
		goto JL1484;
	}
	nextSlot = UnknownFunction146(nextSlot,numBlessEnchantAm);
	i = 0;
	if ( UnknownFunction150(i,numBlessEnchantWp) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),BlessEnchantWpList[i]);
		UnknownFunction163(i);
		goto JL14DC;
	}
	nextSlot = UnknownFunction146(nextSlot,numBlessEnchantWp);
	i = 0;
	if ( UnknownFunction150(i,numEnchantAm) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),EnchantAmList[i]);
		UnknownFunction163(i);
		goto JL1534;
	}
	nextSlot = UnknownFunction146(nextSlot,numEnchantAm);
	i = 0;
	if ( UnknownFunction150(i,numEnchantWp) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),EnchantWpList[i]);
		UnknownFunction163(i);
		goto JL158C;
	}
	nextSlot = UnknownFunction146(nextSlot,numEnchantWp);
	i = 0;
	if ( UnknownFunction150(i,numPotion) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),PotionList[i]);
		UnknownFunction163(i);
		goto JL15E4;
	}
	nextSlot = UnknownFunction146(nextSlot,numPotion);
	i = 0;
	if ( UnknownFunction150(i,numElixir) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),ElixirList[i]);
		UnknownFunction163(i);
		goto JL163C;
	}
	nextSlot = UnknownFunction146(nextSlot,numElixir);
	i = 0;
	if ( UnknownFunction150(i,numArrow) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),ArrowList[i]);
		UnknownFunction163(i);
		goto JL1694;
	}
	nextSlot = UnknownFunction146(nextSlot,numArrow);
	i = 0;
	if ( UnknownFunction150(i,numRecipe) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),RecipeList[i]);
		UnknownFunction163(i);
		goto JL16EC;
	}
	nextSlot = UnknownFunction146(nextSlot,numRecipe);
	i = 0;
	if ( UnknownFunction150(i,numEtcItem) )
	{
		m_invenItem.SetItem(UnknownFunction146(nextSlot,i),EtcItemList[i]);
		UnknownFunction163(i);
		goto JL1744;
	}
	nextSlot = UnknownFunction146(nextSlot,numEtcItem);
	SaveItemOrder();
}

function OnSelectItemWithHandle (ItemWindowHandle a_hItemWindow, int a_Index)
{
	local int i;
	local string L2jBRVar4;
	local ItemInfo L2jBRVar28;

	L2jBRVar4 = Class'UIAPI_EDITBOX'.GetString("ChatWnd.ChatEditBox");
	if ( IsKeyDown(16) )
	{
		a_hItemWindow.GetSelectedItem(L2jBRVar28);
		if ( UnknownFunction151(L2jBRVar28.ItemNum,1) )
		{
			SetChatMessage(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRVar4),""),L2jBRVar28.Name)," "),"("),string(L2jBRVar28.ItemNum)),") "));
		} else {
			if ( UnknownFunction154(L2jBRVar28.ItemType,0) )
			{
				if ( UnknownFunction130(UnknownFunction123(L2jBRVar28.AdditionalName,""),UnknownFunction151(L2jBRVar28.Enchanted,0)) )
				{
					SetChatMessage(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRVar4),""),L2jBRVar28.Name)," "),"+"),string(L2jBRVar28.Enchanted)),"")," ("),L2jBRVar28.AdditionalName),") "));
				} else {
					if ( UnknownFunction151(L2jBRVar28.Enchanted,0) )
					{
						SetChatMessage(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRVar4),""),L2jBRVar28.Name)," "),"+"),string(L2jBRVar28.Enchanted))," "));
					} else {
						if ( UnknownFunction123(L2jBRVar28.AdditionalName,"") )
						{
							SetChatMessage(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRVar4),""),L2jBRVar28.Name)," "),"("),L2jBRVar28.AdditionalName),") "));
						} else {
							SetChatMessage(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRVar4),""),L2jBRVar28.Name)," "));
						}
					}
				}
			} else {
				if ( UnknownFunction132(UnknownFunction154(L2jBRVar28.ItemType,1),UnknownFunction154(L2jBRVar28.ItemType,2)) )
				{
					if ( UnknownFunction130(UnknownFunction123(L2jBRVar28.AdditionalName,""),UnknownFunction151(L2jBRVar28.Enchanted,0)) )
					{
						SetChatMessage(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRVar4),""),L2jBRVar28.Name)," "),"+"),string(L2jBRVar28.Enchanted)),"")," ("),L2jBRVar28.AdditionalName),") "));
					} else {
						if ( UnknownFunction151(L2jBRVar28.Enchanted,0) )
						{
							SetChatMessage(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRVar4),""),L2jBRVar28.Name)," "),"+"),string(L2jBRVar28.Enchanted))," "));
						} else {
							SetChatMessage(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRVar4),""),L2jBRVar28.Name)," "));
						}
					}
				} else {
					SetChatMessage(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",L2jBRVar4),""),L2jBRVar28.Name)," "));
				}
			}
		}
		Class'UIAPI_WINDOW'.SetFocus("ChatWnd.ChatEditBox");
	}
	if ( UnknownFunction114(a_hItemWindow,m_invenItem) )
	{
		return;
	}
	if ( UnknownFunction114(a_hItemWindow,m_questItem) )
	{
		return;
	}
	i = 0;
	if ( UnknownFunction150(i,15) )
	{
		if ( UnknownFunction119(a_hItemWindow,m_equipItem[i]) )
		{
			m_equipItem[i].ClearSelect();
		}
		UnknownFunction163(i);
		goto JL036A;
	}
}

function OnDropItem (string strTarget, ItemInfo Info, int X, int Y)
{
	local int toIndex;
	local int fromIndex;

	if ( UnknownFunction129(UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction122(Info.DragSrcName,"InventoryItem"),UnknownFunction122(Info.DragSrcName,"QuestItem")),UnknownFunction155(-1,UnknownFunction126(Info.DragSrcName,"EquipItem"))),UnknownFunction122(Info.DragSrcName,"PetInvenWnd"))) )
	{
		return;
	}
	if ( UnknownFunction122(strTarget,"InventoryItem") )
	{
		if ( UnknownFunction122(Info.DragSrcName,"InventoryItem") )
		{
			toIndex = m_invenItem.GetIndexAt(X,Y,1,1);
			if ( UnknownFunction153(toIndex,0) )
			{
				fromIndex = m_invenItem.FindItemWithServerID(Info.ServerID);
				if ( UnknownFunction155(toIndex,fromIndex) )
				{
					if ( UnknownFunction150(fromIndex,toIndex) )
					{
						m_invenItem.SwapItems(fromIndex,UnknownFunction146(fromIndex,1));
						UnknownFunction163(fromIndex);
						goto JL0110;
					}
					if ( UnknownFunction150(toIndex,fromIndex) )
					{
						m_invenItem.SwapItems(fromIndex,UnknownFunction147(fromIndex,1));
						UnknownFunction164(fromIndex);
						goto JL0145;
					}
				}
			} else {
				fromIndex = m_invenItem.GetItemNum();
				if ( UnknownFunction150(toIndex,UnknownFunction147(fromIndex,1)) )
				{
					m_invenItem.SwapItems(toIndex,UnknownFunction146(toIndex,1));
					UnknownFunction163(toIndex);
					goto JL0192;
				}
			}
		} else {
			if ( UnknownFunction155(-1,UnknownFunction126(Info.DragSrcName,"EquipItem")) )
			{
				RequestUnequipItem(Info.ServerID,Info.SlotBitType);
			} else {
				if ( UnknownFunction122(Info.DragSrcName,"PetInvenWnd") )
				{
					if ( UnknownFunction130(IsStackableItem(Info.ConsumeType),UnknownFunction151(Info.ItemNum,1)) )
					{
						if ( UnknownFunction151(Info.AllItemCount,0) )
						{
							if ( CheckItemLimit(Info.ClassID,Info.AllItemCount) )
							{
								Class'PetAPI'.RequestGetItemFromPet(Info.ServerID,Info.AllItemCount,False);
							}
						} else {
							DialogSetID(10000);
							DialogSetReservedInt(Info.ServerID);
							DialogSetParamInt(Info.ItemNum);
							DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),Info.Name));
						}
					} else {
						Class'PetAPI'.RequestGetItemFromPet(Info.ServerID,1,False);
					}
				}
			}
		}
	} else {
		if ( UnknownFunction122(strTarget,"QuestItem") )
		{
			if ( UnknownFunction122(Info.DragSrcName,"QuestItem") )
			{
				toIndex = m_questItem.GetIndexAt(X,Y,1,1);
				if ( UnknownFunction153(toIndex,0) )
				{
					fromIndex = m_questItem.FindItemWithServerID(Info.ServerID);
					if ( UnknownFunction155(toIndex,fromIndex) )
					{
						if ( UnknownFunction150(fromIndex,toIndex) )
						{
							m_questItem.SwapItems(fromIndex,UnknownFunction146(fromIndex,1));
							UnknownFunction163(fromIndex);
							goto JL0395;
						}
						if ( UnknownFunction150(toIndex,fromIndex) )
						{
							m_questItem.SwapItems(fromIndex,UnknownFunction147(fromIndex,1));
							UnknownFunction164(fromIndex);
							goto JL03CA;
						}
					}
				} else {
					fromIndex = m_invenItem.GetItemNum();
					if ( UnknownFunction150(toIndex,UnknownFunction147(fromIndex,1)) )
					{
						m_invenItem.SwapItems(toIndex,UnknownFunction146(toIndex,1));
						UnknownFunction163(toIndex);
						goto JL0417;
					}
				}
			}
		} else {
			if ( UnknownFunction155(-1,UnknownFunction126(strTarget,"EquipItem")) )
			{
				if ( UnknownFunction122(Info.DragSrcName,"PetInvenWnd") )
				{
					Class'PetAPI'.RequestGetItemFromPet(Info.ServerID,1,True);
				} else {
					if ( UnknownFunction155(-1,UnknownFunction126(Info.DragSrcName,"EquipItem")) )
					{
						goto JL04F3;
					}
					if ( UnknownFunction155(Info.ItemType,5) )
					{
						RequestUseItem(Info.ServerID);
					}
				}
			} else {
				if ( UnknownFunction122(strTarget,"TrashButton") )
				{
					if ( UnknownFunction130(IsStackableItem(Info.ConsumeType),UnknownFunction151(Info.ItemNum,1)) )
					{
						if ( UnknownFunction151(Info.AllItemCount,0) )
						{
							DialogSetID(7777);
							DialogSetReservedInt(Info.ServerID);
							DialogSetReservedInt2(Info.AllItemCount);
							DialogShow(4,MakeFullSystemMsg(GetSystemMessage(74),Info.Name,""));
						} else {
							DialogSetID(8888);
							DialogSetReservedInt(Info.ServerID);
							DialogSetParamInt(Info.ItemNum);
							DialogShow(6,MakeFullSystemMsg(GetSystemMessage(73),Info.Name));
						}
					} else {
						DialogSetID(6666);
						DialogSetReservedInt(Info.ServerID);
						DialogShow(4,MakeFullSystemMsg(GetSystemMessage(74),Info.Name));
					}
				} else {
					if ( UnknownFunction122(strTarget,"CrystallizeButton") )
					{
						if ( UnknownFunction132(UnknownFunction122(Info.DragSrcName,"InventoryItem"),UnknownFunction155(-1,UnknownFunction126(Info.DragSrcName,"EquipItem"))) )
						{
							if ( UnknownFunction130(Class'UIDATA_PLAYER'.HasCrystallizeAbility(),Class'UIDATA_ITEM'.IsCrystallizable(Info.ClassID)) )
							{
								DialogSetID(9999);
								DialogSetReservedInt(Info.ServerID);
								DialogShow(4,MakeFullSystemMsg(GetSystemMessage(336),Info.Name));
							}
						}
					}
				}
			}
		}
	}
}

function OnDropItemSource (string strTarget, ItemInfo Info)
{
	if ( UnknownFunction122(strTarget,"Console") )
	{
		if ( UnknownFunction132(UnknownFunction132(UnknownFunction122(Info.DragSrcName,"InventoryItem"),UnknownFunction122(Info.DragSrcName,"QuestItem")),UnknownFunction155(-1,UnknownFunction126(Info.DragSrcName,"EquipItem"))) )
		{
			m_clickLocation = GetClickLocation();
			if ( UnknownFunction130(IsStackableItem(Info.ConsumeType),UnknownFunction151(Info.ItemNum,1)) )
			{
				if ( UnknownFunction151(Info.AllItemCount,0) )
				{
					DialogHide();
					DialogSetID(5555);
					DialogSetReservedInt(Info.ServerID);
					DialogSetReservedInt2(Info.AllItemCount);
					DialogShow(4,MakeFullSystemMsg(GetSystemMessage(1833),Info.Name,""));
				} else {
					DialogHide();
					DialogSetID(4444);
					DialogSetReservedInt(Info.ServerID);
					DialogSetParamInt(Info.ItemNum);
					DialogShow(6,MakeFullSystemMsg(GetSystemMessage(71),Info.Name,""));
				}
			} else {
				DialogHide();
				DialogSetID(3333);
				DialogSetReservedInt(Info.ServerID);
				DialogShow(4,MakeFullSystemMsg(GetSystemMessage(400),Info.Name,""));
			}
		}
	}
}

function bool IsEquipItem (out ItemInfo Info)
{
	return Info.bEquipped;
}

function bool IsQuestItem (out ItemInfo Info)
{
	return UnknownFunction154(Info.ItemType,3);
}

function HandleClear ()
{
	EquipItemClear();
	m_invenItem.Clear();
	m_questItem.Clear();
	m_EarItemList.Length = 0;
	m_FingerItemLIst.Length = 0;
}

function int EquipItemGetItemNum ()
{
	local int i;
	local int ItemNum;

	i = 0;
	if ( UnknownFunction150(i,15) )
	{
		if ( m_equipItem[i].IsEnableWindow() )
		{
			ItemNum = UnknownFunction146(ItemNum,m_equipItem[i].GetItemNum());
		}
		UnknownFunction163(i);
		goto JL0007;
	}
	return ItemNum;
}

function EquipItemClear ()
{
	local int i;

	i = 0;
	if ( UnknownFunction150(i,15) )
	{
		m_equipItem[i].Clear();
		UnknownFunction163(i);
		goto JL0007;
	}
}

function bool EquipItemFind (int a_ServerID)
{
	local int i;
	local int Index;

	i = 0;
	if ( UnknownFunction150(i,15) )
	{
		Index = m_equipItem[i].FindItemWithServerID(a_ServerID);
		if ( UnknownFunction155(-1,Index) )
		{
			return True;
		}
		UnknownFunction163(i);
		goto JL0007;
	}
	return False;
}

function EquipItemDelete (int a_ServerID)
{
	local int i;
	local int Index;
	local ItemInfo TheItemInfo;

	i = 0;
	if ( UnknownFunction150(i,15) )
	{
		Index = m_equipItem[i].FindItemWithServerID(a_ServerID);
		if ( UnknownFunction155(-1,Index) )
		{
			m_equipItem[i].Clear();
			if ( UnknownFunction154(i,7) )
			{
				if ( m_equipItem[5].GetItem(0,TheItemInfo) )
				{
					if ( UnknownFunction154(TheItemInfo.SlotBitType,16384) )
					{
						m_equipItem[7].Clear();
						m_equipItem[7].AddItem(TheItemInfo);
						m_equipItem[7].DisableWindow();
					}
				}
			}
		}
		UnknownFunction163(i);
		goto JL0007;
	}
}

function EarItemUpdate ()
{
	local int i;
	local int LEarIndex;
	local int REarIndex;

	LEarIndex = -1;
	REarIndex = -1;
	i = 0;
	if ( UnknownFunction150(i,m_EarItemList.Length) )
	{
		switch (IsLOrREar(m_EarItemList[i].ServerID))
		{
			case -1:
			LEarIndex = i;
			break;
			case 0:
			m_EarItemList.Remove (i,1);
			break;
			case 1:
			REarIndex = i;
			break;
			default:
		}
		UnknownFunction163(i);
		goto JL001D;
	}
	if ( UnknownFunction155(-1,LEarIndex) )
	{
		m_equipItem[9].Clear();
		m_equipItem[9].AddItem(m_EarItemList[LEarIndex]);
	}
	if ( UnknownFunction155(-1,REarIndex) )
	{
		m_equipItem[8].Clear();
		m_equipItem[8].AddItem(m_EarItemList[REarIndex]);
	}
}

function FingerItemUpdate ()
{
	local int i;
	local int LFingerIndex;
	local int RFingerIndex;

	LFingerIndex = -1;
	RFingerIndex = -1;
	i = 0;
	if ( UnknownFunction150(i,m_FingerItemLIst.Length) )
	{
		switch (IsLOrRFinger(m_FingerItemLIst[i].ServerID))
		{
			case -1:
			LFingerIndex = i;
			break;
			case 0:
			m_FingerItemLIst.Remove (i,1);
			break;
			case 1:
			RFingerIndex = i;
			break;
			default:
		}
		UnknownFunction163(i);
		goto JL001D;
	}
	if ( UnknownFunction155(-1,LFingerIndex) )
	{
		m_equipItem[14].Clear();
		m_equipItem[14].AddItem(m_FingerItemLIst[LFingerIndex]);
	}
	if ( UnknownFunction155(-1,RFingerIndex) )
	{
		m_equipItem[13].Clear();
		m_equipItem[13].AddItem(m_FingerItemLIst[RFingerIndex]);
	}
}

function EquipItemUpdate (ItemInfo a_Info)
{
	local ItemWindowHandle hItemWnd;
	local ItemInfo TheItemInfo;
	local bool ClearLHand;
	local ItemInfo RHand;
	local ItemInfo LHand;
	local ItemInfo Legs;
	local ItemInfo Gloves;
	local ItemInfo Feet;
	local ItemInfo Hair2;
	local int i;

	switch (a_Info.SlotBitType)
	{
		case 1:
		hItemWnd = m_equipItem[0];
		break;
		case 2:
		case 4:
		case 6:
		i = 0;
		if ( UnknownFunction150(i,m_EarItemList.Length) )
		{
			if ( UnknownFunction154(m_EarItemList[i].ServerID,a_Info.ServerID) )
			{
				goto JL0072;
			}
			UnknownFunction163(i);
			goto JL0036;
		}
		if ( UnknownFunction154(i,m_EarItemList.Length) )
		{
			m_EarItemList.Length = UnknownFunction146(m_EarItemList.Length,1);
			m_EarItemList[UnknownFunction147(m_EarItemList.Length,1)] = a_Info;
		}
		hItemWnd = None;
		EarItemUpdate();
		break;
		case 8:
		hItemWnd = m_equipItem[4];
		break;
		case 16:
		case 32:
		case 48:
		i = 0;
		if ( UnknownFunction150(i,m_FingerItemLIst.Length) )
		{
			if ( UnknownFunction154(m_FingerItemLIst[i].ServerID,a_Info.ServerID) )
			{
				goto JL011F;
			}
			UnknownFunction163(i);
			goto JL00E3;
		}
		if ( UnknownFunction154(i,m_FingerItemLIst.Length) )
		{
			m_FingerItemLIst.Length = UnknownFunction146(m_FingerItemLIst.Length,1);
			m_FingerItemLIst[UnknownFunction147(m_FingerItemLIst.Length,1)] = a_Info;
		}
		hItemWnd = None;
		FingerItemUpdate();
		break;
		case 64:
		hItemWnd = m_equipItem[1];
		hItemWnd.EnableWindow();
		break;
		case 128:
		hItemWnd = m_equipItem[5];
		break;
		case 256:
		hItemWnd = m_equipItem[7];
		hItemWnd.EnableWindow();
		break;
		case 512:
		hItemWnd = m_equipItem[10];
		hItemWnd.EnableWindow();
		break;
		case 1024:
		hItemWnd = m_equipItem[6];
		break;
		case 2048:
		hItemWnd = m_equipItem[11];
		hItemWnd.EnableWindow();
		break;
		case 4096:
		hItemWnd = m_equipItem[12];
		hItemWnd.EnableWindow();
		break;
		case 8192:
		hItemWnd = m_equipItem[0];
		break;
		case 16384:
		hItemWnd = m_equipItem[5];
		ClearLHand = True;
		if ( IsBowOrFishingRod(a_Info) )
		{
			if ( m_equipItem[7].GetItem(0,TheItemInfo) )
			{
				if ( IsArrow(TheItemInfo) )
				{
					ClearLHand = False;
				}
			}
		}
		if ( ClearLHand )
		{
			if ( UnknownFunction155(UnknownFunction125(a_Info.IconNameEx1),0) )
			{
				RHand = a_Info;
				LHand = a_Info;
				RHand.IconIndex = 1;
				LHand.IconIndex = 2;
				m_equipItem[5].Clear();
				m_equipItem[5].AddItem(RHand);
				m_equipItem[7].Clear();
				m_equipItem[7].AddItem(LHand);
				m_equipItem[7].DisableWindow();
				hItemWnd = None;
			} else {
				m_equipItem[7].Clear();
				m_equipItem[7].AddItem(a_Info);
				m_equipItem[7].DisableWindow();
			}
		}
		break;
		case 32768:
		hItemWnd = m_equipItem[6];
		Legs = a_Info;
		Legs.IconName = a_Info.IconNameEx2;
		m_equipItem[11].Clear();
		m_equipItem[11].AddItem(Legs);
		m_equipItem[11].DisableWindow();
		break;
		case 65536:
		hItemWnd = m_equipItem[2];
		break;
		case 131072:
		hItemWnd = m_equipItem[6];
		Hair2 = a_Info;
		Gloves = a_Info;
		Legs = a_Info;
		Feet = a_Info;
		Hair2.IconName = a_Info.IconNameEx1;
		Gloves.IconName = a_Info.IconNameEx2;
		Legs.IconName = a_Info.IconNameEx3;
		Feet.IconName = a_Info.IconNameEx4;
		m_equipItem[1].Clear();
		m_equipItem[1].AddItem(Hair2);
		m_equipItem[1].DisableWindow();
		m_equipItem[10].Clear();
		m_equipItem[10].AddItem(Gloves);
		m_equipItem[10].DisableWindow();
		m_equipItem[11].Clear();
		m_equipItem[11].AddItem(Legs);
		m_equipItem[11].DisableWindow();
		m_equipItem[12].Clear();
		m_equipItem[12].AddItem(Feet);
		m_equipItem[12].DisableWindow();
		break;
		case 262144:
		hItemWnd = m_equipItem[3];
		hItemWnd.EnableWindow();
		break;
		case 524288:
		hItemWnd = m_equipItem[2];
		m_equipItem[3].Clear();
		m_equipItem[3].AddItem(a_Info);
		m_equipItem[3].DisableWindow();
		break;
		default:
	}
	if ( UnknownFunction119(None,hItemWnd) )
	{
		hItemWnd.Clear();
		hItemWnd.AddItem(a_Info);
	}
}

function L2jBRFunction6 ()
{
	LoadItemOrder();
	ShowWindow(L2jBRVar13);
	Class'UIAPI_WINDOW'.SetFocus(L2jBRVar13);
}

function 
L2jBRFunction63 ()
{
	HideWindow(L2jBRVar13);
}

function HandleAddItem (string L2jBRVar1)
{
	local ItemInfo Info;

	ParamToItemInfo(L2jBRVar1,Info);
	if ( IsEquipItem(Info) )
	{
		EquipItemUpdate(Info);
	} else {
		if ( IsQuestItem(Info) )
		{
			m_questItem.AddItem(Info);
		} else {
			m_invenItem.AddItem(Info);
		}
	}
}

function HandleUpdateItem (string L2jBRVar1)
{
	local string L2jBRVar5;
	local ItemInfo Info;
	local int Index;

	ParseString(L2jBRVar1,"type",L2jBRVar5);
	ParamToItemInfo(L2jBRVar1,Info);
	if ( UnknownFunction122(L2jBRVar5,"add") )
	{
		if ( IsEquipItem(Info) )
		{
			EquipItemUpdate(Info);
		} else {
			if ( IsQuestItem(Info) )
			{
				m_questItem.AddItem(Info);
				Index = UnknownFunction147(m_questItem.GetItemNum(),1);
				if ( UnknownFunction151(Index,0) )
				{
					m_questItem.SwapItems(UnknownFunction147(Index,1),Index);
					UnknownFunction164(Index);
					goto JL008B;
				}
			} else {
				m_invenItem.AddItem(Info);
				Index = UnknownFunction147(m_invenItem.GetItemNum(),1);
				if ( UnknownFunction151(Index,0) )
				{
					m_invenItem.SwapItems(UnknownFunction147(Index,1),Index);
					UnknownFunction164(Index);
					goto JL00EB;
				}
			}
		}
	} else {
		if ( UnknownFunction122(L2jBRVar5,"update") )
		{
			if ( IsEquipItem(Info) )
			{
				if ( EquipItemFind(Info.ServerID) )
				{
					EquipItemUpdate(Info);
				} else {
					Index = m_invenItem.FindItemWithServerID(Info.ServerID);
					if ( UnknownFunction155(Index,-1) )
					{
						m_invenItem.DeleteItem(Index);
					}
					EquipItemUpdate(Info);
				}
			} else {
				if ( IsQuestItem(Info) )
				{
					Index = m_questItem.FindItemWithServerID(Info.ServerID);
					if ( UnknownFunction155(Index,-1) )
					{
						m_questItem.SetItem(Index,Info);
					} else {
						EquipItemDelete(Info.ServerID);
						m_questItem.AddItem(Info);
					}
				} else {
					Index = m_invenItem.FindItemWithServerID(Info.ServerID);
					if ( UnknownFunction155(Index,-1) )
					{
						m_invenItem.SetItem(Index,Info);
					} else {
						EquipItemDelete(Info.ServerID);
						m_invenItem.AddItem(Info);
						Index = UnknownFunction147(m_invenItem.GetItemNum(),1);
						if ( UnknownFunction151(Index,0) )
						{
							m_invenItem.SwapItems(UnknownFunction147(Index,1),Index);
							UnknownFunction164(Index);
							goto JL02B5;
						}
					}
				}
			}
		} else {
			if ( UnknownFunction122(L2jBRVar5,"delete") )
			{
				if ( IsEquipItem(Info) )
				{
					EquipItemDelete(Info.ServerID);
				} else {
					if ( IsQuestItem(Info) )
					{
						Index = m_questItem.FindItemWithServerID(Info.ServerID);
						m_questItem.DeleteItem(Index);
					} else {
						Index = m_invenItem.FindItemWithServerID(Info.ServerID);
						m_invenItem.DeleteItem(Index);
					}
				}
			}
		}
	}
	SetAdenaText();
	L2jBRFunction42();
}

function HandleItemListEnd ()
{
	SetAdenaText();
	L2jBRFunction42();
	OrderItem();
}

function HandleAddHennaInfo (string L2jBRVar1)
{
	UpdateHennaInfo();
}

function HandleUpdateHennaInfo (string L2jBRVar1)
{
	UpdateHennaInfo();
}

function UpdateHennaInfo ()
{
	local int i;
	local int HennaInfoCount;
	local int HennaID;
	local int IsActive;
	local ItemInfo HennaItemInfo;
	local UserInfo PlayerInfo;
	local int ClassStep;

	if ( GetPlayerInfo(PlayerInfo) )
	{
		ClassStep = GetClassStep(PlayerInfo.nSubClass);
		switch (ClassStep)
		{
			case 1:
			case 2:
			case 3:
			m_hHennaItemWindow.SetRow(ClassStep);
			break;
			default:
		}
		m_hHennaItemWindow.SetRow(0);
	} else {
	}
	m_hHennaItemWindow.Clear();
	HennaInfoCount = Class'HennaAPI'.GetHennaInfoCount();
	if ( UnknownFunction151(HennaInfoCount,ClassStep) )
	{
		HennaInfoCount = ClassStep;
	}
	i = 0;
	if ( UnknownFunction150(i,HennaInfoCount) )
	{
		if ( Class'HennaAPI'.GetHennaInfo(i,HennaID,IsActive) )
		{
			if ( UnknownFunction129(Class'UIDATA_HENNA'.GetItemName(HennaID,HennaItemInfo.Name)) )
			{
				goto JL0193;
			}
			if ( UnknownFunction129(Class'UIDATA_HENNA'.GetDescription(HennaID,HennaItemInfo.Description)) )
			{
				goto JL0193;
			}
			if ( UnknownFunction129(Class'UIDATA_HENNA'.GetIconTex(HennaID,HennaItemInfo.IconName)) )
			{
				goto JL0193;
			}
			if ( UnknownFunction154(0,IsActive) )
			{
				HennaItemInfo.bDisabled = True;
			} else {
				HennaItemInfo.bDisabled = False;
			}
			m_hHennaItemWindow.AddItem(HennaItemInfo);
		}
		UnknownFunction163(i);
		goto JL00AB;
	}
}

function SetAdenaText ()
{
	local string L2jBRVar14;

	L2jBRVar14 = MakeCostString(string(GetAdena()));
	L2jBRVar143.SetText(L2jBRVar14);
	L2jBRVar143.SetTooltipString(ConvertNumToText(string(GetAdena())));
}

function UseItem (ItemWindowHandle a_hItemWindow, int Index)
{
	local ItemInfo Info;

	if ( a_hItemWindow.GetItem(Index,Info) )
	{
		if ( Info.bRecipe )
		{
			DialogSetReservedInt(Info.ServerID);
			DialogSetID(1111);
			DialogShow(4,GetSystemMessage(798));
		} else {
			if ( UnknownFunction151(Info.PopMsgNum,0) )
			{
				DialogSetID(2222);
				DialogSetReservedInt(Info.ServerID);
				DialogShow(4,GetSystemMessage(Info.PopMsgNum));
			} else {
				RequestUseItem(Info.ServerID);
			}
		}
	}
}

function SaveItemOrder ()
{
	local ItemInfo Info;
	local int i;

	m_itemOrder.Length = m_invenItem.GetItemNum();
	i = 0;
	if ( UnknownFunction150(i,m_itemOrder.Length) )
	{
		m_invenItem.GetItem(i,Info);
		m_itemOrder[i] = Info.ClassID;
		UnknownFunction163(i);
		goto JL001D;
	}
	SaveInventoryOrder(m_itemOrder);
}

function LoadItemOrder ()
{
	LoadInventoryOrder(m_itemOrder);
}

function OrderItem ()
{
	local int newItemIndex;
	local int ItemNum;
	local int itemIndex;
	local int orderIndex;
	local ItemInfo Info;
	local bool matched;

	newItemIndex = 0;
	ItemNum = m_invenItem.GetItemNum();
	itemIndex = 0;
	if ( UnknownFunction150(itemIndex,ItemNum) )
	{
		m_invenItem.GetItem(itemIndex,Info);
		matched = False;
		orderIndex = 0;
		if ( UnknownFunction150(orderIndex,m_itemOrder.Length) )
		{
			if ( UnknownFunction154(Info.ClassID,m_itemOrder[orderIndex]) )
			{
				matched = True;
			} else {
				UnknownFunction163(orderIndex);
				goto JL005A;
			}
		}
		if ( UnknownFunction129(matched) )
		{
			m_invenItem.SwapItems(itemIndex,newItemIndex);
			UnknownFunction163(newItemIndex);
		}
		UnknownFunction163(itemIndex);
		goto JL0023;
	}
	orderIndex = 0;
	if ( UnknownFunction150(orderIndex,m_itemOrder.Length) )
	{
		itemIndex = 0;
		if ( UnknownFunction150(itemIndex,ItemNum) )
		{
			m_invenItem.GetItem(itemIndex,Info);
			if ( UnknownFunction154(Info.ClassID,m_itemOrder[orderIndex]) )
			{
				m_invenItem.SwapItems(itemIndex,newItemIndex);
				UnknownFunction163(newItemIndex);
			} else {
				UnknownFunction163(itemIndex);
				goto JL00EC;
			}
		}
		UnknownFunction163(orderIndex);
		goto JL00D5;
	}
}

function int GetMyInventoryLimit ()
{
	return Class'UIDATA_PLAYER'.GetInventoryLimit();
}

function L2jBRFunction42 ()
{
	local int L2jBRVar148;
	local int L2jBRVar15_;
	local TextBoxHandle L2jBRVar38;

	L2jBRVar15_ = UnknownFunction146(UnknownFunction146(m_invenItem.GetItemNum(),m_questItem.GetItemNum()),EquipItemGetItemNum());
	L2jBRVar148 = GetMyInventoryLimit();
	L2jBRVar38 = TextBoxHandle(GetHandle(UnknownFunction112(L2jBRVar13,".ItemCount")));
	L2jBRVar38.SetText(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("(",string(L2jBRVar15_)),"/"),string(L2jBRVar148)),")"));
}

function HandleDialogOK ()
{
	local int Id;
	local int Reserved;
	local int reserved2;
	local int L2jBRVar40;

	if ( DialogIsMine() )
	{
		Id = DialogGetID();
		Reserved = DialogGetReservedInt();
		reserved2 = DialogGetReservedInt2();
		L2jBRVar40 = int(DialogGetString());
		if ( UnknownFunction132(UnknownFunction154(Id,1111),UnknownFunction154(Id,2222)) )
		{
			RequestUseItem(Reserved);
		} else {
			if ( UnknownFunction154(Id,3333) )
			{
				RequestDropItem(Reserved,1,m_clickLocation);
			} else {
				if ( UnknownFunction154(Id,4444) )
				{
					if ( UnknownFunction154(L2jBRVar40,0) )
					{
						L2jBRVar40 = 1;
					}
					RequestDropItem(Reserved,L2jBRVar40,m_clickLocation);
				} else {
					if ( UnknownFunction154(Id,5555) )
					{
						RequestDropItem(Reserved,reserved2,m_clickLocation);
					} else {
						if ( UnknownFunction154(Id,6666) )
						{
							RequestDestroyItem(Reserved,1);
							PlayConsoleSound(4);
						} else {
							if ( UnknownFunction154(Id,8888) )
							{
								RequestDestroyItem(Reserved,L2jBRVar40);
								PlayConsoleSound(4);
							} else {
								if ( UnknownFunction154(Id,7777) )
								{
									RequestDestroyItem(Reserved,reserved2);
									PlayConsoleSound(4);
								} else {
									if ( UnknownFunction154(Id,9999) )
									{
										RequestCrystallizeItem(Reserved,1);
										PlayConsoleSound(4);
									} else {
										if ( UnknownFunction154(Id,10000) )
										{
											Class'PetAPI'.RequestGetItemFromPet(Reserved,L2jBRVar40,False);
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

function HandleUpdateUserInfo ()
{
	if ( m_hOwnerWnd.IsShowWindow() )
	{
		EarItemUpdate();
		FingerItemUpdate();
	}
}

function HandleToggleWindow ()
{
	if ( m_hOwnerWnd.IsShowWindow() )
	{
		m_hOwnerWnd.HideWindow();
		PlayConsoleSound(14);
	} else {
		if ( IsShowInventoryWndUponEvent() )
		{
			RequestItemList();
			m_hOwnerWnd.ShowWindow();
			PlayConsoleSound(13);
		}
	}
}

function bool IsShowInventoryWndUponEvent ()
{
	local WindowHandle m_warehouseWnd;
	local WindowHandle m_privateShopWnd;
	local WindowHandle m_tradeWnd;
	local WindowHandle m_shopWnd;
	local WindowHandle m_multiSellWnd;
	local WindowHandle m_deliverWnd;
	local PrivateShopWnd m_scriptPrivateShopWnd;

	m_warehouseWnd = GetHandle("WarehouseWnd");
	m_privateShopWnd = GetHandle("PrivateShopWnd");
	m_tradeWnd = GetHandle("TradeWnd");
	m_shopWnd = GetHandle("ShopWnd");
	m_multiSellWnd = GetHandle("MultiSellWnd");
	m_deliverWnd = GetHandle("DeliverWnd");
	m_scriptPrivateShopWnd = PrivateShopWnd(GetScript("PrivateShopWnd"));
	if ( m_warehouseWnd.IsShowWindow() )
	{
		return False;
	}
	if ( m_warehouseWnd.IsShowWindow() )
	{
		return False;
	}
	if ( m_tradeWnd.IsShowWindow() )
	{
		return False;
	}
	if ( m_shopWnd.IsShowWindow() )
	{
		return False;
	}
	if ( m_multiSellWnd.IsShowWindow() )
	{
		return False;
	}
	if ( m_deliverWnd.IsShowWindow() )
	{
		return False;
	}
	if ( UnknownFunction130(m_privateShopWnd.IsShowWindow(),UnknownFunction154(m_scriptPrivateShopWnd.m_type,2)) )
	{
		return False;
	}
	return True;
}

function int IsLOrREar (int a_ServerID)
{
	local int LEar;
	local int REar;
	local int LFinger;
	local int RFinger;

	GetAccessoryServerID(LEar,REar,LFinger,RFinger);
	if ( UnknownFunction154(a_ServerID,LEar) )
	{
		return -1;
	} else {
		if ( UnknownFunction154(a_ServerID,REar) )
		{
			return 1;
		} else {
			return 0;
		}
	}
}

function int IsLOrRFinger (int a_ServerID)
{
	local int LEar;
	local int REar;
	local int LFinger;
	local int RFinger;

	GetAccessoryServerID(LEar,REar,LFinger,RFinger);
	if ( UnknownFunction154(a_ServerID,LFinger) )
	{
		return -1;
	} else {
		if ( UnknownFunction154(a_ServerID,RFinger) )
		{
			return 1;
		} else {
			return 0;
		}
	}
}

function bool IsBowOrFishingRod (ItemInfo a_Info)
{
	if ( UnknownFunction132(UnknownFunction154(6,a_Info.WeaponType),UnknownFunction154(10,a_Info.WeaponType)) )
	{
		return True;
	}
	return False;
}

function bool IsArrow (ItemInfo a_Info)
{
	return a_Info.bArrow;
}

function CustomTooltip L2jBRFunction29 (string Text)
{
	local CustomTooltip ToolTip;
	local DrawItemInfo Info;

	ToolTip.DrawList.Length = 1;
	Info.eType = 1;
	Info.t_strText = Text;
	ToolTip.DrawList[0] = Info;
	return ToolTip;
}

function SetFocus ()
{
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.ItemCount");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_Underwear");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_Head");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_Hair");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_Hair2");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_Neck");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_RHand");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_Chest");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_LHand");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_REar");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_LEar");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_Gloves");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_Legs");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_Feet");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_RFinger");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.EquipItem_LFinger");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.HennaItem");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.InventoryItem");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.QuestItem");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.InventoryTab");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.CrystallizeButton");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.TrashButton");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.AdenaText");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.AdenaIcon");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.InvenWeight");
	Class'UIAPI_WINDOW'.SetFocus("InventoryWnd.BtnClose");
}

defaultproperties
{
    L2jBRVar13="InventoryWnd"

}
