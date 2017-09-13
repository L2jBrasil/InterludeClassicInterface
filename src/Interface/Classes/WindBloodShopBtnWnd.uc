//================================================================================
// WindBloodShopBtnWnd.
//================================================================================

class WindBloodShopBtnWnd extends UICommonAPI;

var WindowHandle L2jBRVar12;
var ButtonHandle BtnShowCashShop;
var WindowHandle Drawer;

function OnLoad ()
{
	L2jBRFunction2();
	Load();
}

function L2jBRFunction2 ()
{
	L2jBRVar12 = GetHandle("WindBloodShopBtnWnd");
	BtnShowCashShop = ButtonHandle(GetHandle("WindBloodShopBtnWnd.BtnShowCashShop"));
}

function Load ()
{
}

function OnClickButton (string Name)
{
	switch (Name)
	{
		case "BtnShowCashShop":
		OnBtnShowCashShopClick();
		break;
		default:
	}
}

function OnBtnShowCashShopClick ()
{
	local int bShow;

	bShow = 0;
	GetINIBool("WindBlood","UsePrimeShop",bShow,"L2.ini");
	if ( UnknownFunction155(bShow,0) )
	{
		ExecuteCommand(".shop");
	}
}

