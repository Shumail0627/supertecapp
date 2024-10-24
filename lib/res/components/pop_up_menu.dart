// import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

// class CustomPopUpMenu extends StatelessWidget {
//   const CustomPopUpMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//         iconColor: Colors.white,
//         itemBuilder: (context) => [
//               PopupMenuItem(
//                   onTap: () {
//                     // Get.to(() => Attendance(
//                     //       id: LocalStorage.id.toString(),
//                     //     ));
//                   },
//                   child: const CustomText(text: 'Attendance')),
//               PopupMenuItem(
//                   onTap: () {
//                     // Get.to(() => const AddTask());
//                   },
//                   child: const CustomText(text: 'Add Task')),
//               PopupMenuItem(
//                   onTap: () {
//                     // Get.to(() => const Colleagues());
//                   },
//                   child: const CustomText(text: 'Colleagues')),
//               PopupMenuItem(
//                   onTap: () {
//                     // Get.to(() => const UpdateProfile());
//                   },
//                   child: const CustomText(text: 'Update Profile Info')),
//               PopupMenuItem(
//                   onTap: () {
//                     // Get.to(() => const ChatWithAdmin());
//                   },
//                   child: const CustomText(text: 'Chat with Admin')),
//               PopupMenuItem(
//                   onTap: () {
//                     // final WorkLogController workLogController =
//                     //     Get.put(WorkLogController());
//                     // showAdaptiveDialog(
//                     //     context: context,
//                     //     builder: (context) => AlertDialog(
//                     //           title: const CustomText(
//                     //             text: 'Add Your Worklog',
//                     //             fweight: FontWeight.bold,
//                     //           ),
//                     //           content: Obx(() => CustomTextFormField(
//                     //               label: 'Write Worklog',
//                     //               controller:
//                     //                   workLogController.writelog.value)),
//                     //           actions: [
//                     //             TextButton(
//                     //               onPressed: () {
//                     //                 LocalStorage.getLocalStorage();
//                     //                 WorkLogModel data = WorkLogModel(
//                     //                     taskComment: workLogController
//                     //                         .writelog.value.text,
//                     //                     userId: LocalStorage.id);
//                     //                 workLogController
//                     //                     .workLog(data)
//                     //                     .whenComplete(() {
//                     //                   Get.back();
//                     //                   workLogController.writelog.value.clear();
//                     //                 });
//                     //               },
//                     //               child: const CustomText(
//                     //                 text: 'Submit',
//                     //               ),
//                     //             ),
//                     //             TextButton(
//                     //               onPressed: () {
//                     //                 Get.back();
//                     //               },
//                     //               child: const CustomText(text: 'Cancel'),
//                     //             ),
//                     //           ],
//                     //         ));
//                   },
//                   child: const CustomText(text: 'Add Daily Worklog')),
//               PopupMenuItem(
//                   onTap: () {
//                     showAdaptiveDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                               title: const CustomText(
//                                 text: 'Are you sure you want to log out',
//                                 fweight: FontWeight.bold,
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     // Api.logoOut().whenComplete(() {
//                                     //   LocalStorage.deleteLocalStorage();
//                                     //   Get.until((route) => false);
//                                     //   Get.to(() => const Start());
//                                     // });
//                                   },
//                                   child: const CustomText(
//                                     text: 'Yes',
//                                   ),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Get.back();
//                                   },
//                                   child: const CustomText(text: 'No'),
//                                 ),
//                               ],
//                             ));
//                   },
//                   child: const CustomText(text: 'Log out'))
//             ]);
//   }
// }
