import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/controller/readnotificationcontroller.dart';
import 'package:imlancerapp/models/notification_model.dart';
import 'package:imlancerapp/models/project_model.dart';
import 'package:imlancerapp/models/subcategory_model.dart';
import 'package:imlancerapp/view/bidpage.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({Key? key}) : super(key: key);
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);
    return Scaffold(
      body: GetBuilder<ReadNotificationController>(
          init: ReadNotificationController(),
          builder: (controller) {
            return Container(
              decoration: BoxDecoration(color: Color(0xff111a1f)),
              width: width,
              child: controller.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.notifications.isEmpty
                      ? Center(
                          child: Text(
                            "No Notifications",
                            style: textStyle2,
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.notifications.length,
                          itemBuilder: (context, index) {
                            NotificationModel model =
                                controller.notifications[index];

                            return GestureDetector(
                              child: Card(
                                color: Color(0xff07080a),
                                child: ListTile(
                                  onTap: () {},
                                  title: Text(
                                    model.title,
                                    style: textStyle2,
                                  ),
                                  subtitle: Text(
                                    "${model.description}",
                                    style: textStyle2.copyWith(
                                        fontSize: 15,
                                        color: Colors.grey.shade300),
                                  ),
                                  trailing: Text(
                                    DateFormat('MMMM dd, yyyy')
                                        .format(model.date),
                                    style: textStyle2.copyWith(fontSize: 10),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            );
          }),
    );
  }
}
