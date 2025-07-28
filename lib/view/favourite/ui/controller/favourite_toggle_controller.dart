import 'package:get/get.dart';

import '../../../../model/network_response.dart';
import '../../../../utils/app_logger.dart';
import '../../../../utils/supabase.dart';
import '../../../home/ui/controller/fetch_popular_item_controller.dart';
import '../../../recipe/ui/controller/get_recipe_controller.dart';

class FavouriteToggleController {
  static const String favouritesTable = 'favourites';
  static const String recipesTable = 'recipe';

  static Future<NetworkResponse> toggleFavourite(
    String recipeId,
    String userId,
  ) async {
    Get.find<GetRecipeController>().updateToggle(recipeId);
    Get.find<FetchPopularItemController>().updateToggle(recipeId);

    try {
      final existing =
          await supabase
              .from(favouritesTable)
              .select()
              .eq('rid', recipeId)
              .eq('uid', userId)
              .maybeSingle();

      if (existing != null) {
        // Remove favorite
        await supabase
            .from(favouritesTable)
            .delete()
            .eq('rid', recipeId)
            .eq('uid', userId);

        // Get current favorite count
        final currentRecipe =
            await supabase
                .from(recipesTable)
                .select('favourite')
                .eq('id', recipeId)
                .single();

        // Decrement count
        final newCount = (currentRecipe['favourite'] as num) - 1;
        await supabase
            .from(recipesTable)
            .update({'favourite': newCount})
            .eq('id', recipeId);

        appLogger.i("ফেভারিট মুছে দেওয়া হয়েছে: রেসিপি ID $recipeId");
        return NetworkResponse(
          isSuccess: true,
          responseData: {'favourited': false},
        );
      } else {
        // Add favorite
        final res =
            await supabase
                .from(favouritesTable)
                .insert({'rid': recipeId, 'uid': userId})
                .select()
                .single();

        // Get current favorite count
        final currentRecipe =
            await supabase
                .from(recipesTable)
                .select('favourite')
                .eq('id', recipeId)
                .single();

        // Increment count
        final newCount = (currentRecipe['favourite'] as num) + 1;
        await supabase
            .from(recipesTable)
            .update({'favourite': newCount})
            .eq('id', recipeId);

        appLogger.i("ফেভারিট যোগ করা হয়েছে: রেসিপি ID $recipeId");
        return NetworkResponse(
          isSuccess: true,
          responseData: {'favourited': true, 'data': res},
        );
      }
    } catch (e) {
      appLogger.e("ফেভারিট টগল করতে সমস্যা: $e");
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
