import 'package:intl/intl.dart';
import '../../../utils/new_all_imports.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatViewModel extends GetxController {
  final pref = UserPreferences();
  final adminPref = AdminPreferences();
  final messages = TextEditingController().obs;
  RxString adminId = '5'.obs;
  final fr = FirebaseFirestore.instance;
  final listScroll = ScrollController().obs;
  String formattedTime = DateFormat('h:mma').format(DateTime.now());
  String formattedDate = DateFormat('dd/MMM').format(DateTime.now());

  void sendMessage({String? receiverId}) async {
    final user = await pref.getUser();
    final admin = await adminPref.getAdmin();
    adminId.value = admin.id.toString();
    // log(adminId.value);
    var data = {
      "sender": user.id ?? admin.id.toString(),
      "receiver": receiverId,
      "message": messages.value.text,
      "timeStamp": Timestamp.now(),
      "time": "$formattedTime $formattedDate",
      "senderName": user.name ?? admin.companyName.toString()
    };
    List<String> ids = [user.id.toString(), receiverId.toString()];
    ids.sort();
    String chatRoomId = ids.join("_");
    if (messages.value.text != '') {
      try {
        await fr
            .collection('chat_Room')
            .doc(chatRoomId)
            .collection("messages")
            .add(data)
            .whenComplete(() {
          listScroll.value.animateTo(listScroll.value.position.extentTotal,
              duration: const Duration(seconds: 1), curve: Curves.linear);

          return Utils.toastMessage('Send Message');
        });
        final messageData = await FirebaseFirestore.instance
            .collection("Location")
            .doc(receiverId)
            .get();
        if (messageData.exists) {
          sendNotification(
              notifToken: messageData['notifToken'].toString(),
              userName: user.name ?? admin.companyName,
              body: messages.value.text);
        }
        messages.value.clear();
      } catch (e) {
        Utils.toastMessage('error send Message');
      }
    } else {
      Utils.toastMessage('Empty Message');
    }
  }

  Stream<QuerySnapshot> getMessage(
      {required String userId, required String otherUserId}) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return fr
        .collection('chat_Room')
        .doc(chatRoomId)
        .collection("messages")
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }

  void sendNotification(
      {required String notifToken, String? userName, String? body}) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    try {
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'key=AAAAYNvK7cY:APA91bFrjSAUOSqfoR_1f1epmmFE1D2jQpdD37L-mOKBJ3YjqtT3_fC-HMpD9ns9Ph1a9ddPrYr38NTHj1wnkbTB7R25SnAdNxNCxgE6wXpHpePW09R9XNXeVEMKg1aOdImPoSL9LcbL',
        },
        body: jsonEncode({
          'to': notifToken,
          'notification': {
            'title': userName,
            'body': body,
            'type': 'chat',
          },
          'data': {
            'id': '1',
            'status': 'done',
            // Add any additional data you want to send with the notification
          },
        }),
      );
    } catch (e) {
      // log(e.toString());
    }
  }

  String generateDocumentId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Widget buildMessageItem(
    DocumentSnapshot documentSnapshot,
    userid,
  ) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    var alignment = (data['sender'] == userid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: AppColor.darkBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextComponent(
              text: data['message'],
              textAlign: TextAlign.end,
              color: Colors.white,
            ),
            TextComponent(
              text: data['time'],
              size: 10,
              fweight: FontWeight.w500,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
