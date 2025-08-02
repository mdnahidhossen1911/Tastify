import 'package:flutter/material.dart';

import '../utils/app_logger.dart';
import '../utils/supabase.dart';
import '../utils/supabase_tables.dart';
import 'auth_view_model.dart';

class RecipeSearchViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _recipes = [];
  List<Map<String, dynamic>> get recipes => _recipes;

  Future<bool> searchWithTitle(String search) async {
    _isLoading = true;
    notifyListeners();

    try {
      final res = await supaBase
          .from(SupaBaseTables.recipe)
          .select('*, category(title), favourites(rid, uid)')
          .or('title.ilike.%$search%,category_name.ilike.%$search%')
          .order('created_at', ascending: false);

      final List<Map<String, dynamic>> recipes =
          List<Map<String, dynamic>>.from(res).map((json) {
            final favList = (json['favourites'] as List<dynamic>?) ?? [];
            final isFavourite = favList.any(
              (fav) => fav['uid'] == AuthViewModel.uid,
            );

            return {...json, 'favourites': isFavourite};
          }).toList();

      _isLoading = false;
      _recipes = recipes;
      notifyListeners();
      appLogger.i("Searched ${recipes.length} recipes with keyword: $search");
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      appLogger.e("Search Recipes Failed: $e");
      return false;
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
