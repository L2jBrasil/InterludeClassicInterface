//================================================================================
// DialogBox.
//================================================================================

class DialogBox extends UICommonAPI;

var string m_strTargetScript;
var string m_strEditMessage;
var EDialogType m_type;
var int m_id;
var bool m_bInUse;
var int m_paramInt;
var int m_reservedInt;
var int m_reservedInt2;
var int m_reservedInt3;
var int m_dialogEditMaxLength;
var int m_dialogEditMaxLength_prev;
var DialogDefaultAction m_defaultAction;
var TextBoxHandle DialogReadingText;
var EditBoxHandle m_dialogEdit;

function ShowDialog (EDialogType Style, string Message, string Target)
{
	if ( m_bInUse )
	{
		Debug("Error!! DialogBox in Use");
		return;
	}
	Class'UIAPI_WINDOW'.ShowWindow("DialogBox");
	SetWindowStyle(Style);
	SetMessage(Message);
	Class'UIAPI_WINDOW'.SetFocus("DialogBox");
	if ( m_dialogEdit.IsShowWindow() )
	{
		m_dialogEdit.SetFocus();
		if ( UnknownFunction155(m_dialogEditMaxLength,-1) )
		{
			m_dialogEditMaxLength_prev = m_dialogEdit.GetMaxLength();
			m_dialogEdit.SetMaxLength(m_dialogEditMaxLength);
		}
	}
	m_strTargetScript = Target;
	m_bInUse = True;
}

function HideDialog ()
{
	HideWindow("DialogBox");
	L2jBRFunction32	();
}

function SetDefaultAction (DialogDefaultAction defaultAction)
{
	Debug(UnknownFunction112("DialogBox SetDefaultAction ",string(defaultAction)));
	m_defaultAction = defaultAction;
}

function string GetTarget ()
{
	return m_strTargetScript;
}

function string GetEditMessage ()
{
	return m_strEditMessage;
}

function SetEditMessage (string strMsg)
{
	m_dialogEdit.SetString(strMsg);
}

function int GetID ()
{
	return m_id;
}

function SetID (int Id)
{
	m_id = Id;
}

function SetEditType (string strType)
{
	m_dialogEdit.Super(EditBoxHandle).SetEditType(strType);
}

function SetParamInt (int L2jBRVar1)
{
	m_paramInt = L2jBRVar1;
}

function SetReservedInt (int Value)
{
	m_reservedInt = Value;
}

function SetReservedInt2 (int Value)
{
	m_reservedInt2 = Value;
}

function SetReservedInt3 (int Value)
{
	m_reservedInt3 = Value;
}

function int GetReservedInt ()
{
	return m_reservedInt;
}

function int GetReservedInt2 ()
{
	return m_reservedInt2;
}

function int GetReservedInt3 ()
{
	return m_reservedInt3;
}

function SetEditBoxMaxLength (int maxLength)
{
	if ( UnknownFunction153(maxLength,0) )
	{
		m_dialogEditMaxLength = maxLength;
	}
}

function OnLoad ()
{
	DialogReadingText = TextBoxHandle(GetHandle("DialogBox.DialogReadingText"));
	m_dialogEdit = EditBoxHandle(GetHandle("DialogBox.DialogBoxEdit"));
	L2jBRFunction32	();
	SetButtonName(1337,1342);
	SetMessage("Message uninitialized");
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "OKButton":
		case "CenterOKButton":
		HandleOK();
		break;
		case "CancelButton":
		HandleCancel();
		break;
		case "num0":
		case "num1":
		case "num2":
		case "num3":
		case "num4":
		case "num5":
		case "num6":
		case "num7":
		case "num8":
		case "num9":
		case "numAll":
		case "numBS":
		case "numC":
		HandleNumberClick(strID);
		break;
		default:
		break;
	}
}

