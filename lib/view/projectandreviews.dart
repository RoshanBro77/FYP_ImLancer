import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/view/bidpage.dart';
import 'package:imlancerapp/view/jobinfo.dart';

import '../controller/myprojectcontroller.dart';
import '../controller/myworkedprojectcontroller.dart';
import '../models/project_model.dart';

class ProjectAndReviewsPage extends StatelessWidget {
  ProjectAndReviewsPage({Key? key}) : super(key: key);
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
  @override
  Widget build(BuildContext context) {
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GetBuilder<MyWorkedProjectController>(
      init: MyWorkedProjectController(),
      builder: (controller) {
        return controller.loading
            ? Center(child: const CircularProgressIndicator())
            : controller.myWorkedProjects.isEmpty
                ? Scaffold(
                    backgroundColor: Color(0xff111a1f),
                    appBar: AppBar(
                      title: Text("Project And Reviews"),
                      backgroundColor: Colors.black,
                      elevation: 5,
                    ),
                    body: Center(
                      child: Text(
                        "Not worked in any Projects",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      backgroundColor: Color(0xff111a1f),
                      appBar: AppBar(
                        title: Text("Project And Reviews"),
                        backgroundColor: Colors.black,
                        elevation: 5,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(30),
                          child: TabBar(
                            tabs: [
                              Center(child: Text("Assigned")),
                              Center(child: Text("Completed")),
                            ],
                          ),
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          Container(
                            height: height / 2.2,
                            decoration: BoxDecoration(color: Color(0xff111a1f)),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: controller.loading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : controller.assignedProjects.isEmpty
                                            ? Center(
                                                child: Text(
                                                  "No Assigned Projects",
                                                  style: textStyle2.copyWith(
                                                      fontSize: 12),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemBuilder: (context, index) {
                                                  ProjectModel model =
                                                      controller
                                                              .assignedProjects[
                                                          index];
                                                  return Card(
                                                    color: Color.fromRGBO(
                                                        7, 8, 10, 1),
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    JobInfo(
                                                              job: controller
                                                                      .assignedProjects[
                                                                  index],
                                                              showReviews: true,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      title: Text(
                                                        model.projectName,
                                                        style: textStyle2,
                                                      ),
                                                      trailing: Text(
                                                        model.projectStatus,
                                                        style:
                                                            textStyle2.copyWith(
                                                          fontSize: 10,
                                                          color: Colors.yellow,
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        "${model.description} \n ${model.budget}",
                                                        style:
                                                            textStyle2.copyWith(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                itemCount: controller
                                                    .assignedProjects.length,
                                              ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: height / 2.2,
                            decoration: BoxDecoration(color: Color(0xff111a1f)),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: controller.loading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : controller.completedProjects.isEmpty
                                            ? Center(
                                                child: Text(
                                                  "No Completed Projects",
                                                  style: textStyle2.copyWith(
                                                      fontSize: 12),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemBuilder: (context, index) {
                                                  ProjectModel model = controller
                                                      .completedProjects[index];
                                                  return (Card(
                                                    color: Color(0xff07080a),
                                                    child: ListTile(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    JobInfo(
                                                              job: controller
                                                                      .completedProjects[
                                                                  index],
                                                              showReviews: true,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      title: Text(
                                                        model.projectName,
                                                        style: textStyle2,
                                                      ),
                                                      trailing: Text(
                                                        model.projectStatus,
                                                        style:
                                                            textStyle2.copyWith(
                                                          fontSize: 10,
                                                          color: Colors.yellow,
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        "${model.description} \n ${model.budget}",
                                                        style:
                                                            textStyle2.copyWith(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),
                                                      ),
                                                    ),
                                                  ));
                                                },
                                                itemCount: controller
                                                    .completedProjects.length,
                                              ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
      },
    );
  }
}
