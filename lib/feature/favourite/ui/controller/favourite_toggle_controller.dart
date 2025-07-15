import 'package:get/get.dart';
import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/supabase.dart';
import 'package:tastify/feature/recipe/ui/controller/get_recipe_controller.dart';

class FavouriteToggleController {
  static const String table = 'favourites';

  static Future<NetworkResponse> toggleFavourite(String recipeId, String userId) async {

    Get.find<GetRecipeController>().updateToggle(recipeId);

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
}
