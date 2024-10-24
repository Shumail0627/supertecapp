import 'package:supertec_app_clean_code/data/network/network_api_services.dart';

class ShiftRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> shiftApi(url) async {
    var response = await _apiServices.getApi(url);
    return response;
  }
}
