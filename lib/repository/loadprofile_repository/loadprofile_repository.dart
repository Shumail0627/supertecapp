import 'package:supertec_app_clean_code/data/network/network_api_services.dart';
import 'package:supertec_app_clean_code/res/app_urls/app_urls.dart';

class LoadProfileRepository {
  final apiServices = NetworkApiServices();

  Future<dynamic> loadIMGApi(var data) async {
    var response = await apiServices.postApi(data, AppUrl.loadimgUrl);
    return response;
  }
}
