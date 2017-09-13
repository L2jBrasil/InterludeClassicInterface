//================================================================================
// GametipWnd.
//================================================================================

class GametipWnd extends UIScript;

var array<GameTipData> TipData;
var int CountRecord;
var UserInfo userinfofortip;
var string CurrentTip;
var int numb;

function OnLoad ()
{
	LoadGameTipData();
	RegisterEvent(1900);
}

function OnEventWithStr (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 1900:
		LoadGameTipData();
		break;
		default:
	}
}

function LoadGameTipData ()
{
	local int i;
	local bool gamedataloaded;
	local GameTipData TipData1;

	CountRecord = Class'UIDATA_GAMETIP'.GetDataCount();
	i = 0;
	if ( UnknownFunction150(i,CountRecord) )
	{
		gamedataloaded = Class'UIDATA_GAMETIP'.GetDataByIndex(i,TipData1);
		TipData[i] = TipData1;
		UnknownFunction163(i);
		goto JL001C;
	}
}

function OnShow ()
{
	local int RandomVal;
	local int PrioritySelect;
	local int UserLevelData;
	local bool userinfoloaded;
	local array<string> SelectedCondition;
	local int i;
	local int j;
	local int UserLevel;
	local int UserArrange;
	local int NumberSelect;

	j = 0;
	userinfoloaded = GetPlayerInfo(userinfofortip);
	if ( UnknownFunction242(userinfoloaded,False) )
	{
		goto JL0028;
	}
	UserLevelData = userinfofortip.nLevel;
	if ( UnknownFunction130(UnknownFunction153(UserLevelData,1),UnknownFunction152(UserLevelData,20)) )
	{
		UserLevel = 1;
	} else {
		if ( UnknownFunction130(UnknownFunction153(UserLevelData,21),UnknownFunction152(UserLevelData,40)) )
		{
			UserLevel = 20;
		} else {
			if ( UnknownFunction130(UnknownFunction153(UserLevelData,41),UnknownFunction152(UserLevelData,60)) )
			{
				UserLevel = 40;
			} else {
				if ( UnknownFunction130(UnknownFunction153(UserLevelData,61),UnknownFunction152(UserLevelData,74)) )
				{
					UserLevel = 60;
				} else {
					if ( UnknownFunction130(UnknownFunction153(UserLevelData,75),UnknownFunction152(UserLevelData,80)) )
					{
						UserLevel = 80;
					}
				}
			}
		}
	}
	if ( UnknownFunction150(UserLevelData,40) )
	{
		UserArrange = 101;
	} else {
		UserArrange = 102;
	}
	RandomVal = UnknownFunction146(UnknownFunction167(99),1);
	if ( UnknownFunction130(UnknownFunction153(RandomVal,1),UnknownFunction152(RandomVal,50)) )
	{
		PrioritySelect = 1;
	} else {
		if ( UnknownFunction130(UnknownFunction153(RandomVal,51),UnknownFunction152(RandomVal,75)) )
		{
			PrioritySelect = 2;
		} else {
			if ( UnknownFunction130(UnknownFunction153(RandomVal,76),UnknownFunction152(RandomVal,90)) )
			{
				PrioritySelect = 3;
			} else {
				if ( UnknownFunction130(UnknownFunction153(RandomVal,91),UnknownFunction152(RandomVal,100)) )
				{
					PrioritySelect = 4;
				}
			}
		}
	}
	i = 0;
	if ( UnknownFunction150(i,TipData.Length) )
	{
		if ( UnknownFunction123(TipData[i].TipMsg,"") )
		{
			if ( UnknownFunction130(UnknownFunction154(TipData[i].Priority,PrioritySelect),UnknownFunction242(TipData[i].Validity,True)) )
			{
				if ( UnknownFunction132(UnknownFunction132(UnknownFunction154(TipData[i].TargetLevel,UserLevel),UnknownFunction154(TipData[i].TargetLevel,0)),UnknownFunction154(TipData[i].TargetLevel,UserArrange)) )
				{
					SelectedCondition[j] = TipData[i].TipMsg;
					UnknownFunction163(j);
				}
			}
		}
		UnknownFunction163(i);
		goto JL01AE;
	}
	NumberSelect = UnknownFunction167(SelectedCondition.Length);
	if ( UnknownFunction154(SelectedCondition.Length,0) )
	{
		CurrentTip = "";
	} else {
		CurrentTip = SelectedCondition[NumberSelect];
	}
	if ( UnknownFunction242(GetOptionBool("Game","ShowGameTipMsg"),False) )
	{
		Class'UIAPI_TEXTBOX'.SetText("GametipWnd.GameTipText1",GetSystemString(1455));
		Class'UIAPI_TEXTBOX'.SetText("GametipWnd.GameTipText1-1",GetSystemString(1455));
		Class'UIAPI_TEXTBOX'.SetText("GametipWnd.GameTipText1-2",GetSystemString(1455));
		Class'UIAPI_TEXTBOX'.SetText("GametipWnd.GameTipText",CurrentTip);
		Class'UIAPI_TEXTBOX'.SetText("GametipWnd.GameTipText-1",CurrentTip);
		Class'UIAPI_TEXTBOX'.SetText("GametipWnd.GameTipText-2",CurrentTip);
	} else {
		Class'UIAPI_TEXTBOX'.SetText("GametipWnd.GameTipText1","");
		Class'UIAPI_TEXTBOX'.SetText("GametipWnd.GameTipText1-1","");
		Class'UIAPI_TEXTBOX'.SetText("GametipWnd.GameTipText1-2","");
		Class'UIAPI_TEXTBOX'.SetText("GametipWnd.GameTipText","");
		Class'UIAPI_TEXTBOX'.SetText("GametipWnd.GameTipText-1","");
		Class'UIAPI_TEXTBOX'.SetText("GametipWnd.GameTipText-2","");
	}
}

