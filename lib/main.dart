import 'dart:io';
import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    NotificationViewModel().initLocalNotification();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandle);
    runApp(const MyApp());
  } catch (e) {
    InternetExpection(onPressed: () {
      main();
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandle(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supertec Office',
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.black),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashView(),
      getPages: AppRoute.appRoute(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
