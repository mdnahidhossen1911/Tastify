import 'package:get/get.dart';

import '../../../../utils/app_logger.dart';
import '../../../../utils/supabase.dart';

class FeedbackController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  static final String table = 'feedback';

  Future<bool> addFeedback(Map<String, dynamic> feedback) async {
    _isLoading = true;
    update();

    try {
      final res = await supabase.from(table).insert(feedback).select().single();

      appLogger.i("Feedback Added: ${res['id']}");
      _isLoading = false;
      update();

      return true;
    } catch (e) {
      appLogger.e("Add Feedback Failed: $e");
      _isLoading = false;
      update();

      return false;
    }
  }
}
