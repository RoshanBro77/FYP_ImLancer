import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:imlancerapp/controller/homepagecontroller.dart';
import 'package:imlancerapp/models/category_model.dart';
import 'package:imlancerapp/models/notification_model.dart';
import 'package:imlancerapp/models/subcategory_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';
import 'package:imlancerapp/view/availablejobs.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
  Map<String, String> categories = {
    "assets/Category/doctor.png": "Doctor",
    "assets/Category/graphic.png": "Graphic & Design",
    "assets/Category/writing.png": "Writing & Translation",
    "assets/Category/premiere.png": "Video & Animation",
    "assets/Category/music.png": "Music & Audio",
    "assets/Category/code.png": "Programming & Tech",
    "assets/Category/database.png": "Data",
    "assets/Category/business.png": "Business",
    "assets/Category/lifestyle.png": "lifestyle",
  };
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<HomePageController>(
          init: HomePageController(),
          builder: (controller) {
            return controller.loading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Container(
                        width: width,
                        margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        height: height * 0.18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Categories",
                              style: textStyle.copyWith(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            Container(
                              height: height * 0.1316,
                              child: ListView.builder(
                                itemCount: controller.category.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  CategoryModel model =
                                      controller.category[index];
                                  return GestureDetector(
                                    onTap: () {
                                      controller
                                          .fetchSubCat(model.id.toString());
                                    },
                                    child: categorytile(model.categoryImage,
                                        model.categoryName),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "Choose Your Sub Category",
                                style: textStyle.copyWith(fontSize: 18),
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () {
                                  return controller.fetchSubCat(
                                      controller.category.first.id.toString());
                                },
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    primary: false,
                                    itemCount: controller.subcategory.length,
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    itemBuilder: (context, index) {
                                      SubCategoryModel model =
                                          controller.subcategory[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AvailableJobs(
                                                          subcategory: model
                                                              .subcategoryName)));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          color: Color(0xff111a1f),
                                          elevation: 10,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Image.network(
                                                    model.subcategoryImage,
                                                    // height: height * 0.142,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Text(
                                                  model.subcategoryName,
                                                  textAlign: TextAlign.center,
                                                  style: textStyle.copyWith(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
          }),
    );
  }

  Container categorytile(String image, String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(2, 5, 2, 0),
      child: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            borderRadius: BorderRadius.circular(360),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              image,
              fit: BoxFit.cover,
              height: 60,
              width: 60,
            ),
          ),
          SizedBox(
            width: 75,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textStyle.copyWith(fontSize: 13, color: Colors.orange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
