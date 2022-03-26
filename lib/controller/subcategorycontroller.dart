import 'package:get/get.dart';
import 'package:imlancerapp/models/subcategory_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class SubCategoryController extends GetxController {
  bool loading = false;
  final String id;
  SubCategoryController({required this.id});
  @override
  void onInit() {
    super.onInit();
    getSubCategory();
  }

  List<SubCategoryModel> category = <SubCategoryModel>[];
  List<String> selectedSubCategory = <String>[];

  getSubCategory({String? id2}) async {
    loading = true;
    update();
    var response = await RemoteServices.getSubCategory(id2 ?? id);
    category = subCategoryModelFromJson(response);
    loading = false;
    update();
  }
}
