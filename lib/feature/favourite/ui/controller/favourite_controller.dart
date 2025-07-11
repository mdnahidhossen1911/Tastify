import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/supabase.dart';

class FavouriteController {
  static const String table = 'favourites';

  static Future<NetworkResponse> toggleFavourite(String recipeId, String userId) async {
    try {
      final existing = await supabase
          .from(table)
          .select()
          .eq('rid', recipeId)
          .eq('uid', userId)
          .maybeSingle();

      if (existing != null) {
        await supabase.from(table).delete().eq('rid', recipeId).eq('uid', userId);
        appLogger.i("Favourite removed for recipe: $recipeId by user: $userId");
        return NetworkResponse(isSuccess: true, responseData: {'favourited': false});
      } else {
        final res = await supabase
            .from(table)
            .insert({'rid': recipeId, 'uid': userId})
            .select()
            .single();

        appLogger.i("Favourite added for recipe: $recipeId by user: $userId");
        return NetworkResponse(isSuccess: true, responseData: {'favourited': true, 'data': res});
      }
    } catch (e) {
      appLogger.e("Toggle Favourite Failed: $e");
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }


  static Future<NetworkResponse> getFavouriteRecipes(String userId) async {
    try {
      final res = await supabase
          .from(table)
          .select('rid, recipe(*, category(title))')
          .eq('uid', userId);

      final List favRecipes = List<Map<String, dynamic>>.from(res).map((item) {
        final recipe = item['recipe'];
        recipe['category_name'] = recipe['category']?['title'];
        recipe['favourites'] = true;
        return recipe;
      }).toList();

      appLogger.i("Fetched ${favRecipes.length} favourite recipes for $userId");
      return NetworkResponse(isSuccess: true, responseData: {'recipes': favRecipes});
    } catch (e) {
      appLogger.e("Fetch Favourites Failed: $e");
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
