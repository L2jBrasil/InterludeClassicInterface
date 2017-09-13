//================================================================================
// UIAPI_HTMLCTRL.
//================================================================================

class UIAPI_HTMLCTRL extends UIAPI_WINDOW;

native static function LoadHtml (string ControlName, string Filename);

native static function LoadHtmlFromString (string ControlName, string HtmlString);

native static function Clear (string ControlName);

native static function int GetFrameMaxHeight (string ControlName);

native static function EControlReturnType ControllerExecution (string ControlName, string strBypass);

native static function SetHtmlBuffData (string ControlName, string strData);

native static function SetPageLock (string ControlName, bool bLock);

native static function bool IsPageLock (string ControlName);