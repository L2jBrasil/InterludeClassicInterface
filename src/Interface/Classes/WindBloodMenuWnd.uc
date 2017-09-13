//================================================================================
// WindBloodMenuWnd.
//================================================================================

class WindBloodMenuWnd extends UICommonAPI;

var WindowHandle L2jBRVar12;
var ButtonHandle BtnShowTemp;
var ButtonHandle BtnShowMuseum;
var ButtonHandle BtnShowAuction;
var WindowHandle Drawer;

function OnLoad ()
{
	L2jBRFunction2();
	Load();
}

function L2jBRFunction2 ()
{
	L2jBRVar12 = GetHandle("WindBloodMenuWnd");
	BtnShowTemp = ButtonHandle(GetHandle("WindBloodMenuWnd.BtnTemp"));
	BtnShowMuseum = ButtonHandle(GetHandle("WindBloodMenuWnd.BtnMuseum"));
	BtnShowAuction = ButtonHandle(GetHandle("WindBloodMenuWnd.BtnAuction"));
}

function Load ()
{
}

function OnClickButton (string Name)
{
	switch (Name)
	{
		case "BtnTemp":
		ExecuteCommand("/inventory");
		break;
		case "BtnMuseum":
		ExecuteCommand("/museum");
		break;
		case "BtnAuction":
		ExecuteCommand("/auction");
		break;
		default:
	}
}

