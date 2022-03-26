import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imlancerapp/controller/datasavingcontroller.dart';
import 'package:imlancerapp/controller/login_controller.dart';
import 'package:imlancerapp/controller/readskillscontroller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/profile_model.dart';
import '../models/skills_model.dart';
import '../utils/remoteservices.dart';
import 'photoviewer.dart';
import 'package:file_picker/file_picker.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key, required this.profile}) : super(key: key);
  final ProfileModel profile;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? pickedPhotoFile;
  TextEditingController projectSkillController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController changeSpeciality = TextEditingController();
  TextEditingController changeDescription = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();

  GlobalKey<FormState> updateForm = GlobalKey<FormState>();

  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
  List<File> documents = [];
  DatasavingController dsc = DatasavingController();
  @override
  Widget build(BuildContext context) {
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);
    var outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black));
    var inputDecoration = InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder);
    return GetBuilder<SkillsController>(
        init: SkillsController(),
        builder: (skillsController) {
          return FutureBuilder<ProfileModel?>(
              future: dsc.readProfile(),
              builder: (context, snapshot) {
                return snapshot.data == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.black,
                          title: Text("Edit Profile"),
                          elevation: 10,
                        ),
                        body: Form(
                          key: updateForm,
                          child: Container(
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
                                            child: GestureDetector(
                                              onTap: () async {
                                                final ImagePicker _picker =
                                                    ImagePicker();
                                                // Pick an image
                                                final XFile? image =
                                                    await _picker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                pickedPhotoFile =
                                                    File(image!.path);
                                                setState(() {});
                                              },
                                              child: Stack(
                                                children: [
                                                  pickedPhotoFile != null
                                                      ? CircleAvatar(
                                                          radius: 50,
                                                          backgroundImage:
                                                              FileImage(
                                                            pickedPhotoFile!,
                                                          ),
                                                        )
                                                      : widget.profile
                                                                  .profileimageId ==
                                                              ""
                                                          ? CircleAvatar(
                                                              radius: 50,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                "assets/default.jpg",
                                                              ),
                                                            )
                                                          : CircleAvatar(
                                                              radius: 50,
                                                              backgroundImage:
                                                                  CachedNetworkImageProvider(
                                                                RemoteServices
                                                                        .initialUrl +
                                                                    "/profilepictures/" +
                                                                    widget
                                                                        .profile
                                                                        .profileimageId
                                                                        .toString(),
                                                              ),
                                                            ),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.image,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                                  TextFormField(
                                    controller: addressController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      fillColor: Colors.white,
                                      hintText: "Enter new Address Here.",
                                      filled: true,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          changeDescription.clear();
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: phonenumberController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      fillColor: Colors.white,
                                      hintText: "Enter Phone number Here.",
                                      filled: true,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          changeDescription.clear();
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: facebookController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      fillColor: Colors.white,
                                      hintText: "Enter Facebook Link Here.",
                                      filled: true,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          changeDescription.clear();
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: instagramController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      fillColor: Colors.white,
                                      hintText: "Enter Instagram Link Here.",
                                      filled: true,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          changeDescription.clear();
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: changeSpeciality,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      fillColor: Colors.white,
                                      hintText: "Change Speciality Here.",
                                      filled: true,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          changeDescription.clear();
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: changeDescription,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      fillColor: Colors.white,
                                      hintText: "Change Description Here.",
                                      filled: true,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          changeDescription.clear();
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      return null;
                                    },
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
                                    children: [
                                      for (var item
                                          in skillsController.selectedSkills)
                                        GestureDetector(
                                          onTap: () {
                                            skillsController.selectedSkills
                                                .remove(item);
                                            skillsController.update();
                                          },
                                          child: Chip(
                                            label: Text(item),
                                            backgroundColor:
                                                Colors.orange.shade800,
                                          ),
                                        ),
                                    ],
                                  ),
                                  DropdownButtonFormField<String>(
                                    decoration: inputDecoration,
                                    items: [
                                      for (var item in skillsController.skills)
                                        DropdownMenuItem(
                                          child: Text(item.skillName),
                                          value: item.skillName,
                                        )
                                    ],
                                    onChanged: (value) {
                                      projectSkillController.text = value!;
                                      skillsController.insertSelection(value);
                                      setState(() {});
                                    },
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
                                  ElevatedButton(
                                    onPressed: () async {
                                      final ImagePicker _picker = ImagePicker();
                                      // Pick multiple images
                                      final List<XFile>? images =
                                          await _picker.pickMultiImage();
                                      if (images == null) {
                                      } else {
                                        for (var item in images) {
                                          File file = File(item.path);
                                          documents.add(file);
                                        }
                                      }
                                      setState(() {});
                                    },
                                    child: Text("Select Documents"),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.orange.shade800),
                                      shape: MaterialStateProperty.all(
                                        const StadiumBorder(),
                                      ),
                                    ),
                                  ),
                                  documents.isEmpty
                                      ? Container()
                                      : Wrap(
                                          children: [
                                            for (var item in documents)
                                              Container(
                                                height: 100,
                                                width: 100,
                                                child: Image.file(
                                                  item,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                          ],
                                        ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (updateForm.currentState!
                                            .validate()) {
                                          List<String> documentName =
                                              <String>[];
                                          for (var item in documents) {
                                            var response = await RemoteServices
                                                .uploadDocument(item);
                                            var name =
                                                json.decode(response)['status'];
                                            if (name == "failed to upload" ||
                                                name ==
                                                    "Error While uploading") {
                                            } else {
                                              documentName.add(name);
                                            }
                                          }
                                          String allDocuments =
                                              documentName.join(',');
                                          ProfileModel profile = snapshot.data!;
                                          String token = await FirebaseMessaging
                                                  .instance
                                                  .getToken() ??
                                              "";
                                          await RemoteServices.updateProfile(
                                            ProfileModel(
                                              id: profile.id,
                                              userName: profile.userName,
                                              password: profile.password,
                                              emailId: profile.emailId,
                                              address: addressController.text,
                                              phone: phonenumberController.text,
                                              date: profile.date,
                                              rating: profile.rating,
                                              skillId:
                                                  projectSkillController.text,
                                              profileimageId:
                                                  profile.profileimageId,
                                              mydescription:
                                                  changeDescription.text,
                                              myspeciality:
                                                  changeSpeciality.text,
                                              document: allDocuments,
                                              socialmedia:
                                                  facebookController.text +
                                                      "," +
                                                      instagramController.text,
                                              gender: profile.gender,
                                              notificationId: token,
                                            ),
                                            pickedPhotoFile,
                                          );
                                          LoginController loginController =
                                              LoginController();
                                          loginController.login(
                                            profile.emailId,
                                            profile.password,
                                            context,
                                          );
                                        }
                                      },
                                      child: const Text("Update Profile"),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.orange.shade800),
                                        shape: MaterialStateProperty.all(
                                          const StadiumBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
              });
        });
  }
}
