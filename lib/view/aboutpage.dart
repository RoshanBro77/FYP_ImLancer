import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);

  @override
  Widget build(BuildContext context) {
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);

    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: Colors.black,
        elevation: 5,
      ),
      bottomNavigationBar: Container(
        color: const Color(0xff111a1f),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Version",
              style: textStyle2,
            ),
            Text(
              "Copyrights 2022 Google",
              style: textStyle2,
            ),
            Text(
              "LLC.All rights reserved",
              style: textStyle2,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        width: Get.width,
        decoration: const BoxDecoration(color: Color(0xff111a1f)),
        child: Column(
          children: [
            Text(
              "ImLancer",
              style: textStyle.copyWith(fontSize: 40),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Accusam no erat placerat at ut tempor nonumy ipsum et takimata kasd lorem labore diam. Velit lorem ut accusam vero sit eu invidunt lorem sit invidunt delenit. Elit liber et dolor accumsan at facilisi magna.",
              style: textStyle2,
            ),
          ],
        ),
      ),
    );
  }
}
