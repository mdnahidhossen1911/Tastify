import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/supabase.dart';
import 'package:tastify/feature/recipe/data/model/recipe_model.dart';


class RecipeController {

  static final String table = 'recipe';

  static Future<NetworkResponse> addRecipe(RecipeModel recipe) async {
    try {
      final res = await supabase.from(table).insert(recipe.toJson()).select().single();

      appLogger.i("Recipe Added: ${res['id']}");
      return NetworkResponse(isSuccess: true, responseData: res);
    } catch (e) {
      appLogger.e("Add Recipe Failed: $e");
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> updateRecipe(String id, RecipeModel recipe) async {
    try {
      final data = recipe.toJson();
      data.removeWhere((key, value) => value == null);

      final res = await supabase.from(table).update(data).eq('id', id).select().single();

      appLogger.i("Recipe Updated: $id");
      return NetworkResponse(isSuccess: true, responseData: res);
    } catch (e) {
      appLogger.e("Update Failed: $e");
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> getAllRecipes(String currentUserId) async {
    try {
      final res = await supabase
          .from(table)
          .select('*, category(title), favourites(rid, uid)')
          .order('created_at', ascending: false);

      final List<Map<String, dynamic>> recipes = List<Map<String, dynamic>>.from(res).map((json) {
        final categoryTitle = json['category']?['title'];

        final favList = (json['favourites'] as List<dynamic>?) ?? [];
        final isFavourite = favList.any((fav) => fav['uid'] == currentUserId);

        return {
          ...json,
          'category_name': categoryTitle,
          'favourites': isFavourite,
        };
      }).toList();

      appLogger.i("Fetched ${recipes.length} recipes with favourites & category");
      return NetworkResponse(isSuccess: true, responseData: {"recipes": recipes});
    } catch (e) {
      appLogger.e("Fetch Recipes Failed: $e");
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }



  static Future<NetworkResponse> deleteRecipe(String id) async {
    try {
      await supabase.from(table).delete().eq('id', id);
      appLogger.i("Recipe Deleted: $id");
      return NetworkResponse(isSuccess: true);
    } catch (e) {
      appLogger.e("Delete Failed: $e");
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
