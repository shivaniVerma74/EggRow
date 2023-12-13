import 'dart:convert';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eggrow/Routes/routes.dart';
import 'package:eggrow/Screens/Privacy_Policy/privacy_view.dart';
import 'package:eggrow/Screens/Terms_Condition/terms_condition_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/GeteggModel.dart';
import '../../Models/HomeModel/get_slider_model.dart';
import '../../Models/get_counter_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/Colors.dart';
import '../Auth_Views/Login/login_view.dart';
import '../Counter/counter_view.dart';
import '../CreateToken/create_token_view.dart';
import '../Notification/notification_view.dart';
import '../Profile/profile_view.dart';
import '../Search/search_view.dart';
import 'package:http/http.dart'as http;
import '../Subscription/sub_plan_view.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key,this.nameC,this.cityC,this.catId,this.counterId}) : super(key: key);
  String? nameC,cityC,catId,counterId;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 1;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eggsDetails();
    getSlider();
    getFilterApi();
    referCode();
  }

  String? userRole;
  referCode() async {
    userRole = await SharedPre.getStringValue('userRole');
    setState(() {
    });
  }

  var whatsNumber;
  final whatsapppBoxKey = GlobalKey();
  openwhatsapp() async {
    var whatsapp = "+917376341786";
    var whatsappURl_android = "whatsapp://send?phone=" + whatsapp +
        "&text=Hello, Giftbash I have one query? ";
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Whatsapp does not exist in this device"),
      ),
      );
    }
  }

  final CarouselController carouselController = CarouselController();
  TextEditingController dobCtr = TextEditingController();

  List<String> tList = [
    'Profile',
    'TermCondition',
    'PrivacuPolicy',
    'Logout'
  ];

  List<IconData> IList = [
    Icons.home,
    Icons.help,
    Icons.help,
    Icons.logout
  ];

  getDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.15,
              //   child: DrawerHeader(
              //       decoration: BoxDecoration(
              //         color: Color(0xFF112c48),
              //       ),
              //       child: Row(
              //         children: [
              //           Container(
              //             width: 80,
              //             height: 80,
              //             child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(50),
              //                 child: Image.network("${getProfileModel?.data?.first.profilePic}", fit: BoxFit.fill,)),
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               const Text(
              //                 'Hello!',
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 24,
              //                     fontWeight: FontWeight.bold),
              //               ),
              //               getProfileModel?.data?.first.name == null || getProfileModel?.data?.first.name == "" ? const Text(
              //                 'Demo',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 18,
              //                 ),
              //               ):
              //               Text(
              //                 '${getProfileModel?.data?.first.name}',
              //                 style: const TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 18,
              //                 ),
              //               ),
              //               const Text(
              //                 'Online',
              //                 style: TextStyle(fontSize: 12,color: Colors.white),
              //               ),
              //             ],
              //           )
              //         ],
              //       )),
              // ),
              Container(padding: const EdgeInsets.symmetric(horizontal: 20)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tList.length,
                itemBuilder: (context, index) {
                  return
                    tileList(icon: IList[index], title: tList[index], index: index);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  int selected = 0;
  Widget tileList({required String title, required IconData icon, required int index}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      onTap: () {
        setState(() {
          selected = index;
        });
        if (selected==0) {
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context) => ProfileScreen()
          ),
          );
        }
        else if(selected==1){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TermsAndConditionScreen()
            ),
          );
        }
        else if(selected==2){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PrivacyPolicyScreen()
            ),
          );
        }
        else if(selected==3){
          logout(context);
        }
      },
      // leading: Container(
      //   margin: EdgeInsets.all(12),
      //   padding: EdgeInsets.all(7),
      //   decoration: BoxDecoration(
      //     color: selected == index ? Colors.white : const Color(0xFF112c48),
      //     borderRadius: BorderRadius.circular(5),
      //   ),
      //   child: Image(image: AssetImage(imagePath[index])),
      //   // Icon(
      //   //   icon,
      //   //   color: selected == index ? Color(0xFF112c48) : Colors.white,
      //   //   size: 18,
      //   // ),
      // ),
      tileColor: selected == index ? const Color(0xFF112c48) : Colors.white,
      minLeadingWidth: 20,
      title: Text(
        title, style: TextStyle(
          fontSize: 14,
          color: selected == index ? Colors.white : Colors.black),
      ),
    );
  }


  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime lastDate = currentDate.add(Duration(days: 6));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: currentDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  logout(context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Sign Out"),
            content: const Text("Are you sure to log out?"),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: AppColors.primary),
                child: Text("YES"),
                onPressed: () async {
                  // setState(() {
                  //   removesession();
                  // });
                  Navigator.pop(context);
                  // SystemNavigator.pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: AppColors.primary),
                child: const Text("NO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  // List newDatalist=[];
   neewData(String location) {
    String locationsString = "${location}";
    List newDatalist = locationsString.split(',');
   return newDatalist;
   // print(locationsList); // Output: [itarsi, bhopal, banglore]
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _key,
          floatingActionButton: Container(
            key: whatsapppBoxKey,
            height: 55.0,
            width: 55.0,
            child: FloatingActionButton(
              backgroundColor: Colors.white ,
              onPressed: () {
                openwhatsapp();
              },
              child: Image.asset("assets/images/whatsapp.png"),
            ),
          ),
        backgroundColor: AppColors.whit,
        appBar: AppBar(
          centerTitle: true,
          title: InkWell(
            onTap: () {
              Fluttertoast.showToast(msg: "Coming Soon");
            },
            child: Container(
              height: 30,
              width: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.yellow),
              child: const Center(child: Text("BuyNow", style: TextStyle(fontSize: 15, color: AppColors.whit),)),),
          ),
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50),
            ),
          ),
          toolbarHeight: 60,
          actions: [
            InkWell(
                onTap: () async {
                  _selectDate(context);
                  // DateTime? datePicked = await showDatePicker(
                  //     context: context,
                  //     initialDate: DateTime.now(),
                  //     firstDate: DateTime(2000),
                  //     lastDate: DateTime(2024));
                  //  if (datePicked != null) {
                  //   print(
                  //       'Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
                  //   String formettedDate =
                  //   DateFormat('dd-MM-yyyy').format(datePicked);
                  //   setState(() {
                  //     dobCtr.text = formettedDate;
                  //   });
                  // }
                },
                child: const Icon(Icons.calendar_month),
            ),
            const SizedBox(width: 15),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationScreen(),
                  ),
                 );
                },
                  child: Image.asset("assets/images/notification.png", height: 15, width:20,color: AppColors.whit)),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10)),
              gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.9,
                  colors: <Color>[AppColors.primary, AppColors.secondary]),
            ),
          ),
          // shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
          leading: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              // _key.currentState!.openDrawer();
            },
            child: Container(
                height: 35,
                width: 42,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Icon(Icons.person, color: AppColors.primary,)
            ),
          ),
        ),
          drawer: getDrawer(context),
          body: eggsModel == null ? Center(child: CircularProgressIndicator()):
          ListView.builder(
          itemCount: eggsModel?.data?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (c, i){
            List  newDatalist =  neewData("${eggsModel?.data?[i].location}");
            List  newDatalistprice =  neewData("${eggsModel?.data?[i].price}");
           return Padding(
            padding:  EdgeInsets.only(left: 10, right: 10, top: 12),
            child: Card(
              shape:  RoundedRectangleBorder(
                side: BorderSide(
                  color:AppColors.primary,
                ),
                  borderRadius: BorderRadius.circular(20.0)
              ),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("${eggsModel?.data?[i].date} ${eggsModel?.data?[i].time}", style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(height: 3,),
                            for(int j=0;j<newDatalist.length;j++)...[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Text("${newDatalist[j]}:  ${newDatalistprice[j]} Rs.",style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold)),
                                    // SizedBox(width: 10,),
                                    // Text("${newDatalistprice[j]}")
                                  ],
                                ),
                              )
                            ],
                            SizedBox(height: 3,),
                            // for(int j=0;j<newDatalistprice.length;j++)...[
                            //
                            // ],
                          //  Text("${eggsModel?.data?[i].location}: ${eggsModel?.data?[i].price}", style: TextStyle(fontSize: 13, color: Colors.black),),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: InkWell(
                                  onTap: () {
                                    launch("${eggsModel?.data?[i].url}");
                                  },
                                  child: Text("${eggsModel?.data?[i].url}", style: TextStyle(fontSize: 13, color: Colors.blue, fontWeight: FontWeight.bold, )),
                              ),
                            ),
                            SizedBox(height: 8,)
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        })
        // userRole == "user" ? userUI() :counterUI()
      ),
    );
  }

  ///////////////////////UserSite//////////////////
  userUI(){
    return getCounterModel == null ?const Center(child: CircularProgressIndicator()) : RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 2),(){
          getSlider();
          getFilterApi();

        });
      },
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context,i){
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Welcome To EggRow',style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     CarouselSlider(
                //         items: getSliderModel?.sliderdata!
                //             .map(
                //               (item) => Stack(
                //               alignment: Alignment.center,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: ClipRRect(
                //                       borderRadius: BorderRadius.circular(10),
                //                       child: Container(
                //                         height: 200,
                //                         decoration: BoxDecoration(
                //                             image: DecorationImage(
                //                                 image: NetworkImage(
                //                                   "${item.sliderImage}",
                //                                 ),
                //                                 fit: BoxFit.fill)),
                //                       )
                //                   ),
                //                 ),
                //               ]),
                //         )
                //             .toList(),
                //         carouselController: carouselController,
                //         options: CarouselOptions(
                //             height: 150,
                //             scrollPhysics: const BouncingScrollPhysics(),
                //             autoPlay: true,
                //             aspectRatio: 1.8,
                //             viewportFraction: 1,
                //             onPageChanged: (index, reason) {
                //               setState(() {
                //                 _currentPost = index ;
                //               });
                //
                //             })),
                //     const SizedBox(
                //       height: 5,
                //     ),
                //     Row(mainAxisAlignment: MainAxisAlignment.center,
                //       children: _buildDots(),),
                //     // sliderPointers (items , currentIndex),
                //
                //   ],),

                // getCatListView(controller),
                //sliderPointers (controller.catList , controller.catCurrentIndex.value ),
                const SizedBox(height: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   color: AppColors.lotteryColor,
                    //   height: 160,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const Text(
                    //           "Today's Token",
                    //           style: TextStyle(
                    //               color: AppColors.fntClr,
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //         const SizedBox(
                    //           height: 10,
                    //         ),
                    //
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    todayToken()
                    // Padding(
                    //   padding: const EdgeInsets.all(0.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const Padding(
                    //         padding: EdgeInsets.only(left: 8),
                    //         child: Text(
                    //           "Tomorrow Token",
                    //           style: TextStyle(
                    //               color: AppColors.fntClr,
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //       const SizedBox(height: 10,),
                    //       //tomorrowToken()
                    //
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 20,)
                  ],
                ),
              ],
            );
          }),
    );
  }


  int _currentPost = 0;
   _buildDots() {
    List<Widget> dots = [];
    if (getSliderModel == null) {
    } else {
      for (int i = 0; i < getSliderModel!.sliderdata!.length; i++) {
        dots.add(
          Container(
            margin: const EdgeInsets.all(1.5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPost == i ?  AppColors.profileColor : AppColors.secondary,
            ),
          ),
        );
      }
    }
    return dots;
  }


  GetSliderModel? getSliderModel;
  Future<void> getSlider() async {
    // isLoading.value = true;
    var param = {
      'app_key': ""
    };
    apiBaseHelper.postAPICall(getSliderAPI, param).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
      if (status == true) {
        getSliderModel = GetSliderModel.fromJson(getData);
        setState(() {

        });
      } else {
        Fluttertoast.showToast(msg: msg);
      }
    });
  }

  todayToken(){
    return Container(
     // height: MediaQuery.of(context).size.height,
      child:getCounterModel?.todaysTokens!.isEmpty ?? false ? Center(child: Text("No Today Token")): ListView.builder(
          scrollDirection: Axis.vertical,
            shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
          itemCount:getCounterModel?.todaysTokens?.length ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CounterScreen(cId:
                getCounterModel!.todaysTokens![index].counterId,
                  tokenId: getCounterModel!.todaysTokens![index].id,
                  date:getCounterModel!.todaysTokens![index].date ,
                  fTime: getCounterModel!.todaysTokens![index].fromTime,
                  toTime: getCounterModel!.todaysTokens![index].toTime,
                  tTotal: getCounterModel!.todaysTokens![index].totalToken,)));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                    height: 100,

                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/lotteryback.png"), fit: BoxFit.fill)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10,top: 6),
                              child: Row(
                                children: [
                                  const Text("Expected Time:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                  const SizedBox(width: 2,),
                                  Row(
                                    children: [
                                      Text("${getCounterModel!.todaysTokens![index].fromTime}",style: const TextStyle(color: AppColors.whit,fontSize: 12),),
                                      Text(" to ${getCounterModel!.todaysTokens![index].toTime}",style: const TextStyle(color: AppColors.whit,fontSize: 12),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8,top: 6),
                              child: Row(
                                children: [

                                  const Text("Date:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                  const SizedBox(width: 2,),
                                  Text("${getCounterModel!.todaysTokens![index].date!}",style: const TextStyle(color: AppColors.whit,fontSize: 12),)
                                ],
                              ),
                            )
                          ],
                        ),

                        // Column(
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("data"),
                        //         Text("data")
                        //       ],
                        //     )
                        //   ],
                        // ),
                        SizedBox(height: 10,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 const Text("City Name : ",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                 const SizedBox(width: 2,),
                                 Text("${getCounterModel!.todaysTokens![index].city}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                               ],
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 const Text("Name : ",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                 const SizedBox(width: 2,),
                                 Text("${getCounterModel!.todaysTokens![index].userName}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                               ],
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 const Text("Current Token : ",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                 const SizedBox(width: 2,),
                                 Text("${getCounterModel!.todaysTokens![index].currentToken}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                               ],
                             ),


                           ],
                         ),
                       ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [


                                ],
                              )

                            ],
                          ),
                        )

                      ],
                    )
                ),
              ),
            );
          }
      ),
    );
  }