function OnHide ()
{
	if ( UnknownFunction154(m_type,7) )
	{
		Class'UIAPI_PROGRESSCTRL'.Stop("DialogBox.DialogProgress");
	}
	SetEditType("normal");
	SetEditMessage("");
	if ( UnknownFunction155(m_dialogEditMaxLength,-1) )
	{
		m_dialogEditMaxLength = -1;
		m_dialogEdit.SetMaxLength(m_dialogEditMaxLength_prev);
	}
	m_dialogEdit.Clear();
}

function OnChangeEditBox (string strID)
{
	local string strInput;

	if ( UnknownFunction122(strID,"DialogBoxEdit") )
	{
		if ( UnknownFunction154(m_type,6) )
		{
			DialogReadingText.SetText("");
			strInput = m_dialogEdit.GetString();
			if ( UnknownFunction151(UnknownFunction125(strInput),0) )
			{
				DialogReadingText.SetText(ConvertNumToTextNoAdena(strInput));
			}
		}
	}
}

function L2jBRFunction32	 ()
{
	m_strTargetScript = "";
	m_bInUse = False;
	SetEditType("normal");
	m_paramInt = 0;
	m_reservedInt = 0;
	m_reservedInt2 = 0;
	m_dialogEditMaxLength = -1;
	SetDefaultAction(0);
}

function HideAll ()
{
	m_dialogEdit.HideWindow();
	Class'UIAPI_WINDOW'.HideWindow("DialogBox.OKButton");
	Class'UIAPI_WINDOW'.HideWindow("DialogBox.CancelButton");
	Class'UIAPI_WINDOW'.HideWindow("DialogBox.CenterOKButton");
	Class'UIAPI_WINDOW'.HideWindow("DialogBox.NumberPad");
	Class'UIAPI_WINDOW'.HideWindow("DialogBox.DialogProgress");
}

function SetWindowStyle (EDialogType Style)
{
	local Rect bodyRect;
	local Rect numpadRect;

	HideAll();
	bodyRect = Class'UIAPI_WINDOW'.GetRect("DialogBox.DialogBody");
	numpadRect = Class'UIAPI_WINDOW'.GetRect("DialogBox.NumberPad");
	m_type = Style;
	switch (Style)
	{
		case 0:
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.OKButton");
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.CancelButton");
		Class'UIAPI_WINDOW'.SetWindowSize("DialogBox",bodyRect.nWidth,bodyRect.nHeight);
		break;
		case 1:
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.CenterOKButton");
		Class'UIAPI_WINDOW'.SetWindowSize("DialogBox",bodyRect.nWidth,bodyRect.nHeight);
		break;
		case 2:
		m_dialogEdit.ShowWindow();
		Class'UIAPI_TEXTBOX'.SetText("DialogBox.DialogReadingText","");
		Debug("what the hell");
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.OKButton");
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.CancelButton");
		Class'UIAPI_WINDOW'.SetWindowSize("DialogBox",bodyRect.nWidth,bodyRect.nHeight);
		break;
		case 3:
		m_dialogEdit.ShowWindow();
		Class'UIAPI_TEXTBOX'.SetText("DialogBox.DialogReadingText","");
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.CenterOKButton");
		Class'UIAPI_WINDOW'.SetWindowSize("DialogBox",bodyRect.nWidth,bodyRect.nHeight);
		break;
		case 4:
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.OKButton");
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.CancelButton");
		Class'UIAPI_WINDOW'.SetWindowSize("DialogBox",bodyRect.nWidth,bodyRect.nHeight);
		break;
		case 5:
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.CenterOKButton");
		Class'UIAPI_WINDOW'.SetWindowSize("DialogBox",bodyRect.nWidth,bodyRect.nHeight);
		break;
		case 6:
		m_dialogEdit.ShowWindow();
		Class'UIAPI_TEXTBOX'.SetText("DialogBox.DialogReadingText","");
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.OKButton");
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.CancelButton");
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.NumberPad");
		Class'UIAPI_WINDOW'.SetWindowSize("DialogBox",UnknownFunction146(bodyRect.nWidth,numpadRect.nWidth),bodyRect.nHeight);
		SetEditType("number");
		break;
		case 7:
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.OKButton");
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.CancelButton");
		Class'UIAPI_WINDOW'.ShowWindow("DialogBox.DialogProgress");
		Class'UIAPI_WINDOW'.SetWindowSize("DialogBox",bodyRect.nWidth,bodyRect.nHeight);
		if ( UnknownFunction154(m_paramInt,0) )
		{
			Debug("DialogBox Error!! DIALOG_Progress needs parameter");
		} else {
			Class'UIAPI_PROGRESSCTRL'.SetProgressTime("DialogBox.DialogProgress",m_paramInt);
			Class'UIAPI_PROGRESSCTRL'.Reset("DialogBox.DialogProgress");
			Class'UIAPI_PROGRESSCTRL'.Start("DialogBox.DialogProgress");
		}
		break;
		default:
	}
	if ( UnknownFunction154(Style,7) )
	{
		Class'UIAPI_WINDOW'.SetAnchor("DialogBox","","BottomCenter","BottomCenter",0,0);
	} else {
		Class'UIAPI_WINDOW'.SetAnchor("DialogBox","","CenterCenter","CenterCenter",0,0);
	}
}

