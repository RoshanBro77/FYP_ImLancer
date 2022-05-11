import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/searchcontroller.dart';
import '../models/project_readig_model.dart';
import 'jobdetails.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);
    return Scaffold(
      backgroundColor: Color(0xff111a1f),
      body: GetBuilder<SearchController>(
          init: SearchController(),
          builder: (controller) {
            return Container(
              margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Column(
                children: [
                  Text(
                    "Type Your Search Here",
                    style: textStyle2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      if (value == "") {
                        controller.jobs.clear();
                        controller.update();
                      } else {
                        controller.getResults(value);
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: controller.jobs.length,
                        itemBuilder: (context, index) {
                          ProjectReadingModel project = controller.jobs[index];
                          return Card(
                            color: Colors.white.withOpacity(0.3),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            JobDetailsPage(job: project)));
                              },
                              isThreeLine: true,
                              title: Text(
                                project.projectName,
                                style: textStyle2.copyWith(
                                    color: Colors.orange, fontSize: 15),
                              ),
                              subtitle: Text(
                                project.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: textStyle2.copyWith(fontSize: 13),
                              ),
                              trailing: Text(
                                "Rs. ${project.budget}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          }),
    );
  }
}
