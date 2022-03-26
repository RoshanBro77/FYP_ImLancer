import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/controller/datasavingcontroller.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class AccountSetting extends StatelessWidget {
  AccountSetting({Key? key}) : super(key: key);
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);

  @override
  Widget build(BuildContext context) {
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);

    return Scaffold(
      appBar: AppBar(
        title: Text("Account Setting"),
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
              Card(
                color: Color(0xff07080a),
                child: ListTile(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.black,
                          title: Text(
                            "Delete Account",
                            style: TextStyle(color: Colors.orange),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "No",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                DatasavingController dsc =
                                    DatasavingController();
                                ProfileModel? model = await dsc.readProfile();
                                String response =
                                    await RemoteServices.deleteAccount(
                                        model!.id.toString());
                                String result = json.decode(response)['status'];
                                if (result == "Account Deleted") {
                                  dsc.deleteProfile();
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      '/startuppage', (event) => false);
                                }
                                Fluttertoast.showToast(msg: result);
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  title: Text(
                    "Delete Account",
                    style: textStyle2,
                  ),
                  subtitle: Text(
                    "Permanent Deletion",
                    style: textStyle2.copyWith(fontSize: 13),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
