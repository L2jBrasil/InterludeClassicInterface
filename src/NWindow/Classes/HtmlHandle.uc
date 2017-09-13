//================================================================================
// HtmlHandle.
//================================================================================

class HtmlHandle extends WindowHandle;

native static function LoadHtml (string Filename);

native static function LoadHtmlFromString (string HtmlString);

native static function Clear ();

native static function int GetFrameMaxHeight ();

native static function EControlReturnType ControllerExecution (string strBypass);

native static function SetHtmlBuffData (string strData);

native static function SetPageLock (bool bLock);

native static function bool IsPageLock ();