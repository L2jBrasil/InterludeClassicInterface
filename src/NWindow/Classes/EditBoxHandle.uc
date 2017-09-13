//================================================================================
// EditBoxHandle.
//================================================================================

class EditBoxHandle extends WindowHandle;

native final function string GetString ();

native final function SetString (string Str);

native final function AddString (string Str);

native final function SimulateBackspace ();

native final function Clear ();

native final function SetEditType (string Type);

native final function SetHighLight (bool bHighlight);

native final function SetMaxLength (int maxLength);

native final function int GetMaxLength ();