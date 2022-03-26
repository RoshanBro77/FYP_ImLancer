import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/controller/myprojectcontroller.dart';
import 'package:imlancerapp/models/myprojectbidmodel.dart';
import 'package:imlancerapp/models/notification_model.dart';
import 'package:imlancerapp/models/project_model.dart';
import 'package:imlancerapp/models/skills_model.dart';
import 'package:imlancerapp/view/profilepage.dart';
import '../controller/jobinfocontroller.dart';
import '../models/profile_model.dart';
import '../utils/remoteservices.dart';

class BidDetailsPage extends StatelessWidget {
  BidDetailsPage(
      {Key? key,
      required this.job,
      this.uploaded = false,
      this.isPaymentPage = false})
      : super(key: key);
  final ProjectModel job;
  final bool uploaded;
  final bool isPaymentPage;
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
  MyProjectController mpc = Get.put(MyProjectController());
  @override
  Widget build(BuildContext context) {
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);
    return GetBuilder<MyProjectController>(
        init: mpc,
        initState: (_) {
          // MyProjectController().readMyProjectBids(job.id.toString());
        },
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Project Details And Bids"),
                backgroundColor: Colors.black,
                elevation: 5,
              ),
              body: Container(
                decoration: BoxDecoration(color: Color(0xff111a1f)),
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                width: Get.width,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      job.projectName.capitalizeFirst!,
                      style: textStyle2.copyWith(
                          fontSize: 23, color: Colors.orange),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Required Skills",
                      style: textStyle2.copyWith(color: Colors.grey.shade400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      job.skillId,
                      style: textStyle2,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Description",
                      style: textStyle2.copyWith(color: Colors.grey.shade400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      job.description,
                      style: textStyle2,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "DeadLine",
                      style: textStyle2.copyWith(color: Colors.grey.shade400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      job.deadline.toString(),
                      style: textStyle2,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Files",
                      style: textStyle2.copyWith(color: Colors.grey.shade400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Download Materials"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange.shade800),
                          shape: MaterialStateProperty.all(
                            const StadiumBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Budget",
                      style: textStyle2.copyWith(color: Colors.grey.shade400),
                    ),
                    Text(
                      "Rs ${job.budget}",
                      style: textStyle2,
                    ),
                    // if (!uploaded && !isPaymentPage)
                    isPaymentPage || uploaded
                        ? Container()
                        : GestureDetector(
                            onTap: () async {
                              var response = await RemoteServices.getProfile(
                                  job.freelancerId);
                              ProfileModel model =
                                  singleprofileModelFromJson(response);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                    profile: model,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: Color.fromARGB(127, 35, 54, 64),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("About Freelancer",
                                      style: textStyle2.copyWith(
                                          color: Colors.grey.shade400)),
                                  GetBuilder<JobInfoController>(
                                      init: JobInfoController(
                                          id: job.freelancerId),
                                      builder: (controller) {
                                        return controller.loading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : controller.model == null
                                                ? Text(
                                                    "No Data",
                                                    style: textStyle2,
                                                  )
                                                : Column(
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          "Freelancer Name",
                                                          style: textStyle2
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400),
                                                        ),
                                                        trailing: Text(
                                                          controller
                                                              .model!.userName
                                                              .toString(),
                                                          style: textStyle2,
                                                        ),
                                                      ),
                                                      ListTile(
                                                        title: Text("E-mail",
                                                            style: textStyle2
                                                                .copyWith(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade400)),
                                                        trailing: Text(
                                                          controller
                                                              .model!.emailId
                                                              .toString(),
                                                          style: textStyle2,
                                                        ),
                                                      ),
                                                      ListTile(
                                                        title: Text(
                                                          "Review in stars",
                                                          style: textStyle2
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400),
                                                        ),
                                                        trailing: RatingStars(
                                                          valueLabelVisibility:
                                                              false,
                                                          value: double.parse(
                                                            controller.model!
                                                                        .rating ==
                                                                    ""
                                                                ? "0"
                                                                : controller
                                                                    .model!
                                                                    .rating,
                                                          ),
                                                          onValueChanged:
                                                              (v) {},
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                      }),
                                ],
                              ),
                            ),
                          ),
                    if (isPaymentPage == true && uploaded == false)
                      GestureDetector(
                        onTap: () async {
                          var response =
                              await RemoteServices.getProfile(job.clientId);
                          ProfileModel model =
                              singleprofileModelFromJson(response);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                        profile: model,
                                      )));
                        },
                        child: Card(
                          color: Color.fromARGB(127, 35, 54, 64),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("About Client",
                                  style: textStyle2.copyWith(
                                      color: Colors.grey.shade400)),
                              GetBuilder<JobInfoController>(
                                  init: JobInfoController(id: job.clientId),
                                  builder: (controller) {
                                    return controller.loading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : controller.model == null
                                            ? Text(
                                                "No Data",
                                                style: textStyle2,
                                              )
                                            : Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      "Client Name",
                                                      style:
                                                          textStyle2.copyWith(
                                                              color: Colors.grey
                                                                  .shade400),
                                                    ),
                                                    trailing: Text(
                                                      controller.model!.userName
                                                          .toString(),
                                                      style: textStyle2,
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text("E-mail",
                                                        style:
                                                            textStyle2.copyWith(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400)),
                                                    trailing: Text(
                                                      controller.model!.emailId
                                                          .toString(),
                                                      style: textStyle2,
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      "Review in stars",
                                                      style:
                                                          textStyle2.copyWith(
                                                              color: Colors.grey
                                                                  .shade400),
                                                    ),
                                                    trailing: RatingStars(
                                                      valueLabelVisibility:
                                                          false,
                                                      value: double.parse(
                                                        controller
                                                            .model!.rating,
                                                      ),
                                                      onValueChanged: (v) {},
                                                    ),
                                                  ),
                                                ],
                                              );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    uploaded
                        ? Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewAppliedBids(
                                      job: job,
                                      textStyle2: textStyle2,
                                    ),
                                  ),
                                );
                              },
                              child: Text("View Bids"),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.orange.shade800),
                                shape: MaterialStateProperty.all(
                                  const StadiumBorder(),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ));
        });
  }
}

