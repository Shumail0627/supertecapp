import 'package:supertec_app_clean_code/data/network/network_api_services.dart';

class CheckInRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> checkinApi(url) async {
    var response = await _apiServices.getApi(url);
    return response;
  }
}
