
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Controllers/app_base_controller/app_base_controller.dart';
import '../Bookings/my_booking_view.dart';
import '../Home/home_view.dart';
import '../Profile/profile_view.dart';

class DashboardController extends AppBaseController {

List <Widget>  pages = [
 HomeScreen(),
const MyBookingsScreen(isFrom: false),
   ProfileScreen(),
   ProfileScreen()
];

RxInt currentIndex = 1.obs ;
int bottomIndex = 0;

}