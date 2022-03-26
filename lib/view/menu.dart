import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/controller/datasavingcontroller.dart';
import 'package:imlancerapp/view/settings.dart';

import '../controller/mainpanelcontroller.dart';
import '../models/profile_model.dart';
import '../utils/remoteservices.dart';
import 'profilepage.dart';

class MenuPage extends StatelessWidget {
  MenuPage({Key? key, required this.profile}) : super(key: key);
  ProfileModel profile;
  DatasavingController dsc = DatasavingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);

    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);
    return Scaffold(
      backgroundColor: Color(0xff111a1f),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<ProfileModel?>(
                future: dsc.readProfile(),
                builder: (context, snapshot) {
                  return snapshot.data == null
                      ? Container()
                      : GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  profile: snapshot.data!,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 15,
                            color: Color(0xff111a1f),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: Get.width,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PhysicalModel(
                                      color: Colors.white,
                                      elevation: 10,
                                      borderRadius: BorderRadius.circular(360),
                                      clipBehavior: Clip.antiAlias,
                                      child: Hero(
                                        tag: profile.id,
                                        child: snapshot.data!.profileimageId ==
                                                ""
                                            ? CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage(
                                                  "assets/default.jpg",
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 50,
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                  RemoteServices.initialUrl +
                                                      "/profilepictures/" +
                                                      snapshot
                                                          .data!.profileimageId,
                                                ),
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      //width: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              snapshot.data!.userName
                                                  .capitalizeFirst!,
                                              textAlign: TextAlign.center,
                                              style: textStyle.copyWith(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!.emailId,
                                              textAlign: TextAlign.center,
                                              style: textStyle2.copyWith(
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                }),
            SizedBox(
              height: 25,
            ),
            GetBuilder<MainPanelController>(
                init: MainPanelController(),
                builder: (controller) {
                  return ListTile(
                    leading:
                        Icon(Icons.search, size: 35, color: Color(0xff879274)),
                    title: Text(
                      "Find Job",
                      style: textStyle2,
                    ),
                    onTap: () {
                      controller.changePage(1);
                    },
                  );
                }),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, "/projectandreviewspage");
              },
              leading:
                  Icon(Icons.cases_sharp, size: 35, color: Color(0xff879274)),
              title: Text(
                "My Project And Reviews",
                style: textStyle2,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, "/createdprojectsandbids");
              },
              leading:
                  Icon(Icons.cases_sharp, size: 35, color: Color(0xff879274)),
              title: Text(
                "Created Projects and Bids",
                style: textStyle2,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, "/bidsapplied");
              },
              leading:
                  Icon(Icons.attach_money, size: 35, color: Color(0xff879274)),
              title: Text(
                "Applied Bids",
                style: textStyle2,
              ),
            ),
            Text(
              "General",
              style: textStyle.copyWith(color: Colors.orange),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.feedback_rounded,
                  size: 35, color: Color(0xff879274)),
              title: Text(
                "Feedback",
                style: textStyle2,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(profile: profile)));
              },
              leading: Icon(Icons.settings, size: 35, color: Color(0xff879274)),
              title: Text(
                "Profile Settings",
                style: textStyle2,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/paymentpage');
              },
              leading:
                  Icon(Icons.payment_sharp, size: 35, color: Color(0xff879274)),
              title: Text(
                "Payment",
                style: textStyle2,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/aboutpage');
              },
              leading: Icon(Icons.info, size: 35, color: Color(0xff879274)),
              title: Text(
                "About",
                style: textStyle2,
              ),
            ),
            ListTile(
              onTap: () {
                DatasavingController dsc = DatasavingController();
                dsc.deleteProfile();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/startuppage', (event) => false);
              },
              leading: Icon(Icons.logout, size: 35, color: Color(0xff879274)),
              title: Text(
                "Log Out",
                style: textStyle2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
