import 'package:flutter/material.dart';

import '../utils/app_logger.dart';
import '../utils/supabase.dart';

class AddFeedbackViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  static final String table = 'feedback';

  Future<bool> addFeedback(Map<String, dynamic> feedback) async {
    _isLoading = true;
    notifyListeners();
    try {
      final res = await supaBase.from(table).insert(feedback).select().single();

      appLogger.i("Feedback Added: ${res['id']}");
      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      appLogger.e("Add Feedback Failed: $e");
      _isLoading = false;
      notifyListeners();

      return false;
    }
  }
}
