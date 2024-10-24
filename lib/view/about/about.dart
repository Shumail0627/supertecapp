import '../../utils/new_all_imports.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextComponent(
          text: "About the Developer",
          color: Colors.white,
        ),
        backgroundColor: AppColor.darkBlue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Developer Picture
            const CircleAvatar(
              radius: 70,
              backgroundColor: AppColor.lightBlue,
              backgroundImage: AssetImage('assets/images/IMG_0007.jpg'),
            ),
            const SizedBox(height: 20),
            // Developer Name
            const TextComponent(
              text: "Hayat Khan",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.darkBlue,
              ),
            ),
            const SizedBox(height: 10),
            // Developer Details
            const TextComponent(
              text:
                  "Flutter Mobile Developer passionate about crafting beautiful and functional applications. Experienced in Flutter and Dart, dedicated to delivering high-quality, user-centric solutions.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColor.black,
              ),
            ),
            const Spacer(),
            // Contact Button
            ElevatedButton(
              onPressed: () {
                String url =
                    "https://api.whatsapp.com/send?phone=+923102205066&text=From SuptecOfficeApp";
                Utils.runUrl(url: url, context: context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.darkBlue,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const TextComponent(
                text: "Contact Me",
                style: TextStyle(fontSize: 18, color: AppColor.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
