//================================================================================
// UIAPI_RADAR.
//================================================================================

class UIAPI_RADAR extends UIScript;

native static function AddTarget (string a_ControlID, int a_X, int a_Y, int a_Z);

native static function DeleteTarget (string a_ControlID, int a_X, int a_Y, int a_Z);

native static function DeleteAllTarget (string a_ControlID);

native static function SetRadarColor (string a_ControlID, Color a_RadarColor, float a_Seconds);