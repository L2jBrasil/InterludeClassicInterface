//================================================================================
// RefineryWnd.
//================================================================================

class RefineryWnd extends UICommonAPI;

var bool procedure1stat;
var bool procedure2stat;
var bool procedure3stat;
var bool procedure4stat;
var ItemInfo RefineItemInfo;
var ItemInfo RefinerItemInfo;
var ItemInfo GemstoneItemInfo;
var ItemInfo RefinedITemInfo;
var WindowHandle m_RefineryWnd_Main;
var WindowHandle m_RefineResultBackPattern;
var WindowHandle m_Highlight1;
var WindowHandle m_Highlight2;
var WindowHandle m_Highlight3;
var WindowHandle m_SeletedItemHighlight1;
var WindowHandle m_SeletedItemHighlight2;
var WindowHandle m_SeletedItemHighlight3;
var WindowHandle m_DragBox1;
var WindowHandle m_DragBox2;
var WindowHandle m_DragBox3;
var WindowHandle m_DragBoxResult;
var WindowHandle m_RefineAnimation;
var WindowHandle m_ResultAnimation1;
var WindowHandle m_ResultAnimation2;
var WindowHandle m_ResultAnimation3;
var AnimTextureHandle m_RefineAnim;
var AnimTextureHandle m_ResultAnim1;
var AnimTextureHandle m_ResultAnim2;
var AnimTextureHandle m_ResultAnim3;
var ButtonHandle m_OkBtn;
var ButtonHandle m_RefineryBtn;
var ItemWindowHandle m_DragboxItem1;
var ItemWindowHandle m_DragBoxItem2;
var ItemWindowHandle m_DragBoxItem3;
var ItemWindowHandle m_ResultBoxItem;
var TextBoxHandle m_InstructionText;
var TextBoxHandle m_hGemstoneNameTextBox;
var TextBoxHandle m_hGemstoneCountTextBox;
var int m_TargetItemServerID;
var int m_RefineItemServerID;
var int m_GemStoneServerID;
var int m_GemStoneClassID;
var int m_NecessaryGemstoneCount;
var int m_GemstoneCount;
var string m_GemstoneName;
var InventoryWnd InventoryWndScript;
const C_ANIMLOOPCOUNT3= 1;
const C_ANIMLOOPCOUNT2= 1;
const C_ANIMLOOPCOUNT1= 1;
const C_ANIMLOOPCOUNT= 1;
const DIALOGID_GemstoneCount= 0;

