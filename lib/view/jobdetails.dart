import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/controller/applybidcontroller.dart';
import 'package:imlancerapp/controller/datasavingcontroller.dart';
import 'package:imlancerapp/models/bid_model.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/models/project_readig_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';
import 'package:imlancerapp/view/profilepage.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class JobDetailsPage extends StatelessWidget {
  JobDetailsPage({Key? key, required this.job}) : super(key: key);
  final ProjectReadingModel job;
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
              height: 20,
            ),
            Text(
              job.projectName.capitalizeFirst!,
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
            GestureDetector(
              onTap: () async {
                var response = await RemoteServices.getProfile(job.clientId);
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
                    ListTile(
                      title: Text(
                        "Client Name",
                        style: textStyle2.copyWith(color: Colors.grey.shade400),
                      ),
                      trailing: Text(
                        job.clientUsername.toString(),
                        style: textStyle2,
                      ),
                    ),
                    ListTile(
                      title: Text("E-mail",
                          style:
                              textStyle2.copyWith(color: Colors.grey.shade400)),
                      trailing: Text(
                        job.clientEmail.toString(),
                        style: textStyle2,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Review in stars",
                        style: textStyle2.copyWith(color: Colors.grey.shade400),
                      ),
                      trailing: RatingStars(
                        valueLabelVisibility: false,
                        value: double.parse(
                            job.clientRating == "" ? "0" : job.clientRating),
                        onValueChanged: (v) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  !await isProfileCompleted()
                      ? Fluttertoast.showToast(
                          msg: "Please complete your profile setup")
                      : showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return BottomSheet(
                                backgroundColor: Colors.transparent,
                                onClosing: () {},
                                enableDrag: false,
                                builder: (context) {
                                  return GetBuilder<ApplyBidController>(
                                      init: ApplyBidController(),
                                      builder: (controller) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(18),
                                                topRight: Radius.circular(18)),
                                            color: Color(0xff233640),
                                          ),
                                          height: Get.height * 0.35,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Apply Bid",
                                                  style: textStyle2.copyWith(
                                                      fontSize: 22,
                                                      color: Colors.orange),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: SleekCircularSlider(
                                                    appearance:
                                                        CircularSliderAppearance(),
                                                    initialValue:
                                                        controller.value,
                                                    min: 0,
                                                    max: double.parse(
                                                        job.budget),
                                                    innerWidget: (value) =>
                                                        Center(
                                                            child: Text(
                                                          "Rs " +
                                                              value
                                                                  .toString()
                                                                  .split(".")
                                                                  .first,
                                                          style: textStyle2,
                                                        )),
                                                    onChange: (double value) {
                                                      controller
                                                          .changeValue(value);
                                                    }),
                                              ),
                                              Center(
                                                child: GetBuilder<
                                                    ApplyBidController>(
                                                  init: ApplyBidController(),
                                                  builder: (controller) {
                                                    return ElevatedButton(
                                                      onPressed: () async {
                                                        DatasavingController
                                                            dsc =
                                                            DatasavingController();
                                                        ProfileModel? profile =
                                                            await dsc
                                                                .readProfile();
                                                        controller.applyBid(
                                                            BidModel(
                                                              id: 0,
                                                              projectId: job.id
                                                                  .toString(),
                                                              date: DateTime
                                                                  .now(),
                                                              userId: profile!
                                                                  .id
                                                                  .toString(),
                                                              bidPrice: controller
                                                                  .value
                                                                  .toString(),
                                                              status: "Applied",
                                                            ),
                                                            context);
                                                      },
                                                      child: controller.loading
                                                          ? Text(
                                                              "Applying",
                                                              style: textStyle2,
                                                            )
                                                          : Text(
                                                              " Apply ",
                                                              style: textStyle2,
                                                            ),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .orange
                                                                      .shade800),
                                                          shape: MaterialStateProperty
                                                              .all(
                                                                  const StadiumBorder())),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                });
                          });
                },
                child: Text(
                  "Apply Bid",
                  style: textStyle2,
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange.shade800),
                    shape: MaterialStateProperty.all(const StadiumBorder())),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<bool> isProfileCompleted() async {
  DatasavingController dsc = DatasavingController();
  ProfileModel? model = await dsc.readProfile();
  if (model!.skillId == "" ||
      model.myspeciality == "" ||
      model.notificationId == "") {
    return false;
  } else {
    return true;
  }
}
