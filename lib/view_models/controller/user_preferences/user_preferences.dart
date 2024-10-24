import 'package:shared_preferences/shared_preferences.dart';
import 'package:supertec_app_clean_code/models/checkinPref/checkin_pref_model.dart';
import 'package:supertec_app_clean_code/models/login/admin_model.dart';
import 'package:supertec_app_clean_code/models/login/user_model.dart';
import 'package:supertec_app_clean_code/models/user_agreement/user_agreement_model.dart';

class UserPreferences {
  Future<bool> saveUser(UserModel data) async {
    final sp = await SharedPreferences.getInstance();
    sp.setBool('login', true);
    sp.setString('id', data.id.toString());
    sp.setString('name', data.name.toString());
    sp.setString('email', data.email.toString());
    sp.setString('companyToken', data.companyToken.toString());
    sp.setString('phone', data.phone.toString());
    sp.setString('image', data.image.toString());
    sp.setString('companyName', data.companyName.toString());
    sp.setString('latitudeStart', data.latitudeStart.toString());
    sp.setString('latitudeEnd', data.latitudeEnd.toString());
    sp.setString('longitudeStart', data.longitudeStart.toString());
    sp.setString('longitudeEnd', data.longitudeEnd.toString());
    return true;
  }

  Future<bool> saveImg(String image, String remoteWorking, String shiftStart,
      String shiftEnd) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(
      'image',
      image,
    );
    sp.setString(
      'remoteWorking',
      remoteWorking,
    );
    sp.setString(
      'shift_start',
      shiftStart,
    );
    sp.setString(
      'shift_end',
      shiftEnd,
    );
    return true;
  }

  Future<UserModel> getUser() async {
    final sp = await SharedPreferences.getInstance();
    bool? login = sp.getBool('login');
    String? id = sp.getString('id');
    String? name = sp.getString('name');
    String? email = sp.getString('email');
    String? companyToken = sp.getString('companyToken');
    String? phone = sp.getString('phone');
    String? image = sp.getString('image');
    String? companyName = sp.getString('companyName');
    String? latitudeStart = sp.getString('latitudeStart');
    String? latitudeEnd = sp.getString('latitudeEnd');
    String? longitudeStart = sp.getString('longitudeStart');
    String? longitudeEnd = sp.getString('longitudeEnd');
    String? remoteWorking = sp.getString('remoteWorking');
    String? shiftS = sp.getString('shift_start');
    String? shiftE = sp.getString('shift_end');
    return UserModel(
        login: login,
        id: id,
        name: name,
        email: email,
        companyToken: companyToken,
        phone: phone,
        image: image,
        companyName: companyName,
        latitudeStart: latitudeStart,
        latitudeEnd: latitudeEnd,
        longitudeStart: longitudeStart,
        longitudeEnd: longitudeEnd,
        remoteWorking: remoteWorking,
        shiftStart: shiftS,
        shiftEnd: shiftE);
  }

  Future<bool> removeUser() async {
    final sp = await SharedPreferences.getInstance();
    sp.remove('login');
    sp.remove('id');
    sp.remove('name');
    sp.remove('email');
    sp.remove('companyToken');
    sp.remove('latitudeStart');
    sp.remove('latitudeEnd');
    sp.remove('longitudeStart');
    sp.remove('longitudeEnd');
    sp.remove('remoteWorking');
    sp.remove('shift_start');
    sp.remove('shift_end');
    // sp.clear();
    return true;
  }
}

class AdminPreferences {
  Future<bool> saveAdmin(AdminLoginModel data) async {
    final sp = await SharedPreferences.getInstance();
    sp.setBool('adminLogin', true);
    sp.setString('id', data.id.toString());
    sp.setString('message', data.message.toString());
    sp.setString('companyToken', data.companyToken.toString());
    sp.setString('companyName', data.companyName.toString());
    sp.setString('companyEmail', data.companyEmail.toString());
    return true;
  }

  Future<AdminLoginModel> getAdmin() async {
    final sp = await SharedPreferences.getInstance();
    bool? adminLogin = sp.getBool('adminLogin');
    String? id = sp.getString('id');
    String? message = sp.getString('message');
    String? companyEmail = sp.getString('companyEmail');
    String? companyToken = sp.getString('companyToken');
    String? companyName = sp.getString('companyName');
    return AdminLoginModel(
        adminLogin: adminLogin,
        companyEmail: companyEmail,
        companyName: companyName,
        companyToken: companyToken,
        id: id,
        message: message);
  }

  Future<bool> removeAdmin() async {
    final sp = await SharedPreferences.getInstance();
    sp.remove('adminLogin');
    sp.remove('id');
    sp.remove('message');
    sp.remove('companyToken');
    sp.remove('companyName');
    sp.remove('companyEmail');

    // sp.clear();
    return true;
  }
}

class UserCheckPref {
  Future<bool> setCheckin(CheckPrefModel data) async {
    final sp = await SharedPreferences.getInstance();
    sp.setBool('isCheckedIn', data.isCheckedIn ?? false);

    sp.setString('lastCheckOutTime',
        data.lastCheckOutTime?.toString() ?? DateTime.now().toString());
    return true;
  }

  Future<CheckPrefModel> getCheckin() async {
    final sp = await SharedPreferences.getInstance();

    bool isCheckedIn = sp.getBool('isCheckedIn') ?? false;
    try {
      String? lastCheckOutTimeString = sp.getString('lastCheckOutTime');
      DateTime lastCheckOutTime = DateTime.now();

      if (lastCheckOutTimeString != null && lastCheckOutTimeString.isNotEmpty) {
        lastCheckOutTime =
            DateTime.parse(lastCheckOutTimeString.replaceAll('/', '-'));
      }
      return CheckPrefModel(
        isCheckedIn: isCheckedIn,
        lastCheckOutTime: lastCheckOutTime,
      );
    } catch (e) {
      return throw ('Error parsing date: $e');
    }
  }

  Future<bool> removeCheck() async {
    final sp = await SharedPreferences.getInstance();
    sp.remove('isCheckedIn');
    sp.remove('lastCheckOutTime');
    // sp.clear();
    return true;
  }
}

class UsersAgreement {
  Future<bool> save(bool value) async {
    final dp = await SharedPreferences.getInstance();

    dp.setBool('accept', value);
    return true;
  }

  Future<UserAgreementModel> getData() async {
    final dp = await SharedPreferences.getInstance();
    final accept = dp.getBool('accept');
    return UserAgreementModel(accept: accept);
  }
}