function OnLoad ()
{
	RegisterEvent(2760);
	RegisterEvent(2770);
	RegisterEvent(2780);
	RegisterEvent(2790);
	RegisterEvent(2800);
	RegisterEvent(1710);
	procedure1stat = False;
	procedure2stat = False;
	procedure3stat = False;
	procedure4stat = False;
	m_RefineryWnd_Main = GetHandle("RefineryWnd");
	m_RefineResultBackPattern = GetHandle("RefineryWnd.BackPattern");
	m_Highlight1 = GetHandle("RefineryWnd.ItemDragBox1Wnd.DropHighlight");
	m_Highlight2 = GetHandle("RefineryWnd.ItemDragBox2Wnd.DropHighlight");
	m_Highlight3 = GetHandle("RefineryWnd.ItemDragBox3Wnd.DropHighlight");
	m_SeletedItemHighlight1 = GetHandle("RefineryWnd.ItemDragBox1Wnd.SelectedItemHighlight");
	m_SeletedItemHighlight2 = GetHandle("RefineryWnd.ItemDragBox2Wnd.SelectedItemHighlight");
	m_SeletedItemHighlight3 = GetHandle("RefineryWnd.ItemDragBox3Wnd.SelectedItemHighlight");
	m_DragBox1 = GetHandle("RefineryWnd.ItemDragBox1Wnd");
	m_DragBox2 = GetHandle("RefineryWnd.ItemDragBox2Wnd");
	m_DragBox3 = GetHandle("RefineryWnd.ItemDragBox3Wnd");
	m_DragBoxResult = GetHandle("RefineryWnd.ItemDragBoxResultWnd");
	m_RefineAnimation = GetHandle("RefineryWnd.RefineLoadingAnimation");
	m_ResultAnimation1 = GetHandle("RefineryWnd.RefineResultAnimation01");
	m_ResultAnimation2 = GetHandle("RefineryWnd.RefineResultAnimation02");
	m_ResultAnimation3 = GetHandle("RefineryWnd.RefineResultAnimation03");
	m_RefineAnim = AnimTextureHandle(GetHandle("RefineryWnd.RefineLoadingAnimation.RefineLoadingAnim"));
	m_ResultAnim1 = AnimTextureHandle(GetHandle("RefineryWnd.RefineResultAnimation01.RefineResult1"));
	m_ResultAnim2 = AnimTextureHandle(GetHandle("RefineryWnd.RefineResultAnimation02.RefineResult2"));
	m_ResultAnim3 = AnimTextureHandle(GetHandle("RefineryWnd.RefineResultAnimation03.RefineResult3"));
	m_DragboxItem1 = ItemWindowHandle(GetHandle("RefineryWnd.ItemDragBox1Wnd.ItemDragBox1"));
	m_DragBoxItem2 = ItemWindowHandle(GetHandle("RefineryWnd.ItemDragBox2Wnd.ItemDragBox2"));
	m_DragBoxItem3 = ItemWindowHandle(GetHandle("RefineryWnd.ItemDragBox3Wnd.ItemDragBox3"));
	m_ResultBoxItem = ItemWindowHandle(GetHandle("RefineryWnd.ItemDragBoxResultWnd.ItemRefined"));
	m_RefineryBtn = ButtonHandle(GetHandle("RefineryWnd.btnRefine"));
	m_OkBtn = ButtonHandle(GetHandle("RefineryWnd.btnClose"));
	m_InstructionText = TextBoxHandle(GetHandle("RefineryWnd.txtInstruction"));
	m_hGemstoneNameTextBox = TextBoxHandle(GetHandle("txtGemstoneName"));
	m_hGemstoneCountTextBox = TextBoxHandle(GetHandle("txtGemstoneCount"));
	m_RefineAnim.SetLoopCount(1);
	m_ResultAnim1.SetLoopCount(1);
	m_ResultAnim2.SetLoopCount(1);
	m_ResultAnim3.SetLoopCount(1);
	Class'UIAPI_PROGRESSCTRL'.SetProgressTime("RefineryWnd.RefineryProgress",1900);
	InventoryWndScript = InventoryWnd(GetScript("InventoryWnd"));
}

function OnShow ()
{
	ResetReady();
	InventoryWndScript.
	L2jBRFunction6();
}

function ResetReady ()
{
	procedure1stat = False;
	procedure2stat = False;
	procedure3stat = False;
	procedure4stat = False;
	m_GemstoneName = "";
	m_RefineryWnd_Main.ShowWindow();
	m_RefineResultBackPattern.HideWindow();
	m_Highlight1.ShowWindow();
	m_Highlight2.HideWindow();
	m_Highlight3.HideWindow();
	m_SeletedItemHighlight1.HideWindow();
	m_SeletedItemHighlight2.HideWindow();
	m_SeletedItemHighlight3.HideWindow();
	m_DragBox1.ShowWindow();
	m_DragBox2.ShowWindow();
	m_DragBox3.ShowWindow();
	m_DragBoxResult.HideWindow();
	m_RefineAnimation.HideWindow();
	m_ResultAnimation1.HideWindow();
	m_ResultAnimation2.HideWindow();
	m_ResultAnimation3.HideWindow();
	m_RefineAnim.Stop();
	m_ResultAnim1.Stop();
	m_ResultAnim2.Stop();
	m_ResultAnim3.Stop();
	m_InstructionText.SetText(GetSystemMessage(1957));
	m_hGemstoneNameTextBox.SetText("");
	m_hGemstoneCountTextBox.SetText("");
	m_hGemstoneCountTextBox.SetTooltipString("");
	m_DragboxItem1.Clear();
	m_DragBoxItem2.Clear();
	m_DragBoxItem3.Clear();
	m_RefineryBtn.DisableWindow();
	Class'UIAPI_PROGRESSCTRL'.Reset("RefineryWnd.RefineryProgress");
	MoveItemBoxes(True);
	m_DragboxItem1.EnableWindow();
	m_DragBoxItem2.DisableWindow();
	m_DragBoxItem3.DisableWindow();
	PlaySound("ItemSound2.smelting.Smelting_dragin");
	m_OkBtn.EnableWindow();
}

