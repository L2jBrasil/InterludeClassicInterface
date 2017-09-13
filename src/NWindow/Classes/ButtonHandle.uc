//================================================================================
// ButtonHandle.
//================================================================================

class ButtonHandle extends WindowHandle;

native final function string GetButtonName ();

native final function SetButtonName (int a_NameID);

native final function SetTexture (string sForeTexture, string sBackTexture, string sHighlightTexture);