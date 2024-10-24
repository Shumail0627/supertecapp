import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/location_model.dart';
import '../../utils/new_all_imports.dart';
import '../../view_models/controller/location/add_office_location_controller.dart';

class OfficeLocationView extends StatefulWidget {
  const OfficeLocationView({super.key, required this.locationPoint});
  final LocationPoint locationPoint;
  @override
  State<OfficeLocationView> createState() => _OfficeLocationViewState();
}

class _OfficeLocationViewState extends State<OfficeLocationView> {
  LocationPoint get locationPoint => widget.locationPoint;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: GetBuilder(
          init: OfficeLocationViewModel(locationPoint),
          builder: (controller) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 250,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade400,
                            Colors.blue.shade600,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.blue.shade700,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GoogleMap(
                          initialCameraPosition: controller.cameraPosition,
                          markers: Set.of(controller.marker),
                        ),
                      ),
                    ),
                    sizedBox(),
                    TextFieldComponent(
                        label: 'Office Name',
                        textSize: 14,
                        validator: fieldValidator,
                        controller: controller.officeNameController,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    sizedBox(),
                    CustomButton(
                        loading: controller.isLoading,
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            controller.addOfficeLocation(context);
                          }
                        },
                        buttonText: 'Save Location')
                  ],
                ),
              ),
            );
          }),
    );
  }
}
