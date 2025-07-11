import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/supabase.dart';

class CategoryController {
  static Future<NetworkResponse> getCategory() async {
    try {
      final categoryItems = await supabase.from('category').select();
      appLogger.i(categoryItems);
      return NetworkResponse(
        isSuccess: true,
        responseData: {"data": categoryItems},
      );
    } catch (e) {
      appLogger.e(e);
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }


  static Future<NetworkResponse> getRecipesByCategory(String currentUserId, String categoryId) async {
    try {
      final res = await supabase
          .from('recipe')
          .select('*, category(title), favourites(rid, uid)')
          .eq('cid', categoryId)
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

      appLogger.i("Fetched ${recipes.length} recipes for category $categoryId");
      return NetworkResponse(isSuccess: true, responseData: {"recipes": recipes});
    } catch (e) {
      appLogger.e("Fetch Recipes by Category Failed: $e");
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}

