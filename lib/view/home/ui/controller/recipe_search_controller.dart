import 'package:get/get.dart';

import '../../../../utils/app_logger.dart';
import '../../../../utils/supabase.dart';
import '../../../auth/ui/controller/auth_controller.dart';

class RecipeSearchController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _recipes = [];
  List<Map<String, dynamic>> get recipes => _recipes;

  Future<bool> searchWithTitle(String search) async {
    _isLoading = true;
    update();

    try {
      final res = await supabase
          .from('recipe')
          .select('*, category(title), favourites(rid, uid)')
          .or('title.ilike.%$search%,category_name.ilike.%$search%')
          .order('created_at', ascending: false);

      final List<Map<String, dynamic>> recipes =
          List<Map<String, dynamic>>.from(res).map((json) {
            final favList = (json['favourites'] as List<dynamic>?) ?? [];
            final isFavourite = favList.any(
              (fav) => fav['uid'] == AuthController.uid,
            );

            return {...json, 'favourites': isFavourite};
          }).toList();

      _isLoading = false;
      _recipes = recipes;
      update();
      appLogger.i("Searched ${recipes.length} recipes with keyword: $search");
      return true;
    } catch (e) {
      _isLoading = false;
      update();
      appLogger.e("Search Recipes Failed: $e");
      return false;
    }
  }

  Future<void> updateToggle(String RID) async {
    for (Map<String, dynamic> recipe in _recipes) {
      if (recipe['id'] == RID) {
        recipe['favourites'] = !(recipe['favourites'] == true);
        update(['fav-$RID']);
        break;
      }
    }
  }
}
