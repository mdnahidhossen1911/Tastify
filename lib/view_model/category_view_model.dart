import 'package:flutter/cupertino.dart';

import '../model/network_response.dart';
import '../utils/app_logger.dart';
import '../utils/supabase.dart';
import '../utils/supabase_tables.dart';

class CategoryViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _categoryList = [];
  List<Map<String, dynamic>> get categoryList => _categoryList;

  Future<NetworkResponse> getCategory() async {
    _isLoading = true;
    notifyListeners();

    try {
      final categoryItems =
          await supaBase.from(SupaBaseTables.category).select();
      appLogger.i(categoryItems);

      _isLoading = false;
      notifyListeners();

      appLogger.i(categoryItems);
      _categoryList = List<Map<String, dynamic>>.from(categoryItems);
      return NetworkResponse(
        isSuccess: true,
        responseData: {"data": categoryItems},
      );
    } catch (e) {
      appLogger.e(e);

      _isLoading = false;
      notifyListeners();

      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
