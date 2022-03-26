import 'dart:developer';

import 'package:get/get.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatasavingController extends GetxController {
  late SharedPreferences preferences;

  @override
  void onInit() {
    super.onInit();
    readProfile();
  }

  deleteProfile() async {
    preferences = await SharedPreferences.getInstance();
    preferences.remove('profile');
  }

  saveProfile(ProfileModel model) async {
    preferences = await SharedPreferences.getInstance();
    String modelJson = singleprofileModelToJson(model);
    preferences.setString('profile', modelJson);
    readProfile();
  }

  bool reading = false;
  ProfileModel? profile;
  Future<ProfileModel?> readProfile() async {
    reading = true;
    update();
    preferences = await SharedPreferences.getInstance();
    String modelJson = preferences.getString('profile') ?? "";
    if (modelJson != "") {
      profile = singleprofileModelFromJson(modelJson);
      reading = false;
      log(profile!.userName);
      update();
      return singleprofileModelFromJson(modelJson);
    } else {
      reading = false;
      update();
      return null;
    }
  }
}
