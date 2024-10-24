import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key, this.id});
  final String? id;
  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  final pref = UserPreferences();
  AttendanceViewModel attendanceVM = Get.put(AttendanceViewModel());
  @override
  void initState() {
    super.initState();
    pref.getUser().then(
      (value) {
        attendanceVM.attendanceRecord(id: widget.id ?? value.id.toString());
        attendanceVM.salary(id: widget.id ?? value.id.toString());
      },
    );
  }

  // final listScroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColor.darkBlue,
            title: Table(
              children: [
                TableRow(
                    children: List.generate(
                        Utils.attendanceHeading.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextComponent(
                                text: Utils.attendanceHeading[index],
                                fweight: FontWeight.bold,
                                color: AppColor.white,
                                size: 13,
                              ),
                            ))),
              ],
            )),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: SingleChildScrollView(
                  // controller: listScroll,
                  child: Column(children: [
                    Obx(() {
                      switch (attendanceVM.rxAttendanceRequestStatus.value) {
                        case Status.LOADING:
                          return const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        case Status.ERROR:
                          return InternetExpection(
                            onPressed: () {
                              pref.getUser().then(
                                (value) {
                                  attendanceVM.attendanceRecord(
                                      id: widget.id ?? value.id.toString());
                                },
                              );
                            },
                          );
                        case Status.COMPLETED:
                          // WidgetsBinding.instance.addPostFrameCallback((_) {
                          //   listScroll
                          //       .jumpTo(listScroll.position.maxScrollExtent);
                          // });
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: attendanceVM.attendanceList.length,
                              reverse: true,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final data = attendanceVM.attendanceList[index];
                                return Table(
                                    border: TableBorder.all(width: 0.5),
                                    children: [
                                      TableRow(children: [
                                        for (var field in [
                                          data.checkinDate,
                                          data.checkinDay,
                                          data.checkinTime,
                                          data.checkoutTime,
                                          data.office,
                                        ])
                                          Padding(
                                            padding: const EdgeInsets.all(4.5),
                                            child: TextComponent(
                                              text: field.toString(),
                                              size: 10,
                                              textAlign: TextAlign.center,
                                              fweight: FontWeight.w500,
                                            ),
                                          ),
                                      ])
                                    ]);
                              });
                      }
                    })
                  ]),
                ),
              ),
              Obx(() {
                switch (attendanceVM.rxSalaryRequestStatus.value) {
                  case Status.LOADING:
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  case Status.ERROR:
                    return InternetExpection(
                      onPressed: () {
                        pref.getUser().then(
                          (value) {
                            attendanceVM.salary(
                                id: widget.id ?? value.id.toString());
                          },
                        );
                      },
                    );
                  case Status.COMPLETED:
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRicText(
                              firstText: 'Late Days: ',
                              secondText: attendanceVM.salaryData.value.lateDays
                                  .toString()),
                          CustomRicText(
                              firstText: 'Present Days: ',
                              secondText: attendanceVM.salaryData.value.presents
                                  .toString()),
                          CustomRicText(
                              firstText: 'Absent Days: ',
                              secondText: attendanceVM.salaryData.value.absents
                                  .toString()),
                          CustomRicText(
                              firstText: 'Per Day Salary is: ',
                              secondText: attendanceVM
                                  .salaryData.value.perDaySalary
                                  .toString()),
                          CustomRicText(
                              firstText: 'Salary deduction: ',
                              secondText: attendanceVM
                                  .salaryData.value.deductedSalaryTillToday
                                  .toString()),
                          CustomRicText(
                              firstText: 'Absent Due to Lates: ',
                              secondText: attendanceVM
                                  .salaryData.value.lateAbsents
                                  .toString()),
                          CustomRicText(
                              firstText: 'Your Monthly Salary is: ',
                              secondText: attendanceVM
                                  .salaryData.value.monthlySalary
                                  .toString()),
                          CustomRicText(
                              firstText: 'Total Number of Days Present: ',
                              secondText: attendanceVM
                                  .salaryData.value.totalPresents
                                  .toString()),
                          CustomRicText(
                              firstText:
                                  'You Will Recieved an Estimated Salary of: ',
                              secondText: attendanceVM
                                  .salaryData.value.salaryTillToday
                                  .toString()),
                        ],
                      ),
                    );
                }
              })
            ])));
  }
}
