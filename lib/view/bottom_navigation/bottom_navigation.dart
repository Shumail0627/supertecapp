// import 'dart:developer';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

import '../../view_models/controller/location/location_handle_model.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  final navVM = Get.put(NavigatorBarModel());
  LoadProfileModel reLoad = Get.put(LoadProfileModel());
  GetLocation getLocation = Get.put(GetLocation());
  final liveLocation = Get.put(LiveLocationModel());
  final checkInVM = Get.put(CheckInModel());
  final taskVM = Get.put(TaskViewModel());
  final checkoutVM = Get.put(CheckoutViewModel());
  final preferences = UserPreferences();
  final colleageVM = Get.put(ColleaguesViewModel());
  final notificationVM = Get.put(NotificationViewModel());
  late Future<void> localStorageFuture;

  @override
  void initState() {
    super.initState();
    notificationVM.requestNotificationPermission();
    notificationVM.getToken();
    // checkInVM.checkin(context);//disable auto checkin
    notificationVM.isTokenRefresh();
    notificationVM.firebaseInit();
    colleageVM.getColleagusData();

    localStorageFuture = preferences.getUser().then((value) {
      navVM.id.value = value.id!;
      navVM.name.value = value.name!;
      navVM.companyName.value = value.companyName!;
      navVM.image.value = value.image!;
      reLoad.updateImg();
      getLocation.getLocation();
      UserCheckPref().getCheckin();
    });
  }

  List destinations = const [
    EmployeeHomeView(),
    AttendanceView(),
    WorkLog(),
    ColleaguesView(),
    MenuView(),
  ];

  @override
  Widget build(BuildContext context) {
    // log('rebuildnav');
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          indicatorColor: AppColor.white,
          onDestinationSelected: (v) {
            navVM.setIndex(v);
          },
          selectedIndex: navVM.currentIndex.value,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.person), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.receipt_long_rounded), label: 'Attendance'),
            NavigationDestination(icon: Icon(Icons.add), label: 'Worklog'),
            NavigationDestination(
                icon: Icon(Icons.groups), label: 'Colleagues'),
            NavigationDestination(icon: Icon(Icons.menu), label: 'Menu'),
          ],
        ),
      ),
      body: FutureBuilderComponent(
          future: localStorageFuture,
          builder: (context, snapshot) {
            return Obx(() => destinations[navVM.currentIndex.value]);
          }),
    );
  }
}
