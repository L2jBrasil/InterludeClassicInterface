//================================================================================
// BenchMarkMenuWnd.
//================================================================================

class BenchMarkMenuWnd extends UIScript;

function OnLoad ()
{
	Class'UIAPI_WINDOW'.SetFocus("BenchMarkMenuWnd.BenchMarkFunctionWnd");
}

function OnClickButton (string strID)
{
	switch (strID)
	{
		case "btnPlay":
		BeginPlay();
		break;
		case "btnBenchMark":
		BeginBenchMark();
		break;
		case "btnOption":
		ShowOptionWnd();
		break;
		case "btnExit":
		ExecQuit();
		break;
		default:
	}
}

function ShowOptionWnd ()
{
	if ( Class'UIAPI_WINDOW'.IsShowWindow("OptionWnd") )
	{
		PlayConsoleSound(6);
		Class'UIAPI_WINDOW'.HideWindow("OptionWnd");
	} else {
		PlayConsoleSound(5);
		Class'UIAPI_WINDOW'.ShowWindow("OptionWnd");
		Class'UIAPI_WINDOW'.SetFocus("OptionWnd");
	}
}

