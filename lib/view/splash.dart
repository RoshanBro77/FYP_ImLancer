import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/datasavingcontroller.dart';
import '../models/profile_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  loadSplash() async {
    DatasavingController dsc = Get.put(DatasavingController());
    ProfileModel? profile = await dsc.readProfile();
    Future.delayed(Duration(
      seconds: 1,
    )).then((value) async {
      if (profile == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/startuppage', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/homepage', (route) => false);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSplash();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        RemoteNotification notification = message.notification!;
        log((message.notification!.title)!.toString());

        Get.showSnackbar(
          GetSnackBar(
            barBlur: 100,
            borderRadius: 16,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            titleText: Text(
              notification.title.toString().capitalizeFirst ??
                  "Notification Received",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            duration: const Duration(seconds: 5),
            isDismissible: true,
            onTap: (snack) {},
            messageText: message.notification!.android!.imageUrl == ""
                ? Text(notification.body ?? "")
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body ?? ""),
                      SizedBox(
                        height: 150,
                        width: Get.width,
                        child: Image.network(
                          message.notification!.android!.imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "ImLancer App",
            style: TextStyle(fontSize: 35),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
