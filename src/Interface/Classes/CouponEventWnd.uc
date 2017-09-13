//================================================================================
// CouponEventWnd.
//================================================================================

class CouponEventWnd extends UIScript;

var string CurrentInput;
var bool completeEditbox;
var array<int> completebox;

function OnLoad ()
{
	RegisterEvent(530);
	Class'UIAPI_WINDOW'.HideWindow("CouponEventWnd");
	completebox.Length = 5;
	initValue();
}

function initValue ()
{
	CurrentInput = "";
	completeEditbox = False;
	completebox[1] = 0;
	completebox[2] = 0;
	completebox[3] = 0;
	completebox[4] = 0;
	completebox[5] = 0;
}

function resetEditBox ()
{
	local int i;

	i = 1;
	if ( UnknownFunction152(i,5) )
	{
		Class'UIAPI_EDITBOX'.SetString(UnknownFunction112("CouponEventWnd.input",string(i)),"");
		UnknownFunction163(i);
		goto JL0007;
	}
}

function OnShow ()
{
	initValue();
	resetEditBox();
	Class'UIAPI_WINDOW'.DisableWindow("CouponEventWnd.inputnumber");
	Class'UIAPI_WINDOW'.SetFocus("CouponEventWnd.input1");
}

function OnEvent (int Event_ID, string L2jBRVar1)
{
	if ( UnknownFunction154(Event_ID,530) )
	{
		Class'UIAPI_WINDOW'.ShowWindow("CouponEventWnd");
	}
}

function OnClickButton (string strID)
{
	if ( UnknownFunction122(strID,"inputnumber") )
	{
		Proc_Delivery();
		resetEditBox();
		initValue();
		Class'UIAPI_WINDOW'.HideWindow("CouponEventWnd");
	}
	if ( UnknownFunction122(strID,"resetbtn") )
	{
		resetEditBox();
		initValue();
		Class'UIAPI_WINDOW'.SetFocus("CouponEventWnd.input1");
	}
}

function Proc_Delivery ()
{
	RequestPCCafeCouponUse(CurrentInput);
}

function OnChangeEditBox (string EditBoxID)
{
	if ( UnknownFunction122(EditBoxID,"input1") )
	{
		count_editBox(EditBoxID);
	}
	if ( UnknownFunction122(EditBoxID,"input2") )
	{
		count_editBox(EditBoxID);
	}
	if ( UnknownFunction122(EditBoxID,"input3") )
	{
		count_editBox(EditBoxID);
	}
	if ( UnknownFunction122(EditBoxID,"input4") )
	{
		count_editBox(EditBoxID);
	}
	if ( UnknownFunction122(EditBoxID,"input5") )
	{
		count_editBox(EditBoxID);
	}
}

function count_editBox (string currentboxnum)
{
	local array<string> inputtxt;
	local int currentboxNumint;
	local int i;

	inputtxt.Length = 5;
	currentboxNumint = int(UnknownFunction234(currentboxnum,1));
	inputtxt[currentboxNumint] = UnknownFunction112("",Class'UIAPI_EDITBOX'.GetString(UnknownFunction112("CouponEventWnd.input",string(currentboxNumint))));
	if ( UnknownFunction154(UnknownFunction125(inputtxt[currentboxNumint]),4) )
	{
		completebox[currentboxNumint] = 1;
		if ( UnknownFunction155(currentboxNumint,5) )
		{
			Class'UIAPI_WINDOW'.SetFocus(UnknownFunction112("CouponEventWnd.input",string(UnknownFunction146(currentboxNumint,1))));
		}
	} else {
		completebox[currentboxNumint] = 0;
	}
	i = 1;
	if ( UnknownFunction152(i,5) )
	{
		UnknownFunction163(i);
		goto JL00CC;
	}
	if ( UnknownFunction130(UnknownFunction130(UnknownFunction130(UnknownFunction130(UnknownFunction154(completebox[1],1),UnknownFunction154(completebox[2],1)),UnknownFunction154(completebox[3],1)),UnknownFunction154(completebox[4],1)),UnknownFunction154(completebox[5],1)) )
	{
		completeEditbox = True;
		CurrentInput = UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112(UnknownFunction112("",Class'UIAPI_EDITBOX'.GetString("CouponEventWnd.input1")),Class'UIAPI_EDITBOX'.GetString("CouponEventWnd.input2")),Class'UIAPI_EDITBOX'.GetString("CouponEventWnd.input3")),Class'UIAPI_EDITBOX'.GetString("CouponEventWnd.input4")),Class'UIAPI_EDITBOX'.GetString("CouponEventWnd.input5"));
		Class'UIAPI_WINDOW'.EnableWindow("CouponEventWnd.inputnumber");
	} else {
		completeEditbox = False;
		Class'UIAPI_WINDOW'.DisableWindow("CouponEventWnd.inputnumber");
	}
}

