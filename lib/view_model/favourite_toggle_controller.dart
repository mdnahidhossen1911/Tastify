import 'package:tastify/service_locator.dart';

import '../model/network_response.dart';
import '../utils/app_logger.dart';
import '../utils/supabase.dart';
import 'fetch_popular_view_model.dart';
import 'get_recipe_view_model.dart';

class FavouriteToggleViewModel {
  static const String favouritesTable = 'favourites';
  static const String recipesTable = 'recipe';

  static Future<NetworkResponse> toggleFavourite(
    String recipeId,
    String userId,
  ) async {
    locator<GetRecipeViewModel>().updateToggle(recipeId);
    locator<FetchPopularViewModel>().updateToggle(recipeId);

    try {
      final existing =
          await supaBase
              .from(favouritesTable)
              .select()
              .eq('rid', recipeId)
              .eq('uid', userId)
              .maybeSingle();

      if (existing != null) {
        // Remove favorite
        await supaBase
            .from(favouritesTable)
            .delete()
            .eq('rid', recipeId)
            .eq('uid', userId);

        // Get current favorite count
        final currentRecipe =
            await supaBase
                .from(recipesTable)
                .select('favourite')
                .eq('id', recipeId)
                .single();

        // Decrement count
        final newCount = (currentRecipe['favourite'] as num) - 1;
        await supaBase
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
            await supaBase
                .from(favouritesTable)
                .insert({'rid': recipeId, 'uid': userId})
                .select()
                .single();

        // Get current favorite count
        final currentRecipe =
            await supaBase
                .from(recipesTable)
                .select('favourite')
                .eq('id', recipeId)
                .single();

        // Increment count
        final newCount = (currentRecipe['favourite'] as num) + 1;
        await supaBase
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
