//================================================================================
// GMQuestWnd.
//================================================================================

class GMQuestWnd extends QuestTreeWnd;

var bool bShow;

function OnLoad ()
{
	RegisterEvent(2320);
	RegisterEvent(2330);
	RegisterEvent(2340);
	RegisterEvent(2350);
	bShow = False;
}

function OnShow ()
{
	Class'UIAPI_WINDOW'.HideWindow("GMQuestWnd.InnerWnd.btnClose");
	Class'UIAPI_WINDOW'.HideWindow("GMQuestWnd.InnerWnd.chkNpcPosBox");
}

function ShowQuest (string _L2jBRVar17_)
{
	if ( UnknownFunction122(_L2jBRVar17_,"") )
	{
		return;
	}
	if ( bShow )
	{
		m_hOwnerWnd.HideWindow();
		bShow = False;
	} else {
		Class'GMAPI'.RequestGMCommand(4,_L2jBRVar17_);
		bShow = True;
	}
}

function OnClickButton (string strID)
{
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 2320:
		HandleGMObservingQuestListStart();
		break;
		case 2330:
		HandleGMObservingQuestList(_L2jBRVar17_);
		break;
		case 2340:
		HandleGMObservingQuestListEnd();
		break;
		case 2350:
		HandleGMObservingQuestItem(_L2jBRVar17_);
		break;
		default:
	}
}

function HandleGMObservingQuestListStart ()
{
	m_hOwnerWnd.ShowWindow();
	m_hOwnerWnd.SetFocus();
	HandleQuestListStart();
}

function HandleGMObservingQuestList (string _L2jBRVar17_)
{
	HandleQuestList(_L2jBRVar17_);
}

function HandleGMObservingQuestListEnd ()
{
	UpdateQuestCount();
	UpdateItemCount(0,-1);
}

function HandleGMObservingQuestItem (string _L2jBRVar17_)
{
	local int ClassID;
	local int ItemCount;

	ParseInt(_L2jBRVar17_,"ClassID",ClassID);
	ParseInt(_L2jBRVar17_,"ItemCount",ItemCount);
	UpdateItemCount(ClassID,ItemCount);
}

defaultproperties
{
    L2jBRVar13="GMQuestWnd.InnerWnd"

}
