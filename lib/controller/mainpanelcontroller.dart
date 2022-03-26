import 'package:flutter/cupertino.dart';
import "package:get/get.dart";
import 'package:imlancerapp/controller/datasavingcontroller.dart';
import 'package:imlancerapp/models/profile_model.dart';

class MainPanelController extends GetxController {
  int page = 0;
  bool loading = false;
  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    readProfile();
  }

  late ProfileModel? profileModel;
  readProfile() async {
    loading = true;
    update();
    DatasavingController dsc = DatasavingController();
    profileModel = await dsc.readProfile();
    loading = false;
    update();
  }

  changePage(int value) {
    page = value;
    pageController.jumpToPage(page);
    update();
  }
}
