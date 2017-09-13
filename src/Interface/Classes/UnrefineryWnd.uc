//================================================================================
// UnrefineryWnd.
//================================================================================

class UnrefineryWnd extends UICommonAPI;

var WindowHandle m_UnRefineryWnd_Main;
var WindowHandle m_ItemtoUnRefineWnd;
var WindowHandle m_ItemtoUnRefineAnim;
var WindowHandle m_hSelectedItemHighlight;
var WindowHandle m_ResultAnimation1;
var AnimTextureHandle m_ResultAnim1;
var TextBoxHandle m_InstructionText;
var TextBoxHandle m_AdenaText;
var ButtonHandle m_hUnrefineButton;
var ButtonHandle m_OkBtn;
var ItemWindowHandle m_ItemDragBox;
var ItemInfo CurrentItem;
var bool procedure1stat;
var bool procedureopenstat;
var INT64 m_Adena;

function OnLoad ()
{
	RegisterEvent(2810);
	RegisterEvent(2820);
	RegisterEvent(2830);
	procedure1stat = False;
	procedureopenstat = False;
	m_ResultAnimation1 = GetHandle("UnrefineryWnd.RefineResultAnimation01");
	m_ResultAnim1 = AnimTextureHandle(GetHandle("UnrefineryWnd.RefineResultAnimation01.RefineResult1"));
	m_UnRefineryWnd_Main = GetHandle("UnrefineryWnd");
	m_ItemtoUnRefineWnd = GetHandle("Itemtounrefine");
	m_ItemtoUnRefineAnim = GetHandle("ItemtounrefineAnim");
	m_hSelectedItemHighlight = GetHandle("SelectedItemHighlight");
	m_ItemDragBox = ItemWindowHandle(GetHandle("UnRefineryWnd.Itemtounrefine.ItemUnrefine"));
	m_InstructionText = TextBoxHandle(GetHandle("UnrefineryWnd.txtInstruction"));
	m_AdenaText = TextBoxHandle(GetHandle("UnrefineryWnd.txtAdenaInstruction"));
	m_hUnrefineButton = ButtonHandle(GetHandle("btnUnRefine"));
	m_OkBtn = ButtonHandle(GetHandle("btnClose"));
	Class'UIAPI_PROGRESSCTRL'.SetProgressTime("UnrefineryWnd.UnRefineryProgress",2000);
}

function OnShow ()
{
	ResetReady();
}

function ResetReady ()
{
	procedure1stat = False;
	procedureopenstat = False;
	m_UnRefineryWnd_Main.ShowWindow();
	m_ItemtoUnRefineWnd.ShowWindow();
	m_ItemtoUnRefineAnim.ShowWindow();
	m_hSelectedItemHighlight.HideWindow();
	m_ResultAnimation1.HideWindow();
	m_ResultAnim1.Stop();
	m_hUnrefineButton.DisableWindow();
	m_ItemDragBox.Clear();
	m_InstructionText.SetText(GetSystemMessage(1963));
	SetAdenaText("0");
	m_AdenaText.SetTooltipString("");
	Class'UIAPI_PROGRESSCTRL'.SetProgressTime("UnrefineryWnd.UnRefineryProgress",2000);
	Class'UIAPI_PROGRESSCTRL'.Reset("UnrefineryWnd.UnRefineryProgress");
	PlaySound("ItemSound2.smelting.Smelting_dragin");
	m_OkBtn.EnableWindow();
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2810:
		if ( UnknownFunction242(procedureopenstat,False) )
		{
			PlaySound("ItemSound2.smelting.Smelting_dragin");
			ResetReady();
		}
		break;
		case 2820:
		PlaySound("ItemSound2.smelting.Smelting_dragin");
		OnTargetItemValidationResult(_L2jBRVar17_);
		break;
		case 2830:
		PlaySound("ItemSound2.smelting.smelting_finalA");
		OnUnRefineDoneResult(_L2jBRVar17_);
		break;
		default:
		break;
	}
}

function OnDropItem (string L2jBRVar18, ItemInfo L2jBRVar19, int X, int Y)
{
	switch (L2jBRVar18)
	{
		case "ItemUnrefine":
		if ( UnknownFunction242(procedure1stat,False) )
		{
			ValidateItem(L2jBRVar19);
		}
		break;
		default:
	}
}

function ValidateItem (ItemInfo L2jBRVar19)
{
	local int TargetItemServerID;

	CurrentItem = L2jBRVar19;
	TargetItemServerID = L2jBRVar19.ServerID;
	Class'RefineryAPI'.ConfirmCancelItem(TargetItemServerID);
}

