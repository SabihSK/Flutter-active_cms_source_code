import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/data_model/slider_response.dart';

class SlidersRepository {
  Future<SliderResponse> getSliders() async {
    try {
      final response =
          await http.get(Uri.parse("${AppConfig.BASE_URL}/sliders"));
      return sliderResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }
}