function SetMessage (string strMessage)
{
	Class'UIAPI_TEXTBOX'.SetText("DialogBox.DialogText",strMessage);
}

function SetButtonName (int indexOK, int indexCancel)
{
	Class'UIAPI_BUTTON'.SetButtonName("DialogBox.OKButton",indexOK);
	Class'UIAPI_BUTTON'.SetButtonName("DialogBox.CenterOKButton",indexOK);
	Class'UIAPI_BUTTON'.SetButtonName("DialogBox.CancelButton",indexCancel);
}

function HandleOK ()
{
	if ( m_dialogEdit.IsShowWindow() )
	{
		m_strEditMessage = m_dialogEdit.GetString();
	} else {
		m_strEditMessage = "";
	}
	Class'UIAPI_WINDOW'.HideWindow("DialogBox");
	m_bInUse = False;
	ExecuteEvent(1710);
}

function HandleCancel ()
{
	Class'UIAPI_WINDOW'.HideWindow("DialogBox");
	m_bInUse = False;
	ExecuteEvent(1720);
}

function HandleNumberClick (string strID)
{
	switch (strID)
	{
		case "num0":
		m_dialogEdit.AddString("0");
		break;
		case "num1":
		m_dialogEdit.AddString("1");
		break;
		case "num2":
		m_dialogEdit.AddString("2");
		break;
		case "num3":
		m_dialogEdit.AddString("3");
		break;
		case "num4":
		m_dialogEdit.AddString("4");
		break;
		case "num5":
		m_dialogEdit.AddString("5");
		break;
		case "num6":
		m_dialogEdit.AddString("6");
		break;
		case "num7":
		m_dialogEdit.AddString("7");
		break;
		case "num8":
		m_dialogEdit.AddString("8");
		break;
		case "num9":
		m_dialogEdit.AddString("9");
		break;
		case "numAll":
		if ( UnknownFunction153(m_paramInt,0) )
		{
			m_dialogEdit.SetString(string(m_paramInt));
		}
		break;
		case "numBS":
		m_dialogEdit.SimulateBackspace();
		break;
		case "numC":
		m_dialogEdit.SetString("0");
		break;
		default:
		break;
	}
}

function OnProgressTimeUp (string strID)
{
	Debug("OnProgressTimeUp");
	if ( UnknownFunction122(strID,"DialogProgress") )
	{
		HandleCancel();
	}
}

function DoDefaultAction ()
{
	Debug("DialogBox DoDefaultAction");
	switch (m_defaultAction)
	{
		case 1:
		HandleOK();
		break;
		case 2:
		HandleCancel();
		break;
		case 0:
		HandleCancel();
		break;
		default:
		break;
	}
	SetDefaultAction(0);
}

