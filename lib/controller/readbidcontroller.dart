import 'dart:developer';

import 'package:get/get.dart';
import 'package:imlancerapp/controller/datasavingcontroller.dart';
import 'package:imlancerapp/models/bid_model.dart';
import 'package:imlancerapp/models/mybidmodel.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class ReadBidController extends GetxController {
  bool loading = false;
  @override
  void onInit() {
    super.onInit();
    getBids();
  }

  List<MyBidModel> bids = <MyBidModel>[];
  List<String> selectedBids = <String>[];
  void insertSelection(String bids) {
    log(selectedBids.contains(bids).toString());
    if (!selectedBids.contains(bids)) {
      selectedBids.add(bids);
      update();
    } else {
      selectedBids.removeWhere((element) => element == bids);
      update();
    }
  }

  getBids() async {
    loading = true;
    update();
    DatasavingController dsc = DatasavingController();
    ProfileModel? profile = await dsc.readProfile();
    var response = await RemoteServices.getBids(profile!.id.toString());
    bids = myBidModelFromJson(response);
    loading = false;
    update();
  }
}
