import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:supertec_app_clean_code/view_models/controller/notify_all/notify_all.dart';

class AdminDrawerView extends StatefulWidget {
  const AdminDrawerView({super.key, this.companyName});
  final String? companyName;

  @override
  State<AdminDrawerView> createState() => _AdminDrawerViewState();
}

class _AdminDrawerViewState extends State<AdminDrawerView> {
  final pref = AdminPreferences();
  final notifyVM = Get.put(NotifyAllVM());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          verticalPadding(
            child: Image.asset(
              ImageAssets.appLogo,
              height: Get.height * 0.20,
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextComponent(
              text: widget.companyName.toString(),
              fweight: FontWeight.bold,
            ),
          ),
          ListTile(
            onTap: () async {
              Clipboard.setData(ClipboardData(
                      text: await pref
                          .getAdmin()
                          .then((value) => value.companyToken.toString())))
                  .whenComplete(() {
                Get.back();
                Utils.toastMessage('Copy Token');
              });
            },
            leading: const Icon(Icons.copy),
            title: const TextComponent(
              text: 'Copy Token',
              fweight: FontWeight.bold,
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () {
              showAdaptiveDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const TextComponent(
                          text: 'Notify All Employees',
                          fweight: FontWeight.bold,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFieldComponent(
                              label: 'Write Message',
                              controller: notifyVM.notifyMessage.value,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            sizedBox(),
                            CustomButton(
                              onPressed: () {
                                if (notifyVM
                                    .notifyMessage.value.text.isNotEmpty) {
                                  notifyVM.notifyAll();
                                }
                              },
                              color: AppColor.darkBlue,
                              buttonText: 'Notify',
                            )
                          ],
                        ),
                      ));
            },
            title: const TextComponent(
              text: 'Notify All Employees',
              fweight: FontWeight.bold,
            ),
          ),
          ListTile(
            onTap: () {
              Get.toNamed(RouteName.addCompanyLocation);
            },
            title: const TextComponent(
              text: 'Add Company Location',
              fweight: FontWeight.bold,
            ),
          ),
          ListTile(
            onTap: () {
              Get.toNamed(RouteName.officeLocation);
            },
            title: const TextComponent(
              text: 'Office Locations',
              fweight: FontWeight.bold,
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              showAdaptiveDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const TextComponent(
                          text: 'Are you sure you want to log out',
                          fweight: FontWeight.bold,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              pref.removeAdmin();
                              Get.until((route) => false);
                              Get.to(() => const Start());
                            },
                            child: const TextComponent(
                              text: 'Yes',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const TextComponent(text: 'No'),
                          ),
                        ],
                      ));
            },
            title: const TextComponent(
              text: 'Log out',
              fweight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
