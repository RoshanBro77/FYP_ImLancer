import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/view/accountsetting.dart';
import 'package:imlancerapp/view/changepassword.dart';
import 'package:imlancerapp/view/editprofile.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key, required this.profile}) : super(key: key);
  ProfileModel profile;
  var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
  // Map<String, String> setting = {
  //   "Edit Your Profile": "/editprofile",
  //   "Change Your Password": "",
  //   "Notification Setting": "",
  //   "Account Setting": "",
  // };
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Setting"),
        backgroundColor: Colors.black,
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xff111a1f)),
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Card(
                color: Color(0xff07080a),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfilePage(profile: profile)));
                  },
                  title: Text(
                    "Edit Your Profile",
                    style: textStyle2,
                  ),
                ),
              ),
              Card(
                color: Color(0xff07080a),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword()));
                  },
                  title: Text(
                    "Change Your Password",
                    style: textStyle2,
                  ),
                ),
              ),
              Card(
                color: Color(0xff07080a),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountSetting()));
                  },
                  title: Text(
                    "Account Setting",
                    style: textStyle2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
