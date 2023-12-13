import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eggrow/Screens/Splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Routes/routes.dart';
import '../../Utils/Colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    // final heightSize = MediaQuery.sizeOf(context).height;
    // final widthSize = MediaQuery.sizeOf(context).width;
    return GetBuilder(
        init: SplashController(),
        builder: (controller) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/splashimage.png"),
                fit: BoxFit.fill,
              ),
            ),
            // child: AnimatedSplashScreen.withScreenFunction(
            //   splash: 'assets/images/SPLASH LOGO.png',
            //   screenFunction: () async {
            //     return checkLogin();
            //   },
            //   splashTransition: SplashTransition.scaleTransition,
            //   pageTransitionType: PageTransitionType.scale,
            //   animationDuration: Duration(seconds: 2),
            //   splashIconSize: 250,
            //   backgroundColor: AppColors.secondary,
            // ),
          );
        });
  }

  checkLogin() async {
    final isLogin2 = await SharedPre.getStringValue('userId');
    Future.delayed(const Duration(seconds: 3), () async {
      final isLogin = await SharedPre.getStringValue('userId');
      final role = await SharedPre.getStringValue('userRole');
      if (isLogin != null && isLogin != '') {
        // Navigator.push(MaterialPageRoute(builder: (context)=>SearchScreen()));
         if(role == "user"){
           Get.offAllNamed(homeScreen);
         }else{
           if(role == "user"){
             print('__________sssssssssssssssss_________');
             Get.offAllNamed(homeScreen);
           }else{
             print('__________pppppppppppppp_________');
             Get.offAllNamed(homeScreen);
           }
         }
        //Get.offAllNamed(bottomBar);
      } else {
        Get.offAllNamed(loginScreen);
      }
    });
  }
}