import 'package:get/get.dart';
import 'package:imlancerapp/models/project_readig_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class SearchController extends GetxController {
  List<ProjectReadingModel> jobs = <ProjectReadingModel>[];
  void getResults(String query) async {
    var response = await RemoteServices.searchProjects(query);
    jobs = projectReadingModelFromJson(response);
    update();
  }
}
