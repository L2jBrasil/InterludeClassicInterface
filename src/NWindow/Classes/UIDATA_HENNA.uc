//================================================================================
// UIDATA_HENNA.
//================================================================================

class UIDATA_HENNA extends UIDataManager;

native static function bool GetItemName (int a_ID, out string a_ItemName);

native static function bool GetDescription (int a_ID, out string a_Description);

native static function bool GetIconTex (int a_ID, out string a_IconTex);