//   tomorrowToken(){
//     return  Container(
//       child: getCounterModel?.upcomingTokens?.isEmpty ?? false ? Center(child: const Text("No UpcomingTokens")):ListView.builder(
//           itemCount:getCounterModel?.upcomingTokens?.length  ?? 0,
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CounterScreen(cId:
//                 getCounterModel!.upcomingTokens![index].counterId,
//                   tokenId: getCounterModel!.upcomingTokens![index].id,
//                   date:getCounterModel!.upcomingTokens![index].date ,
//                   fTime: getCounterModel!.upcomingTokens![index].fromTime,
//                   toTime: getCounterModel!.upcomingTokens![index].toTime,
//                   tTotal: getCounterModel!.upcomingTokens![index].totalToken,)));
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child:  Container(
//                     height: 100,
//                     width: 280,
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage("assets/images/lotteryback.png"), fit: BoxFit.fill)),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10,top: 6),
//                               child: Row(
//                                 children: [
//                                   const Text("Expected Time:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
//                                   const SizedBox(width: 2,),
//                                   Row(
//                                     children: [
//                                       Text("${getCounterModel!.upcomingTokens![index].fromTime}",style: const TextStyle(color: AppColors.whit,fontSize: 12),),
//                                       Text(" to ${getCounterModel!.upcomingTokens![index].toTime}",style: const TextStyle(color: AppColors.whit,fontSize: 12),),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8,top: 6),
//                               child: Row(
//                                 children: [
//
//                                   const Text("Date:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
//                                   const SizedBox(width: 2,),
//                                   Text("${getCounterModel!.upcomingTokens![index].date!}",style: const TextStyle(color: AppColors.whit,fontSize: 12),)
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//
//                         Padding(
//                           padding: const EdgeInsets.only(left: 5,right: 10,top: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   children: [
//                                     const SizedBox(height: 2,),
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             const Text("City Name:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
//                                             const SizedBox(width: 2,),
//                                             Text("${getCounterModel!.upcomingTokens![index].companyName}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             const SizedBox(height: 10,),
//                                             const Text("Name :",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
//                                             const SizedBox(width: 2,),
//                                             Text("${getCounterModel!.upcomingTokens![index].userName!}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),)
//                                           ],
//                                         ),
//                                         const SizedBox(height: 2,),
//                                         Row(
//                                           children: [
//                                             const Text("Current Token:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
//                                             const SizedBox(width: 2,),
//                                             Text("${getCounterModel!.upcomingTokens![index].currentToken}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
//                                           ],
//                                         ),
//
//
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                         ),
//
//                       ],
//                     )
//                 ),
//               ),
//             );
//           }
//       ),
//     );
// }

  GetHomeTokenModel? getCounterModel;
  getFilterApi() async {
    var headers = {
      'Cookie': 'ci_session=052f7198d39c07d7c57fb2fed6a242b3b8aaa2de'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/counters'));
    request.fields.addAll({
      userName!.isEmpty ? "" : 'counter_name': userName.toString(),
      cityName!.isEmpty ? "" : 'counter_city': cityName.toString(),
      catNewId == null ? "" : 'counter_category': catNewId.toString(),
      cId!.isEmpty ? "" : 'counter_id': cId.toString(),
      'filter_date':dayId.toString()
    });
    print("------Surendra----rrrrrrr---${request.fields}----------");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =  await response.stream.bytesToString();
      var finalResult  = GetHomeTokenModel.fromJson(jsonDecode(result));
      setState(() {
        getCounterModel =  finalResult;
        print(getCounterModel);
      });
      Fluttertoast.showToast(msg: "${finalResult.message}");
    }
    else {
      print(response.reasonPhrase);
    }
  }

  GeteggModel? eggsModel;
  eggsDetails() async {
    var headers = {
      'Cookie': 'ci_session=37d48f13ceea059309f0dc4490ed5a9da62f6e51'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://eggrow.in/Apicontroller/home_data'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult  = GeteggModel.fromJson(jsonDecode(result));
      setState(() {
        eggsModel = finalResult;
        print(eggsModel);
      });
      Fluttertoast.showToast(msg: "${finalResult.message}");
    }
    else {
      print(response.reasonPhrase);
    }
  }
