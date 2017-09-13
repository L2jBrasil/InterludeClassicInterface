//================================================================================
// ComboBoxHandle.
//================================================================================

class ComboBoxHandle extends WindowHandle;

native final function AddString (string Str);

native final function SYS_AddString (int Index);

native final function AddStringWithReserved (string Str, int Reserved);

native final function SYS_AddStringWithReserved (int Index, int Reserved);

native final function string GetString (int Num);

native final function int GetReserved (int Num);

native final function int GetSelectedNum ();

native final function SetSelectedNum (int Num);

native final function Clear ();