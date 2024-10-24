import 'package:flutter/cupertino.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';
import 'package:supertec_app_clean_code/view_models/controller/leave/grant_leave_view_model.dart';

class GrantLeaveView extends StatefulWidget {
  const GrantLeaveView({super.key, required this.id});
  final String id;
  @override
  State<GrantLeaveView> createState() => _GrantLeaveViewState();
}

class _GrantLeaveViewState extends State<GrantLeaveView> {
  final grantLeaveVM = Get.put(GrantLeaveViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextComponent(
              text: 'Select how mant leaves you are willing to assign',
              color: AppColor.darkBlue,
              fweight: FontWeight.bold,
            ),
            verticalPadding(
              child: SizedBox(
                width: 200,
                height: 200,
                child: CupertinoPicker(
                  itemExtent: 31,
                  looping: true,
                  onSelectedItemChanged: (value) {
                    grantLeaveVM.selectLeave.value = value + 1;
                    // setState(() {
                    //   selectLeave = value + 1;
                    // });
                  },
                  children: List.generate(
                    31,
                    (index) {
                      return Text("${index + 1}");
                    },
                  ),
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                grantLeaveVM.grantLeaves(id: widget.id.toString());
              },
              color: AppColor.darkBlue,
              buttonText: 'GRANT LEAVES',
            )
          ],
        ),
      ),
    );
  }
}
