import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Controllers/app_base_controller/app_base_controller.dart';
import '../../../Models/HomeModel/signUp_cat_model.dart';
import '../../../Routes/routes.dart';
import '../../../Services/api_services/apiStrings.dart';

class SignupController extends AppBaseController {
  RxBool isLoading = false.obs ;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    // TODO: implement initState
    getCateApi();
  }
  Future<void> registerUser(
      {
      required String mobile,
      required String? name,
      required String? city,
      required String? state,
      required String? email,
      required String? capacity,
      }) async {
    isLoading.value = true ;
    var param = {
      'userName': name,
      'mobile': mobile,
      'role': 'user',
      'city': city
    };
    apiBaseHelper.postAPICall(getUserRegister, param).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
      // String msg = getData['msg'];
      if (status) {
        Get.toNamed(otpScreen, arguments: [mobile, getData['otp']]);
        Fluttertoast.showToast(msg: msg);
      } else {
        Fluttertoast.showToast(msg: msg);
      }
      isLoading.value = false;
    });
  }

  GetCatModel? getCatModel;
  Future<void> getCateApi() async {
    apiBaseHelper.postAPICall2(getCatAPI).then((getData) {
      print('_____getData_____${getData}_________');
      getCatModel = GetCatModel.fromJson(getData);
    update();
      //isLoading.value = false;
    });
  }
}
