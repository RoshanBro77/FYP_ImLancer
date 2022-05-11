import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/view/appliedbids.dart';
import 'package:imlancerapp/view/bidpage.dart';
import 'package:imlancerapp/view/createdprojectandbids.dart';
import 'package:imlancerapp/view/editprofile.dart';
import 'package:imlancerapp/view/payment.dart';
import 'package:imlancerapp/view/splashscreen.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'noficationpage.dart';
import 'view/aboutpage.dart';
import 'view/chooseprofile.dart';
import 'view/loginpage.dart';
import 'view/mainpanel.dart';
import 'view/projectandreviews.dart';
import 'view/resetpasswordpage.dart';
import 'view/searchpage.dart';
import 'view/settings.dart';
import 'view/startuppage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.subscribeToTopic('all');
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: 'test_public_key_2a85ec174f84413f972b0895d5d0b051',
        builder: (context, navigatorkey) {
          return GetMaterialApp(
            navigatorKey: navigatorkey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
                iconTheme: IconThemeData(color: Color(0xff879274))),
            home: const SplashPage(),
            routes: {
              '/choosesearchingprofile': (_) => ChooseSearchingProfile(),
              '/homepage': (_) => MainPanel(),
              // '/settingpage': (_) => SettingsPage(profile: ,),
              '/searchpage': (_) => SearchPage(),
              '/aboutpage': (_) => AboutPage(),
              '/notificationpage': (_) => NotificationPage(),
              '/projectandreviewspage': (_) => ProjectAndReviewsPage(),
              '/createdprojectsandbids': (_) => CreatedProjectAndBids(),
              '/loginpage': (_) => LogInPage(),
              '/startuppage': (_) => const StartUpScreen(),
              '/bidsapplied': (_) => BidsApplied(),
              '/forgotpassword': (_) => ForgotPassword(),
              '/paymentpage': (_) => Payment(),
            },
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
