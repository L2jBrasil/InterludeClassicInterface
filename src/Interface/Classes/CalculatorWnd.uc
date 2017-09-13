//================================================================================
// CalculatorWnd.
//================================================================================

class CalculatorWnd extends UICommonAPI;

const OP_EQUAL=4;
const OP_DIVIDE=3;
const OP_MULTIPLY=2;
const OP_MINUS=1;
const OP_PLUS=0;
var int m_iState;
var float m_fOperand1;
var int m_nOperator;
const STATE_INSERT_OP2=3;
const STATE_OP=2;
const STATE_OP1=1;
const STATE_INSERT_OP1=0;

function OnLoad ()
{
	RegisterEvent(1700);
}

function OnShow ()
{
	InitCalculator();
	Class'UIAPI_WINDOW'.SetFocus("CalculatorWnd.editBoxCalculate");
}

function Clear ()
{
	Class'UIAPI_EDITBOX'.Clear("CalculatorWnd.editBoxCalculate");
}

function InitCalculator ()
{
	m_fOperand1 = 0.0;
	m_nOperator = -1;
	SetState(1);
	AddNum(0.0);
}

function CE ()
{
	Clear();
	SetString("0");
}

function SetState (int iState)
{
	m_iState = iState;
}

function SetOperand1 (string Str)
{
	if ( UnknownFunction151(UnknownFunction125(Str),0) )
	{
		m_fOperand1 = float(Str);
	} else {
		m_fOperand1 = 0.0;
	}
}

function SetOperator (int Op)
{
	m_nOperator = Op;
}

function AddString (string Str)
{
	local string strTempGet;
	local string strTempResult;

	strTempGet = GetString();
	strTempResult = UnknownFunction112(UnknownFunction112(strTempGet,""),Str);
	Class'UIAPI_EDITBOX'.SetString("CalculatorWnd.editBoxCalculate",strTempResult);
}

function SetString (string Str)
{
	Class'UIAPI_EDITBOX'.SetString("CalculatorWnd.editBoxCalculate",Str);
}

function string GetString ()
{
	local string strTemp;

	strTemp = Class'UIAPI_EDITBOX'.GetString("CalculatorWnd.editBoxCalculate");
	return strTemp;
}

function float GetOperand ()
{
	local string Str;

	Str = GetString();
	if ( UnknownFunction151(UnknownFunction125(Str),0) )
	{
		return float(Str);
	} else {
		return 0.0;
	}
}

function AddNum (float Num)
{
	local string strTemp;

	Clear();
	AddString(UnknownFunction112(UnknownFunction112(strTemp,""),string(int(Num))));
}

function float Calc (float A, float B, int Op)
{
	switch (Op)
	{
		case -1:
		return B;
		case 0:
		return UnknownFunction174(A,B);
		case 1:
		return UnknownFunction175(A,B);
		case 2:
		return UnknownFunction171(A,B);
		case 3:
		if ( UnknownFunction180(B,0) )
		{
			return 0.0;
		}
		return UnknownFunction172(A,B);
		default:
	}
	return 0.0;
}

function bool ExecOverFlow (float A, float B, int Op, float Result)
{
	switch (Op)
	{
		case 0:
		case 2:
		if ( UnknownFunction130(UnknownFunction130(UnknownFunction177(A,0),UnknownFunction177(B,0)),UnknownFunction132(UnknownFunction176(Result,0),UnknownFunction177(Result,1.02487734E2))) )
		{
			InitCalculator();
			return True;
		}
		break;
		case 1:
		case 3:
		break;
		default:
	}
	return False;
}

function BackSpace ()
{
	local string strTemp;
	local string strResult;
	local int iLength;

	strTemp = GetString();
	iLength = UnknownFunction147(UnknownFunction125(strTemp),1);
	if ( UnknownFunction151(iLength,0) )
	{
		strResult = UnknownFunction128(strTemp,iLength);
		SetString(strResult);
	} else {
		CE();
	}
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	switch (Event_ID)
	{
		case 1700:
		ShowWindowWithFocus("CalculatorWnd");
		break;
		default:
	}
}

