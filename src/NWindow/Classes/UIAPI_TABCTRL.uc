//================================================================================
// UIAPI_TABCTRL.
//================================================================================

class UIAPI_TABCTRL extends UIAPI_WINDOW;

native static function InitTabCtrl (string ControlName);

native static function SetTopOrder (string ControlName, int Index, bool bSendMessage);

native static function int GetTopIndex (string ControlName);

native static function SetDisable (string ControlName, int Index, bool bDisable);