//================================================================================
// UIDATA_USER.
//================================================================================

class UIDATA_USER extends UIDataManager;

native static function string GetUserName (int ServerID);

native static function bool GetClanType (int Id, out int Type);