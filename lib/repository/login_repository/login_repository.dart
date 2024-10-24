import 'package:supertec_app_clean_code/data/network/network_api_services.dart';
import 'package:supertec_app_clean_code/res/app_urls/app_urls.dart';

class Loginrepository {
  final _apiservices = NetworkApiServices();

  Future<dynamic> employeeLoginApi(var data) async {
    var response =
        await _apiservices.postApi(data, AppUrl.employeeloginPostUrl);
    return response;
  }
}

class AdminLoginrepository {
  final _apiservices = NetworkApiServices();

  Future<dynamic> adminLoginApi(var data) async {
    var response = await _apiservices.postApi(data, AppUrl.adminloginPostUrl);
    return response;
  }
}
