import 'package:flutter/foundation.dart';

import '../utils/app_logger.dart';
import '../utils/supabase.dart';
import '../utils/supabase_tables.dart';
import 'auth_view_model.dart';

class GetRecipeByCategoryViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _recipes = [];
  List<Map<String, dynamic>> get recipes => _recipes;

  Future<void> getRecipesByCategory(String categoryName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await supaBase
          .from(SupaBaseTables.recipe)
          .select('*, favourites(rid, uid)')
          .eq('category_name', categoryName);

      final List<Map<String, dynamic>> recipes =
          List<Map<String, dynamic>>.from(response).map((json) {
            final favList = (json['favourites'] as List<dynamic>?) ?? [];
            final isFavourite = favList.any(
              (fav) => fav['uid'] == AuthViewModel.uid,
            );

            return {...json, 'favourites': isFavourite};
          }).toList();

      _recipes = recipes;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      appLogger.e(e.toString());
      _isLoading = false;
      notifyListeners();
      rethrow; // Propagate the error
    }
  }

  Future<void> updateToggle(String RID) async {
    for (Map<String, dynamic> recipe in _recipes) {
      if (recipe['id'] == RID) {
        recipe['favourites'] = !(recipe['favourites'] == true);
        notifyListeners();
        break;
      }
    }
  }
}
