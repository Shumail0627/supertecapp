// import 'dart:developer';

import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class ChatWithAdminView extends StatefulWidget {
  const ChatWithAdminView({super.key, required this.id});
  final String id;
  @override
  State<ChatWithAdminView> createState() => _ChatWithAdminViewState();
}

class _ChatWithAdminViewState extends State<ChatWithAdminView> {
  final chatVM = Get.put(ChatViewModel());

  @override
  Widget build(BuildContext context) {
    // log(widget.id.toString());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        ImageAssets.appLogo,
                        height: Get.height * 0.15,
                      ),
                    ),
                    verticalPadding(
                        child: const TextComponent(
                      text: 'Rehan Foundation',
                      fweight: FontWeight.bold,
                      color: Color.fromARGB(255, 3, 83, 150),
                    )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: chatVM.listScroll.value,
                child: StreamBuilder(
                    stream:
                        chatVM.getMessage(userId: widget.id, otherUserId: '5'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        return ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((document) => chatVM.buildMessageItem(
                                    document,
                                    widget.id,
                                  ))
                              .toList(),
                        );
                      } else {
                        return const Center(child: Text("No Messages Yet"));
                      }
                    }),
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
                      chatVM.sendMessage(receiverId: '5');
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
