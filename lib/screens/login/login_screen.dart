import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laugh1/constants/constants.dart';
import 'package:laugh1/controllers/auth_controllers/logincontroller.dart';
import 'package:laugh1/screens/login/widgets/inputfield.dart';
import 'package:laugh1/screens/sign_login/widgets/buttons.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black)),
      ),
      backgroundColor: Colors.white,
      body: loginController.obx(
          (login) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: loginController.Login,
                  child: Container(
                    height: Constants.defHeight,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Laugh1",
                                style: GoogleFonts.poppins(
                                    color: Constants.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25)),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                children: [
                                  makeInput(
                                      label: "email",
                                      obscuretext: false,
                                      controller: loginController.mailControl),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  makeInput(
                                      label: "Password",
                                      obscuretext: true,
                                      controller:
                                          loginController.passwordControl),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  LoginButton2(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Don't have an account? "),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed("/signup");
                                        },
                                        child: Text(
                                          "Sign Up",
                                          style: GoogleFonts.poppins(
                                              color: Constants.primaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: Constants.defHeight / 3,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/svg.png"),
                                  fit: BoxFit.cover)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          onError: (error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.connect_without_contact,
                        size: 50, color: Colors.red[700]),
                    SizedBox(
                      height: 15,
                    ),
                    Text(error.toString(),
                        style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                            fontSize: 12))
                  ],
                ),
              )),
    );
  }
}
