import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Controllers/app_base_controller/app_base_controller.dart';
import '../../../Local_Storage/shared_pre.dart';
import '../../../Routes/routes.dart';
import '../../../Services/api_services/apiStrings.dart';

class OTPVerifyController extends AppBaseController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
      data = Get.arguments ;
      otp = data[1].toString();
      print('______otp____${otp}_________');
  }

RxBool isLoading = false.obs ;
  List data = [];
  var otp;

  String? role;
  Future<void> verifyOTP() async {
    isLoading.value = true ;
    var param = {
      'mobile': data[0].toString(),
      'otp': otp,
    };
    apiBaseHelper.postAPICall(verifyOTPAPI, param).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
       role = getData['role'];
      if (status) {
        SharedPre.setValue('userData', getData['user_name']);
        SharedPre.setValue('userMobile', getData['mobile']);
        SharedPre.setValue('userReferCode', getData['referral_code']);
        SharedPre.setValue('balanceUser', getData['wallet_balance']);
        SharedPre.setValue('userId', getData['user_id'].toString());
        SharedPre.setValue('userRole', getData['role']);
        Fluttertoast.showToast(msg: msg);
        if(role == "user"){
          Get.offAllNamed(homeScreen);
        }else{
          if(role == 'user'){
            print('__________${role}_________');
            Get.offAllNamed(homeScreen);
          }else{
            print('__________${role}_________');
            Get.offAllNamed(homeScreen);
          }
        }
      } else {
        Fluttertoast.showToast(msg: msg);
      }
      isLoading.value = false ;
    });
  }

  Future<void> resendSendOtp() async {
    update();
    var param = {
      'mobile': data[0].toString(),
      'app_key':"#63Y@#)KLO57991(\$457D9(JE4dY3d2250f\$%#(mhgamesapp!xyz!punjablottery)8fm834(HKU8)5grefgr48mg1"
    };
    apiBaseHelper.postAPICall(sendOTPAPI, param).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
       otp = getData['otp'].toString();
       update();
      if (status) {
        Fluttertoast.showToast(msg: msg);
        update();
      } else {
      }
    });
  }
}