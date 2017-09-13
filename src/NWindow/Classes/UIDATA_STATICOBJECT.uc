//================================================================================
// UIDATA_STATICOBJECT.
//================================================================================

class UIDATA_STATICOBJECT extends UIDataManager;

native static function int GetServerObjectNameID (int Id);

native static function EServerObjectType GetServerObjectType (int Id);

native static function int GetServerObjectMaxHP (int Id);

native static function int GetServerObjectHP (int Id);

native static function string GetStaticObjectName (int NameID);

native static function bool GetStaticObjectShowHP (int a_ID);