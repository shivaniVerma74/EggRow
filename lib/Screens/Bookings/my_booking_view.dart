import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Local_Storage/shared_pre.dart';

import '../../Models/get_token_list_model.dart';
import '../../Services/api_services/apiConstants.dart';
import 'package:http/http.dart'as http;

import '../../Utils/Colors.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key, this.isFrom}) : super(key: key);
final bool? isFrom ;

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  String? userId;
  getUser() async {
    userId = await SharedPre.getStringValue('userId');
    getBookingApi();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whit,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius:  BorderRadius.only(
            bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50),
          ),),
        toolbarHeight: 60,
        centerTitle: true,
        title: Text("My Token",style: TextStyle(fontSize: 17),),
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            borderRadius:   BorderRadius.only(
              bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),
            gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.1,
                colors: <Color>[AppColors.primary, AppColors.secondary]),
          ),
        ),
      ),
      body:  SingleChildScrollView(
        child:Container(
          child:getTokenListModel == null ? Center(child: CircularProgressIndicator()): getTokenListModel!.data!.length == 0 ?  Center(child: Text("No Token List Found!!")):ListView.builder(
              itemCount:getTokenListModel!.data!.length ,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: getTokenListModel!.data! == "" ? Text("Not Tood") : Container(
                        height: 120,
                        width: 280,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/lotteryback.png"), fit: BoxFit.fill)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 12),
                                  child: Row(
                                    children: [
                                      Text("Expected Time:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                      SizedBox(width: 2,),
                                      Row(
                                        children: [
                                          Text("${getTokenListModel!.data![index].time}",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8,top: 6),
                                  child: Row(
                                    children: [
                                      Text("Date:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                      SizedBox(width: 2,),
                                      Text("${getTokenListModel!.data![index].date!}",style: TextStyle(color: AppColors.whit,fontSize: 12),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Name:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                          SizedBox(width: 2,),
                                          Text("${getTokenListModel!.data![index].name}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          SizedBox(height: 10,),
                                          Text("Mobile :",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                          SizedBox(width: 2,),
                                          Text("${getTokenListModel!.data![index].mobile!}",style: TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 5,),
                                          Text("Current Token:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                          SizedBox(width: 2,height: 5,),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: AppColors.secondary1,
                                            ),
                                            child: Center(child: Text("${getTokenListModel!.data![index].currentToken}",style: TextStyle(color: AppColors.whit),)),
                                          )

                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5,),
                                          Text("My Token :",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                          SizedBox(width: 2,height: 5,),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: AppColors.secondary,
                                            ),
                                            child: Center(child: Text("${getTokenListModel!.data![index].tokenNumber}",style: TextStyle(color: AppColors.whit),)),
                                          )

                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 10,)

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
        ),
      )
    ) ;
  }

  GetTokenListModel? getTokenListModel;

  getBookingApi() async {
    var headers = {
      'Cookie': 'ci_session=54b75d7a8d31a31e8269c4131f4e43bd2f9eabf2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/my_booking'));
    request.fields.addAll({
      'user_id':userId.toString()
    });
   print('____request.fields______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     var result = await response.stream.bytesToString();
     var finalResult = GetTokenListModel.fromJson(jsonDecode(result));
     setState(() {
       getTokenListModel = finalResult;
     });
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