function OnRefineryConfirmTargetItemResult ()
{
	m_RefineResultBackPattern.HideWindow();
	m_Highlight1.HideWindow();
	m_Highlight2.ShowWindow();
	m_Highlight3.HideWindow();
	m_SeletedItemHighlight1.ShowWindow();
	m_SeletedItemHighlight2.HideWindow();
	m_SeletedItemHighlight3.HideWindow();
	m_DragBox1.ShowWindow();
	m_DragBox2.ShowWindow();
	m_DragBox3.ShowWindow();
	m_DragBoxResult.HideWindow();
	m_RefineAnimation.HideWindow();
	m_ResultAnimation1.HideWindow();
	m_ResultAnimation2.HideWindow();
	m_ResultAnimation3.HideWindow();
	procedure1stat = True;
	procedure2stat = False;
	procedure3stat = False;
	procedure4stat = False;
	m_InstructionText.SetText(GetSystemMessage(1958));
	m_hGemstoneNameTextBox.SetText("");
	m_hGemstoneCountTextBox.SetText("");
	m_hGemstoneCountTextBox.SetTooltipString("");
	m_DragboxItem1.EnableWindow();
	m_DragBoxItem2.EnableWindow();
	m_DragBoxItem3.DisableWindow();
	m_RefineryBtn.DisableWindow();
}

function OnRefineryConfirmRefinerItemResult ()
{
	local string GemstoneName;
	local string Instruction;

	m_RefineResultBackPattern.HideWindow();
	m_Highlight1.HideWindow();
	m_Highlight2.HideWindow();
	m_Highlight3.ShowWindow();
	m_SeletedItemHighlight1.ShowWindow();
	m_SeletedItemHighlight2.ShowWindow();
	m_SeletedItemHighlight3.HideWindow();
	m_DragBox1.ShowWindow();
	m_DragBox2.ShowWindow();
	m_DragBox3.ShowWindow();
	m_DragBoxResult.HideWindow();
	m_RefineAnimation.HideWindow();
	m_ResultAnimation1.HideWindow();
	m_ResultAnimation2.HideWindow();
	m_ResultAnimation3.HideWindow();
	procedure1stat = True;
	procedure2stat = True;
	procedure3stat = False;
	procedure4stat = False;
	GemstoneName = Class'UIDATA_ITEM'.GetItemName(m_GemStoneClassID);
	m_GemstoneName = GemstoneName;
	Instruction = MakeFullSystemMsg(GetSystemMessage(1959),GemstoneName,string(m_NecessaryGemstoneCount));
	m_InstructionText.SetText(Instruction);
	m_hGemstoneNameTextBox.SetText(GemstoneName);
	m_hGemstoneCountTextBox.SetText(MakeCostString(string(m_NecessaryGemstoneCount)));
	m_hGemstoneCountTextBox.SetTooltipString(ConvertNumToTextNoAdena(string(m_NecessaryGemstoneCount)));
	m_DragboxItem1.EnableWindow();
	m_DragBoxItem2.EnableWindow();
	m_DragBoxItem3.EnableWindow();
	m_RefineryBtn.DisableWindow();
}

function OnRefineryConfirmGemStoneResult ()
{
	m_RefineResultBackPattern.HideWindow();
	m_Highlight1.HideWindow();
	m_Highlight2.HideWindow();
	m_Highlight3.HideWindow();
	m_SeletedItemHighlight1.ShowWindow();
	m_SeletedItemHighlight2.ShowWindow();
	m_SeletedItemHighlight3.ShowWindow();
	m_DragBox1.ShowWindow();
	m_DragBox2.ShowWindow();
	m_DragBox3.ShowWindow();
	m_DragBoxResult.HideWindow();
	m_RefineAnimation.HideWindow();
	m_ResultAnimation1.HideWindow();
	m_ResultAnimation2.HideWindow();
	m_ResultAnimation3.HideWindow();
	procedure1stat = True;
	procedure2stat = True;
	procedure3stat = True;
	procedure4stat = False;
	m_InstructionText.SetText(GetSystemMessage(1984));
	m_hGemstoneNameTextBox.SetText("");
	m_hGemstoneCountTextBox.SetText("");
	m_hGemstoneCountTextBox.SetTooltipString("");
	m_RefineryBtn.EnableWindow();
	m_hGemstoneCountTextBox.SetTooltipString("");
}

