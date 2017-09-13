//================================================================================
// UIAPI_ITEMWINDOW.
//================================================================================

class UIAPI_ITEMWINDOW extends UIAPI_WINDOW;

native static function int GetSelectedNum (string ControlName);

native static function int GetItemNum (string ControlName);

native static function ClearSelect (string ControlName);

native static function AddItem (string ControlName, ItemInfo Info);

native static function SetItem (string ControlName, int Index, ItemInfo Info);

native static function DeleteItem (string ControlName, int Index);

native static function bool GetSelectedItem (string ControlName, out ItemInfo Info);

native static function bool GetItem (string ControlName, int Index, out ItemInfo Info);

native static function int GetSelectedItemID (string ControlName);

native static function Clear (string ControlName);

native static function int FindItemWithServerID (string ControlName, int ServerID);

native static function int FindItemWithClassID (string ControlName, int ClassID);

native static function SetFaded (string ControlName, bool bOn);

native static function ShowScrollBar (string ControlName, bool bShow);