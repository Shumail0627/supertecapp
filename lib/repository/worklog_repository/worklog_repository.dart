import 'package:supertec_app_clean_code/data/network/network_api_services.dart';
import 'package:supertec_app_clean_code/res/app_urls/app_urls.dart';

class WorkLogRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> workLogApi(var data) async {
    var response = await _apiServices.postApi(data, AppUrl.worklogPostUrl);
    return response;
  }
}
