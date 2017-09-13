//================================================================================
// PCCafeEventWnd.
//================================================================================

class PCCafeEventWnd extends UICommonAPI;

var int m_TotalPoint;
var int m_AddPoint;
var int m_PeriodType;
var int m_RemainTime;
var int m_PointType;
var WindowHandle HelpButton;

function OnLoad ()
{
	RegisterEvent(1910);
	HelpButton = GetHandle("PCCafeEventWnd.HelpButton");
}

function OnClickButton (string a_ButtonID)
{
	switch (a_ButtonID)
	{
		case "HelpButton":
		OnClickHelpButton();
		break;
		default:
	}
}

function OnEvent (int L2jBRVar16, string _L2jBRVar17_)
{
	switch (L2jBRVar16)
	{
		case 1910:
		HandlePCCafePointInfo(_L2jBRVar17_);
		break;
		default:
	}
}

function OnClickHelpButton ()
{
}

function HandlePCCafePointInfo (string _L2jBRVar17_)
{
	ParseInt(_L2jBRVar17_,"TotalPoint",m_TotalPoint);
	ParseInt(_L2jBRVar17_,"AddPoint",m_AddPoint);
	ParseInt(_L2jBRVar17_,"PeriodType",m_PeriodType);
	ParseInt(_L2jBRVar17_,"RemainTime",m_RemainTime);
	ParseInt(_L2jBRVar17_,"PointType",m_PointType);
	Refresh();
}

function bool IsPCCafeEventOpened ()
{
	if ( UnknownFunction150(0,m_PeriodType) )
	{
		return True;
	}
	return False;
}

function OnEnterState (name a_PreStateName)
{
	Refresh();
}

function Refresh ()
{
	local Color TextColor;
	local string AddPointText;

	if ( IsPCCafeEventOpened() )
	{
		ShowWindow("PCCafeEventWnd");
		HelpButton.SetTooltipCustomType(L2jBRFunction29(GetHelpButtonTooltipText()));
		Class'UIAPI_TEXTBOX'.SetText("PCCafeEventWnd.PointTextBox",MakeCostString(string(m_TotalPoint)));
		Class'UIAPI_WINDOW'.SetAlpha("PCCafeEventWnd.PointAddTextBox",0);
		if ( UnknownFunction155(0,m_AddPoint) )
		{
			if ( UnknownFunction150(0,m_AddPoint) )
			{
				AddPointText = UnknownFunction112("+",MakeCostString(string(m_AddPoint)));
			} else {
				AddPointText = MakeCostString(string(m_AddPoint));
			}
			Class'UIAPI_TEXTBOX'.SetText("PCCafeEventWnd.PointAddTextBox",AddPointText);
			switch (m_PointType)
			{
				case 0:
				TextColor.R = 255;
				TextColor.G = 255;
				TextColor.B = 0;
				break;
				case 1:
				TextColor.R = 0;
				TextColor.G = 255;
				TextColor.B = 255;
				break;
				case 2:
				TextColor.R = 255;
				TextColor.G = 0;
				TextColor.B = 0;
				break;
				default:
			}
			Class'UIAPI_TEXTBOX'.SetTextColor("PCCafeEventWnd.PointAddTextBox",TextColor);
			Class'UIAPI_WINDOW'.SetAnchor("PCCafeEventWnd.PointAddTextBox","PCCafeEventWnd","TopRight","TopRight",-5,41);
			Class'UIAPI_WINDOW'.ClearAnchor("PCCafeEventWnd.PointAddTextBox");
			Class'UIAPI_WINDOW'.Move("PCCafeEventWnd.PointAddTextBox",0,-18,1.0);
			Class'UIAPI_WINDOW'.SetAlpha("PCCafeEventWnd.PointAddTextBox",255);
			Class'UIAPI_WINDOW'.SetAlpha("PCCafeEventWnd.PointAddTextBox",0,0.81);
			m_AddPoint = 0;
		}
	} else {
		HideWindow("PCCafeEventWnd");
	}
}

function string GetHelpButtonTooltipText ()
{
	local string TooltipSystemMsg;

	if ( UnknownFunction154(1,m_PeriodType) )
	{
		TooltipSystemMsg = GetSystemMessage(1705);
	} else {
		if ( UnknownFunction154(2,m_PeriodType) )
		{
			TooltipSystemMsg = GetSystemMessage(1706);
		} else {
			return "";
		}
	}
	return MakeFullSystemMsg(TooltipSystemMsg,string(m_RemainTime),"");
}

function CustomTooltip L2jBRFunction29 (string Text)
{
	local CustomTooltip ToolTip;
	local DrawItemInfo Info;

	ToolTip.MinimumWidth = 144;
	ToolTip.DrawList.Length = 1;
	Info.eType = 1;
	Info.t_bDrawOneLine = True;
	Info.t_color.R = 178;
	Info.t_color.G = 190;
	Info.t_color.B = 207;
	Info.t_color.A = 255;
	Info.t_strText = Text;
	ToolTip.DrawList[0] = Info;
	return ToolTip;
}

