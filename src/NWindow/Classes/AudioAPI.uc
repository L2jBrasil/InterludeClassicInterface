//================================================================================
// AudioAPI.
//================================================================================

class AudioAPI extends Object;

native static function PlaySound (string a_SoundName);

native static function PlayMusic (string a_MusicName, float a_FadeInTime, optional bool a_bLooping, optional bool a_bVoice);

native static function StopMusic ();

native static function StopVoice ();