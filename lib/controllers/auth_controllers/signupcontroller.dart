import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:laugh1/constants/constants.dart';
import 'dart:async';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:laugh1/services/services.dart';

class SignUpController extends GetxController with StateMixin {
  var isM = false.obs;
  var isF = false.obs;
  var processing = false.obs;
  var skip = false.obs;

  var socketError = false.obs;
  var emailExists, unameExists;
  var selectedImage;
  var bdChecked = false.obs;
  var isValid = false.obs;
  var bd;
  var signupId;
  final GlobalKey<FormState> SignUp = GlobalKey<FormState>();
  final GlobalKey<FormState> Finalize = GlobalKey<FormState>();
  var imagesList = <File>[].obs;

  late TextEditingController nameControl,
      unameControl,
      passwordControl,
      confirmControl,
      mailControl,
      phoneControl;
  @override
  void onInit() {
    // TODO: implement onInit
    unameControl = TextEditingController();
    nameControl = TextEditingController();
    passwordControl = TextEditingController();
    confirmControl = TextEditingController();
    mailControl = TextEditingController();
    phoneControl = TextEditingController();
    change(null, status: RxStatus.success());

    super.onInit();
  }

  Future<int> sign_up(data) async {
    try {
      signupId = await RemoteServices.SignUp(data);
    } on Exception catch (e) {
      socketError.value = true;
      change(null, status: RxStatus.error("Something went wrong"));
    }
    return signupId;
  }

  Future<bool> checkEmail(email) async {
    try {
      emailExists = await RemoteServices.checkEmail(email);
      return emailExists;
    } catch (e) {
      socketError.value = true;
      processing.value = false;
      change(null,
          status: RxStatus.error("Something went wrong,we'll fix it soon"));
      throw e;
    }
  }

  Future<bool> checkUname(uname) async {
    try {
      unameExists = await RemoteServices.checkUname(uname);
      return unameExists;
    } catch (e) {
      change(null, status: RxStatus.error("Something went wrong"));

      throw e;
    }
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "please provide a valid Email";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "please provide a name";
    }
    return null;
  }

  String? validateBio(String value) {
    if (value.isEmpty) {
      return "please provide a bio";
    }
    return null;
  }

  String? validateUsername(String value) {
    if (value.isEmpty) {
      return "please provide a Userame";
    }
    return null;
  }

  String? validateBd(String value) {
    if (value.isEmpty) {
      return "please provide a birthday";
    }
    return null;
  }

  String? validatePass(String value) {
    if (!validateStructure(value)) {
      return "please provide a valid password";
    }
    return null;
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void showPicker(context) {
    Get.defaultDialog(
        radius: 25,
        title: "Choose From",
        titleStyle: GoogleFonts.poppins(
            color: Constants.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.bold),
        content: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    selectImagesCamera();
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white.withOpacity(.4),
                                  blurRadius: 5,
                                  offset: Offset(0, 5))
                            ]),
                        child: Center(
                            child: Icon(
                          Icons.camera,
                          color: Colors.grey[500],
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "Camera",
                          style: GoogleFonts.poppins(
                              color: Constants.primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectImagesFile();
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white.withOpacity(.4),
                                  blurRadius: 5,
                                  offset: Offset(0, 5))
                            ]),
                        child: Center(
                            child: Icon(
                          Feather.file,
                          color: Colors.grey[500],
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "File",
                          style: GoogleFonts.poppins(
                              color: Constants.primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }

  void chooseBd() {
    DatePicker.showDatePicker(Get.context!,
        theme: DatePickerTheme(
            containerHeight: 150,
            itemStyle: GoogleFonts.poppins(
                color: Constants.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),
            doneStyle: GoogleFonts.poppins(
                color: Constants.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
        showTitleActions: true,
        minTime: DateTime(1900, 2, 12),
        maxTime: DateTime.now(), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      bdChecked.value = true;
      bd = date;
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  ImagePicker picker = ImagePicker();

  void selectImagesFile() async {
    try {
      imagesList.clear();
      selectedImage = await picker.pickImage(source: ImageSource.gallery);
      File convertedFile = File(selectedImage.path);
      imagesList.add(convertedFile);
      Navigator.of(Get.context!).pop(true);
    } catch (e) {
      print(e.toString());
    }
  }

  void selectImagesCamera() async {
    try {
      imagesList.clear();
      selectedImage = await picker.pickImage(source: ImageSource.camera);
      File convertedFile = File(selectedImage.path);
      imagesList.add(convertedFile);
      Navigator.of(Get.context!).pop(true);
    } catch (e) {
      print(e.toString());
    }
  }
}
