import 'dart:io';

import 'package:get/get.dart';
import 'package:imlancerapp/models/category_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class CategoryController extends GetxController {
  bool loading = false;
  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  List<CategoryModel> category = <CategoryModel>[];
  List<String> selectedCategory = <String>[];

  getCategory() async {
    loading = true;
    update();
    var response = await RemoteServices.getCategory();
    category = categoryModelFromJson(response);
    loading = false;
    update();
  }
}
