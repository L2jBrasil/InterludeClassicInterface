//================================================================================
// UIDATA_SKILL.
//================================================================================

class UIDATA_SKILL extends UIDataManager;

native static function int GetFirstID ();

native static function int GetNextID ();

native static function int GetDataCount ();

native static function string GetIconName (int ClassID, int Level);

native static function string GetName (int ClassID, int Level);

native static function string GetDescription (int ClassID, int Level);

native static function string GetEnchantName (int ClassID, int Level);

native static function int GetEnchantSkillLevel (int ClassID, int Level);

native static function string GetOperateType (int ClassID, int Level);

native static function int GetHpConsume (int ClassID, int Level);

native static function int GetMpConsume (int ClassID, int Level);

native static function int GetCastRange (int ClassID, int Level);