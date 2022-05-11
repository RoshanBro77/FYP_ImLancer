import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/signup_controller.dart';
import '../models/profile_model.dart';
import 'loginpage.dart';
import 'startuppage.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool passwordhide = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
    return Scaffold(
      body: GetBuilder<SignupController>(
          init: SignupController(),
          builder: (controller) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff111a1f),
                    Color(0xff07080a),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: SvgPicture.asset(
                      'assets/Pages/BottomDesign.svg',
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30, 20, 40, 30),
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/seo.png',
                                height: 50,
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    "ImLancer",
                                    style: textStyle.copyWith(
                                        color: Colors.amber[400], fontSize: 40),
                                  ),
                                  SvgPicture.asset(
                                    'assets/Pages/lancerbottom.svg',
                                    width: width * 0.5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Center(
                            child: Text(
                              "Sign Up to ImLancer",
                              style: textStyle,
                            ),
                          ),
                          SizedBox(
                            height: height / 3.1,
                            width: width / 1.3,
                            child: Image.asset(
                              "assets/Pages/userAdd.gif",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: Colors.white,
                              hintText: "Enter Email Here",
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.clear),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (emailController.text == "") {
                                return "Email is required";
                              } else if (!value!.contains("@gmail.com")) {
                                return "Enter valid Email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          TextFormField(
                            controller: usernameController,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Enter Username",
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (usernameController.text == "") {
                                return "Username is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: passwordhide,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Enter Password",
                              fillColor: Colors.white,
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordhide = !passwordhide;
                                  });
                                },
                                icon: passwordhide
                                    ? const Icon(
                                        Icons.visibility_off_outlined,
                                      )
                                    : const Icon(
                                        Icons.visibility_outlined,
                                      ),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (passwordController.text == "") {
                                return "Password is required";
                              } else if (value!.length < 8) {
                                return "Too short password";
                              }
                              return null;
                            },
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                  value: "Male",
                                  groupValue: controller.gender,
                                  onChanged: (value) {
                                    controller.changeGender(value!);
                                  }),
                              Text(
                                "Male",
                                style: textStyle.copyWith(fontSize: 17),
                              ),
                              Radio<String>(
                                  value: "Female",
                                  groupValue: controller.gender,
                                  onChanged: (value) {
                                    controller.changeGender(value!);
                                  }),
                              Text(
                                "Female",
                                style: textStyle.copyWith(fontSize: 17),
                              ),
                              Radio<String>(
                                  value: "Other",
                                  groupValue: controller.gender,
                                  onChanged: (value) {
                                    controller.changeGender(value!);
                                  }),
                              Text(
                                "Other",
                                style: textStyle.copyWith(fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          GestureDetector(
                            onTap: () async {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => LogInPage(),
                              //   ),
                              // );
                              if (formKey.currentState!.validate()) {
                                String notifId = await FirebaseMessaging
                                        .instance
                                        .getToken() ??
                                    "";
                                log("message");
                                controller.signUp(
                                    ProfileModel(
                                      gender: controller.gender,
                                      id: 0,
                                      userName: usernameController.text,
                                      emailId: emailController.text,
                                      password: passwordController.text,
                                      date: DateTime.now().toString(),
                                      notificationId: notifId,
                                      phone: "",
                                      profileimageId: "",
                                      rating: "",
                                      skillId: "",
                                      myspeciality: "",
                                      socialmedia: "",
                                      document: "",
                                      address: "",
                                      mydescription: "",
                                    ),
                                    context);
                              }
                            },
                            child: SizedBox(
                              height: height * 0.06,
                              width: width * 0.6,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff870000),
                                        Color(0xff190A05),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  height: height * 0.06,
                                  width: width * 0.55,
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LogInPage(),
                                        ));
                                  },
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
