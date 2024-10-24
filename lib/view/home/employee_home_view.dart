import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class EmployeeHomeView extends StatefulWidget {
  const EmployeeHomeView({super.key});
  @override
  State<EmployeeHomeView> createState() => _EmployeeHomeViewState();
}

class _EmployeeHomeViewState extends State<EmployeeHomeView> {
  late Future<void> localStorageFuture;
  LoadProfileModel reLoad = Get.put(LoadProfileModel());
  final liveLocation = Get.put(LiveLocationModel());
  final navVM = Get.put(NavigatorBarModel());
  final checkInVM = Get.put(CheckInModel());
  final taskVM = Get.put(TaskViewModel());
  final checkoutVM = Get.put(CheckoutViewModel());
  final preferences = UserPreferences();
  final colleageVM = Get.put(ColleaguesViewModel());
  final notificationVM = Get.put(NotificationViewModel());
  late bool isCheckedIn;
  late DateTime lastCheckOutTime;
  UserCheckPref setCheck = UserCheckPref();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    preferences.getUser().then((value) {
      taskVM.taskApi(id: value.id.toString());
      liveLocation.setLiveLocation(Get.context ?? context, value.id.toString());
      // CheckinReminderModel().displayCheckInNotification(value.shiftStart);
    });
    localStorageFuture = setCheck.getCheckin().then(
      (value) {
        isCheckedIn = value.isCheckedIn ?? false;
        lastCheckOutTime = value.lastCheckOutTime!;
        checkInVM.showCheckinButton!.value =
            isNextDay(lastCheckOutTime) ? false : value.isCheckedIn!;
      },
    );
  }

  bool isNextDay(DateTime dateTime) {
    DateTime now = DateTime.now();
    return dateTime.year < now.year ||
        dateTime.month < now.month ||
        dateTime.day < now.day;
  }

  Future<void> fetchData() async {
    colleageVM.getColleagusData();
    reLoad.updateImg();
    preferences.getUser().then((value) {
      taskVM.taskApi(id: value.id.toString());
    });
    localStorageFuture = setCheck.getCheckin().then((value) {
      isCheckedIn = value.isCheckedIn!;
      lastCheckOutTime = value.lastCheckOutTime!;
      checkInVM.showCheckinButton!.value =
          isNextDay(lastCheckOutTime) ? false : value.isCheckedIn!;
    });
  }

  Future<void> _refresh() async {
    await fetchData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: TextComponent(
            text: navVM.companyName.value,
            color: Colors.white,
            fweight: FontWeight.bold,
          ),
          elevation: 20,
          actions: [
            IconButton(
                onPressed: () {
                  _refreshIndicatorKey.currentState!.show();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: AppColor.white,
                )),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          key: _refreshIndicatorKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                color: AppColor.darkBlue,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColor.darkBlue,
                              backgroundImage: CachedNetworkImageProvider(
                                  'http://superteclabs.com/apis2/images/${navVM.image.value}')),
                          sizedBox(),
                          TextComponent(
                            text: navVM.name.value,
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            fweight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    sizedBox(width: 15),
                    Expanded(
                      child: FutureBuilderComponent(
                        future: localStorageFuture,
                        builder: (context, snapshot) {
                          return Obx(() => Column(
                                children: [
                                  CustomButton(
                                    click:
                                        !(checkInVM.showCheckinButton?.value ??
                                            false),
                                    onPressed: () {
                                      checkInVM.checkin(context);
                                    },
                                    color: AppColor.checkinButton,
                                    buttonText: 'CheckIn',
                                    loading: checkInVM.loading.value,
                                  ),
                                  sizedBox(),
                                  CustomButton(
                                    click: checkInVM.showCheckinButton!.value,
                                    onPressed: () {
                                      checkoutVM.checkout(context);
                                      _refresh();
                                    },
                                    color: AppColor.checkoutButton,
                                    buttonText: 'CheckOut',
                                    loading: checkoutVM.loading.value,
                                  ),
                                ],
                              ));
                        },
                      ),
                    )
                  ],
                ),
              ),
              const TabBar(
                  indicatorColor: AppColor.darkBlue,
                  labelColor: AppColor.darkBlue,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.person),
                      text: 'Chats',
                    ),
                    Tab(
                      icon: Icon(Icons.pending_actions),
                      text: 'Pending Task',
                    ),
                    Tab(
                      icon: Icon(Icons.task_alt),
                      text: 'Complete Task',
                    )
                  ]),
              Expanded(
                  child: TabBarView(children: [
                // First Tab
                Obx(() {
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
                      return Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFieldComponent(
                                controller: colleageVM.search.value,
                                onChanged: (v) {
                                  colleageVM.filterColleagues(v);
                                },
                                textSize: 13,
                                label: 'Search',
                                border: const UnderlineInputBorder()),
                          ),
                          Expanded(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: colleageVM.filteredColleagues.length,
                                itemBuilder: (context, index) {
                                  final filteredData =
                                      colleageVM.filteredColleagues;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      onTap: () {
                                        Get.to(() => UserToUser(
                                              data: UserChatRequire(
                                                  personalId: navVM.id.value,
                                                  userId:
                                                      filteredData[index].id,
                                                  userImage:
                                                      filteredData[index].image,
                                                  userName:
                                                      filteredData[index].name),
                                            ));
                                      },
                                      leading: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  'http://superteclabs.com/apis2/images/${filteredData[index].image}')),
                                      title: TextComponent(
                                          text: filteredData[index]
                                              .name
                                              .toString()),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                  }
                }),
                // ,
                // Second Tab
                const TaskWidget(
                  msg: 'pending',
                ),
                // // third Tab
                const TaskWidget(
                  msg: 'complete',
                )
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