class ViewAppliedBids extends StatelessWidget {
  ViewAppliedBids({
    Key? key,
    required this.job,
    required this.textStyle2,
  }) : super(key: key);

  final ProjectModel job;
  final TextStyle textStyle2;
  MyProjectController mpc = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyProjectController>(
        init: mpc,
        initState: (_) {
          mpc.readMyProjectBids(job.id.toString());
        },
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Applied Bids"),
              backgroundColor: Colors.black,
            ),
            body: Container(
              decoration: BoxDecoration(color: Color(0xff111a1f)),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    controller.reading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.myProjectBids.isEmpty
                            ? Center(
                                child: Text(
                                  "No Bids",
                                  style: textStyle2,
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return (Card(
                                      color: Color(0xff07080a),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            onTap: () {},
                                            title: Text(
                                              controller.myProjectBids[index]
                                                  .freelancerUsername,
                                              style: textStyle2,
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                RatingStars(
                                                  valueLabelVisibility: false,
                                                  value: double.parse(controller
                                                      .myProjectBids[index]
                                                      .freelancerRating),
                                                  starSize: 10,
                                                  onValueChanged: (v) {},
                                                ),
                                                Text(
                                                  "Bid Amount : Rs. ${double.parse(controller.myProjectBids[index].bidPrice).roundToDouble()}",
                                                  style: textStyle2.copyWith(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            subtitle: Wrap(
                                              children: [
                                                for (var item in controller
                                                    .myProjectBids[index]
                                                    .freelancerSkills
                                                    .split(','))
                                                  FutureBuilder<SkillModel>(
                                                    future: RemoteServices
                                                        .getSkillsDetails(item),
                                                    builder:
                                                        (context, snapshot) {
                                                      return snapshot.connectionState ==
                                                                  ConnectionState
                                                                      .active ||
                                                              snapshot.data ==
                                                                  null
                                                          ? Text(
                                                              ".",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : Text(
                                                              snapshot.data!
                                                                  .skillName,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            );
                                                    },
                                                  )
                                              ],
                                            ),
                                            // subtitle: Text(
                                            //   "${controller.myProjectBids[index].freelancerSkills} \n ${double.parse(controller.myProjectBids[index].bidPrice).roundToDouble()}",
                                            //   style: textStyle2.copyWith(
                                            //       fontSize: 15,
                                            //       color: Colors.grey.shade300),
                                            // ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              Colors.black,
                                                          title: Text("Hey!"),
                                                          content: Text(
                                                            "Do you wanna Accept this bid?",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.orange,
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    "No",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white))),
                                                            TextButton(
                                                                onPressed: () {
                                                                  controller
                                                                      .acceptBid(
                                                                    controller
                                                                        .myProjectBids[
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    controller
                                                                        .myProjectBids[
                                                                            index]
                                                                        .projectId,
                                                                    controller
                                                                        .myProjectBids[
                                                                            index]
                                                                        .userId,
                                                                    controller
                                                                        .myProjectBids[
                                                                            index]
                                                                        .notificationId,
                                                                  );
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Bid Accepted");
                                                                  Navigator.pop(
                                                                      context);

                                                                  RemoteServices
                                                                      .sendNotification(
                                                                    title:
                                                                        "Bid Accepted",
                                                                    body:
                                                                        "Your bid for the project ${controller.myProjectBids[index].projectName} has been accepted",
                                                                    to: controller
                                                                        .myProjectBids[
                                                                            index]
                                                                        .notificationId,
                                                                  );
                                                                  RemoteServices
                                                                      .saveNotification(
                                                                    NotificationModel(
                                                                      id: 0,
                                                                      title:
                                                                          "Bid Accepted",
                                                                      description:
                                                                          "Your bid for the project ${controller.myProjectBids[index].projectName} has been accepted",
                                                                      type:
                                                                          'bid',
                                                                      content:
                                                                          '',
                                                                      date: DateTime
                                                                          .now(),
                                                                      recieverId:
                                                                          int.parse(
                                                                        controller
                                                                            .myProjectBids[index]
                                                                            .userId,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Text(
                                                                    "Yes",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white))),
                                                          ],
                                                        );
                                                      },
                                                    ).whenComplete(() {
                                                      controller
                                                          .readMyProjectBids(
                                                        job.id.toString(),
                                                      );
                                                    });
                                                  },
                                                  child: Text("Accept Bid"),
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.orange
                                                                .shade800),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      const StadiumBorder(),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              Colors.black,
                                                          title: Text("Hey!"),
                                                          content: Text(
                                                            "Do you wanna Reject this bid?",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.orange,
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    "No",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white))),
                                                            TextButton(
                                                              onPressed: () {
                                                                controller
                                                                    .rejectingBid(
                                                                  controller
                                                                      .myProjectBids[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  controller
                                                                      .myProjectBids[
                                                                          index]
                                                                      .projectId,
                                                                  controller
                                                                      .myProjectBids[
                                                                          index]
                                                                      .userId,
                                                                  controller
                                                                      .myProjectBids[
                                                                          index]
                                                                      .notificationId,
                                                                );
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            "Bid Rejected");
                                                                Navigator.pop(
                                                                    context);

                                                                RemoteServices
                                                                    .sendNotification(
                                                                  title:
                                                                      "Bid Rejected",
                                                                  body:
                                                                      "Your bid for the project ${controller.myProjectBids[index].projectName} has been rejected",
                                                                  to: controller
                                                                      .myProjectBids[
                                                                          index]
                                                                      .notificationId,
                                                                );
                                                                RemoteServices
                                                                    .saveNotification(
                                                                  NotificationModel(
                                                                    id: 0,
                                                                    title:
                                                                        "Bid Rejected",
                                                                    description:
                                                                        "Your bid for the project ${controller.myProjectBids[index].projectName} has been rejected",
                                                                    type: 'bid',
                                                                    content: '',
                                                                    date: DateTime
                                                                        .now(),
                                                                    recieverId:
                                                                        int.parse(
                                                                      controller
                                                                          .myProjectBids[
                                                                              index]
                                                                          .userId,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text(
                                                                "Yes",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ).whenComplete(() {
                                                      controller
                                                          .readMyProjectBids(
                                                        job.id.toString(),
                                                      );
                                                    });
                                                    ;
                                                  },
                                                  child: Text("Reject Bid"),
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.orange
                                                                .shade800),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      const StadiumBorder(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                                  },
                                  itemCount: controller.myProjectBids.length,
                                ),
                              ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
