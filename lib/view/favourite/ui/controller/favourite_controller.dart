import 'package:get/get.dart';

import '../../../../utils/app_logger.dart';
import '../../../../utils/supabase.dart';
import '../../../../utils/supabase_tables.dart';

class GetFavouriteController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _favouriteRecipes = [];
  List<Map<String, dynamic>> get favouriteRecipes => _favouriteRecipes;

  Future<bool> FavouriteRecipes(String userId) async {
    _isLoading = true;
    update();

    try {
      final res = await supaBase
          .from(SupaBaseTables.favourites)
          .select('rid, recipe(*)') // ✅ fixed syntax
          .eq('uid', userId);

      List<Map<String, dynamic>> favRecipes =
          List<Map<String, dynamic>>.from(res).map((item) {
            final recipe = Map<String, dynamic>.from(item['recipe']);
            recipe['favourites'] = true;
            return recipe;
          }).toList();

      _favouriteRecipes = favRecipes;
      appLogger.i("Fetched ${favRecipes.length} favourite recipes for $userId");

      _isLoading = false; // ✅ always stop loading, even if it succeeds
      update();

      return true;
    } catch (e) {
      _isLoading = false; // ✅ always stop loading, even if it fails
      update();
      appLogger.e("Fetch Favourites Failed: $e");
      return false;
    }
  }

  Future<void> removeFavourite(String RID) async {
    _favouriteRecipes.removeWhere((e) => e['id'] == RID);
    update();
  }
}
