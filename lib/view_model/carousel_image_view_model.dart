import 'package:flutter/cupertino.dart';

import '../model/network_response.dart';
import '../utils/app_logger.dart';
import '../utils/supabase.dart';
import '../utils/supabase_tables.dart';

class CarouselImageViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _carouselImages = [];
  List<Map<String, dynamic>> get carouselImages => _carouselImages;

  Future<NetworkResponse> getImage() async {
    _isLoading = true;
    notifyListeners();
    try {
      final image = await supaBase.from(SupaBaseTables.carousel).select();
      appLogger.i(image);

      _isLoading = false;
      notifyListeners();

      _carouselImages = image;
      return NetworkResponse(isSuccess: true, responseData: {'data': image});
    } catch (e) {
      appLogger.e(e);

      _isLoading = false;
      notifyListeners();

      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
