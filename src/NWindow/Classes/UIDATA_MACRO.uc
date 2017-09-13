//================================================================================
// UIDATA_MACRO.
//================================================================================

class UIDATA_MACRO extends UIDataManager;

native static function bool GetMacroInfo (int MacroID, out MacroInfo Info);

native static function int GetMacroCount ();