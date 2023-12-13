
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Utils/Colors.dart';
import '../Bookings/my_booking_view.dart';
import '../Home/home_view.dart';
import '../Profile/profile_view.dart';
import '../Subscription/sub_plan_view.dart';
class DashBoardCounterScreen extends StatefulWidget {
  DashBoardCounterScreen({Key? key,this.nameC,this.cityC,this.catId,this.counterId}) : super(key: key);
  String? nameC,cityC,catId,counterId;
  @override
  State<DashBoardCounterScreen> createState() => _DashBoardCounterScreenState();
}

class _DashBoardCounterScreenState extends State<DashBoardCounterScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  //final GlobalKey<ScaffoldState> _key = GlobalKey();
  int currentIndex = 1 ;
  int bottomIndex = 0;
  String? userRole;
  List <Widget>
  pageList  = [
    HomeScreen(),
    ProfileScreen(),
    SubscriptionScreen(isbool: true,)
  ];

  // List <Widget>  pageList1  = [
  //   HomeScreen(),
  //   ProfileScreen()
  // ];

  @override
  void initState() {
    super.initState();
    referCode();
  }

  referCode() async {
    userRole = await SharedPre.getStringValue('userRole');
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Display a confirmation dialog when the back button is pressed.
        bool exit = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Exit App'),
              content: Text('Are you sure you want to exit the app?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Cancel exit
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Confirm exit
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );

        return exit ?? false; // Exit if the user confirmed (true) or continue if canceled (false).
      },
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            //buttonBackgroundColor: Colors.white,
            color: AppColors.secondary,
            backgroundColor: AppColors.whit,
            items:  const [
              CurvedNavigationBarItem(
                  child: ImageIcon(AssetImage(AppConstants.homeIcon),
                      color: AppColors.whit),
                  label: 'Home',
                  labelStyle: TextStyle(color: AppColors.whit)
              ),

              CurvedNavigationBarItem(
                  child: ImageIcon(AssetImage(AppConstants.profileIcon),
                      color: AppColors.whit),
                  label: 'Account',
                  labelStyle: TextStyle(color: AppColors.whit)
              ),
              CurvedNavigationBarItem(
                  child: ImageIcon(AssetImage(AppConstants.bookingHistoryIcon),
                      color: AppColors.whit),
                  label: 'Subscription',
                  labelStyle: TextStyle(color: AppColors.whit)
              ),
            ],
            onTap: (index) {
              setState(() {
                bottomIndex = index;
              });

              //Handle button tap
            },
          ),
          key: _key,
          backgroundColor: AppColors.whit,
          body: pageList[bottomIndex]

      ),
    );
  }
}
