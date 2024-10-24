import 'package:supertec_app_clean_code/data/network/network_api_services.dart';

class TaskStatusRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> taskStatusApi(url) async {
    var response = await _apiService.getApi(url);
    return response;
  }
}
