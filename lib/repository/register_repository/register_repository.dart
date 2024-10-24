import 'package:supertec_app_clean_code/data/network/network_api_services.dart';
import 'package:supertec_app_clean_code/res/app_urls/app_urls.dart';

class UserRegisterRepository {
  final _apiservices = NetworkApiServices();

  Future<dynamic> userRegisterApi(var data) async {
    var response = await _apiservices.postApi(data, AppUrl.userRegisterPostUrl);
    return response;
  }
}
