import 'package:flutter/cupertino.dart';
import 'package:supertec_app_clean_code/repository/shift_repository/shift_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class UpdatShiftModel extends GetxController {
  final _apiService = ShiftRepository();
  RxString startHour = ''.obs;
  RxString startMinute = '00'.obs;
  RxString endHour = ''.obs;
  RxString endMinute = '00'.obs;
  RxString startShift = 'am'.obs;
  RxString endShift = ''.obs;
  List time = ['am', 'pm'];
  RxBool loading = false.obs;

  updateShift(
      {required String? startTime,
      required String? endTime,
      required String? id}) async {
    loading.value = true;
    final url =
        "https://superteclabs.com/apis2/updateShifts.php?id=$id&time_s=$startTime&time_e=$endTime";

    _apiService.shiftApi(url).then((value) {
      if (value['message'] == 'Shift Assigned') {
        loading.value = false;
        Utils.toastMessage(value['message']);
      } else {
        loading.value = false;
        Utils.toastMessage(value['message']);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      return Utils.toastMessage(
          "Error occurred. Check your network or try again later.");
    });
  }

//start timePicker
  startShiftTimePicker() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 200,
            width: 200,
            child: CupertinoPicker(
                looping: true,
                itemExtent: 20,
                onSelectedItemChanged: (v) {
                  if (v < 10) {
                    startHour.value = "0${v + 1}";
                  } else {
                    startHour.value = "${v + 1}";
                  }
                },
                children: List.generate(
                    12, (index) => TextComponent(text: "${index + 1}"))),
          ),
        ),
        const TextComponent(
          text: ':',
          fweight: FontWeight.bold,
        ),
        Expanded(
          child: SizedBox(
            height: 200,
            width: 200,
            child: CupertinoPicker(
                looping: true,
                itemExtent: 20,
                onSelectedItemChanged: (v) {
                  if (v < 10) {
                    startMinute.value = "0${v.toString()}";
                  } else {
                    startMinute.value = v.toString();
                  }
                },
                children: List.generate(
                    60, (index) => TextComponent(text: index.toString()))),
          ),
        ),
        const TextComponent(
          text: ':',
          fweight: FontWeight.bold,
        ),
        Expanded(
          child: SizedBox(
            height: 200,
            width: 200,
            child: CupertinoPicker(
                // looping: true,
                itemExtent: 20,
                onSelectedItemChanged: (v) {
                  startShift.value = v == 0 ? "am" : "pm";
                  // startShift.value = v.toString();
                },
                children: List.generate(
                    time.length, (index) => TextComponent(text: time[index]))),
          ),
        )
      ],
    );
  }

//end timePicker
  endShiftTimePicker() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 200,
            width: 200,
            child: CupertinoPicker(
                looping: true,
                itemExtent: 20,
                onSelectedItemChanged: (v) {
                  if (v < 10) {
                    endHour.value = "0${v + 1}";
                  } else {
                    endHour.value = "${v + 1}";
                  }
                },
                children: List.generate(
                    12, (index) => TextComponent(text: "${index + 1}"))),
          ),
        ),
        const TextComponent(
          text: ':',
          fweight: FontWeight.bold,
        ),
        Expanded(
          child: SizedBox(
            height: 200,
            width: 200,
            child: CupertinoPicker(
                looping: true,
                itemExtent: 20,
                onSelectedItemChanged: (v) {
                  if (v < 10) {
                    endMinute.value = "0${v.toString()}";
                  } else {
                    endMinute.value = v.toString();
                  }
                },
                children: List.generate(
                    60, (index) => TextComponent(text: index.toString()))),
          ),
        ),
        const TextComponent(
          text: ':',
          fweight: FontWeight.bold,
        ),
        Expanded(
          child: SizedBox(
            height: 200,
            width: 200,
            child: CupertinoPicker(
                // looping: true,
                itemExtent: 20,
                onSelectedItemChanged: (v) {
                  endShift.value = v == 0 ? "am" : "pm";
                  // startShift.value = v.toString();
                },
                children: List.generate(
                    time.length, (index) => TextComponent(text: time[index]))),
          ),
        )
      ],
    );
  }
}
