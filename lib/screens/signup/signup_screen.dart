import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laugh1/constants/constants.dart';
import 'package:laugh1/controllers/auth_controllers/signupcontroller.dart';
import 'package:laugh1/screens/signup/widgets/inputfield.dart';
import 'package:laugh1/services/services.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final signUpcontroller = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        brightness: Brightness.light,
      ),
      body: signUpcontroller.obx(
          (signup) => Form(
                key: signUpcontroller.SignUp,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Stack(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0, top: 20),
                          child: Text("Sign Up",
                              style: GoogleFonts.poppins(
                                  color: Constants.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Text(
                            "Email",
                            style: GoogleFonts.poppins(
                                color: Constants.primaryColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 25.0, right: 50.0),
                          child: makeSignInput(
                            obscuretext: false,
                            type: "email",
                            controller: signUpcontroller.mailControl,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Text(
                            "please try to use a real email otherwise we cannot\nbe able to verify your account.",
                            style: GoogleFonts.poppins(
                                color: Colors.grey[400],
                                fontSize: 10,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Text(
                            "username",
                            style: GoogleFonts.poppins(
                                color: Constants.primaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 25.0, right: 50.0),
                          child: makeSignInput(
                            obscuretext: false,
                            type: "username",
                            controller: signUpcontroller.unameControl,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Text(
                            "Password",
                            style: GoogleFonts.poppins(
                                color: Constants.primaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 25.0, right: 50.0),
                          child: makeSignInput(
                            obscuretext: true,
                            type: "password",
                            controller: signUpcontroller.passwordControl,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Text(
                            "password must be 8 characters long containing  \nupper case,lower case,Special character and a digit ",
                            style: GoogleFonts.poppins(
                                color: Colors.grey[400],
                                fontSize: 10,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Text(
                            "Confirm Password",
                            style: GoogleFonts.poppins(
                                color: Constants.primaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 25.0, right: 50.0),
                          child: makeSignInput(
                            obscuretext: true,
                            type: "password",
                            controller: signUpcontroller.confirmControl,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 30.0),
                            child: proceed(isFinish: false)),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
          onError: (error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_rounded, size: 50, color: Colors.red[700]),
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
