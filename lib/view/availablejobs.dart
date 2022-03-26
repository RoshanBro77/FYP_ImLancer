import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/controller/fetchsubcategoryjobscontroller.dart';
import 'package:imlancerapp/models/project_readig_model.dart';
import 'package:imlancerapp/view/jobdetails.dart';

class AvailableJobs extends StatelessWidget {
  AvailableJobs({Key? key, required this.subcategory}) : super(key: key);
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
  final String subcategory;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);
    return GetBuilder<FetchSubCategoryJobController>(
        init: FetchSubCategoryJobController(subcategory),
        builder: (controller) {
          return controller.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.subcategoryJobs.length == 0
                  ? Scaffold(
                      backgroundColor: const Color(0xff111a1f),
                      appBar: AppBar(
                        title: Text(subcategory),
                        backgroundColor: Colors.black,
                        elevation: 5,
                      ),
                      body: const Center(
                        child: Text(
                          "No Jobs available",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Scaffold(
                      appBar: AppBar(
                        title: const Text('Available Jobs'),
                        backgroundColor: Colors.black,
                        elevation: 5,
                      ),
                      body: Container(
                        decoration:
                            const BoxDecoration(color: Color(0xff111a1f)),
                        height: height,
                        width: width,
                        child: ListView.builder(
                            itemCount: controller.subcategoryJobs.length,
                            itemBuilder: (context, index) {
                              ProjectReadingModel jobs =
                                  controller.subcategoryJobs[index];
                              return Card(
                                color: const Color(0xff07080a),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            JobDetailsPage(job: jobs),
                                      ),
                                    );
                                  },
                                  title: Text(
                                    jobs.projectName,
                                    style: textStyle2,
                                  ),
                                  trailing: Text(
                                    "Rs ${jobs.budget}",
                                    style: textStyle2,
                                  ),
                                  subtitle: Text(
                                    jobs.description,
                                    style: textStyle2.copyWith(
                                        fontSize: 15,
                                        color: Colors.grey.shade300),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
        });
  }
}
