//================================================================================
// NPHRN_KeyWnd.
//================================================================================

class NPHRN_KeyWnd extends UICommonAPI;

var WindowHandle L2jBRVar12;
var Shortcut L2jBRVar21;
var CheckBoxHandle L2jBRVar175;
var CheckBoxHandle L2jBRVar176;
var CheckBoxHandle L2jBRVar177;
var CheckBoxHandle L2jBRVar181;
var ComboBoxHandle L2jBRVar182;
var ComboBoxHandle L2jBRVar180;
var ComboBoxHandle L2jBRVar178;
var TextBoxHandle L2jBRVar183;
var TextBoxHandle L2jBRVar179;
var TextBoxHandle L2jBRVar184;
var TextBoxHandle L2jBRVar185;

function OnLoad ()
{
	L2jBRFunction2();
	L2jBRFunction95();
}

function L2jBRFunction2 ()
{
	L2jBRVar12 = GetHandle("NPHRN_KeyWnd");
	L2jBRVar21 = Shortcut(GetScript("Shortcut"));
	L2jBRVar175 = CheckBoxHandle(GetHandle("NPHRN_KeyWnd.Cb_UseNumpad"));
	L2jBRVar176 = CheckBoxHandle(GetHandle("NPHRN_KeyWnd.Cb_UseFPad"));
	L2jBRVar177 = CheckBoxHandle(GetHandle("NPHRN_KeyWnd.Cb_UseQwerty"));
	L2jBRVar181 = CheckBoxHandle(GetHandle("NPHRN_KeyWnd.Cb_ChatEnter"));
	L2jBRVar182 = ComboBoxHandle(GetHandle("NPHRN_KeyWnd.ComboPanel1"));
	L2jBRVar180 = ComboBoxHandle(GetHandle("NPHRN_KeyWnd.ComboPanel2"));
	L2jBRVar178 = ComboBoxHandle(GetHandle("NPHRN_KeyWnd.ComboPanel3"));
	L2jBRVar183 = TextBoxHandle(GetHandle("NPHRN_BeltWnd.Tooltip_ChatEnter"));
	L2jBRVar179 = TextBoxHandle(GetHandle("NPHRN_BeltWnd.Tooltip_UseNumpad"));
	L2jBRVar184 = TextBoxHandle(GetHandle("NPHRN_BeltWnd.Tooltip_UseFPad"));
	L2jBRVar185 = TextBoxHandle(GetHandle("NPHRN_BeltWnd.Tooltip_UseQwerty"));
}

function L2jBRFunction95 ()
{
	if ( UnknownFunction152(GetOptionInt("Key","Panel1"),0) )
	{
		SetOptionInt("Key","Panel1",1);
	}
	if ( UnknownFunction152(GetOptionInt("Key","Panel2"),0) )
	{
		SetOptionInt("Key","Panel2",1);
	}
	if ( UnknownFunction152(GetOptionInt("Key","Panel3"),0) )
	{
		SetOptionInt("Key","Panel3",1);
	}

	L2jBRVar181.SetTitle("Enter Chat");
	L2jBRVar175.SetTitle("Numpad");
	L2jBRVar177.SetTitle("Qwerty");
	L2jBRVar176.SetTitle("F-Pad");
	L2jBRVar183.SetTooltipString("Enable Enter Chat to use binded shortcuts.");
	L2jBRVar179.SetTooltipString("Keys: 1, 2, 3 Etc");
	L2jBRVar184.SetTooltipString("Keys: F1, F2, F3 Etc");
	L2jBRVar185.SetTooltipString("Keys: Q, W, E, Etc");

	L2jBRVar181.SetCheck(GetOptionBool("Game","EnterChatting"));
	L2jBRVar175.SetCheck(GetOptionBool("Key","UseNumpad"));
	L2jBRVar176.SetCheck(GetOptionBool("Key","UseFPad"));
	L2jBRVar177.SetCheck(GetOptionBool("Key","UseQwerty"));
	L2jBRVar182.SetSelectedNum(UnknownFunction147(GetOptionInt("Key","Panel1"),1));
	L2jBRVar180.SetSelectedNum(UnknownFunction147(GetOptionInt("Key","Panel2"),1));
	L2jBRVar178.SetSelectedNum(UnknownFunction147(GetOptionInt("Key","Panel3"),1));
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "BtnApply":
		OnClickApply();
		break;
		case "BtnClose":
		L2jBRVar12.HideWindow();
		break;
		default:
	}
}

function OnClickApply ()
{
	SetOptionInt("Key","Panel1",UnknownFunction146(L2jBRVar182.GetSelectedNum(),1));
	SetOptionInt("Key","Panel2",UnknownFunction146(L2jBRVar180.GetSelectedNum(),1));
	SetOptionInt("Key","Panel3",UnknownFunction146(L2jBRVar178.GetSelectedNum(),1));
	L2jBRVar21.L2jBRVar36();
}

function OnClickCheckBox (string strID)
{
	switch (strID)
	{
		case "Cb_ChatEnter":
		if ( L2jBRVar181.IsChecked() )
		{
			SetOptionBool("Game","EnterChatting",True);
		} else {
			SetOptionBool("Game","EnterChatting",False);
		}
		break;
		case "Cb_UseNumpad":
		if ( L2jBRVar175.IsChecked() )
		{
			SetOptionBool("Key","UseNumpad",True);
		} else {
			SetOptionBool("Key","UseNumpad",False);
		}
		break;
		case "Cb_UseFPad":
		if ( L2jBRVar176.IsChecked() )
		{
			SetOptionBool("Key","UseFPad",True);
		} else {
			SetOptionBool("Key","UseFPad",False);
		}
		break;
		case "Cb_UseQwerty":
		if ( L2jBRVar177.IsChecked() )
		{
			SetOptionBool("Key","UseQwerty",True);
		} else {
			SetOptionBool("Key","UseQwerty",False);
		}
		break;
		default:
	}
}

