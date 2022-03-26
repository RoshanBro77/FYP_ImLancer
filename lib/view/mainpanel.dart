import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:imlancerapp/controller/datasavingcontroller.dart';
import 'package:imlancerapp/controller/mainpanelcontroller.dart';
import 'package:imlancerapp/noficationpage.dart';
import 'package:imlancerapp/view/createproject.dart';
import 'package:imlancerapp/view/searchpage.dart';

import 'homepage.dart';
import 'menu.dart';

class MainPanel extends StatelessWidget {
  MainPanel({Key? key}) : super(key: key);
  var arr = ["Home", "Search", "Create Project", "Notification", "Menu"];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPanelController>(
        init: MainPanelController(),
        builder: (controller) {
          return controller.loading
              ? Center(child: CircularProgressIndicator())
              : GetBuilder<DatasavingController>(
                  init: DatasavingController(),
                  builder: (dataController) {
                    return dataController.reading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Scaffold(
                            backgroundColor: Colors.transparent,
                            bottomNavigationBar: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GNav(
                                  selectedIndex: controller.page,
                                  onTabChange: (value) {
                                    controller.changePage(value);
                                  },
                                  rippleColor: Colors.grey[
                                      800]!, // tab button ripple color when pressed

                                  haptic: true, // haptic feedback
                                  tabBorderRadius: 15,
                                  curve: Curves
                                      .easeOutExpo, // tab animation curves
                                  duration: Duration(
                                      milliseconds:
                                          500), // tab animation duration
                                  gap:
                                      8, // the tab button gap between icon and text
                                  color: Colors.white, // unselected icon color
                                  activeColor: Colors
                                      .orange, // selected icon and text color
                                  backgroundColor: Colors.transparent,
                                  iconSize: 26, // tab button icon size
                                  tabBackgroundColor: Colors
                                      .white, // selected tab background color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5), // navigation bar padding
                                  tabs: [
                                    GButton(
                                      icon: Icons.home,
                                      text: 'Home',
                                    ),
                                    GButton(
                                      icon: Icons.search,
                                      text: 'Search',
                                    ),
                                    GButton(
                                      icon: Icons.add,
                                      text: 'Create Project',
                                    ),
                                    GButton(
                                      icon: Icons.notifications,
                                      text: 'Notification',
                                    ),
                                    GButton(
                                      icon: Icons.menu,
                                      text: 'Menu',
                                    )
                                  ]),
                            ),
                            appBar: AppBar(
                              title: Text(arr[controller.page]),
                              backgroundColor: Colors.black,
                              elevation: 5,
                            ),
                            body: PageView(
                              controller: controller.pageController,
                              onPageChanged: (value) {
                                controller.changePage(value);
                              },
                              children: [
                                HomePage(),
                                SearchPage(),
                                CreateProjectPage(),
                                NotificationPage(),
                                MenuPage(
                                  profile: controller.profileModel!,
                                ),
                              ],
                            ),
                          );
                  });
        });
  }
}
