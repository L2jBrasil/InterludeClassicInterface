//================================================================================
// UIDATA_RECIPE.
//================================================================================

class UIDATA_RECIPE extends UIDataManager;

native static function int GetRecipeClassID (int Id);

native static function string GetRecipeIconName (int Id);

native static function int GetRecipeProductID (int Id);

native static function int GetRecipeProductNum (int Id);

native static function int GetRecipeCrystalType (int Id);

native static function int GetRecipeMpConsume (int Id);

native static function int GetRecipeLevel (int Id);

native static function int GetRecipeIndex (int Id);

native static function string GetRecipeDescription (int Id);

native static function int GetRecipeSuccessRate (int Id);

native static function ParamStack GetRecipeMaterialItem (int Id);

native static function string GetRecipeNameBy2Condition (int Id, int nSuccessRate);

native static function string GetRecipeIconNameBy2Condition (int Id, int nSuccessRate);

native static function string GetRecipeDescriptionBy2Condition (int Id, int nSuccessRate);

native static function ParamStack GetRecipeMaterialItemBy2Condition (int Id, int nSuccessRate);