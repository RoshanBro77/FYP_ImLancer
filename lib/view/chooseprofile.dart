import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseSearchingProfile extends StatelessWidget {
  ChooseSearchingProfile({Key? key}) : super(key: key);
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xff000000),
              const Color(0xff434343),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Stack(children: [
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              'assets/Pages/BottomDesign.svg',
            ),
          ),
          Container(
            height: height,
            width: width,
            margin: EdgeInsets.fromLTRB(30, 50, 30, 30),
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
                  height: height * 0.02,
                ),
                Text(
                  "What Are You Searching ",
                  style: textStyle.copyWith(fontSize: 22),
                ),
                Text(
                  "For?",
                  style: textStyle.copyWith(fontSize: 22),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/freelancerhomepage');
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[300],
                        ),
                        height: height / 3.5,
                        width: width / 1.6,
                        child: Image.asset(
                          "assets/Pages/jobsearch.gif",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        "A Job",
                        style: textStyle.copyWith(fontSize: 22),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/hirerhomepage');
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[300],
                        ),
                        height: height / 3.5,
                        width: width / 1.6,
                        child: Image.asset(
                          "assets/Pages/freelancer.gif",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        "Freelancer",
                        style: textStyle.copyWith(fontSize: 22),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
