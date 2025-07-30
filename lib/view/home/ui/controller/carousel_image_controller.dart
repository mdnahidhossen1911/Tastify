import 'package:get/get.dart';

import '../../../../model/network_response.dart';
import '../../../../utils/app_logger.dart';
import '../../../../utils/supabase.dart';
import '../../../../utils/supabase_tables.dart';

class CarouselImageController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _carouselImages = [];
  List<Map<String, dynamic>> get carouselImages => _carouselImages;

  Future<NetworkResponse> getImage() async {
    _isLoading = true;
    update();

    try {
      final image = await supaBase.from(SupaBaseTables.carousel).select();
      appLogger.i(image);

      _isLoading = false;
      update();

      _carouselImages = image;
      return NetworkResponse(isSuccess: true, responseData: {'data': image});
    } catch (e) {
      appLogger.e(e);

      _isLoading = false;
      update();

      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
