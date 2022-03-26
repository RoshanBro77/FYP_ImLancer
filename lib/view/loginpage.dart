import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:imlancerapp/controller/login_controller.dart';

import '../controller/datasavingcontroller.dart';
import '../models/profile_model.dart';
import 'signuppage.dart';

class LogInPage extends StatefulWidget {
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool passwordhide = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
    return Scaffold(
      body: GetBuilder<LoginController>(
          init: LoginController(),
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
                              Text(
                                "Logo",
                                style: textStyle.copyWith(fontSize: 32),
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
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Center(
                            child: Text(
                              "Log In to ImLancer",
                              style: textStyle,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          SizedBox(
                            height: height / 3.1,
                            width: width / 1.3,
                            child: Image.asset(
                              "assets/Pages/login.gif",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
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
                                onPressed: () {
                                  emailController.clear();
                                },
                                icon: Icon(Icons.clear),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (!value!.isEmail) {
                                return "The email is invalid";
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
                              if (value!.length < 8) {
                                return "Too short password";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          SizedBox(
                            height: height * 0.06,
                            width: width * 0.6,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.login(
                                      emailController.text,
                                      passwordController.text,
                                      context,
                                    );
                                  }
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //   context,
                                  //   '/homepage',
                                  //   (route) => false,
                                  // );
                                },
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
                                    child: controller.loading
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                            "Log in",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
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
                                "Don't have an account?",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpPage(),
                                        ));
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                    ),
                                  ))
                            ],
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/forgotpassword');
                              },
                              child: Text(
                                "Forgot Possword?",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.06,
                            width: width * 0.6,
                            child: Center(
                              child: GestureDetector(
                                onTap: () async {
                                  try {
                                    GoogleSignIn googleSignIn = GoogleSignIn();
                                    googleSignIn.signOut();
                                    log("Login");
                                    GoogleSignInAccount? googleUser =
                                        await googleSignIn.signIn();
                                    log("Step1 completed");

                                    // Obtain the auth details from the request
                                    final GoogleSignInAuthentication?
                                        googleAuth =
                                        await googleUser?.authentication;
                                    log("Step2 completed");

                                    // Create a new credential
                                    final credential =
                                        GoogleAuthProvider.credential(
                                      accessToken: googleAuth?.accessToken,
                                      idToken: googleAuth?.idToken,
                                    );
                                    log("Step3 completed");

                                    // Once signed in, return the UserCredential
                                    await FirebaseAuth.instance
                                        .signInWithCredential(credential);
                                    ProfileModel profile = ProfileModel(
                                        id: 0,
                                        notificationId: "",
                                        mydescription: "",
                                        myspeciality: "",
                                        date: DateTime.now().toString(),
                                        emailId: googleUser!.email,
                                        phone: "",
                                        password: "",
                                        rating: "",
                                        userName: googleUser.displayName ?? "",
                                        skillId: "",
                                        profileimageId:
                                            googleUser.photoUrl ?? "",
                                        document: "",
                                        socialmedia: "",
                                        address: "",
                                        gender: "");
                                    log(profile.emailId);
                                    DatasavingController dsc =
                                        DatasavingController();
                                    dsc.saveProfile(profile);
                                    Fluttertoast.showToast(
                                        msg: "Login Successful");
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/homepage', (event) => false);
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //   context,
                                  //   '/homepage',
                                  //   (route) => false,
                                  // );
                                },
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
                                    child: controller.loading
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                            "Log in with google",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                  ),
                                ),
                              ),
                            ),
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
