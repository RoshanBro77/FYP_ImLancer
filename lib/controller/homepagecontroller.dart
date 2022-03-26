import 'dart:ffi';

import 'package:get/get.dart';
import 'package:imlancerapp/models/category_model.dart';
import 'package:imlancerapp/models/subcategory_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class HomePageController extends GetxController {
  bool loading = false;
  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  List<CategoryModel> category = <CategoryModel>[];
  Future<void> getCategory() async {
    loading = true;
    update();
    var response = await RemoteServices.getCategory();
    category = categoryModelFromJson(response);
    fetchSubCat(category.first.id.toString());
    loading = false;
    update();
  }

  bool subCategoryLoading = false;

  List<SubCategoryModel> subcategory = <SubCategoryModel>[];
  Future<void> fetchSubCat(String id) async {
    subCategoryLoading = true;
    update();
    var response = await RemoteServices.getSubCategory(id);
    subcategory = subCategoryModelFromJson(response);
    subCategoryLoading = false;
    update();
  }
}
