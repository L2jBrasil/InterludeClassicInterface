//================================================================================
// UIAPI_MINIMAPCTRL.
//================================================================================

class UIAPI_MINIMAPCTRL extends UIAPI_WINDOW;

native static function AdjustMapView (string a_ControlID, Vector loc, optional bool a_ZoomToTownMap, optional bool a_UseGridLocation);

native static function InitPosition (string a_ControlID);

native static function AddTarget (string a_ControlID, Vector a_Loc);

native static function DeleteTarget (string a_ControlID, Vector a_Loc);

native static function DeleteAllTarget (string a_ControlID);

native static function SetShowQuest (string a_ControlID, bool a_ShowQuest);

native static function SetSSQStatus (string a_ControlID, int a_SSQStatus);

native static function DrawGridIcon (string a_ControlID, string a_IconName, string a_DupIconName, Vector a_Loc, bool a_Refresh, optional int a_XOffset, optional int a_YOffset, optional string TooltipString);

native static function RequestReduceBtn (string a_ControlID);

native static function bool IsOverlapped (string a_ControlID, int FirstX, int FirstY, int SecondX, int SecondY);

native static function DeleteAllCursedWeaponIcon (string a_ControlID);