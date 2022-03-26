import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class SignupController extends GetxController {
  bool loading = false;
  Future<void> signUp(ProfileModel model, BuildContext context) async {
    loading = true;
    update();
    var response = await RemoteServices.signUp(model);
    String message = json.decode(response)[0]['status'];
    Fluttertoast.showToast(msg: message);
    if (message.toLowerCase().contains('created')) {
      Navigator.pop(context);
    }
    log(response);
    loading = false;
    update();
  }

  String gender = "Male";
  void changeGender(String gen) {
    gender = gen;
    update();
  }
}
