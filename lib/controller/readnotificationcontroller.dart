import 'package:get/get.dart';
import 'package:imlancerapp/controller/datasavingcontroller.dart';
import 'package:imlancerapp/models/notification_model.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';

class ReadNotificationController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    readNotification();
  }

  List<NotificationModel> notifications = <NotificationModel>[];
  readNotification() async {
    loading = true;
    update();
    DatasavingController dsc = DatasavingController();
    ProfileModel? profileModel = await dsc.readProfile();
    var response = await RemoteServices.readNotification(
      profileModel!.id.toString(),
    );
    if (response.contains("The notification with id doesnot exist")) {
    } else {
      notifications = notificationModelFromJson(response);
    }
    loading = false;
    update();
  }
}
