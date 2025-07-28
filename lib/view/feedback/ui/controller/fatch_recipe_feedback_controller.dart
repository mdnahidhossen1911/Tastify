import 'package:get/get.dart';

import '../../../../utils/app_logger.dart';
import '../../../../utils/supabase.dart';
import '../../../auth/ui/controller/auth_controller.dart';

class FatchRecipeFeedbackController extends GetxController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _feedbacks = [];

  List<Map<String, dynamic>> get feedbacks => _feedbacks;

  static final String table = 'feedback';

  Future<void> fetchFeedbacks() async {
    _isLoading = true;
    update();

    try {
      final res = await supabase
          .from(table)
          .select('*, recipe(title,photo) , Users(name, photo)')
          .eq('rwid', AuthController.uid ?? '')
          .order('created_at', ascending: false);

      if (res.isNotEmpty) {
        appLogger.i("Feedbacks fetched successfully - Count: ${res.length}");
        _isLoading = false;

        _feedbacks = List<Map<String, dynamic>>.from(res);
        update();
      } else {
        appLogger.w("No feedbacks found");
        _isLoading = false;
        update();
      }
    } catch (e) {
      appLogger.e("Failed to fetch feedbacks: $e");
      _isLoading = false;
      update();
    }
  }
}
