import 'package:get/get.dart';
import 'package:imlancerapp/controller/datasavingcontroller.dart';
import 'package:imlancerapp/models/bid_model.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/models/project_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class MyWorkedProjectController extends GetxController {
  bool loading = false;

  @override
  onInit() {
    super.onInit();
    readProject();
  }

  List<ProjectModel> assignedProjects = <ProjectModel>[];
  List<ProjectModel> uploadedProjects = <ProjectModel>[];
  List<ProjectModel> completedProjects = <ProjectModel>[];
  List<ProjectModel> myWorkedProjects = <ProjectModel>[];
  readProject() async {
    loading = true;
    update();
    DatasavingController dsc = DatasavingController();
    ProfileModel? profileModel = await dsc.readProfile();
    var response =
        await RemoteServices.getWorkedProjects(profileModel!.id.toString());
    myWorkedProjects = projectModelFromJson(response);
    filterProjects();
    loading = false;
    update();
  }

  Future<BidModel> getMyEarnings(String id) async {
    var response = await RemoteServices.getPaymentProject(id);
    BidModel model = singlebidModelFromJson(response);
    return model;
  }

  filterProjects() {
    for (var item in myWorkedProjects) {
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
}
