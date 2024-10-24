import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class NotifyAllVM extends GetxController {
  final notifyMessage = TextEditingController().obs;

  Future<void> notifyAll() async {
    log('Start');
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    try {
      await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'key=AAAAYNvK7cY:APA91bFrjSAUOSqfoR_1f1epmmFE1D2jQpdD37L-mOKBJ3YjqtT3_fC-HMpD9ns9Ph1a9ddPrYr38NTHj1wnkbTB7R25SnAdNxNCxgE6wXpHpePW09R9XNXeVEMKg1aOdImPoSL9LcbL',
        },
        body: jsonEncode({
          'to': '/topics/all_users',
          'notification': {
            'title': 'Notice',
            'body': notifyMessage.value.text,
            'type': 'chat',
          },
        }),
      )
          .whenComplete(() {
        notifyMessage.value.clear();
      });
    } catch (e) {
      // log(e.toString());
    }
  }
}
