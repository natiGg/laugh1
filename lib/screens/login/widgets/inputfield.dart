import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:laugh1/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laugh1/controllers/auth_controllers/logincontroller.dart';
import 'package:laugh1/controllers/bindings/bindings.dart';
import 'package:laugh1/models/user/user_model.dart';
import 'package:laugh1/screens/home/home.dart';
import 'package:laugh1/screens/signup/widgets/loading.dart';

class makeInput extends StatefulWidget {
  final label;
  final bool obscuretext;
  final TextEditingController controller;
  const makeInput(
      {Key? key,
      required this.label,
      required this.obscuretext,
      required this.controller})
      : super(key: key);

  @override
  State<makeInput> createState() => _makeInputState();
}

class _makeInputState extends State<makeInput> {
  bool _hiddenP = false;
  @override
  void initState() {
    _hiddenP = widget.obscuretext;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Constants.primaryColor.withOpacity(.15),
                    blurRadius: 5,
                    offset: Offset(0, 5))
              ]),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                    controller: widget.controller,
                    obscureText: _hiddenP,
                    decoration: InputDecoration(
                        hintText: widget.label,
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        suffixIcon: !widget.obscuretext
                            ? Icon(
                                Feather.mail,
                                size: 20,
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    _hiddenP = !_hiddenP;
                                  });
                                },
                                icon: Icon(
                                  _hiddenP
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 20,
                                ),
                              )),
                    validator: (validator) {
                      if (_hiddenP) {
                        return loginController.validatePass(validator!);
                      } else if (_hiddenP && widget.label == "email") {
                        return loginController.validateEmail(validator!);
                      }
                    }),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class LoginButton2 extends StatelessWidget {
  const LoginButton2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
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
        onPressed: () async {
          if (loginController.Login.currentState!.validate()) {
            var data = {
              "email": loginController.mailControl.text,
              "password": loginController.passwordControl.text
            };
            await loginController.login(data);
            if (loginController.loggedin[0] == 200) {
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.fade,
              //     child: SecondPage(),
              //   ),
              // );
              Get.to(HomePage(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 300),
                  binding: AuthBindings());
              // Get.toNamed("/home");
            } else if (loginController.loggedin[0] == 401) {
              Get.defaultDialog(
                  title: "",
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          loginController.loggedin[1]
                                  .toString()
                                  .contains("credentials")
                              ? Feather.log_in
                              : Icons.mail_outline,
                          size: 50,
                          color: Colors.red[700]),
                      SizedBox(
                        height: 15,
                      ),
                      Text(loginController.loggedin[1],
                          style: GoogleFonts.poppins(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                              fontSize: 12))
                    ],
                  ));
            }
          }
        },
        elevation: 0,
        color: Constants.primaryColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(50)),
        child: Obx(() => !loginController.authenticating.value
            ? Text("Login",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20))
            : ColorLoader5()),
      ),
    );
  }
}
