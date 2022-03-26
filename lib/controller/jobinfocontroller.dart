import 'package:get/get.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class JobInfoController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }

  bool loading = false;
  JobInfoController({required this.id});
  final String id;
  ProfileModel? model;
  getProfileData() async {
    loading = true;
    update();
    var response = await RemoteServices.getProfile(id.toString());
    if (response == "") {
      model = null;
    } else {
      model = singleprofileModelFromJson(response);
    }
    loading = false;
    update();
  }
}
