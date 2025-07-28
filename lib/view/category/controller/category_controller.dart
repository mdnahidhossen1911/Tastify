import 'package:get/get.dart';

import '../../../model/network_response.dart';
import '../../../utils/app_logger.dart';
import '../../../utils/supabase.dart';

class CategoryController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _categoryList = [];
  List<Map<String, dynamic>> get categoryList => _categoryList;

  Future<NetworkResponse> getCategory() async {
    _isLoading = true;
    update();

    try {
      final categoryItems = await supabase.from('category').select();
      appLogger.i(categoryItems);

      _isLoading = false;
      update();

      appLogger.i(categoryItems);
      _categoryList = List<Map<String, dynamic>>.from(categoryItems);
      return NetworkResponse(
        isSuccess: true,
        responseData: {"data": categoryItems},
      );
    } catch (e) {
      appLogger.e(e);

      _isLoading = false;
      update();

      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
