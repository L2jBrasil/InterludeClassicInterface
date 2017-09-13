//================================================================================
// SiegeAPI.
//================================================================================

class SiegeAPI extends Object;

native static function RequestCastleSiegeAttackerList (int castleID);

native static function RequestCastleSiegeDefenderList (int castleID);

native static function RequestJoinCastleSiege (int castleID, int IsAttacker, int IsRegister);

native static function RequestConfirmCastleSiegeWaitingList (int castleID, int clanID, int IsRegister);

native static function RequestSetCastleSiegeTime (int castleID, int TimeID);