function OnRefineryRefineResult ()
{
	m_RefineResultBackPattern.HideWindow();
	m_Highlight1.HideWindow();
	m_Highlight2.HideWindow();
	m_Highlight3.HideWindow();
	m_DragBox1.HideWindow();
	m_DragBox2.HideWindow();
	m_DragBox3.HideWindow();
	MoveItemBoxes(True);
	m_DragBoxResult.ShowWindow();
	m_RefineAnimation.HideWindow();
	m_ResultAnimation1.HideWindow();
	m_ResultAnimation2.HideWindow();
	m_ResultAnimation3.HideWindow();
	procedure1stat = True;
	procedure2stat = True;
	procedure3stat = True;
	procedure4stat = True;
	m_InstructionText.SetText(GetSystemMessage(1962));
	m_hGemstoneNameTextBox.SetText("");
	m_hGemstoneCountTextBox.SetText("");
	m_hGemstoneCountTextBox.SetTooltipString("");
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2760:
		if ( UnknownFunction242(procedure1stat,False) )
		{
			ShowRefineryInterface();
		}
		break;
		case 2770:
		PlaySound("ItemSound2.smelting.Smelting_dragin");
		OnTargetItemValidationResult(_L2jBRVar17_);
		break;
		case 2780:
		PlaySound("ItemSound2.smelting.Smelting_dragin");
		OnRefinerItemValidationResult(_L2jBRVar17_);
		break;
		case 2790:
		PlaySound("ItemSound2.smelting.Smelting_dragin");
		OnGemstoneValidationResult(_L2jBRVar17_);
		break;
		case 2800:
		OnRefineDoneResult(_L2jBRVar17_);
		break;
		case 1710:
		HandleDialogOK();
		break;
		default:
		break;
	}
}

function ShowRefineryInterface ()
{
	ResetReady();
}

function OnDropItem (string L2jBRVar18, ItemInfo L2jBRVar19, int X, int Y)
{
	switch (L2jBRVar18)
	{
		case "ItemDragBox1":
		Debug(UnknownFunction168(UnknownFunction168(UnknownFunction168("드래그 박스 1에 아이템 올려 놓았음.",string(procedure1stat)),string(procedure2stat)),string(procedure3stat)));
		if ( UnknownFunction130(UnknownFunction130(UnknownFunction242(procedure1stat,False),UnknownFunction242(procedure2stat,False)),UnknownFunction242(procedure3stat,False)) )
		{
			ValidateFirstItem(L2jBRVar19);
		}
		break;
		case "ItemDragBox2":
		Debug(UnknownFunction168(UnknownFunction168(UnknownFunction168("드래그 박스 2에 아이템 올려 놓았음.",string(procedure1stat)),string(procedure2stat)),string(procedure3stat)));
		if ( UnknownFunction130(UnknownFunction130(UnknownFunction242(procedure1stat,True),UnknownFunction242(procedure2stat,False)),UnknownFunction242(procedure3stat,False)) )
		{
			ValidateSecondItem(L2jBRVar19);
		}
		break;
		case "ItemDragBox3":
		Debug(UnknownFunction168(UnknownFunction168(UnknownFunction168("드래그 박스 3에 아이템 올려 놓았음.",string(procedure1stat)),string(procedure2stat)),string(procedure3stat)));
		if ( UnknownFunction130(UnknownFunction130(UnknownFunction242(procedure1stat,True),UnknownFunction242(procedure2stat,True)),UnknownFunction242(procedure3stat,False)) )
		{
			ValidateGemstoneItem(L2jBRVar19);
		}
		break;
		default:
	}
}

