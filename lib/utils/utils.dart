import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static final List image = [ImageAssets.hayat, ImageAssets.kamran, null];
  static final List name = ['Hayat', 'Kamran', 'Abdul Rehman'];
  static List attendanceHeading = [
    'Date',
    'Day',
    'Checkin',
    'Checkout',
    'Location'
  ];

  static String formatDate = DateFormat('dd-MMMM-yyyy').format(DateTime.now());
  static String formatDay = DateFormat.EEEE().format(DateTime.now());
  static String formatTime = DateFormat.jm().format(DateTime.now());

  static fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String msg) async {
    return Fluttertoast.showToast(
        msg: msg,
        backgroundColor: AppColor.grey,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT,
        webPosition: 1,
        timeInSecForIosWeb: 1);
  }

  static snackBar(String title, String message) {
    Get.snackbar(title, message);
  }

//not confirm
  static Future<void> runUrl({required String? url, required context}) async {
    try {
      final uri = Uri.parse(url.toString());
      if (!await launchUrl(uri)) {
        throw Exception('network error $uri');
      }
    } on Exception catch (e) {
      Utils.toastMessage('Error: $e');
    }
  }

  static boldStyle({double? size}) {
    return TextStyle(fontSize: size ?? 18, fontWeight: FontWeight.bold);
  }
}

String? Function(String?) get fieldValidator => (v) {
      if (v?.isEmpty ?? false) {
        return "Field Required";
      } else {
        return null;
      }
    };
final _emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
String? Function(String?) get emailValidation => (v) {
      if (v?.isEmpty ?? false) {
        return "Email Required";
      } else if (!_emailRegExp.hasMatch(v!)) {
        return "Enter a valid email address";
      } else {
        return null;
      }
    };

Future<void> getPermission() async {
  var status = await Permission.location.request();
  if (status == PermissionStatus.granted) {
  } else if (status == PermissionStatus.denied) {
    Utils.toastMessage("Location permission is required for check-in.");
  } else if (status == PermissionStatus.permanentlyDenied) {
    Utils.toastMessage("Location permission is permanently denied.");
    openAppSettings();
  }
}

Future<Position> getLocation() async {
  await getPermission();
  Position location = await Geolocator.getCurrentPosition();
  return location;
}

extension CapitalizeExtension on String {
  String capitalizeWords() {
    if (isEmpty) return this;

    return split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
