import 'package:supertec_app_clean_code/data/network/network_api_services.dart';

class AttendanceRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> attendanceApi(url) async {
    var response = await _apiServices.getApi(url);
    return response;
  }
}
