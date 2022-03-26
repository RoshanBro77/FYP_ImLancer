import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loginpage.dart';
import 'signuppage.dart';

class StartUpScreen extends StatelessWidget {
  const StartUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 50, 40, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    height: height / 2.3,
                    width: width / 1.3,
                    child: Image.asset(
                      "assets/Pages/typing.gif",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber[400],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color(0xffFF8008),
                    Color(0xffFFC837),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              height: height / 2.2,
              padding: EdgeInsets.fromLTRB(40, 50, 40, 50),
              child: Column(
                children: [
                  Text(
                    "This is a freelancing App developed to increase freelancing opportunity to everyone",
                    style:
                        textStyle.copyWith(fontSize: 15, color: Colors.black),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogInPage(),
                        ),
                      );
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
                      width: width * 0.7,
                      child: Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
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
                      width: width * 0.7,
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
