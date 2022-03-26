import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
  TextEditingController presentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Your Password",
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Color(0xff111a1f),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Enter present password",
              style: textStyle2,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: presentPassword,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                fillColor: Colors.white,
                hintText: "Enter present password Here.",
                filled: true,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.clear),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Enter new password",
              style: textStyle2,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: newPassword,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                fillColor: Colors.white,
                hintText: "Enter new password Here.",
                filled: true,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.clear),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Update Password"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange.shade800),
                    shape: MaterialStateProperty.all(const StadiumBorder())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
