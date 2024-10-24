import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class ColleaguesView extends StatefulWidget {
  const ColleaguesView({super.key});

  @override
  State<ColleaguesView> createState() => _ColleaguesViewState();
}

class _ColleaguesViewState extends State<ColleaguesView> {
  // String company = "II@tNfQ70O";
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final colleageVM = Get.put(ColleaguesViewModel());
  @override
  void initState() {
    super.initState();
    colleageVM.getColleagusData();
  }

  Future<void> _refresh() async {
    colleageVM.getColleagusData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TextComponent(
            text: 'Colleagues',
            color: Colors.white,
          ),
          backgroundColor: AppColor.darkBlue,
        ),
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
                  itemCount: colleageVM.colleagesusList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    final data = colleageVM.colleagesusList[index];
                    return InkWell(
                      onTap: () {
                        Get.to(() => ColleaguesUser(
                              userDetail: User(
                                  lat: data.userLocationLat,
                                  long: data.userLocationLon,
                                  name: data.name,
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
                            child: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.white,
                                backgroundImage: CachedNetworkImageProvider(
                                    'http://superteclabs.com/apis2/images/${data.image}')
                                //  NetworkImage(
                                //     'http://superteclabs.com/apis2/images/${data.image}'),
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
                            //                         data.status == "in"
                            // ? (data.day == Utils.formatDate ? data.checkinTime : "Not Checked in")
                            // : (data.status == "out" ? (data.day == Utils.formatDate ? data.checkoutTime : "Not Checked in") : "Not Checked in"),
                            //  data.status == "in"
                            //     ? data.day == Utils.formatDate
                            //         ? data.checkinTime ??
                            //             "Checkin time not available"
                            //         : data.status == "out"
                            //             ? data.day == Utils.formatDate
                            //                 ? "Checked out today at ${data.checkoutTime ?? 'unknown time'}"
                            //                 : "Not Checked in"
                            //             : "Not Checked in"
                            //     : "Not Checked in",
                            // data.status == "in"
                            //     ? data.day == Utils.formatDate
                            //         ? data.checkinTime
                            //         : data.status == "out"
                            //             ? data.day == Utils.formatDate
                            //                 ? "Checked out today at ${data.checkoutTime}"
                            //                 : "Not Checked in"
                            //             : "Not Checked in"
                            //     : "Not Checked in",
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
