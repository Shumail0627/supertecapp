import 'dart:developer';

import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class ChatWithUser extends StatefulWidget {
  const ChatWithUser({super.key, required this.adminStaff});
  final AdminStaff adminStaff;
  @override
  State<ChatWithUser> createState() => _ChatWithUserState();
}

class _ChatWithUserState extends State<ChatWithUser> {
  final chatVM = Get.put(ChatViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.darkBlue,
          title: const TextComponent(
            text: 'Supertec',
            color: Colors.white,
            fweight: FontWeight.bold,
          ),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: () {
                            showAdaptiveDialog(
                                context: context,
                                builder: (context) => AdminTaskView(
                                    id: widget.adminStaff.id.toString()));
                          },
                          child: const TextComponent(
                            text: 'View Task',
                          )),
                      PopupMenuItem(
                          onTap: () {
                            Get.to(() => AttendanceView(
                                  id: widget.adminStaff.id.toString(),
                                ));
                          },
                          child: const TextComponent(
                            text: 'Attendance Record',
                          )),
                      PopupMenuItem(
                          onTap: () {
                            Get.to(() => AssignTaskView(
                                  id: widget.adminStaff.id.toString(),
                                ));
                          },
                          child: const TextComponent(
                            text: 'Add Task',
                          )),
                      PopupMenuItem(
                          onTap: () {
                            Get.to(() => GrantLeaveView(
                                  id: widget.adminStaff.id.toString(),
                                ));
                          },
                          child: const TextComponent(
                            text: 'Grant Leaves',
                          )),
                      PopupMenuItem(
                          onTap: () {
                            Get.to(() => UpdateSalaryView(
                                  id: widget.adminStaff.id.toString(),
                                ));
                          },
                          child: const TextComponent(
                            text: 'Update Salary',
                          )),
                      PopupMenuItem(
                          onTap: () {
                            Get.to(() => ShiftView(
                                  id: widget.adminStaff.id.toString(),
                                ));
                          },
                          child: const TextComponent(
                            text: 'Assign Shift',
                          )),
                      PopupMenuItem(
                          onTap: () {
                            showAdaptiveDialog(
                                context: context,
                                builder: (context) => RemoteWorkView(
                                      id: widget.adminStaff.id.toString(),
                                    ));
                          },
                          child: const TextComponent(
                            text: 'Allow Remote Work',
                          )),
                    ]),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: widget.adminStaff.borderColor,
                  child: CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    backgroundImage: CachedNetworkImageProvider(
                        'http://superteclabs.com/apis2/images/${widget.adminStaff.image}'),
                  ),
                ),
                verticalPadding(
                  v: 10,
                  child: TextComponent(
                    text: widget.adminStaff.name.toString(),
                    fweight: FontWeight.bold,
                    size: 12,
                  ),
                ),
                TextComponent(
                  text: widget.adminStaff.status.toString(),
                  fweight: FontWeight.bold,
                  size: 12,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {
                        employeLocation(
                            id: widget.adminStaff.id.toString(),
                            context: context,
                            latitude: widget.adminStaff.lat.toString(),
                            longtitude: widget.adminStaff.long.toString());
                      },
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: Get.height * 0.05,
                      )),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: chatVM.listScroll.value,
                child: StreamBuilder(
                    stream: chatVM.getMessage(
                        userId: chatVM.adminId.toString(),
                        otherUserId: widget.adminStaff.id.toString()),
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
                                    chatVM.adminId.toString(),
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
                      chatVM.sendMessage(receiverId: widget.adminStaff.id);
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

class AdminStaff {
  String? id;
  String? name;
  String? image;
  String? lat;
  String? long;

  String? status;
  Color? borderColor;
  AdminStaff(
      {required this.id,
      required this.name,
      this.image,
      this.lat,
      this.long,
      this.status,
      required this.borderColor});
}

employeLocation(
    {required BuildContext context,
    required String latitude,
    required String longtitude,
    required String id}) {
  // final location = Get.put(LiveLocationModel());
  final fr = FirebaseFirestore.instance;
  return showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
            // title: CustomText(text: ''),
            actions: [
              Container(
                  child: verticalPadding(
                v: 10,
                child: FutureBuilder(
                  future: fr.collection('Location').doc(id).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      log(snapshot.error.toString());
                      Utils.toastMessage('Error Check your network');
                      return const Center(
                          child:
                              TextComponent(text: 'Error Check your network'));
                    } else if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Center(
                          child: TextComponent(
                              text: 'No Live Location Available'));
                    } else if (snapshot.hasData) {
                      var data = snapshot.data!.data() as Map<String, dynamic>;
                      var firebaseLocationModel =
                          FirebaseLocationModel.fromJson(data);
                      return Column(
                        children: [
                          TextComponent(
                            text:
                                "Last Record ${firebaseLocationModel.time.toString()}",
                            fweight: FontWeight.bold,
                          ),
                          verticalPadding(
                              v: 10,
                              child: CustomButton(
                                  onPressed: () {
                                    Get.to(() => GoogleMapView(
                                          lat: firebaseLocationModel.latitude,
                                          long:
                                              firebaseLocationModel.longtitude,
                                        ));
                                  },
                                  buttonText: 'Live Location')),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )),
              CustomButton(
                  onPressed: () {
                    Get.to(() => GoogleMapView(
                          lat: latitude,
                          long: longtitude,
                        ));
                  },
                  buttonText: 'Office Location'),
            ],
          ));
}
