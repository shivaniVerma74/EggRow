
import 'package:eggrow/Routes/routes.dart';
import 'package:eggrow/Routes/screen_bindings.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../Screens/Auth_Views/Forgot_Password/forgot_password_view.dart';
import '../Screens/Auth_Views/Login/login_view.dart';
import '../Screens/Auth_Views/Otp_Verification/otp_verify_view.dart';
import '../Screens/Auth_Views/Signup/signup_view.dart';
import '../Screens/Bookings/my_booking_view.dart';
import '../Screens/ChnagePassword/chnage_password_view.dart';
import '../Screens/ContactUs/contactUs_View.dart';
import '../Screens/Dashboard/dashboard_view.dart';
import '../Screens/Dashboard/dashbord_counter_view.dart';
import '../Screens/FaQ/faq_view.dart';
import '../Screens/Home/home_view.dart';
import '../Screens/Privacy_Policy/privacy_view.dart';
import '../Screens/Profile/profile_view.dart';
import '../Screens/Search/search_view.dart';
import '../Screens/Splash/splash_screen.dart';
import '../Screens/Terms_Condition/terms_condition_view.dart';

class AllPages {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: splashScreen,
          page: () => const SplashScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: loginScreen,
          page: () => const LoginScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: forgotPasswordScreen,
          page: () => const ForgotPasswordScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: otpScreen,
          page: () => const OTPVerificationScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: signupScreen,
          page: () => const SignupScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: bottomBar,
          page: () =>  DashBoardScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: bottomBar1,
          page: () =>  DashBoardCounterScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: homeScreen,
          page: () =>  HomeScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: privacyScreen,
          page: () => const PrivacyPolicyScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: termConditionScreen,
          page: () => const TermsAndConditionScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: bookings,
          page: () => const MyBookingsScreen(isFrom: true),
          binding: ScreenBindings()),
      GetPage(
          name: changePasswordScreen,
          page: () => const ChangePasswordScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: profileScreen,
          page: () =>  ProfileScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: search,
          page: () => const SearchScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: faq,
          page: () => const FaqScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: contact,
          page: () => const ContactUsScreen(),
          binding: ScreenBindings()),

    ];
  }
}