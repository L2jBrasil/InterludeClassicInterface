//================================================================================
// UIAPI_MULTISELLITEMINFO.
//================================================================================

class UIAPI_MULTISELLITEMINFO extends UIAPI_WINDOW;

native static function SetItemInfo (string ControlName, int Index, ItemInfo item);

native static function Clear (string ControlName);