function ValidateFirstItem (ItemInfo L2jBRVar19)
{
	RefineItemInfo = L2jBRVar19;
	m_TargetItemServerID = L2jBRVar19.ServerID;
	Class'RefineryAPI'.ConfirmTargetItem(m_TargetItemServerID);
}

function OnTargetItemValidationResult (string _L2jBRVar17_)
{
	local int Item1ServerID;
	local int Item1ClassID;
	local int ItemValidationResult1;

	ParseInt(_L2jBRVar17_,"TargetItemServerID",Item1ServerID);
	ParseInt(_L2jBRVar17_,"TargetItemClassID",Item1ClassID);
	ParseInt(_L2jBRVar17_,"Result",ItemValidationResult1);
	switch (ItemValidationResult1)
	{
		case 1:
		if ( UnknownFunction154(Item1ServerID,RefineItemInfo.ServerID) )
		{
			if ( UnknownFunction129(m_DragboxItem1.SetItem(0,RefineItemInfo)) )
			{
				m_DragboxItem1.AddItem(RefineItemInfo);
			}
			OnRefineryConfirmTargetItemResult();
		}
		break;
		case 0:
		break;
		default:
	}
}

function ValidateSecondItem (ItemInfo L2jBRVar19)
{
	RefinerItemInfo = L2jBRVar19;
	m_RefineItemServerID = L2jBRVar19.ServerID;
	Class'RefineryAPI'.ConfirmRefinerItem(m_TargetItemServerID,m_RefineItemServerID);
}

function OnRefinerItemValidationResult (string _L2jBRVar17_)
{
	local int Item2ServerID;
	local int Item2ClassID;
	local int ItemValidationResult2;
	local int RequiredGemstoneAmount;
	local int RequiredGemstoneClassID;

	Debug("두번째 이벤트 받음:제련제");
	ParseInt(_L2jBRVar17_,"RefinerItemServerID",Item2ServerID);
	ParseInt(_L2jBRVar17_,"RefinerItemClassID",Item2ClassID);
	ParseInt(_L2jBRVar17_,"Result",ItemValidationResult2);
	ParseInt(_L2jBRVar17_,"GemStoneCount",RequiredGemstoneAmount);
	ParseInt(_L2jBRVar17_,"GemStoneClassID",RequiredGemstoneClassID);
	m_GemStoneClassID = RequiredGemstoneClassID;
	m_NecessaryGemstoneCount = RequiredGemstoneAmount;
	switch (ItemValidationResult2)
	{
		case 1:
		if ( UnknownFunction154(Item2ServerID,RefinerItemInfo.ServerID) )
		{
			if ( UnknownFunction129(m_DragBoxItem2.SetItem(0,RefinerItemInfo)) )
			{
				m_DragBoxItem2.AddItem(RefinerItemInfo);
			}
			OnRefineryConfirmRefinerItemResult();
		}
		break;
		case 0:
		break;
		default:
	}
}

function ValidateGemstoneItem (ItemInfo L2jBRVar19)
{
	GemstoneItemInfo = L2jBRVar19;
	m_GemStoneServerID = L2jBRVar19.ServerID;
	if ( UnknownFunction151(L2jBRVar19.AllItemCount,0) )
	{
		m_GemstoneCount = L2jBRVar19.AllItemCount;
		Class'RefineryAPI'.ConfirmGemStone(m_TargetItemServerID,m_RefineItemServerID,m_GemStoneServerID,m_GemstoneCount);
	} else {
		DialogSetID(0);
		DialogSetParamInt(L2jBRVar19.ItemNum);
		DialogShow(6,MakeFullSystemMsg(GetSystemMessage(72),L2jBRVar19.Name,""));
	}
}

