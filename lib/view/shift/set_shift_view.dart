import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class ShiftView extends StatefulWidget {
  const ShiftView({super.key, required this.id});
  final String id;
  @override
  State<ShiftView> createState() => _ShiftViewState();
}

class _ShiftViewState extends State<ShiftView> {
  UpdatShiftModel shiftController = Get.put(UpdatShiftModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              borderText('Shift Start'),
              shiftController.startShiftTimePicker(),
              borderText('Shift End'),
              shiftController.endShiftTimePicker(),
              Obx(() => CustomButton(
                    onPressed: () {
                      String shiftStart;
                      String shiftEnd;
                      shiftStart =
                          '${shiftController.startHour.value}:${shiftController.startMinute.value} ${shiftController.startShift}';
                      shiftEnd =
                          '${shiftController.endHour.value}:${shiftController.endMinute.value} ${shiftController.endShift}';
                      // Api.updateShift(shiftStart, shiftEnd, widget.id);
                      shiftController.updateShift(
                          startTime: shiftStart,
                          endTime: shiftEnd,
                          id: widget.id);
                    },
                    color: AppColor.darkBlue,
                    buttonText: 'ASSIGN SHIFT',
                    loading: shiftController.loading.value,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Row borderText(msg) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: const RoundedRectangleBorder(),
            color: AppColor.darkBlue,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextComponent(
                  text: msg,
                  fweight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
