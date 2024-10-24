import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class UserToUser extends StatefulWidget {
  const UserToUser({super.key, required this.data});
  final UserChatRequire data;

  @override
  State<UserToUser> createState() => _UserToUserState();
}

class _UserToUserState extends State<UserToUser> {
  // final listScroll = ScrollController();
  final fr = FirebaseFirestore.instance;
  final chatVM = Get.put(ChatViewModel());

  // void sendNotification() async {
  //   final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  //   const regId =
  //       "eLRQ8nM4Sq-fr0AcU_CKoY:APA91bEG_XPU5Coi1xNZ17kAyTZJMAV8OX02jRobPA_kLOuJ53TD-6yL99Lf2ZE7hQBhCYQ_POFNsO3RO3QdVIMJdtKlO_6_UwyfX6uE7TzptdnKpf5YqTCCFgyGVWNi4dE5kORYJraQ";

  //   try {
  //     await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization':
  //             'key=AAAAYNvK7cY:APA91bFrjSAUOSqfoR_1f1epmmFE1D2jQpdD37L-mOKBJ3YjqtT3_fC-HMpD9ns9Ph1a9ddPrYr38NTHj1wnkbTB7R25SnAdNxNCxgE6wXpHpePW09R9XNXeVEMKg1aOdImPoSL9LcbL',
  //       },
  //       body: jsonEncode({
  //         'to': regId,
  //         'notification': {
  //           'title': "work",
  //           'body': 'yes',
  //           'type': 'chat'
  //           // Add your notification options here
  //         },
  //       }),
  //     );
  //   } catch (e) {
  //     Utils.toastMessage(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        backgroundColor: AppColor.darkBlue,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  'http://superteclabs.com/apis2/images/${widget.data.userImage}'),
            ),
            horizontalPadding(
                child: TextComponent(
              text: widget.data.userName.toString(),
              fweight: FontWeight.bold,
              color: AppColor.white,
            ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: chatVM.listScroll.value,
                      child: StreamBuilder(
                          stream: chatVM.getMessage(
                              userId: widget.data.userId.toString(),
                              otherUserId: widget.data.personalId.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasData) {
                              return ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: snapshot.data!.docs
                                    .map((document) => chatVM.buildMessageItem(
                                          document,
                                          widget.data.personalId,
                                        ))
                                    .toList(),
                              );
                            } else {
                              return const Center(
                                  child: Text("No Messages Yet"));
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldComponent(
                    label: 'Send Messages',
                    controller: chatVM.messages.value,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      chatVM.sendMessage(
                          receiverId: widget.data.userId.toString());
                    },
                    icon: const CircleAvatar(
                      child: Icon(Icons.send),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserChatRequire {
  String? userId;
  String? personalId;
  String? userImage;
  String? userName;
  UserChatRequire(
      {required this.userId,
      required this.personalId,
      required this.userImage,
      required this.userName});
}
