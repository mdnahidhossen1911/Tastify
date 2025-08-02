import 'package:flutter/cupertino.dart';

import '../model/network_response.dart';
import '../utils/app_logger.dart';
import '../utils/supabase.dart';

class GetRecipeViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _recipes = [];
  List<Map<String, dynamic>> get recipes => _recipes;

  static final String table = 'recipe';

  Future<NetworkResponse> getAllRecipes(String currentUserId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final res = await supaBase
          .from(table)
          .select('*, category(title), favourites(rid, uid)')
          .order('created_at', ascending: false);

      final List<Map<String, dynamic>> recipes =
          List<Map<String, dynamic>>.from(res).map((json) {
            final favList = (json['favourites'] as List<dynamic>?) ?? [];
            final isFavourite = favList.any(
              (fav) => fav['uid'] == currentUserId,
            );

            return {...json, 'favourites': isFavourite};
          }).toList();

      _isLoading = false;
      notifyListeners();

      _recipes = recipes;

      appLogger.i(
        "Fetched ${recipes.length} recipes with favourites & category",
      );
      return NetworkResponse(
        isSuccess: true,
        responseData: {"recipes": recipes},
      );
    } catch (e) {
      appLogger.e("Fetch Recipes Failed: $e");

      _isLoading = false;
      notifyListeners();

      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
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
