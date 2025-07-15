import 'package:get/get.dart';
import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/supabase.dart';

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
          .select()
          .eq('category_name', categoryName);

      _recipes = List<Map<String, dynamic>>.from(response);
      _isLoading = false;
      update();
    } catch (e) {
      appLogger.e(e.toString());
      _isLoading = false;
      update();
      rethrow; // Propagate the error
    }
  }


}