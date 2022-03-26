import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/controller/readbidcontroller.dart';
import 'package:imlancerapp/models/mybidmodel.dart';
import 'package:imlancerapp/models/project_model.dart';
import 'package:imlancerapp/view/jobinfo.dart';

class BidsApplied extends StatelessWidget {
  BidsApplied({Key? key}) : super(key: key);
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);

  @override
  Widget build(BuildContext context) {
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);
    return Scaffold(
      backgroundColor: Color(0xff111a1f),
      appBar: AppBar(
        title: Text("Applied Bids"),
        backgroundColor: Colors.black,
      ),
      body: GetBuilder<ReadBidController>(
        init: ReadBidController(),
        builder: (controller) {
          return controller.loading
              ? Center(child: const CircularProgressIndicator())
              : controller.bids.isEmpty
                  ? Center(
                      child: Text("You have not applied yet.",
                          style: TextStyle(
                            color: Colors.white,
                          )))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        MyBidModel model = controller.bids[index];
                        return (ListTile(
                          onTap: () {
                            ProjectModel model = ProjectModel(
                              budget: controller.bids[index].budget,
                              review: "",
                              clientId: controller.bids[index].clientId,
                              date: controller.bids[index].date,
                              deadline: controller.bids[index].deadline,
                              description: controller.bids[index].description,
                              duration: controller.bids[index].duration,
                              file: controller.bids[index].file,
                              freelancerId: controller.bids[index].freelancerId,
                              id: controller.bids[index].id,
                              projectCategory:
                                  controller.bids[index].projectCategory,
                              projectName: controller.bids[index].projectName,
                              projectStatus:
                                  controller.bids[index].projectStatus,
                              projectSubcategory:
                                  controller.bids[index].projectSubcategory,
                              skillId: controller.bids[index].skillId,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobInfo(
                                  job: model,
                                  showReviews: false,
                                  bidStatus: controller.bids[index].status,
                                ),
                              ),
                            );
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => JobInfo(

                            //         showReviews: false,
                            //       ),
                            //     ));
                          },
                          title: Text(
                            model.projectName,
                            style: textStyle2,
                          ),
                          subtitle: Text(
                            "${model.description} \n Rs ${double.parse(model.bidPrice == '' ? '0' : model.bidPrice).toStringAsFixed(2)}",
                            style: textStyle2.copyWith(
                                fontSize: 15, color: Colors.grey.shade300),
                          ),
                        ));
                      },
                      itemCount: controller.bids.length,
                    );
        },
      ),
    );
  }
}
