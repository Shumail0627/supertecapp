import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:supertec_app_clean_code/models/uploadIMG/uploadimg_model.dart';
import 'package:supertec_app_clean_code/repository/upload_image_repository/upload_image_repository.dart';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class IMGUpdateModel extends GetxController {
  final pref = UserPreferences();
  final _apiServices = UploadIMGRepository();
  File? imageFile;
  String encodedImage = '';
  final refreshVM = Get.put(LoadProfileModel());

  getImage() async {
    var user = await pref.getUser();
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
      List<int> imageBytes = imageFile!.readAsBytesSync();
      encodedImage = base64Encode(imageBytes);
      ImagePostModel data =
          ImagePostModel(id: user.id, image: encodedImage.toString());

      //now post img
      _apiServices.uploadIMGApi(data.toJson()).then((value) {
        if (!value['error']) {
          refreshVM.updateImg();
          Utils.toastMessage(value['message']);
        } else {
          Utils.toastMessage(value['message']);
        }
      }).onError((error, stackTrace) => Utils.toastMessage(
          "Error occurred. Check your network or try again later."));
    }
  }
}
