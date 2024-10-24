import '../../utils/new_all_imports.dart';
import '../about/about.dart'; // Add this line

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final dataVM = Get.put(LoadProfileModel());
  final logoutVM = Get.put(LogoutViewModel());
  final imgVM = Get.put(IMGUpdateModel());
  final navVM = Get.put(NavigatorBarModel());

  List<String> tileName = [
    "Add Task",
    "Chat With Admin",
    "About",
    "Logout",
  ];
  List<Icon> tileIcon = const [
    Icon(Icons.task, color: AppColor.darkBlue),
    Icon(Icons.person, color: AppColor.darkBlue),
    Icon(Icons.info, color: AppColor.red),
    Icon(Icons.logout, color: AppColor.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGrey,
      body: Column(
        children: [
          Container(
            height: Get.height * 0.25, // Reduced height
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColor.darkBlue,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30), // Slightly smaller curve
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: -40,
                  left: 40,
                  right: 40,
                  child: Container(
                    height: 100, // Reduced card height
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(15), // Smaller radius
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8, // Less blur
                          offset: Offset(0, 4), // Smaller shadow offset
                        ),
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -30,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: imgVM.getImage,
                                child: CircleAvatar(
                                  radius: 40, // Reduced radius
                                  backgroundColor: Colors.amber,
                                  backgroundImage: CachedNetworkImageProvider(
                                      'http://superteclabs.com/apis2/images/${navVM.image.value}'),
                                ),
                              ),
                              const SizedBox(height: 5), // Reduced spacing
                              TextComponent(
                                text: navVM.name.value,
                                textAlign: TextAlign.center,
                                size: 16, // Smaller font size
                                color: AppColor.darkBlue,
                                fweight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: AppColor.blue),
                            onPressed: () =>
                                Get.toNamed(RouteName.updateProfileView),
                            tooltip: "Edit Profile Info",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.1), // Reduced spacing
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              // shrinkWrap: true,
              itemCount: tileName.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 5), // Reduced padding
                child: Material(
                  elevation: 3, // Reduced elevation
                  borderRadius: BorderRadius.circular(10), // Smaller radius
                  child: ListTile(
                    onTap: () async {
                      final pref = await UserPreferences().getUser();

                      switch (index) {
                        case 0:
                          Get.to(() => const AssignTaskView());
                          break;
                        case 1:
                          Get.to(
                              () => ChatWithAdminView(id: pref.id.toString()));
                          break;

                        case 2:
                          Get.to(() => const AboutPage());
                          break;

                        case 3:
                          logoutVM.logoutDialog(Get.context ?? context);
                          break;
                        default:
                          logoutVM.logoutDialog(Get.context ?? context);
                      }
                    },
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8), // Reduced padding
                    leading: tileIcon[index],
                    title: TextComponent(
                      text: tileName[index],
                      size: 16, // Smaller text size
                      fweight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.black54), // Smaller icon
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Smaller radius
                      side:
                          const BorderSide(color: AppColor.lightGrey, width: 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
