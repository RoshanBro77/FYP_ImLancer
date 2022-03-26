import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:imlancerapp/models/skills_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class SkillsController extends GetxController {
  bool loading = false;
  @override
  void onInit() {
    super.onInit();
    getSkills();
  }

  List<SkillModel> skills = <SkillModel>[];
  List<String> selectedSkills = <String>[];
  void insertSelection(String skill) {
    log(selectedSkills.contains(skill).toString());
    if (!selectedSkills.contains(skill)) {
      selectedSkills.add(skill);
      update();
    } else {
      selectedSkills.removeWhere((element) => element == skill);
      update();
    }
  }

  getSkills() async {
    loading = true;
    update();
    var response = await RemoteServices.getSkills();
    skills = skillModelFromJson(response);
    loading = false;
    update();
  }
}
