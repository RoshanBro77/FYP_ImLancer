import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imlancerapp/controller/categorycontroller.dart';
import 'package:imlancerapp/controller/datasavingcontroller.dart';
import 'package:imlancerapp/controller/projectcontroller.dart';
import 'package:imlancerapp/controller/readskillscontroller.dart';
import 'package:imlancerapp/controller/subcategorycontroller.dart';
import 'package:imlancerapp/models/category_model.dart';
import 'package:imlancerapp/models/paymentmodel.dart';
import 'package:imlancerapp/models/profile_model.dart';
import 'package:imlancerapp/models/project_model.dart';
import 'package:imlancerapp/utils/remoteservices.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class CreateProjectPage extends StatefulWidget {
  CreateProjectPage({Key? key}) : super(key: key);

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  Map<String, String> categories = {"Doctor": "conductor", "Momo": "Jhol Momo"};

  TextEditingController projectNameController = TextEditingController();

  TextEditingController projectDescriptionController = TextEditingController();

  TextEditingController projectSkillController = TextEditingController();

  TextEditingController projectBudgetController = TextEditingController();

  TextEditingController projectDeadlineController = TextEditingController();

  TextEditingController projectCategoryController = TextEditingController();

  TextEditingController projectSubCategoryController = TextEditingController();

  File? pickedZipFile;

  @override
  Widget build(BuildContext context) {
    var textStyle = GoogleFonts.robotoSlab(color: Colors.white, fontSize: 24);
    var textStyle2 = textStyle.copyWith(color: Colors.white, fontSize: 18);
    var outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black));
    var inputDecoration = InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder);
    return GetBuilder<CategoryController>(
        init: CategoryController(),
        builder: (categoryController) {
          return categoryController.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GetBuilder<SubCategoryController>(
                  init: SubCategoryController(
                      id: categoryController.category.first.id.toString()),
                  builder: (subcategoryController) {
                    return GetBuilder<SkillsController>(
                        init: SkillsController(),
                        builder: (skillsController) {
                          return GetBuilder<UploadProjectController>(
                              init: UploadProjectController(),
                              builder: (controller) {
                                return Scaffold(
                                  backgroundColor: Color(0xff111a1f),
                                  body: Container(
                                    margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                                    child: ListView(
                                      children: [
                                        Text(
                                          "Create Your Project",
                                          style: textStyle.copyWith(
                                              color: Colors.orange),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Write name of your project",
                                          style:
                                              textStyle2.copyWith(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: projectNameController,
                                          decoration: inputDecoration,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Write more about your project",
                                          style:
                                              textStyle2.copyWith(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller:
                                              projectDescriptionController,
                                          decoration: inputDecoration,
                                          minLines: 2,
                                          maxLines: 5,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Skills Required",
                                          style:
                                              textStyle2.copyWith(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Wrap(
                                          children: [
                                            for (var item in skillsController
                                                .selectedSkills)
                                              GestureDetector(
                                                onTap: () {
                                                  skillsController
                                                      .selectedSkills
                                                      .remove(item);
                                                  skillsController.update();
                                                },
                                                child: Chip(
                                                  backgroundColor:
                                                      Colors.orange.shade800,
                                                  label: Text(item),
                                                ),
                                              ),
                                          ],
                                        ),
                                        DropdownButtonFormField<String>(
                                          decoration: inputDecoration,
                                          items: [
                                            for (var item
                                                in skillsController.skills)
                                              DropdownMenuItem(
                                                child: Text(item.skillName),
                                                value: item.skillName,
                                              )
                                          ],
                                          onChanged: (value) {
                                            projectSkillController.text =
                                                value!;
                                            skillsController
                                                .insertSelection(value);
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Budget",
                                          style:
                                              textStyle2.copyWith(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: projectBudgetController,
                                          decoration: inputDecoration,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Deadline",
                                          style:
                                              textStyle2.copyWith(fontSize: 16),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2024),
                                            ).then((value) {
                                              projectDeadlineController.text =
                                                  value.toString();
                                              // DateFormat('yyyy MMMM dd').format(value!);
                                            });
                                          },
                                          child: TextFormField(
                                            controller:
                                                projectDeadlineController,
                                            enabled: false,
                                            decoration:
                                                inputDecoration.copyWith(
                                                    hintText: "Pick up date"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Choose Category",
                                          style:
                                              textStyle2.copyWith(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),

                                        DropdownButtonFormField<CategoryModel>(
                                          decoration: inputDecoration,
                                          items: [
                                            for (var item
                                                in categoryController.category)
                                              DropdownMenuItem(
                                                child: Text(item.categoryName),
                                                value: item,
                                              )
                                          ],
                                          onChanged: (value) {
                                            projectCategoryController.text =
                                                value!.categoryName;
                                            categoryController.selectedCategory
                                                .add(value.categoryName);
                                            subcategoryController
                                                .getSubCategory(
                                                    id2: value.id.toString());
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Choose SubCategory",
                                          style:
                                              textStyle2.copyWith(fontSize: 16),
                                        ),
                                        subcategoryController.loading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : DropdownButtonFormField<String>(
                                                decoration: inputDecoration,
                                                items: [
                                                  for (var item
                                                      in subcategoryController
                                                          .category)
                                                    DropdownMenuItem(
                                                      child: Text(
                                                          item.subcategoryName),
                                                      value:
                                                          item.subcategoryName,
                                                    )
                                                ],
                                                onChanged: (value) {
                                                  projectSubCategoryController
                                                      .text = value!;
                                                  subcategoryController
                                                      .selectedSubCategory
                                                      .add(value);
                                                  setState(() {});
                                                },
                                              ),
                                        SizedBox(
                                          height: 5,
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                          allowedExtensions: [
                                                    'zip',
                                                    'rar'
                                                  ],
                                                          type:
                                                              FileType.custom);

                                              if (result != null) {
                                                pickedZipFile = File(
                                                    result.files.first.path!);
                                                setState(() {});
                                              } else {
                                                // User canceled the picker
                                              }
                                            },
                                            child:
                                                const Text("Upload Materials"),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.orange.shade800),
                                                shape:
                                                    MaterialStateProperty.all(
                                                        const StadiumBorder())),
                                          ),
                                        ),

                                        pickedZipFile == null
                                            ? Text(
                                                "Pick a file",
                                                style: textStyle2,
                                                textAlign: TextAlign.center,
                                              )
                                            : Text(
                                                pickedZipFile!.path
                                                    .split('/')
                                                    .last,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final config = PaymentConfig(
                                                amount:
                                                    10000, // Amount should be in paisa
                                                productIdentity: DateTime.now()
                                                    .toIso8601String(),
                                                productName:
                                                    projectNameController.text,
                                                productUrl: '',
                                              );
                                              KhaltiScope.of(context).pay(
                                                config: config,
                                                preferences: [
                                                  PaymentPreference.khalti,
                                                  PaymentPreference.connectIPS,
                                                  PaymentPreference.eBanking,
                                                  PaymentPreference.sct,
                                                ],
                                                onSuccess: (onSuccess) async {
                                                  DatasavingController dsc =
                                                      DatasavingController();
                                                  ProfileModel? profile =
                                                      await dsc.readProfile();
                                                  int projectId = await controller.uploadProject(
                                                      ProjectModel(
                                                          id: 0,
                                                          budget:
                                                              projectBudgetController
                                                                  .text,
                                                          projectCategory:
                                                              projectCategoryController
                                                                  .text,
                                                          projectSubcategory:
                                                              projectSubCategoryController
                                                                  .text,
                                                          projectName:
                                                              projectNameController
                                                                  .text,
                                                          date: DateTime.now(),
                                                          duration: DateTime.parse(projectDeadlineController.text)
                                                              .difference(DateTime
                                                                  .now())
                                                              .inDays
                                                              .toString(),
                                                          deadline: DateTime.parse(
                                                              projectDeadlineController
                                                                  .text),
                                                          clientId: profile!.id
                                                              .toString(),
                                                          freelancerId: "",
                                                          projectStatus: "Uploaded",
                                                          file: "",
                                                          description: projectDescriptionController.text,
                                                          skillId: skillsController.selectedSkills.toString(),
                                                          review: ""),
                                                      pickedZipFile);
                                                  await RemoteServices
                                                      .savePayment(
                                                    PaymentModel(
                                                      id: 0,
                                                      clientId: profile.id,
                                                      amount: int.parse(
                                                          projectBudgetController
                                                              .text),
                                                      status: 'payed',
                                                      date: DateTime.now(),
                                                      account: onSuccess.mobile,
                                                      projectId: projectId,
                                                    ),
                                                  );
                                                },
                                                onFailure: (onFailure) {
                                                  Fluttertoast.showToast(
                                                      msg: "payment failed");
                                                },
                                                onCancel: () {
                                                  Fluttertoast.showToast(
                                                      msg: "payment Cancelled");
                                                },
                                              );
                                            },
                                            child: const Text("Submit"),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.orange.shade800),
                                                shape:
                                                    MaterialStateProperty.all(
                                                        const StadiumBorder())),
                                          ),
                                        ),

                                        // DropdownButtonFormField(items: items, onChanged: onChanged)
                                      ],
                                    ),
                                  ),
                                );
                              });
                        });
                  });
        });
  }
}
