//================================================================================
// UIAPI_INVENWEIGHT.
//================================================================================

class UIAPI_INVENWEIGHT extends UIAPI_WINDOW;

native static function AddWeight (string ControlName, int Weight);

native static function ReduceWeight (string ControlName, int Weight);

native static function ZeroWeight (string ControlName);