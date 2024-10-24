import 'package:supertec_app_clean_code/data/network/network_api_services.dart';

class LeaveRepository {
  final _apiservices = NetworkApiServices();

  Future<dynamic> leaveApi(url) async {
    var response = await _apiservices.getApi(url);
    return response;
  }
}
