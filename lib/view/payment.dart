import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/controller/myprojectcontroller.dart';
import 'package:imlancerapp/controller/myworkedprojectcontroller.dart';
import 'package:imlancerapp/models/bid_model.dart';
import 'package:imlancerapp/models/project_model.dart';

import 'bidpage.dart';

class Payment extends StatelessWidget {
  Payment({Key? key}) : super(key: key);
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);

  @override
  Widget build(BuildContext context) {
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);

    return Scaffold(
      backgroundColor: Color(0xff111a1f),
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: GetBuilder<MyWorkedProjectController>(
            init: MyWorkedProjectController(),
            builder: (controller) {
              return controller.loading
                  ? Center(child: const CircularProgressIndicator())
                  : Container(
                      decoration: const BoxDecoration(color: Color(0xff111a1f)),
                      //height: height,
                      width: Get.width,
                      child: allProjects(
                          controller.completedProjects, textStyle2, controller),
                    );
            }),
      ),
    );
  }
}

Widget allProjects(List<ProjectModel> projects, TextStyle textStyle2,
    MyWorkedProjectController controller) {
  return ListView.builder(
    itemBuilder: (context, index) {
      ProjectModel model = projects[index];
      return (Card(
        color: const Color(0xff07080a),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BidDetailsPage(
                  job: projects[index],
                  isPaymentPage: true,
                  uploaded: false,
                ),
              ),
            );
          },
          title: Text(
            model.projectName,
            style: textStyle2,
          ),
          subtitle: Text(
            "${model.description}",
            style:
                textStyle2.copyWith(fontSize: 15, color: Colors.grey.shade300),
          ),
          trailing: FutureBuilder<BidModel>(
            future: controller.getMyEarnings(model.id.toString()),
            builder: ((context, snapshot) {
              return snapshot.data == null
                  ? Text(
                      "Rs.",
                      style: textStyle2,
                    )
                  : Text(
                      "Rs. ${double.parse(snapshot.data!.bidPrice).toPrecision(2)}",
                      style: textStyle2,
                    );
            }),
          ),
        ),
      ));
    },
    itemCount: projects.length,
  );
}