function OnTargetItemValidationResult (string _L2jBRVar17_)
{
	local int ItemServerID;
	local int ItemClassID;
	local int Option1;
	local int Option2;
	local int ItemValidationResult;
	local string AdenaText;

	Debug("아이템 수락 결정");
	ParseInt(_L2jBRVar17_,"CancelItemServerID",ItemServerID);
	ParseInt(_L2jBRVar17_,"CancelItemClassID",ItemClassID);
	ParseInt(_L2jBRVar17_,"Option1",Option1);
	ParseInt(_L2jBRVar17_,"Option2",Option2);
	ParseInt64(_L2jBRVar17_,"Adena",m_Adena);
	ParseInt(_L2jBRVar17_,"Result",ItemValidationResult);
	switch (ItemValidationResult)
	{
		case 1:
		m_hUnrefineButton.EnableWindow();
		if ( UnknownFunction129(m_ItemDragBox.SetItem(0,CurrentItem)) )
		{
			m_ItemDragBox.AddItem(CurrentItem);
		}
		AdenaText = MakeCostStringInt64(m_Adena);
		SetAdenaText(AdenaText);
		m_ItemtoUnRefineAnim.HideWindow();
		m_hSelectedItemHighlight.ShowWindow();
		m_InstructionText.SetText("");
		procedureopenstat = True;
		if ( UnknownFunction242(CheckAdena(),False) )
		{
			m_hUnrefineButton.DisableWindow();
			m_InstructionText.SetText(GetSystemMessage(279));
		}
		break;
		case 0:
		break;
		default:
	}
}

function SetAdenaText (string a_AdenaText)
{
	local string AdenaText;

	AdenaText = ConvertNumToText(a_AdenaText);
	m_AdenaText.SetText(UnknownFunction168(a_AdenaText,GetSystemString(469)));
	m_AdenaText.SetTextColor(GetNumericColor(a_AdenaText));
	if ( UnknownFunction154(int(a_AdenaText),0) )
	{
		m_AdenaText.SetTooltipString("");
	} else {
		m_AdenaText.SetTooltipString(AdenaText);
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnUnRefine":
		OnClickUnRefineButton();
		break;
		case "btnClose":
		procedure1stat = False;
		procedureopenstat = False;
		PlaySound("Itemsound2.smelting.smelting_dragout");
		m_UnRefineryWnd_Main.HideWindow();
		break;
		default:
	}
}

function OnClickUnRefineButton ()
{
	local INT64 Diff;
	local INT64 CurAdena;

	CurAdena.nLeft = 0;
	CurAdena.nRight = GetAdena();
	Diff = Int64SubtractBfromA(CurAdena,m_Adena);
	if ( UnknownFunction132(UnknownFunction153(Diff.nLeft,0),UnknownFunction153(Diff.nRight,0)) )
	{
		m_hUnrefineButton.DisableWindow();
		m_ResultAnim1.SetLoopCount(1);
		m_ResultAnimation1.ShowWindow();
		PlaySound("ItemSound2.smelting.smelting_loding");
		m_ResultAnim1.Play();
		PlayProgressiveBar();
		m_OkBtn.DisableWindow();
	} else {
		DialogShow(1,GetSystemMessage(279));
	}
}

function bool CheckAdena ()
{
	local INT64 Diff;
	local INT64 CurAdena;

	CurAdena.nLeft = 0;
	CurAdena.nRight = GetAdena();
	Diff = Int64SubtractBfromA(CurAdena,m_Adena);
	if ( UnknownFunction132(UnknownFunction153(Diff.nLeft,0),UnknownFunction153(Diff.nRight,0)) )
	{
		return True;
	} else {
		return False;
	}
}

function PlayProgressiveBar ()
{
	Class'UIAPI_PROGRESSCTRL'.Start("UnrefineryWnd.UnRefineryProgress");
}

function OnProgressTimeUp (string aWindowID)
{
	switch (aWindowID)
	{
		case "UnRefineryProgress":
		OnUnRefineRequest();
		break;
		default:
	}
}

function OnTextureAnimEnd (AnimTextureHandle L2jBRVar20)
{
	switch (L2jBRVar20)
	{
		case m_ResultAnim1:
		m_ResultAnimation1.HideWindow();
		break;
		default:
	}
}

function OnUnRefineRequest ()
{
	Class'RefineryAPI'.RequestRefineCancel(CurrentItem.ServerID);
}

function OnUnRefineDoneResult (string _L2jBRVar17_)
{
	local int UnRefineResult;

	ParseInt(_L2jBRVar17_,"Result",UnRefineResult);
	m_OkBtn.EnableWindow();
	Debug("아이템 제련 해제 완료");
	switch (UnRefineResult)
	{
		case 1:
		CurrentItem.RefineryOp1 = 0;
		CurrentItem.RefineryOp2 = 0;
		if ( UnknownFunction129(m_ItemDragBox.SetItem(0,CurrentItem)) )
		{
			m_ItemDragBox.AddItem(CurrentItem);
		}
		m_InstructionText.SetText(MakeFullSystemMsg(GetSystemMessage(1965),CurrentItem.Name,""));
		m_hUnrefineButton.DisableWindow();
		procedure1stat = True;
		break;
		case 0:
		m_hUnrefineButton.EnableWindow();
		procedure1stat = False;
		m_UnRefineryWnd_Main.HideWindow();
		break;
		default:
	}
}

