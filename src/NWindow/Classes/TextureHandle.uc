//================================================================================
// TextureHandle.
//================================================================================

class TextureHandle extends WindowHandle;

native final function SetTexture (string a_TextureName);

native final function SetUV (int a_U, int a_V);

native final function SetTextureSize (int a_UL, int a_VL);

native final function SetTextureCtrlType (ETextureCtrlType Type);

native final function SetTextureWithClanCrest (int clanID);

native final function SetTextureWithObject (Texture objTexture);

native final function string GetTextureName ();