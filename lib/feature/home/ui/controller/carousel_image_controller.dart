import 'package:get/get.dart';
import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/supabase.dart';

class CarouselImageController extends GetxController{

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<NetworkResponse> getImage() async {

    _isLoading = true;
    update();

    try{
      final image = await supabase.from('carousel').select();
      appLogger.i(image);

      _isLoading = false;
      update();

      return NetworkResponse(isSuccess: true,responseData: {'data':image});
    }catch(e){
      appLogger.e(e);

      _isLoading = false;
      update();

      return NetworkResponse(isSuccess: false,errorMessage: e.toString());
    }

  }

}