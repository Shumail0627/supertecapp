import '../../utils/new_all_imports.dart';
import '../../view/office_location_view.dart';
import '../../view/start/privacy_policy_view.dart';

class AppRoute {
  static appRoute() => [
        GetPage(
          name: RouteName.splashView,
          page: () => const SplashView(),
        ),
        GetPage(
          name: RouteName.employeeLoginView,
          page: () => const EmployeeLoginView(),
        ),
        GetPage(
          name: RouteName.employeeSignUpView,
          page: () => const EmployeeSignUpView(),
        ),
        GetPage(
          name: RouteName.start,
          page: () => const Start(),
        ),
        // GetPage(
        //   name: RouteName.employeeHomeView,
        //   page: () => const EmployeeHomeView(),
        // ),
        GetPage(
          name: RouteName.assignTaskView,
          page: () => const AssignTaskView(),
        ),
        // GetPage(
        //   name: RouteName.chatwithadminView,
        //   page: () => const ChatWithAdminView(),
        // ),
        GetPage(
          name: RouteName.customBottomNavigationView,
          page: () => const CustomBottomNavigation(),
        ),
        GetPage(
          name: RouteName.updateProfileView,
          page: () => const UpdateProfileView(),
        ),
        GetPage(
          name: RouteName.adminLoginView,
          page: () => const AdminLoginView(),
        ),
        GetPage(
          name: RouteName.adminHomeView,
          page: () => const AdminHomeView(),
        ),
        GetPage(
          name: RouteName.addCompanyLocation,
          page: () => const AddCompanyLocation(),
        ),
        GetPage(
          name: RouteName.officeLocation,
          page: () => const AllOfficeLocationView(),
        ),
        GetPage(
          name: RouteName.resgisterCompanyView,
          page: () => const ResgisterCompanyView(),
        ),
        GetPage(
          name: RouteName.privacyPolicyView,
          page: () => const PrivacyPolicyView(),
        ),
      ];
}
