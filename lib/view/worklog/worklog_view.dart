// import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

// class WorkLog extends StatefulWidget {
//   const WorkLog({super.key});

//   @override
//   State<WorkLog> createState() => _WorkLogState();
// }

// class _WorkLogState extends State<WorkLog> {
//   final navVM = Get.put(NavigatorBarModel());
//   final workVM = Get.put(WorkLogController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: TextComponent(text: 'WORK LOG', style: Utils.boldStyle()),
//           centerTitle: true,
//           leading: IconButton(
//               onPressed: () {
//                 navVM.currentIndex.value = 0;
//               },
//               icon: const Icon(Icons.close)),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 workVM.workLog();
//               },
//               child: TextComponent(text: 'Submit', style: Utils.boldStyle()),
//             )
//           ],
//         ),
//         body: Column(
//           children: [
//             Card(
//               child: TextFieldComponent(
//                   label: 'Write Work Log',
//                   autofocus: true,
//                   floatingLabelAlignment: FloatingLabelAlignment.center,
//                   controller: workVM.writeLog.value,
//                   textSize: 17,
//                   line: 7),
//             )
//           ],
//         ));
//   }
// }

import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class WorkLog extends StatefulWidget {
  const WorkLog({super.key});

  @override
  State<WorkLog> createState() => _WorkLogState();
}

class _WorkLogState extends State<WorkLog> {
  final navVM = Get.put(NavigatorBarModel());
  final workVM = Get.put(WorkLogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Work Log',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              workVM.workLog();
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: AppColor.darkBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: workVM.writeLog.value,
                  autofocus: true,
                  maxLines: 7,
                  decoration: InputDecoration(
                    labelText: 'Write Work Log',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                workVM.workLog();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text('Submit Work Log'),
            ),
          ],
        ),
      ),
    );
  }
}