function OnGemstoneValidationResult (string _L2jBRVar17_)
{
	local int Item3ServerID;
	local int Item3ClassID;
	local int ItemValidationResult3;
	local int RequiredMoreGemstoneAmount;
	local int GemstoneAmountChecked;

	Debug("세번째 이벤트 받음:젬스톤");
	ParseInt(_L2jBRVar17_,"GemStoneServerID",Item3ServerID);
	ParseInt(_L2jBRVar17_,"GemStoneClassID",Item3ClassID);
	ParseInt(_L2jBRVar17_,"Result",ItemValidationResult3);
	ParseInt(_L2jBRVar17_,"NecessaryGemStoneCount",RequiredMoreGemstoneAmount);
	ParseInt(_L2jBRVar17_,"GemStoneCount",GemstoneAmountChecked);
	m_GemStoneClassID = Item3ClassID;
	m_NecessaryGemstoneCount = GemstoneAmountChecked;
	switch (ItemValidationResult3)
	{
		case 1:
		if ( UnknownFunction154(Item3ServerID,GemstoneItemInfo.ServerID) )
		{
			if ( UnknownFunction129(m_DragBoxItem3.SetItem(0,GemstoneItemInfo)) )
			{
				GemstoneItemInfo.ItemNum = GemstoneAmountChecked;
				m_DragBoxItem3.AddItem(GemstoneItemInfo);
			}
			OnRefineryConfirmGemStoneResult();
		}
		break;
		case 0:
		break;
		default:
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnRefine":
		Debug("Button 눌렸음");
		PlaySound("Itemsound2.smelting.smelting_loding");
		OnClickRefineButton();
		break;
		case "btnClose":
		OnClickCancelButton();
		break;
		default:
	}
}

function OnClickCancelButton ()
{
	m_RefineryWnd_Main.HideWindow();
	PlaySound("Itemsound2.smelting.smelting_dragout");
	Class'UIAPI_PROGRESSCTRL'.Stop("RefineryWnd.RefineryProgress");
	m_RefineAnim.Stop();
	m_RefineAnim.SetLoopCount(1);
	procedure1stat = False;
	procedure2stat = False;
	procedure3stat = False;
	procedure4stat = False;
}

function OnClickRefineButton ()
{
	m_RefineResultBackPattern.HideWindow();
	m_Highlight1.HideWindow();
	m_Highlight2.HideWindow();
	m_Highlight3.HideWindow();
	m_DragBoxResult.HideWindow();
	m_RefineAnimation.ShowWindow();
	m_ResultAnimation1.HideWindow();
	m_ResultAnimation2.HideWindow();
	m_ResultAnimation3.HideWindow();
	m_RefineryBtn.DisableWindow();
	m_OkBtn.DisableWindow();
	procedure1stat = True;
	procedure2stat = True;
	procedure3stat = True;
	procedure4stat = True;
	PlayRefineAnimation();
	MoveItemBoxes(False);
}

function PlayRefineAnimation ()
{
	m_InstructionText.SetText("");
	m_RefineAnim.Stop();
	m_RefineAnim.SetLoopCount(1);
	m_RefineAnim.Play();
	Class'UIAPI_PROGRESSCTRL'.Start("RefineryWnd.RefineryProgress");
}

function OnTextureAnimEnd (AnimTextureHandle L2jBRVar20)
{
	switch (L2jBRVar20)
	{
		case m_RefineAnim:
		m_RefineAnimation.HideWindow();
		m_DragBox1.HideWindow();
		m_DragBox2.HideWindow();
		m_DragBox3.HideWindow();
		OnRefineRequest();
		break;
		case m_ResultAnim1:
		case m_ResultAnim2:
		case m_ResultAnim3:
		OnResultAnimEnd();
		break;
		default:
	}
}

function OnResultAnimEnd ()
{
	m_ResultAnimation1.HideWindow();
	m_ResultAnimation2.HideWindow();
	m_ResultAnimation3.HideWindow();
}

function OnRefineRequest ()
{
	Class'RefineryAPI'.RequestRefine(m_TargetItemServerID,m_RefineItemServerID,m_GemStoneServerID,m_NecessaryGemstoneCount);
}

