import '../../utils/new_all_imports.dart';
import '../chats/admin_with_user/admin_with_users.dart';
import '../drawer/drawer_view.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final notificationVM = Get.put(NotificationViewModel());
  final liveLocation = Get.put(LiveLocationModel());
  final pref = AdminPreferences();
  final colleageVM = Get.put(ColleaguesViewModel());
  @override
  void initState() {
    super.initState();
    colleageVM.getColleagusData();
    notificationVM.isTokenRefresh();
    notificationVM.firebaseInit();
    pref.getAdmin().then((value) {
      liveLocation.setLiveLocation(Get.context ?? context, value.id.toString());
    });
    // pref.getAdmin().then((value) => user = value.companyName.toString());
  }

  Future<void> _refresh() async {
    // pref.getAdmin().then((value) => user = value.companyName.toString());
    colleageVM.getColleagusData();
    pref.getAdmin().then((value) {
      liveLocation.setLiveLocation(Get.context ?? context, value.id.toString());
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColor.darkBlue,
          title: TextComponent(
            text: colleageVM.companyName.value,
            color: Colors.white,
            fweight: FontWeight.bold,
          ),
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          actions: [
            Obx(() => colleageVM.searchbar.value
                ? AnimatedContainer(
                    duration: const Duration(seconds: 10),
                    height: colleageVM.searchbar.value ? 60 : 0,
                    child: Visibility(
                      visible: colleageVM.searchbar.value,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: Get.width * 0.50,
                            child: TextFieldComponent(
                              controller: colleageVM.search.value,
                              onChanged: (v) {
                                colleageVM.filterColleagues(v);
                              },
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    colleageVM.searchbar.value =
                                        !colleageVM.searchbar.value;
                                  },
                                  icon: const Icon(Icons.search)),
                              textSize: 12,
                              label: 'Search',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      colleageVM.searchbar.value = !colleageVM.searchbar.value;
                    },
                    icon: const Icon(Icons.search))),
          ],
        ),
        drawer: AdminDrawerView(companyName: colleageVM.companyName.value),
        body: Obx(() {
          switch (colleageVM.rxRequestStatus.value) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.ERROR:
              return InternetExpection(
                onPressed: () {
                  colleageVM.colleaguesRefresh();
                },
              );
            case Status.COMPLETED:
              return RefreshIndicator(
                onRefresh: _refresh,
                key: _refreshIndicatorKey,
                child: GridView.builder(
                  shrinkWrap: true,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: colleageVM.filteredColleagues.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    final data = colleageVM.filteredColleagues[index];
                    return InkWell(
                      onTap: () {
                        Get.to(() => ChatWithUser(
                              adminStaff: AdminStaff(
                                  lat: data.userLocationLat,
                                  long: data.userLocationLon,
                                  image: data.image ?? ImageAssets.userImage,
                                  status: data.status == "in"
                                      ? (data.day == Utils.formatDate
                                          ? data.checkinTime ?? "Not Checked in"
                                          : "Not Checked in")
                                      : (data.status == "out"
                                          ? (data.day == Utils.formatDate
                                              ? data.checkoutTime ??
                                                  "Not Checked in"
                                              : "Not Checked in")
                                          : "Not Checked in"),
                                  id: data.id,
                                  name: data.name,
                                  borderColor: data.status == "in"
                                      ? data.loginStatus == "loggedin"
                                          ? data.day == Utils.formatDate
                                              ? const Color(0xff30CF4B)
                                              : data.status == "out"
                                                  ? data.day == Utils.formatDate
                                                      ? const Color(0xffbf4752)
                                                      : const Color(0xffbf4752)
                                                  : const Color(0xffbf4752)
                                          : const Color(0xffECD610)
                                      : const Color(0xffbf4752)),
                            ));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 34,
                            backgroundColor: data.status == "in"
                                ? data.day == Utils.formatDate
                                    ? const Color(0xff30CF4B)
                                    : data.status == "out"
                                        ? data.day == Utils.formatDate
                                            ? const Color(0xffbf4752)
                                            : const Color(0xffbf4752)
                                        : const Color(0xffbf4752)
                                : const Color(0xffbf4752),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "http://superteclabs.com/apis2/images/${data.image}",
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.white,
                                backgroundImage: imageProvider,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          TextComponent(
                            text: data.name.toString(),
                            fweight: FontWeight.bold,
                            textAlign: TextAlign.center,
                            size: 12,
                          ),
                          TextComponent(
                            textAlign: TextAlign.center,
                            text: data.status == "in"
                                ? (data.day == Utils.formatDate
                                    ? data.checkinTime ?? "Not Checked in"
                                    : "Not Checked in")
                                : (data.status == "out"
                                    ? (data.day == Utils.formatDate
                                        ? data.checkoutTime ?? "Not Checked in"
                                        : "Not Checked in")
                                    : "Not Checked in"),
                            fweight: FontWeight.bold,
                            size: 12,
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
          }
        }));
  }
}
