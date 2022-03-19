import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laugh1/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      onPressed: () {
        Get.toNamed("/login");
      },
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(50)),
      child: Text("Login",
          style: GoogleFonts.poppins(
              color: Constants.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 20)),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 3, right: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border(
              bottom: BorderSide(color: Colors.black),
              top: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black),
              left: BorderSide(color: Colors.black))),
      child: MaterialButton(
        minWidth: double.infinity,
        height: 60,
        onPressed: () {},
        elevation: 0,
        color: Constants.primaryColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(50)),
        child: Text("Sign Up",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20)),
      ),
    );
  }
}
