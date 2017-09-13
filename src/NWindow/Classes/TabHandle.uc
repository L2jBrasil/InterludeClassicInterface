//================================================================================
// TabHandle.
//================================================================================

class TabHandle extends WindowHandle;

native final function InitTabCtrl ();

native final function SetTopOrder (int Index, bool bSendMessage);

native final function int GetTopIndex ();

native final function SetDisable (int Index, bool bDisable);

native final function MergeTab (int Index);