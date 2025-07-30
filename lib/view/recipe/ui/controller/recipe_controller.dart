import 'package:get/get.dart';

import '../../../../model/network_response.dart';
import '../../../../model/recipe_model.dart';
import '../../../../utils/app_logger.dart';
import '../../../../utils/supabase.dart';

class RecipeController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  static final String table = 'recipe';

  Future<NetworkResponse> addRecipe(RecipeModel recipe) async {
    _isLoading = true;
    update();

    try {
      final res =
          await supaBase.from(table).insert(recipe.toJson()).select().single();

      appLogger.i("Recipe Added: ${res['id']}");

      _isLoading = false;
      update();

      return NetworkResponse(isSuccess: true, responseData: res);
    } catch (e) {
      appLogger.e("Add Recipe Failed: $e");
      _isLoading = false;
      update();

      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  Future<NetworkResponse> updateRecipe(String id, RecipeModel recipe) async {
    _isLoading = true;
    update();

    try {
      final data = recipe.toJson();
      data.removeWhere((key, value) => value == null);

      final res =
          await supaBase
              .from(table)
              .update(data)
              .eq('id', id)
              .select()
              .single();

      appLogger.i("Recipe Updated: $id");
      _isLoading = false;
      update();

      return NetworkResponse(isSuccess: true, responseData: res);
    } catch (e) {
      appLogger.e("Update Failed: $e");

      _isLoading = false;
      update();

      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  Future<NetworkResponse> deleteRecipe(String id) async {
    _isLoading = true;
    update();

    try {
      await supaBase.from(table).delete().eq('id', id);
      appLogger.i("Recipe Deleted: $id");

      _isLoading = false;
      update();

      return NetworkResponse(isSuccess: true);
    } catch (e) {
      appLogger.e("Delete Failed: $e");

      _isLoading = false;
      update();

      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
