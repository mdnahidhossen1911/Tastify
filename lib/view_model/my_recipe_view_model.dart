import 'package:flutter/cupertino.dart';

import '../../utils/app_logger.dart';
import '../utils/supabase.dart';
import '../utils/supabase_tables.dart';
import 'auth_view_model.dart';

class MyRecipeViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _myRecipes = [];

  List<Map<String, dynamic>> get myRecipes => _myRecipes;

  static final String table = 'recipe';

  Future<void> fetchMyRecipes() async {
    _isLoading = true;

    notifyListeners();

    try {
      final res = await supaBase
          .from(table)
          .select()
          .eq('user_id', AuthViewModel.uid ?? '')
          .order('created_at', ascending: false);

      _myRecipes = List<Map<String, dynamic>>.from(res);
      _isLoading = false;
      notifyListeners();

      appLogger.i(
        "Fetched ${_myRecipes.length} recipes for user ${AuthViewModel.uid ?? ''}",
      );
    } catch (e) {
      appLogger.e("Fetch My Recipes Failed: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteRecipe(String id) async {
    try {
      await supaBase.from(SupaBaseTables.favourites).delete().eq('rid', id);
      await supaBase.from(SupaBaseTables.feedback).delete().eq('rid', id);
      await supaBase.from(SupaBaseTables.recipe).delete().eq('id', id);

      _myRecipes.removeWhere((recipe) => recipe['id'] == id);
      notifyListeners();

      appLogger.i("Recipe Deleted: $id");
      return true;
    } catch (e) {
      appLogger.e("Delete Recipe Failed: $e");
      return false;
    }
  }
}
