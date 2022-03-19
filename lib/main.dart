import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:laugh1/controllers/auth_controllers/logincontroller.dart';
import 'package:laugh1/controllers/bindings/bindings.dart';
import 'package:laugh1/screens/home/home.dart';
import 'package:laugh1/screens/login/login_screen.dart';
import 'package:laugh1/screens/sign_login/main_screen.dart';
import 'package:laugh1/screens/signup/email_verification.dart';
import 'package:laugh1/screens/signup/finish.dart';
import 'package:laugh1/screens/signup/signup_screen.dart';
import 'package:laugh1/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

void main() {
  LoginController loginController = Get.put(LoginController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: "laugh1",
    home: SplashScreen(),
    getPages: [
      GetPage(
          name: "/presign", page: () => SignLogin(), binding: AuthBindings()),
      GetPage(name: "/login", page: () => Login(), binding: AuthBindings()),
      GetPage(name: "/signup", page: () => SignUp(), binding: AuthBindings()),
      GetPage(
          name: "/finishsignup",
          page: () => FinishSignUp(),
          binding: AuthBindings()),
      GetPage(
          name: "/emailverify",
          page: () => EmailSent(),
          binding: AuthBindings()),
      GetPage(name: "/home", page: () => HomePage(), binding: AuthBindings()),
    ],
  ));
}
