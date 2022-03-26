import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imlancerapp/models/project_readig_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class FetchSubCategoryJobController extends GetxController {
  bool loading = false;
  final String subcategory;

  FetchSubCategoryJobController(this.subcategory);
  @override
  void onInit() {
    super.onInit();
    getSubCategoryJobs();
  }

  List<ProjectReadingModel> subcategoryJobs = <ProjectReadingModel>[];
  Future<void> getSubCategoryJobs() async {
    loading = true;
    update();
    var response = await RemoteServices.getProjects(subcategory);
    if (json
        .decode(response)
        .toString()
        .contains('The project with subcategory_id doesnot exist')) {
      subcategoryJobs = [];
      update();
    } else {
      subcategoryJobs = projectReadingModelFromJson(response);
      update();
    }

    loading = false;
    update();
  }
}
