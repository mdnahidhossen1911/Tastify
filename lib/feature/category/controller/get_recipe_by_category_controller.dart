import 'package:get/get.dart';
import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/supabase.dart';
import 'package:tastify/feature/auth/ui/controller/auth_controller.dart';

class GetRecipeByCategoryController extends GetxController {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _recipes = [];
  List<Map<String, dynamic>> get recipes => _recipes;

  Future<void> getRecipesByCategory(String categoryName) async {
    _isLoading = true;
    update();

    try {
      final response = await supabase
          .from('recipe')
          .select('*, favourites(rid, uid)')
          .eq('category_name', categoryName);

      final List<Map<String, dynamic>> recipes = List<Map<String, dynamic>>.from(response).map((json) {
        final favList = (json['favourites'] as List<dynamic>?) ?? [];
        final isFavourite = favList.any((fav) => fav['uid'] == AuthController.uid);

        return {
          ...json,
          'favourites': isFavourite,
        };
      }).toList();


      _recipes = recipes;
      _isLoading = false;
      update();
    } catch (e) {
      appLogger.e(e.toString());
      _isLoading = false;
      update();
      rethrow; // Propagate the error
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