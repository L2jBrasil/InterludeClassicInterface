//================================================================================
// ItemWindowHandle.
//================================================================================

class ItemWindowHandle extends WindowHandle;

native static function int GetSelectedNum ();

native static function int GetItemNum ();

native static function ClearSelect ();

native static function AddItem (ItemInfo Info);

native static function bool SetItem (int Index, ItemInfo Info);

native static function DeleteItem (int Index);

native static function bool GetSelectedItem (out ItemInfo Info);

native static function bool GetItem (int Index, out ItemInfo Info);

native static function int GetSelectedItemID ();

native static function Clear ();

native static function int FindItemWithServerID (int ServerID);

native static function int FindItemWithClassID (int ClassID);

native static function SetFaded (bool bOn);

native static function ShowScrollBar (bool bShow);

native static function SwapItems (int index1, int index2);

native static function int GetIndexAt (int X, int Y, int offsetX, int offsetY);

native static function SetDisableTex (string a_DisableTex);

native static function SetRow (int a_Row);

native static function SetCol (int a_Col);