import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/supabase.dart';

class RecipeSearchController {

  static Future<NetworkResponse> searchWithTitle(String search, String currentUserId) async {
    try {
      final res = await supabase
          .from('recipe')
          .select('*, category(title), favourites(rid, uid)')
          .or('title.ilike.%$search%')
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

      appLogger.i("Searched ${recipes.length} recipes with keyword: $search");
      return NetworkResponse(isSuccess: true, responseData: {"recipes": recipes});
    } catch (e) {
      appLogger.e("Search Recipes Failed: $e");
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

}