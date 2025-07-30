import 'package:get/get.dart';

import '../../../../../utils/app_logger.dart';
import '../../../../utils/supabase.dart';
import '../../../../utils/supabase_tables.dart';
import '../../../auth/ui/controller/auth_controller.dart';

class MyRecipeController extends GetxController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _myRecipes = [];

  List<Map<String, dynamic>> get myRecipes => _myRecipes;

  static final String table = 'recipe';

  Future<void> fetchMyRecipes() async {
    _isLoading = true;
    update();

    try {
      final res = await supaBase
          .from(table)
          .select()
          .eq('user_id', AuthController.uid ?? '')
          .order('created_at', ascending: false);

      _myRecipes = List<Map<String, dynamic>>.from(res);
      _isLoading = false;
      update();

      appLogger.i(
        "Fetched ${_myRecipes.length} recipes for user ${AuthController.uid ?? ''}",
      );
    } catch (e) {
      appLogger.e("Fetch My Recipes Failed: $e");
      _isLoading = false;
      update();
    }
  }

  Future<bool> deleteRecipe(String id) async {
    try {
      await supaBase.from(SupaBaseTables.favourites).delete().eq('rid', id);
      await supaBase.from(SupaBaseTables.feedback).delete().eq('rid', id);
      await supaBase.from(SupaBaseTables.recipe).delete().eq('id', id);

      _myRecipes.removeWhere((recipe) => recipe['id'] == id);
      update();

      appLogger.i("Recipe Deleted: $id");
      return true;
    } catch (e) {
      appLogger.e("Delete Recipe Failed: $e");
      return false;
    }
  }
}
