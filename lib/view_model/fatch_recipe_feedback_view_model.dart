import 'package:flutter/material.dart';

import '../utils/app_logger.dart';
import '../utils/supabase.dart';
import 'auth_view_model.dart';

class FetchRecipeFeedbackViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _feedbacks = [];

  List<Map<String, dynamic>> get feedbacks => _feedbacks;

  static final String table = 'feedback';

  Future<void> fetchFeedbacks() async {
    _isLoading = true;
    notifyListeners();

    try {
      final res = await supaBase
          .from(table)
          .select('*, recipe(title,photo) , Users(name, photo)')
          .eq('rwid', AuthViewModel.uid ?? '')
          .order('created_at', ascending: false);

      if (res.isNotEmpty) {
        appLogger.i("Feedbacks fetched successfully - Count: ${res.length}");
        _isLoading = false;

        _feedbacks = List<Map<String, dynamic>>.from(res);
        notifyListeners();
      } else {
        appLogger.w("No feedbacks found");
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      appLogger.e("Failed to fetch feedbacks: $e");
      _isLoading = false;
      notifyListeners();
    }
  }
}
