import 'dart:async';
import 'package:get/get.dart';

import '../../Controllers/app_base_controller/app_base_controller.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Routes/routes.dart';


class SplashController extends AppBaseController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    checkLogin();
  }

checkLogin() async{
    Timer(const Duration(seconds: 3),() async{
      final isLogin = await SharedPre.getStringValue('userId');
      if(isLogin != null && isLogin != ''){
          Get.offAllNamed(homeScreen);
      }else {
          Get.offAllNamed(loginScreen);
      }
    });
}
}