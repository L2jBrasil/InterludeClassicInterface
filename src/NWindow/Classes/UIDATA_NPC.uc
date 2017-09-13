//================================================================================
// UIDATA_NPC.
//================================================================================

class UIDATA_NPC extends UIDataManager;

native static function int GetFirstID ();

native static function int GetNextID ();

native static function bool IsValidData (int Id);

native static function string GetNPCName (int Id);

native static function bool GetNpcProperty (int Id, out array<int> arrProperty);