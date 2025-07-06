import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/supabase.dart';

class CategoryController {
  static Future<NetworkResponse> categorys() async {
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
}

