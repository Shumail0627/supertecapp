import 'package:supertec_app_clean_code/data/network/network_api_services.dart';

class ForgetRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> forgetApi(url) async {
    var response = await _apiServices.getApi(url);
    return response;
  }
}
