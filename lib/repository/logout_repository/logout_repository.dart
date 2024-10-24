import 'package:supertec_app_clean_code/data/network/network_api_services.dart';

class LogoutRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> logoutApi(url) async {
    var response = await _apiService.getApi(url);
    return response;
  }
}
