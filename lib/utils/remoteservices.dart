import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:imlancerapp/models/paymentmodel.dart';
import 'package:imlancerapp/utils/constant.dart';

import '../models/bid_model.dart';
import '../models/notification_model.dart';
import '../models/profile_model.dart';
import '../models/project_model.dart';
import '../models/skills_model.dart';

class RemoteServices {
  static String initialUrl = "https://192.168.1.65/ImLancer";

  static Future<String> login(String email_id, String password) async {
    String notifId = await FirebaseMessaging.instance.getToken() ?? "";
    String url = initialUrl +
        '/login.php?email_id=$email_id&password=$password&notificationid=$notifId';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> getPaymentProject(String id) async {
    String url = initialUrl + '/bid/getacceptedbid.php?project_id=$id';
    log(url);
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> uploadDocument(File file) async {
    String url = initialUrl + '/profile/uploaddocument.php';
    FormData formData = FormData.fromMap({});
    formData.files.add(
      MapEntry(
        "file",
        await MultipartFile.fromFile(file.path),
      ),
    );
    var response = await Dio().post(url, data: formData);
    log(response.data);
    return response.data;
  }

  static Future<String> deleteAccount(String id) async {
    String url = "$initialUrl/profile/deleteprofile.php?id=$id";
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> changePassword(
      String email, String currentPassword, String newPassword) async {
    Uri url = Uri.parse('$initialUrl/changepassword.php');

    var response = await http.post(
      url,
      body: {
        "email": email,
        "password": currentPassword,
        "newpassword": newPassword,
      },
    );
    log(response.body);
    return response.body;
  }

  static Future<String> requestPasswordChange({
    required String email,
  }) async {
    log("<==Changing the password==>");
    Uri url =
        Uri.parse('$initialUrl/passwordreset/requestreset.php?email=$email');

    var response = await http.get(url);
    log(response.body);
    return response.body;
  }

  static Future<String> submitVerificationCode(
      String code, String email) async {
    log("<==Submitting Verification Code==>");
    Uri url = Uri.parse(
        '$initialUrl/passwordreset/verifyCode.php?email=$email&token=$code');
    var response = await http.get(url);
    log(response.body);
    return response.body;
  }

  static Future<String> resetPassword(
      String token, String email, String password) async {
    log("<==Resetting the password==>");
    Uri url = Uri.parse('$initialUrl/passwordreset/resetpassword.php');

    var response = await http.post(
      url,
      body: {
        "email": email,
        "token": token,
        "password": password,
      },
    );
    log(response.body);
    return response.body;
  }

  static Future<String> acceptBid(
      String bid_id, String project_id, String freelancer_id) async {
    String url = initialUrl + "/bid/acceptbid.php";
    FormData data = FormData.fromMap({
      "bid_id": bid_id,
      "project_id": project_id,
      "freelancer_id": freelancer_id
    });
    var response = await Dio().post(url, data: data);
    log(response.data);
    return response.data;
  }

  static Future<String> rejectBid(
      String bid_id, String project_id, String freelancer_id) async {
    String url = initialUrl + "/bid/rejectbid.php";
    FormData data = FormData.fromMap({
      "bid_id": bid_id,
      "project_id": project_id,
      "freelancer_id": freelancer_id
    });
    var response = await Dio().post(url, data: data);
    log(response.data);
    return response.data;
  }

  static Future<String> signUp(ProfileModel model) async {
    String url = initialUrl + "/signup.php";
    FormData data = FormData.fromMap(model.toJson());
    var response = await Dio().post(url, data: data);
    log(response.data);
    return response.data;
  }

  static Future<String> updateProfile(ProfileModel model, File? file) async {
    String url = initialUrl + "/profile/updateprofile.php";
    FormData data = FormData.fromMap(model.toJson());
    if (file != null) {
      data.files.add(MapEntry(
        'file',
        await MultipartFile.fromFile(file.path),
      ));
    }
    var response = await Dio().post(url, data: data);
    log(response.data);
    return response.data;
  }

  static Future<String> getUploadedProjects(String id) async {
    String url = initialUrl + '/project/readproject.php?creator=$id';
    log(url);
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> getWorkedProjects(String id) async {
    String url = initialUrl + '/project/readproject.php?freelancer=$id';
    log(url);
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> getCategory() async {
    String url = initialUrl + '/category/readcategory.php';
    log(url);
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> getProfile(String id) async {
    String url = initialUrl + '/profile/readusers.php?id=$id';
    log(url);
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> readNotification(String id) async {
    String url = initialUrl + '/notification/readnotification.php?user_id=$id';
    log(url);
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> getSubCategory(String id) async {
    String url = initialUrl + '/subcategory/readsubcategory.php?id=$id';
    log(url);
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<String> uploadProject(ProjectModel model, File? file) async {
    String url = initialUrl + '/project/createproject.php';
    FormData form =
        FormData.fromMap(json.decode(singleprojectModelToJson(model)));
    form.files.add(MapEntry("file", await MultipartFile.fromFile(file!.path)));
    // form.files
    //     .add(MapEntry("poster", await MultipartFile.fromFile(poster!.path)));
    var response = await Dio().post(url, data: form);
    log(response.data);
    return response.data;
  }

  static Future<String> uploadBid(BidModel model) async {
    String url = initialUrl + '/bid/createbid.php';
    FormData form = FormData.fromMap(json.decode(singlebidModelToJson(model)));
    // form.files
    //     .add(MapEntry("banner", await MultipartFile.fromFile(banner!.path)));
    // form.files
    //     .add(MapEntry("poster", await MultipartFile.fromFile(poster!.path)));
    var response = await Dio().post(url, data: form);
    return response.data;
  }

  static Future<String> uploadNotification(
      NotificationModel model, File? banner, File? poster) async {
    String url = initialUrl + '/createnotification.php';
    FormData form =
        FormData.fromMap(json.decode(singlenotificationModelToJson(model)));
    form.files
        .add(MapEntry("banner", await MultipartFile.fromFile(banner!.path)));
    form.files
        .add(MapEntry("poster", await MultipartFile.fromFile(poster!.path)));
    var response = await Dio().post(url, data: form);
    return response.data;
  }

  static Future<String> getProjects(String subcategory) async {
    String url = Uri.parse(initialUrl +
            '/project/readsubcategoryprojects.php?subcategory_id=$subcategory')
        .toString();
    log(url);
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> getSkills() async {
    String url = initialUrl + '/skills/readskills.php';
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> getBids(String id) async {
    String url = initialUrl + '/bid/readbid.php?user_id=$id';
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static Future<String> getMyProjectBids(String id) async {
    String url = initialUrl + '/bid/readbid.php?project_id=$id';
    var response = await Dio().get(url);
    return response.data;
  }

  static Future<SkillModel> getSkillsDetails(String id) async {
    String url = initialUrl + '/skills/readskills.php?id=$id';
    var response = await Dio().get(url);
    log(response.data);

    return singleskillModelFromJson(response.data);
  }

  static Future<String> searchProjects(String query) async {
    String url = initialUrl + '/project/search.php?query=$query';
    var response = await Dio().get(url);
    log(response.data);
    return response.data;
  }

  static void sendNotification(
      {required String title,
      required String body,
      String image = "",
      String to = "all"}) async {
    Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$vapidkey',
      },
      body: json.encode(
        {
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
            'image': image,
          },
          "android": {
            "notification": {
              "image": image,
            }
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK'
          },
          'to': '/topics/all',
          // 'to': await firebaseMessaging.getToken(),
        },
      ),
    );
    log(response.body);
  }

  static Future<void> savePayment(PaymentModel model) async {
    String url = '$initialUrl/payment/createpayment.php';
    FormData data =
        FormData.fromMap(json.decode(singlepaymentModelToJson(model)));
    var response = await Dio().post(url, data: data);
    return response.data;
  }

  static Future<void> saveNotification(NotificationModel model) async {
    String url = '$initialUrl/notification/createnotification.php';
    FormData data =
        FormData.fromMap(json.decode(singlenotificationModelToJson(model)));
    var response = await Dio().post(url, data: data);
    log(response.data);
    return response.data;
  }

  // FirebaseMessaging.onMessage.listen(
  //     (RemoteMessage message) async {
  //       RemoteNotification notification = message.notification!;
  //       log((message.notification!.title)!.toString());

  //       Get.showSnackbar(
  //         GetSnackBar(
  //           barBlur: 100,
  //           borderRadius: 16,
  //           snackPosition: SnackPosition.TOP,
  //           backgroundColor: Colors.white,
  //           titleText: Text(
  //             notification.title.toString().capitalizeFirst ??
  //                 "Notification Received",
  //             style: const TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black,
  //             ),
  //           ),
  //           duration: const Duration(seconds: 5),
  //           isDismissible: true,
  //           onTap: (snack) {},
  //           messageText: message.notification!.android!.imageUrl == ""
  //               ? Text(notification.body ?? "")
  //               : Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(notification.body ?? ""),
  //                     SizedBox(
  //                       height: 150,
  //                       width: Get.width,
  //                       child: Image.network(
  //                         message.notification!.android!.imageUrl!,
  //                         fit: BoxFit.cover,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //         ),
  //       );
  //     },
  //   );

  //   FirebaseMessaging.onMessageOpenedApp.listen(
  //     (RemoteMessage message) async {
  //     },
  //   );
}
