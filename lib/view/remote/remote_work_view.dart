import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:supertec_app_clean_code/view_models/controller/remote/remote_work_view_model.dart';

class RemoteWorkView extends StatelessWidget {
  RemoteWorkView({super.key, required this.id});
  final String id;
  final remoteWorkVM = Get.put(RemoteWorkViewModel());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const TextComponent(
          text: 'Allow/Disallow this employee to work remotely'),
      actions: [
        TextButton(
            onPressed: () {
              remoteWorkVM.allowRemoteWork(id, "yes");
            },
            child: const TextComponent(
              text: 'ALLOW',
              color: AppColor.darkBlue,
            )),
        TextButton(
            onPressed: () {
              remoteWorkVM.allowRemoteWork(id, "no");
            },
            child: const TextComponent(
              text: 'DISALLOW',
              color: AppColor.darkBlue,
            )),
      ],
    );
  }
}
