//================================================================================
// UIDATA_QUEST.
//================================================================================

class UIDATA_QUEST extends UIDataManager;

native static function int GetFirstID ();

native static function int GetNextID ();

native static function bool IsValidData (int Id);

native static function bool IsMinimapOnly (int Id, int Level);

native static function string GetQuestName (int Id);

native static function string GetQuestJournalName (int Id, int Level);

native static function string GetQuestDescription (int Id, int Level);

native static function string GetQuestItem (int Id, int Level);

native static function Vector GetTargetLoc (int Id, int Level);

native static function string GetTargetName (int Id, int Level);

native static function Vector GetStartNPCLoc (int Id, int Level);

native static function int GetStartNPCID (int Id, int Level);

native static function string GetRequirement (int Id, int Level);

native static function string GetIntro (int Id, int Level);

native static function int GetMinLevel (int Id, int Level);

native static function int GetMaxLevel (int Id, int Level);

native static function int GetQuestType (int Id, int Level);

native static function int GetClearedQuest (int Id, int Level);

native static function int GetQuestZone (int Id, int Level);

native static function bool IsShowableJournalQuest (int Id, int Level);

native static function bool IsShowableItemNumQuest (int Id, int Level);