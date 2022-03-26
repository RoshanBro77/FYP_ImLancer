import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:imlancerapp/models/bid_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class ApplyBidController extends GetxController {
  double value = 0;
  bool loading = false;
  void changeValue(double val) {
    value = val;
    update();
  }

  void applyBid(BidModel model, BuildContext context) async {
    loading = true;
    update();
    var response = await RemoteServices.uploadBid(model);
    log(response);
    String result = json.decode(response)["status"];

    if (result.toString().toLowerCase() == "bid is applied!") {
      Navigator.pop(context);
    }
    Fluttertoast.showToast(msg: result);

    loading = false;
    update();
  }
}
