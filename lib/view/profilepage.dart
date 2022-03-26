import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/profile_model.dart';
import '../models/skills_model.dart';
import '../utils/remoteservices.dart';
import 'photoviewer.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, required this.profile}) : super(key: key);
  final ProfileModel profile;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? pickedPhotoFile;

  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);

  @override
  Widget build(BuildContext context) {
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Profile"),
        elevation: 10,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: BoxDecoration(color: Colors.black),
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 220,
                width: Get.width,
                child: Stack(
                  children: [
                    Container(
                      height: 180,
                      width: Get.width + 100,
                      child: SvgPicture.asset(
                        "assets/CircularProfile.svg",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Hero(
                        tag: widget.profile.id,
                        child: widget.profile.profileimageId == ""
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                  "assets/default.jpg",
                                ),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: CachedNetworkImageProvider(
                                  RemoteServices.initialUrl +
                                      "/profilepictures/" +
                                      widget.profile.profileimageId.toString(),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                widget.profile.userName.capitalizeFirst!,
                style: textStyle2,
              ),
              Text(
                widget.profile.emailId,
                style: textStyle2,
              ),
              Text(
                widget.profile.gender,
                style: textStyle2,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // SizedBox(
                  //   width: 65,
                  // ),
                  GestureDetector(
                    onTap: () async {
                      String phone =
                          widget.profile.socialmedia.split(',').first;
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: phone,
                      );
                      await launch(launchUri.toString());
                    },
                    child: Image.asset(
                      "assets/phone-call.png",
                      height: 40,
                    ),
                  ),

                  GestureDetector(
                    onTap: () async {
                      String _url = widget.profile.socialmedia.split(',')[1];
                      if (!await launch(_url)) throw 'Could not launch $_url';
                    },
                    child: Image.asset(
                      "assets/facebook.png",
                      height: 40,
                    ),
                  ),

                  GestureDetector(
                    onTap: () async {
                      String _url = widget.profile.socialmedia.split(',').last;
                      if (!await launch(_url)) throw 'Could not launch $_url';
                    },
                    child: Image.asset(
                      "assets/instagram.png",
                      height: 40,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  "Review in stars",
                  style: textStyle2.copyWith(color: Colors.grey.shade400),
                ),
                trailing: RatingStars(
                  valueLabelVisibility: false,
                  value: double.parse(widget.profile.rating),
                  onValueChanged: (v) {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              widget.profile.myspeciality == "0"
                  ? SizedBox.shrink()
                  : Text(
                      widget.profile.myspeciality,
                      style: textStyle,
                    ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.profile.mydescription,
                style: textStyle2,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Skills",
                style: textStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (var item in widget.profile.skillId.split(','))
                    FutureBuilder<SkillModel>(
                      future: RemoteServices.getSkillsDetails(item),
                      builder: (context, snapshot) {
                        return snapshot.connectionState ==
                                    ConnectionState.active ||
                                snapshot.data == null
                            ? Text(
                                ".",
                                style: TextStyle(color: Colors.white),
                              )
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                                child: Chip(
                                  backgroundColor: Colors.orange.shade700,
                                  label: Text(
                                    snapshot.data!.skillName,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                      },
                    )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Documents",
                style: textStyle,
              ),
              SizedBox(
                height: 10,
              ),
              widget.profile.document == ""
                  ? SizedBox.shrink()
                  : Card(
                      color: Colors.white,
                      child: Wrap(
                        children: [
                          for (var item in widget.profile.document.split(","))
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhotoViewer(
                                      image: RemoteServices.initialUrl +
                                          "/profile/documents/" +
                                          item,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CachedNetworkImage(
                                  imageUrl: RemoteServices.initialUrl +
                                      "/profile/documents/" +
                                      item,
                                  width: Get.width / 2.6,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
