import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/core/supabase.dart';

class CarouselImageController {

  static Future<NetworkResponse> getImage() async {

    try{
      final image = await supabase.from('carousel').select();
      appLogger.i(image);
      return NetworkResponse(isSuccess: true,responseData: {'data':image});
    }catch(e){
      appLogger.e(e);
      return NetworkResponse(isSuccess: false,errorMessage: e.toString());
    }

  }

}