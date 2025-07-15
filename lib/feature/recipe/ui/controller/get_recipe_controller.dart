import 'package:get/get.dart';
import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/supabase.dart';

class GetRecipeController extends GetxController {


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List <Map<String, dynamic>> _recipes = [];
  List<Map<String, dynamic>> get recipes => _recipes;

  static final String table = 'recipe';

  Future<NetworkResponse> getAllRecipes(String currentUserId) async {

    _isLoading = true;
    update();

    try {
      final res = await supabase
          .from(table)
          .select('*, category(title), favourites(rid, uid)')
          .order('created_at', ascending: false);

      final List<Map<String, dynamic>> recipes = List<Map<String, dynamic>>.from(res).map((json) {
        final favList = (json['favourites'] as List<dynamic>?) ?? [];
        final isFavourite = favList.any((fav) => fav['uid'] == currentUserId);

        return {
          ...json,
          'favourites': isFavourite,
        };
      }).toList();

      _isLoading = false;
      update();

      _recipes = recipes;

      appLogger.i("Fetched ${recipes.length} recipes with favourites & category");
      return NetworkResponse(isSuccess: true, responseData: {"recipes": recipes});

    } catch (e) {
      appLogger.e("Fetch Recipes Failed: $e");

      _isLoading = false;
      update();

      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }


}