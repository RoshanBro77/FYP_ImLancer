import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:imlancerapp/controller/datasavingcontroller.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  bool loading = false;

  void login(String email, String password, BuildContext context) async {
    loading = true;
    update();
    var response = await RemoteServices.login(email, password);
    log(response);
    if (response.contains('status')) {
      String result = json.decode(response)['status'];
      Fluttertoast.showToast(msg: result);
    } else {
      ProfileModel profile = singleprofileModelFromJson(response);
      log(profile.emailId);
      DatasavingController dsc = DatasavingController();
      dsc.saveProfile(profile);
      dsc.readProfile();
      Fluttertoast.showToast(msg: "Login Successful");
      Navigator.pushNamedAndRemoveUntil(context, '/homepage', (event) => false);
    }
    loading = false;
    update();
  }
}
