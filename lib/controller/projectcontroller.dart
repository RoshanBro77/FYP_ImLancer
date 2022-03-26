import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:imlancerapp/controller/mainpanelcontroller.dart';
import 'package:imlancerapp/models/createprojectresponsemodel.dart';
import 'package:imlancerapp/models/project_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class UploadProjectController extends GetxController {
  bool loading = false;
  Future<int> uploadProject(ProjectModel model, File? file) async {
    loading = false;
    update();
    var response = await RemoteServices.uploadProject(model, file);
    if (response.contains("Project created")) {
      Fluttertoast.showToast(msg: "Project Created");
      MainPanelController mpc = Get.find();
      mpc.pageController.jumpToPage(0);
    } else {
      Fluttertoast.showToast(msg: "Project Already Exists");
    }
    CreateProjectResponseModel mdl =
        createProjectResponseModelFromJson(response).first;

    loading = true;
    update();
    return int.parse(mdl.projectid.toString());
  }
}
