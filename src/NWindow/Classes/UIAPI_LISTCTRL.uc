//================================================================================
// UIAPI_LISTCTRL.
//================================================================================

class UIAPI_LISTCTRL extends UIAPI_WINDOW;

native static function InsertRecord (string ControlName, LVDataRecord Record);

native static function bool ModifyRecord (string ControlName, int Index, LVDataRecord Record);

native static function LVDataRecord GetSelectedRecord (string ControlName);

native static function DeleteAllItem (string ControlName);

native static function DeleteRecord (string ControlName, int Index);

native static function int GetRecordCount (string ControlName);

native static function LVDataRecord GetRecord (string ControlName, int Index);

native static function int GetSelectedIndex (string ControlName);

native static function SetSelectedIndex (string ControlName, int Index, bool bMoveToRow);

native static function ShowScrollBar (string ControlName, bool bShow);