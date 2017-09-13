//================================================================================
// ListCtrlHandle.
//================================================================================

class ListCtrlHandle extends WindowHandle;

native final function InsertRecord (LVDataRecord Record);

native final function LVDataRecord GetSelectedRecord ();

native final function DeleteAllItem ();

native final function DeleteRecord (int Index);

native final function int GetRecordCount ();

native final function LVDataRecord GetRecord (int Index);

native final function int GetSelectedIndex ();

native final function SetSelectedIndex (int Index, bool bMoveToRow);

native final function ShowScrollBar (bool bShow);

native final function bool ModifyRecord (int Index, LVDataRecord Record);