//================================================================================
// TextBoxHandle.
//================================================================================

class TextBoxHandle extends WindowHandle;

native final function string GetText ();

native final function SetText (string a_Text);

native final function SetTextColor (Color a_Color);

native final function Color GetTextColor ();

native final function SetAlign (ETextAlign Align);

native final function SetInt (int Number);

native final function SetTooltipString (string Text);