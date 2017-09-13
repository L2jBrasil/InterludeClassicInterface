//================================================================================
// UIDATA_ITEM.
//================================================================================

class UIDATA_ITEM extends UIDataManager;

native static function int GetFirstID ();

native static function int GetNextID ();

native static function int GetDataCount ();

native static function string GetItemName (int Id);

native static function string GetItemAdditionalName (int Id);

native static function string GetItemTextureName (int Id);

native static function string GetItemDescription (int Id);

native static function int GetItemClassID (int Id);

native static function int GetItemWeight (int Id);

native static function int GetItemDataType (int ClassID);

native static function int GetItemCrystalType (int ClassID);

native static function bool GetItemInfo (int ClassID, out ItemInfo Info);

native static function bool IsCrystallizable (int ClassID);

native static function string GetRefineryItemName (string strItemName, int RefineryOp1, int RefineryOp2);

native static function GetSetItemIDList (int ClassID, int EffectID, out array<int> arrID);

native static function int GetSetItemEnchantValue (int ClassID);

native static function string GetSetItemEffectDescription (int ClassID, int EffectID);

native static function string GetSetItemEnchantEffectDescription (int ClassID);