///////////////////////UserSite//////////////////
////////////////////////Counter///////////

counterUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                //   InkWell(
                //     onTap: (){
                //       Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionScreen()));
                //     },
                //     child: Container(
                //       height: 120,
                // decoration: BoxDecoration(
                //     borderRadius:BorderRadius.circular(10),
                //     gradient: const LinearGradient(
                //         colors: [
                //           AppColors.primary,
                //           Color(0xFF00CCFF),
                //         ],
                //         begin: FractionalOffset(0.0, 1.0),
                //         end: FractionalOffset(1.0, 0.0),
                //         stops: [0.0, 1.1],
                //         tileMode: TileMode.clamp),
                //      ),
                //       child: Center(child: const Text("Subscription",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 15),)),
                //     ),
                //   ),
                //   const SizedBox(height: 10,),
                  InkWell(

                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTokenScreen()));
                   },

                      child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                AppColors.primary,
                                Color(0xFF00CCFF),
                              ],
                              begin: FractionalOffset(0.0, 1.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.1],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(10)

                      ),
                      child: Center(child: const Text("Create Token",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 15),),),

                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              AppColors.primary,
                              Color(0xFF00CCFF),
                            ],
                            begin: FractionalOffset(0.0, 1.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.1],
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: const Text("Booking",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 15),)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
   }

  int _currentPostCounter = 0;
  _buildDotsCounter() {
    List<Widget> dots = [];
    if (getSliderModel == null) {
    } else {
      for (int i = 0; i < getSliderModel!.sliderdata!.length; i++) {
        dots.add(
          Container(
            margin: const EdgeInsets.all(1.5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPost == i ?  AppColors.profileColor : AppColors.secondary,
            ),
          ),
        );
      }
    }
    return dots;
  }

}
