//================================================================================
// HeroTowerWnd.
//================================================================================

class HeroTowerWnd extends UIScript;

function OnLoad ()
{
	RegisterEvent(880);
	RegisterEvent(890);
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,880) )
	{
		Clear();
		Class'UIAPI_WINDOW'.ShowWindow("HeroTowerWnd");
		Class'UIAPI_WINDOW'.SetFocus("HeroTowerWnd");
		HandleCheckAmIHero();
		HandleHeroShowList(L2jBRVar1);
	}
}

function OnDBClickListCtrlRecord (string strID)
{
	switch (strID)
	{
		case "lstHero":
		HandleShowDiary();
		break;
		default:
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnShowDiary":
		HandleShowDiary();
		break;
		case "btnReg":
		Class'HeroTowerAPI'.RequestWriteHeroWords(Class'UIAPI_EDITBOX'.GetString("HeroTowerWnd.txtDiary"));
		Class'UIAPI_EDITBOX'.SetString("HeroTowerWnd.txtDiary","");
		break;
		default:
	}
}

function HandleShowDiary ()
{
	local LVDataRecord Record;
	local string strTmp;

	Record = Class'UIAPI_LISTCTRL'.GetSelectedRecord("HeroTowerWnd.lstHero");
	if ( UnknownFunction151(Record.nReserved1,0) )
	{
		strTmp = UnknownFunction112(UnknownFunction112("_diary?class=",string(Record.nReserved1)),"&page=1");
		RequestBypassToServer(strTmp);
	}
}

function HandleCheckAmIHero ()
{
	local bool bHero;

	bHero = Class'UIDATA_PLAYER'.IsHero();
	if ( bHero )
	{
		Class'UIAPI_WINDOW'.ShowWindow("HeroTowerWnd.txtDiary");
		Class'UIAPI_WINDOW'.ShowWindow("HeroTowerWnd.btnReg");
	} else {
		Class'UIAPI_WINDOW'.HideWindow("HeroTowerWnd.txtDiary");
		Class'UIAPI_WINDOW'.HideWindow("HeroTowerWnd.btnReg");
	}
}

function Clear ()
{
	Class'UIAPI_LISTCTRL'.DeleteAllItem("HeroTowerWnd.lstHero");
	Class'UIAPI_EDITBOX'.SetString("HeroTowerWnd.txtDiary","");
}

function HandleHeroShowList (string L2jBRVar1)
{
	local int i;
	local int nMax;
	local string strName;
	local int ClassID;
	local string strPledgeName;
	local int PledgeCrestID;
	local string strAllianceName;
	local int AllianceCrestID;
	local int WinCount;
	local Texture texPledge;
	local Texture texAlliance;
	local LVDataRecord Record;
	local LVDataRecord recordClear;

	ParseInt(L2jBRVar1,"Max",nMax);
	i = 0;
	if ( UnknownFunction150(i,nMax) )
	{
		strName = "";
		ClassID = 0;
		strPledgeName = "";
		PledgeCrestID = 0;
		strAllianceName = "";
		AllianceCrestID = 0;
		WinCount = 0;
		ParseString(L2jBRVar1,UnknownFunction112("Name_",string(i)),strName);
		ParseInt(L2jBRVar1,UnknownFunction112("ClassId_",string(i)),ClassID);
		ParseString(L2jBRVar1,UnknownFunction112("PledgeName_",string(i)),strPledgeName);
		ParseInt(L2jBRVar1,UnknownFunction112("PledgeCrestId_",string(i)),PledgeCrestID);
		ParseString(L2jBRVar1,UnknownFunction112("AllianceName_",string(i)),strAllianceName);
		ParseInt(L2jBRVar1,UnknownFunction112("AllianceCrestId_",string(i)),AllianceCrestID);
		ParseInt(L2jBRVar1,UnknownFunction112("WinCount_",string(i)),WinCount);
		texPledge = GetPledgeCrestTexFromPledgeCrestID(PledgeCrestID);
		texAlliance = GetAllianceCrestTexFromAllianceCrestID(AllianceCrestID);
		Record = recordClear;
		Record.LVDataList.Length = 5;
		Record.LVDataList[0].szData = strName;
		Record.LVDataList[1].szData = GetClassType(ClassID);
		Record.LVDataList[2].szData = strPledgeName;
		if ( UnknownFunction151(AllianceCrestID,0) )
		{
			if ( UnknownFunction151(PledgeCrestID,0) )
			{
				Record.LVDataList[2].arrTexture.Length = 2;
				Record.LVDataList[2].arrTexture[0].objTex = texAlliance;
				Record.LVDataList[2].arrTexture[0].X = 10;
				Record.LVDataList[2].arrTexture[0].Y = 0;
				Record.LVDataList[2].arrTexture[0].Width = 8;
				Record.LVDataList[2].arrTexture[0].Height = 12;
				Record.LVDataList[2].arrTexture[0].U = 0;
				Record.LVDataList[2].arrTexture[0].V = 4;
				Record.LVDataList[2].arrTexture[1].objTex = texPledge;
				Record.LVDataList[2].arrTexture[1].X = 18;
				Record.LVDataList[2].arrTexture[1].Y = 0;
				Record.LVDataList[2].arrTexture[1].Width = 16;
				Record.LVDataList[2].arrTexture[1].Height = 12;
				Record.LVDataList[2].arrTexture[1].U = 0;
				Record.LVDataList[2].arrTexture[1].V = 4;
			} else {
				Record.LVDataList[2].arrTexture.Length = 1;
				Record.LVDataList[2].arrTexture[0].objTex = texPledge;
				Record.LVDataList[2].arrTexture[0].X = 10;
				Record.LVDataList[2].arrTexture[0].Y = 0;
				Record.LVDataList[2].arrTexture[0].Width = 8;
				Record.LVDataList[2].arrTexture[0].Height = 12;
				Record.LVDataList[2].arrTexture[0].U = 0;
				Record.LVDataList[2].arrTexture[0].V = 4;
			}
		} else {
			if ( UnknownFunction151(PledgeCrestID,0) )
			{
				Record.LVDataList[2].arrTexture.Length = 1;
				Record.LVDataList[2].arrTexture[0].objTex = texPledge;
				Record.LVDataList[2].arrTexture[0].X = 10;
				Record.LVDataList[2].arrTexture[0].Y = 0;
				Record.LVDataList[2].arrTexture[0].Width = 16;
				Record.LVDataList[2].arrTexture[0].Height = 12;
				Record.LVDataList[2].arrTexture[0].U = 0;
				Record.LVDataList[2].arrTexture[0].V = 4;
			}
		}
		Record.LVDataList[3].szData = strAllianceName;
		Record.LVDataList[4].szData = string(WinCount);
		Record.nReserved1 = ClassID;
		Class'UIAPI_LISTCTRL'.InsertRecord("HeroTowerWnd.lstHero",Record);
		UnknownFunction165(i);
		goto JL001C;
	}
}

