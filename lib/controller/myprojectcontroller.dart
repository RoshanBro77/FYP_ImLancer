import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:imlancerapp/controller/datasavingcontroller.dart';
import 'package:imlancerapp/models/bid_model.dart';
import 'package:imlancerapp/models/mybidmodel.dart';
import 'package:imlancerapp/models/myprojectbidmodel.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/models/project_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class MyProjectController extends GetxController {
  bool loading = false;

  @override
  onInit() {
    super.onInit();
    readProject();
  }

  List<ProjectModel> myProjects = <ProjectModel>[];
  List<ProjectModel> assignedProjects = <ProjectModel>[];
  List<ProjectModel> uploadedProjects = <ProjectModel>[];
  List<ProjectModel> completedProjects = <ProjectModel>[];

  readProject() async {
    loading = true;
    update();
    DatasavingController dsc = DatasavingController();
    ProfileModel? profileModel = await dsc.readProfile();
    var response =
        await RemoteServices.getUploadedProjects(profileModel!.id.toString());
    log(response);
    myProjects = projectModelFromJson(response);
    filterProjects();
    loading = false;
    update();
  }

  filterProjects() {
    for (var item in myProjects) {
      switch (item.projectStatus.toLowerCase()) {
        case "assigned":
          assignedProjects.add(item);
          break;
        case "uploaded":
          uploadedProjects.add(item);
          break;
        case "completed":
          completedProjects.add(item);
          break;
        default:
      }
    }
  }

  bool reading = false;
  List<MyProjectBidModel> myProjectBids = <MyProjectBidModel>[];
  List<MyProjectBidModel> myInitialBids = <MyProjectBidModel>[];
  readMyProjectBids(String projectid) async {
    reading = true;
    var response = await RemoteServices.getMyProjectBids(projectid);
    myInitialBids = myProjectBidModelFromJson(response);
    log(response);
    myProjectBids = myInitialBids
        .where(
          (element) => element.status == "Applied",
        )
        .toList();
    reading = false;
    update();
  }

  bool accepting = false;
  void acceptBid(String bid_id, String project_id, String freelancer_id,
      String notification_id) async {
    accepting = true;
    update();
    var response =
        await RemoteServices.acceptBid(bid_id, project_id, freelancer_id);
    String data = json.decode(response)["status"];
    if (data == "Project assigned") {
      RemoteServices.sendNotification(
          title: "Project assigned",
          body: " The project has been assigned to you.",
          to: notification_id);
    }
    accepting = false;
    update();
  }

  bool rejecting = false;
  void rejectingBid(String bid_id, String project_id, String freelancer_id,
      String notification_id) async {
    rejecting = true;
    update();
    var response =
        await RemoteServices.rejectBid(bid_id, project_id, freelancer_id);
    String data = json.decode(response)["status"];
    if (data == "Project rejected") {
      RemoteServices.sendNotification(
          title: "Project rejected",
          body: " The project has been rejected.",
          to: notification_id);
    }
    accepting = false;
    update();
  }
}
