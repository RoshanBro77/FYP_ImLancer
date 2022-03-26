import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/models/project_model.dart';
import 'package:imlancerapp/view/bidpage.dart';

import '../controller/myprojectcontroller.dart';

class CreatedProjectAndBids extends StatelessWidget {
  CreatedProjectAndBids({Key? key}) : super(key: key);
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xff111a1f),
        appBar: AppBar(
          title: Text("Created Projects and Bids"),
          backgroundColor: Colors.black,
          bottom: TabBar(
              tabs: [Text("Assigned"), Text("Uploaded"), Text("Completed")]),
        ),
        body: GetBuilder<MyProjectController>(
            init: MyProjectController(),
            builder: (controller) {
              return controller.loading
                  ? Center(child: const CircularProgressIndicator())
                  : TabBarView(
                      children: [
                        controller.assignedProjects.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Projects Created",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xff111a1f)),
                                //height: height,
                                width: width,
                                child: allProjects(
                                  controller.assignedProjects,
                                  textStyle2,
                                ),
                              ),
                        controller.uploadedProjects.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Projects For now",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xff111a1f)),
                                //height: height,
                                width: width,
                                child: allProjects(
                                  controller.uploadedProjects,
                                  textStyle2,
                                  showBids: true,
                                ),
                              ),
                        controller.completedProjects.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Projects Completed Till now",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xff111a1f)),
                                //height: height,
                                width: width,
                                child: allProjects(
                                    controller.completedProjects, textStyle2),
                              ),
                      ],
                    );
            }),
      ),
    );
  }

  Expanded allProjects(List<ProjectModel> projects, TextStyle textStyle2,
      {bool showBids = false}) {
    return Expanded(
      child: ListView.builder(
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
                      uploaded: showBids,
                    ),
                  ),
                );
              },
              title: Text(
                model.projectName,
                style: textStyle2,
              ),
              subtitle: Text(
                "${model.description} \n ${model.budget}",
                style: textStyle2.copyWith(
                    fontSize: 15, color: Colors.grey.shade300),
              ),
            ),
          ));
        },
        itemCount: projects.length,
      ),
    );
  }
}
