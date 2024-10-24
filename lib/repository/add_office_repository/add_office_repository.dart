import 'package:supertec_app_clean_code/data/network/network_api_services.dart';

class AddOfficeRepository {
  final _apiservices = NetworkApiServices();

  Future<dynamic> addOfficeInfoApi(var url) async {
    var response = await _apiservices.getApi(
      url,
    );
    return response;
  }

  Future<dynamic> getOfficeLocations() async {
    var response = await _apiservices.getApi(
      "https://superteclabs.com/apis2/get_office_locations.php",
    );
    return response;
  }
}