function ProcessBtn (int iValue)
{
	local int iTemp;
	local string strTemp;
	local string strTemp2;
	local float Result;
	local float fTmp;
	local string strTmp3;
	local string strTempGet;

	strTempGet = GetString();
	if ( UnknownFunction151(UnknownFunction125(strTempGet),24) )
	{
		return;
	}
	if ( UnknownFunction154(iValue,13) )
	{
		iValue = 61;
	}
	if ( UnknownFunction130(UnknownFunction153(iValue,48),UnknownFunction152(iValue,57)) )
	{
		if ( UnknownFunction132(UnknownFunction154(m_iState,0),UnknownFunction154(m_iState,3)) )
		{
			if ( UnknownFunction122(GetString(),"0") )
			{
				if ( UnknownFunction155(iValue,48) )
				{
					Clear();
				}
			}
		}
		if ( UnknownFunction154(m_iState,1) )
		{
			Clear();
			SetState(0);
		} else {
			if ( UnknownFunction154(m_iState,2) )
			{
				SetOperand1(GetString());
				Clear();
				SetState(3);
			}
		}
		strTemp = GetString();
		iTemp = UnknownFunction147(iValue,48);
		strTemp2 = UnknownFunction112("",string(iTemp));
		if ( UnknownFunction151(UnknownFunction125(strTemp),0) )
		{
			AddString(strTemp2);
		} else {
			SetString(strTemp2);
		}
	} else {
		if ( UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction132(UnknownFunction154(iValue,42),UnknownFunction154(iValue,43)),UnknownFunction154(iValue,45)),UnknownFunction154(iValue,47)),UnknownFunction154(iValue,61)) )
		{
			if ( UnknownFunction154(m_iState,1) )
			{
				SetState(2);
			} else {
				if ( UnknownFunction154(m_iState,0) )
				{
					SetOperand1(GetString());
					SetState(2);
				} else {
					if ( UnknownFunction154(m_iState,3) )
					{
						Result = Calc(m_fOperand1,GetOperand(),m_nOperator);
						if ( UnknownFunction129(ExecOverFlow(m_fOperand1,GetOperand(),m_nOperator,Result)) )
						{
							SetOperand1(GetString());
							AddNum(Result);
							SetState(2);
						}
					} else {
						if ( UnknownFunction130(UnknownFunction154(m_iState,2),UnknownFunction154(iValue,61)) )
						{
							fTmp = GetOperand();
							Result = Calc(fTmp,m_fOperand1,m_nOperator);
							if ( UnknownFunction129(ExecOverFlow(fTmp,m_fOperand1,m_nOperator,Result)) )
							{
								strTmp3 = UnknownFunction112("",string(int(Result)));
								Clear();
								AddString(strTmp3);
							}
						}
					}
				}
			}
		}
		if ( UnknownFunction154(iValue,42) )
		{
			SetOperator(2);
		} else {
			if ( UnknownFunction154(iValue,43) )
			{
				SetOperator(0);
			} else {
				if ( UnknownFunction154(iValue,45) )
				{
					SetOperator(1);
				} else {
					if ( UnknownFunction154(iValue,47) )
					{
						SetOperator(3);
					} else {
						if (! UnknownFunction154(iValue,61) ) goto JL02E9;
					}
				}
			}
		}
	}
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btn7":
		ProcessBtn(55);
		break;
		case "btn8":
		ProcessBtn(56);
		break;
		case "btn9":
		ProcessBtn(57);
		break;
		case "btnAdd":
		ProcessBtn(43);
		break;
		case "btnCE":
		CE();
		break;
		case "btn4":
		ProcessBtn(52);
		break;
		case "btn5":
		ProcessBtn(53);
		break;
		case "btn6":
		ProcessBtn(54);
		break;
		case "btnSub":
		ProcessBtn(45);
		break;
		case "btnC":
		InitCalculator();
		break;
		case "btn1":
		ProcessBtn(49);
		break;
		case "btn2":
		ProcessBtn(50);
		break;
		case "btn3":
		ProcessBtn(51);
		break;
		case "btnMul":
		ProcessBtn(42);
		break;
		case "btnBS":
		BackSpace();
		break;
		case "btn0":
		ProcessBtn(48);
		break;
		case "btn00":
		ProcessBtn(48);
		ProcessBtn(48);
		break;
		case "btnDiv":
		ProcessBtn(47);
		break;
		case "btnEQ":
		ProcessBtn(61);
		break;
		case "btnClose":
		Class'UIAPI_WINDOW'.HideWindow("CalculatorWnd");
		break;
		default:
	}
}

