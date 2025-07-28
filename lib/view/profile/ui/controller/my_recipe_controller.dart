import 'package:get/get.dart';

import '../../../../../utils/app_logger.dart';
import '../../../../utils/supabase.dart';
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
      final res = await supabase
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
      await supabase.from('favourites').delete().eq('rid', id);
      await supabase.from('feedback').delete().eq('rid', id);
      await supabase.from('recipe').delete().eq('id', id);

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
