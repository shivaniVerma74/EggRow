import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eggrow/Screens/Auth_Views/Signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import '../../../Models/GetCityModel.dart';
import '../../../Models/GetStateModel.dart';
import '../../../Models/HomeModel/signUp_cat_model.dart';
import '../../../Routes/routes.dart';
import '../../../Services/api_services/apiConstants.dart';
import '../../../Services/api_services/apiStrings.dart';
import '../../../Utils/Colors.dart';
import '../../../Utils/extentions.dart';
import '../../../Widgets/app_button.dart';
import '../../../Widgets/button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final capacityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String selectedOption = "Get Token";
  String? catId;
  SignUpCat? animalCat;
  bool? isUser = true;

  @override
  void initState(){
    super.initState();
    getstate();
  }

  String dropdownvalue = 'Layer Farmer';
  var items = [
    'Layer Farmer',
    'Boiler Farmer',
    'Hatchery',
    'Egg Trader',
    'Broiler Trader',
    'Feed Miller',
    'Feed Trader',
    'Veterinarian',
    'Medicine Company',
    'Company Representative',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SignupController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
             // physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/backimage.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 30),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 35),
                          const Text("Sign Up", style: TextStyle(color: AppColors.whit, fontWeight: FontWeight.bold, fontSize: 25),),
                          // const SizedBox(height: 30,),
                          //  Image.asset("assets/images/registerimage.png", height: 150, width: 200,),
                            const SizedBox(height: 10),
                             Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Container(
                                      width: double.maxFinite,
                                      height: 50,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: CustomBoxDecoration.myCustomDecoration(),
                                      child: TextFormField(
                                        controller: nameController,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Name",
                                            hintStyle: TextStyle(color: Colors.black),
                                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                            border: InputBorder.none
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Name cannot be empty";
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 50,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: CustomBoxDecoration.myCustomDecoration(),
                                      child: TextFormField(
                                        controller: emailController,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Email",
                                            hintStyle: TextStyle(color: Colors.black),
                                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                            border: InputBorder.none
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Address cannot be empty";
                                          } else if (val.length < 2) {
                                            return "Please enter must 2 digit";
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 50,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: CustomBoxDecoration.myCustomDecoration(),
                                      child: TextFormField(
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        controller: mobileController,
                                        decoration: const InputDecoration(
                                            counterText: "",
                                            hintText: "Enter Mobile Number",
                                            hintStyle: TextStyle(color: Colors.black),
                                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                            // prefixIcon: Icon(Icons.call),
                                            border: InputBorder.none
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Mobile cannot be empty";
                                          } else if (val.length < 10) {
                                            return "Please enter mobile must 10 digit";
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 50,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: CustomBoxDecoration.myCustomDecoration(),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: addressController,
                                        decoration: const InputDecoration(
                                            counterText: "",
                                            hintText: "Address",
                                            hintStyle: TextStyle(color: Colors.black),
                                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                            // prefixIcon: Icon(Icons.call),
                                            border: InputBorder.none
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Address cannot be empty";
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 50,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: CustomBoxDecoration.myCustomDecoration(),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: capacityController,
                                        decoration: const InputDecoration(
                                            counterText: "",
                                            hintText: "Business Name",
                                            hintStyle: TextStyle(color: Colors.black),
                                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                            // prefixIcon: Icon(Icons.call),
                                            border: InputBorder.none
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Business name cannot be empty";
                                          }
                                        },
                                      ),
                                    ),
                                    // Container(
                                    //   width: double.maxFinite,
                                    //   height: 50,
                                    //   padding: const EdgeInsets.all(5.0),
                                    //   decoration: CustomBoxDecoration.myCustomDecoration(),
                                    //   child: DropdownButton(
                                    //     isExpanded: true,
                                    //     value: dropdownvalue,
                                    //     hint: const Text(''),
                                    //     icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                                    //     items: items.map((String items) {
                                    //       return DropdownMenuItem(
                                    //         value: items,
                                    //         child: Text(items),
                                    //       );
                                    //     }).toList(),
                                    //     onChanged: (value) {
                                    //       setState(() {
                                    //         dropdownvalue = value!;
                                    //       });
                                    //     },
                                    //     underline: Container(),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 50,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: CustomBoxDecoration.myCustomDecoration(),
                                      child:
                                      DropdownButton(
                                        isExpanded: true,
                                        value: stateValue,
                                        hint: const Text('State', style: TextStyle(color: Colors.black),),
                                        // Down Arrow Icon
                                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                                        // Array list of items
                                        items: stateList.map((items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Container(
                                                child: Text(items.name.toString())),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (StataData? value) {
                                          setState(() {
                                            stateValue = value!;
                                            getCity("${stateValue!.id}");
                                            stateName = stateValue!.name;
                                            print("name herererb $stateName");
                                          });
                                        },
                                        underline: Container(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 50,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: CustomBoxDecoration.myCustomDecoration(),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        value: cityValue,
                                        hint: Text('City', style: TextStyle(color: Colors.black)),
                                        // Down Arrow Icon
                                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                                        // Array list of items
                                        items: cityList.map((items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Container(
                                                child: Text(items.name.toString())),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (CityData? value) {
                                          setState(() {
                                            cityValue = value!;
                                            cityName = cityValue!.name;
                                            print("name herererb cityytyty $cityName $cityValue");
                                          });
                                        },
                                        underline: Container(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 0,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: AppButton(
                              title: 'SignUp',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                    controller.registerUser(
                                    mobile: mobileController.text,
                                    name: nameController.text,
                                    email: emailController.text,
                                    state: stateValue.toString(),
                                    city: cityValue.toString(),
                                      capacity: capacityController.text,
                                  );
                                 } else {
                                  Fluttertoast.showToast(msg: "All field are required");
                                }
                              },
                             ),
                            ),
                             Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(loginScreen);
                                },
                                child: const Text(
                                  'Log In', style: TextStyle(
                                      color: AppColors.yellow,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  GetCatModel? getCatModel;
  Future<void> getLottery() async {
    apiBaseHelper.postAPICall2(getCatAPI).then((getData) {
      setState(() {
        getCatModel = GetCatModel.fromJson(getData);
      });
      //isLoading.value = false;
    });
  }

  List<CityData> cityList = [];
  List<StataData> stateList = [];
  CityData? cityValue;
  StataData? stateValue;
  String? stateName;
  String? cityName;

  getstate() async {
    print("state apiii isss");
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/egg_row/Apicontroller/get_state'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          stateList = GetStateModel.fromJson(userData).data!;
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  getCity(String? sId) async {
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request = http.MultipartRequest('POST', Uri.parse("https://developmentalphawizz.com/egg_row/Apicontroller/get_city"));
    request.fields.addAll({
      'state_id': sId.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          cityList = GetCityModel.fromJson(userData).data!;
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

}
