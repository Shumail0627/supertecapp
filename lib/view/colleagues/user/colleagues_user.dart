import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class ColleaguesUser extends StatelessWidget {
  const ColleaguesUser({
    super.key,
    required this.userDetail,
  });
  final User? userDetail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 58,
              backgroundColor: userDetail!.borderColor!,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: CachedNetworkImageProvider(
                    'http://superteclabs.com/apis2/images/${userDetail!.image!}'),
              ),
            ),
            TextComponent(
              text: userDetail!.name!,
              fweight: FontWeight.bold,
              size: 18,
            ),
            verticalPadding(
              v: 10,
              child: TextComponent(
                text: userDetail!.status!,
                fweight: FontWeight.bold,
                size: 12,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(() => GoogleMapView(
                      lat: userDetail!.lat,
                      long: userDetail!.long,
                    ));
              },
              icon: Icon(
                Icons.location_on,
                color: Colors.red,
                size: Get.height * 0.08,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class User {
  String? name;
  String? image;
  String? lat;
  String? long;
  String? status;
  Color? borderColor;
  User(
      {required this.name,
      this.lat,
      this.long,
      required this.image,
      required this.status,
      required this.borderColor});
}