function OnRefineDoneResult (string _L2jBRVar17_)
{
	local int Option1;
	local int Option2;
	local int RefineResult;
	local int Quality;

	Debug("제련완료: 결과 확인");
	ParseInt(_L2jBRVar17_,"Option1",Option1);
	ParseInt(_L2jBRVar17_,"Option2",Option2);
	ParseInt(_L2jBRVar17_,"Result",RefineResult);
	m_OkBtn.EnableWindow();
	switch (RefineResult)
	{
		case 1:
		RefineItemInfo.RefineryOp1 = Option1;
		RefineItemInfo.RefineryOp2 = Option2;
		if ( UnknownFunction129(m_ResultBoxItem.SetItem(0,RefineItemInfo)) )
		{
			m_ResultBoxItem.AddItem(RefineItemInfo);
		}
		OnRefineryRefineResult();
		Quality = Class'UIDATA_REFINERYOPTION'.GetQuality(Option2);
		if ( UnknownFunction153(0,Quality) )
		{
			Quality = 1;
		} else {
			if ( UnknownFunction150(4,Quality) )
			{
				Quality = 4;
			}
		}
		m_RefineResultBackPattern.ShowWindow();
		m_RefineResultBackPattern.SetAlpha(0);
		m_RefineResultBackPattern.SetAlpha(255,1.0);
		PlayResultAnimation(Quality);
		break;
		case 0:
		OnClickCancelButton();
		break;
		default:
	}
}

function HandleDialogOK ()
{
	local int Id;

	if ( DialogIsMine() )
	{
		Id = DialogGetID();
		switch (Id)
		{
			case 0:
			m_GemstoneCount = int(DialogGetString());
			Class'RefineryAPI'.ConfirmGemStone(m_TargetItemServerID,m_RefineItemServerID,m_GemStoneServerID,m_GemstoneCount);
			break;
			default:
		}
	}
}

function PlayResultAnimation (int grade)
{
	m_ResultAnim1.SetLoopCount(1);
	m_ResultAnim2.SetLoopCount(1);
	m_ResultAnim3.SetLoopCount(1);
	switch (grade)
	{
		case 1:
		m_ResultAnimation1.ShowWindow();
		PlaySound("ItemSound2.smelting.smelting_finalB");
		m_ResultAnim1.Play();
		break;
		case 2:
		m_ResultAnimation2.ShowWindow();
		PlaySound("ItemSound2.smelting.smelting_finalC");
		m_ResultAnim2.Play();
		break;
		case 3:
		m_ResultAnimation3.ShowWindow();
		PlaySound("ItemSound2.smelting.smelting_finalD");
		m_ResultAnim3.Play();
		break;
		case 4:
		m_ResultAnimation1.ShowWindow();
		m_ResultAnimation2.ShowWindow();
		m_ResultAnimation3.ShowWindow();
		PlaySound("ItemSound2.smelting.smelting_finalD");
		m_ResultAnim1.Play();
		m_ResultAnim2.Play();
		m_ResultAnim3.Play();
		break;
		default:
	}
}

function MoveItemBoxes (bool a_Origin)
{
	local Rect Item1Rect;
	local Rect Item2Rect;
	local Rect Item3Rect;
	local Rect ResultRect;

	if ( a_Origin )
	{
		m_DragBox1.SetAnchor("RefineryWnd","TopLeft","TopLeft",77,51);
		m_DragBox1.ClearAnchor();
		m_DragBox2.SetAnchor("RefineryWnd","TopLeft","TopLeft",157,51);
		m_DragBox2.ClearAnchor();
		m_DragBox3.SetAnchor("RefineryWnd","TopLeft","TopLeft",117,91);
		m_DragBox3.ClearAnchor();
	} else {
		Item1Rect = m_DragBox1.GetRect();
		Item2Rect = m_DragBox2.GetRect();
		Item3Rect = m_DragBox3.GetRect();
		ResultRect = m_DragBoxResult.GetRect();
		m_DragBox1.Move(UnknownFunction147(ResultRect.nX,Item1Rect.nX),UnknownFunction147(ResultRect.nY,Item1Rect.nY),1.5);
		m_DragBox2.Move(UnknownFunction147(ResultRect.nX,Item2Rect.nX),UnknownFunction147(ResultRect.nY,Item2Rect.nY),1.5);
		m_DragBox3.Move(UnknownFunction147(ResultRect.nX,Item3Rect.nX),UnknownFunction147(ResultRect.nY,Item3Rect.nY),1.5);
	}
}

