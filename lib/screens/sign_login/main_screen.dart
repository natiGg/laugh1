import 'package:flutter/material.dart';
import 'package:laugh1/constants/constants.dart';
import 'package:laugh1/screens/sign_login/widgets/buttons.dart';
import 'package:google_fonts/google_fonts.dart';

class SignLogin extends StatelessWidget {
  const SignLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: Constants.defHeight,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Welcome",
                style: GoogleFonts.poppins(
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                height: Constants.defHeight / 3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/svg3.png"),
                        fit: BoxFit.scaleDown)),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: LoginButton(),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: SignUpButton(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
