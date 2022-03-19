import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:laugh1/services/services.dart';

class LoginController extends GetxController with StateMixin {
  var showP = false.obs;
  var loggedin;
  var authenticating = false.obs;
  late TextEditingController mailControl, passwordControl;
  final GlobalKey<FormState> Login = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    mailControl = TextEditingController();
    passwordControl = TextEditingController();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<List> login(data) async {
    try {
      authenticating(true);
      loggedin = await RemoteServices.login(data);
      authenticating(false);
      return loggedin;
    } catch (e) {
      // change(null,
      //     status:
      //         RxStatus.error("Connection problem or the Server might be down"));
      throw (e);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "please provide a valid Email";
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
}
