import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/controller/jobinfocontroller.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/models/project_model.dart';
import 'package:imlancerapp/models/project_readig_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';
import 'package:imlancerapp/view/profilepage.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../controller/applybidcontroller.dart';
import '../controller/datasavingcontroller.dart';
import '../models/bid_model.dart';

class JobInfo extends StatefulWidget {
  JobInfo({
    Key? key,
    required this.job,
    required this.showReviews,
    this.bidStatus = "",
  }) : super(key: key);
  final ProjectModel job;
  final bool showReviews;
  final String bidStatus;

  @override
  State<JobInfo> createState() => _JobInfoState();
}

class _JobInfoState extends State<JobInfo> {
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);

    return Scaffold(
      appBar: AppBar(
        title: Text("Details of the Project"),
        backgroundColor: Colors.black,
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xff111a1f)),
        height: height,
        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
        width: width,
        child: ListView(
          children: [
            SizedBox(
              height: 3,
            ),
            Text(
              widget.job.projectName.capitalizeFirst!,
              style: textStyle2.copyWith(fontSize: 23, color: Colors.orange),
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
              widget.job.skillId,
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
              widget.job.description,
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
              widget.job.deadline.toString(),
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
              "Rs ${widget.job.budget}",
              style: textStyle2,
            ),
            GestureDetector(
              onTap: () async {
                var response =
                    await RemoteServices.getProfile(widget.job.clientId);
                ProfileModel model = singleprofileModelFromJson(response);
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
                        style:
                            textStyle2.copyWith(color: Colors.grey.shade400)),
                    GetBuilder<JobInfoController>(
                        init: JobInfoController(id: widget.job.clientId),
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
                                            style: textStyle2.copyWith(
                                                color: Colors.grey.shade400),
                                          ),
                                          trailing: Text(
                                            controller.model!.userName
                                                .toString(),
                                            style: textStyle2,
                                          ),
                                        ),
                                        ListTile(
                                          title: Text("E-mail",
                                              style: textStyle2.copyWith(
                                                  color: Colors.grey.shade400)),
                                          trailing: Text(
                                            controller.model!.emailId
                                                .toString(),
                                            style: textStyle2,
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "Review in stars",
                                            style: textStyle2.copyWith(
                                                color: Colors.grey.shade400),
                                          ),
                                          trailing: RatingStars(
                                            valueLabelVisibility: false,
                                            value: double.parse(
                                              controller.model!.rating,
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
            Container(
              decoration: BoxDecoration(
                color: Colors.orange.shade800,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: widget.showReviews
                        ? Text(
                            widget.job.projectStatus,
                            style: textStyle2,
                          )
                        : Text(widget.bidStatus, style: textStyle2)),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            widget.showReviews
                ? Column(
                    children: [
                      Text(
                        "Review",
                        style: textStyle2.copyWith(
                            color: Colors.grey.shade400, fontSize: 22),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.job.review,
                        style: textStyle2,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
