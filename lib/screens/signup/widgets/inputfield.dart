import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:laugh1/animations/shaking_anim.dart';
import 'package:laugh1/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laugh1/controllers/auth_controllers/signupcontroller.dart';
import 'package:laugh1/models/user/profile_model.dart';
import 'package:laugh1/models/user/user_model.dart';
import 'package:laugh1/screens/signup/widgets/loading.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:laugh1/services/services.dart';

class makeSignInput extends StatefulWidget {
  final bool obscuretext;
  final String type;
  final TextEditingController controller;
  const makeSignInput(
      {Key? key,
      required this.obscuretext,
      required this.type,
      required this.controller})
      : super(key: key);

  @override
  State<makeSignInput> createState() => _makeSignInputState();
}

class _makeSignInputState extends State<makeSignInput> {
  final signUpController = Get.find<SignUpController>();
  bool _hiddenP = false;
  @override
  void initState() {
    _hiddenP = widget.obscuretext;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    blurRadius: 3,
                    offset: Offset(0, 3))
              ]),
          child: Column(
            children: [
              Container(
                  child: widget.type != "password"
                      ? TextFormField(
                          autofocus: false,
                          controller: widget.controller,
                          decoration: InputDecoration(
                              hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey[300],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              border: InputBorder.none,
                              errorStyle: GoogleFonts.poppins(
                                  color: Colors.red[400],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10),
                              suffixIcon: widget.type == "email"
                                  ? Icon(
                                      Feather.mail,
                                      size: 20,
                                    )
                                  : widget.type == "username"
                                      ? Icon(
                                          Feather.user,
                                          size: 20,
                                        )
                                      : widget.type == "name"
                                          ? Icon(
                                              Feather.user_plus,
                                              size: 20,
                                            )
                                          : Icon(
                                              Icons.lock,
                                              size: 20,
                                            )),
                          validator: (validator) {
                            if (widget.type == "email") {
                              return signUpController.validateEmail(validator!);
                            }
                            if (widget.type == "username") {
                              return signUpController
                                  .validateUsername(validator!);
                            }
                            if (widget.type == "name") {
                              return signUpController.validateName(validator!);
                            }
                          },
                        )
                      : TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: widget.controller,
                          obscureText: _hiddenP,
                          decoration: InputDecoration(
                              errorStyle: GoogleFonts.poppins(
                                  color: Colors.red[400],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10),
                              hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey[300],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _hiddenP = !_hiddenP;
                                  });
                                },
                                icon: Icon(
                                  _hiddenP ? Icons.lock : Icons.lock_open,
                                  size: 20,
                                ),
                              )),
                          validator: (validator) {
                            return signUpController.validatePass(validator!);
                          },
                        )
                  // : TypeAheadField(
                  //     textFieldConfiguration: TextFieldConfiguration(
                  //         autofocus: false,
                  //         style: DefaultTextStyle.of(context)
                  //             .style
                  //             .copyWith(fontStyle: FontStyle.italic),
                  //         decoration: InputDecoration(
                  //             hintStyle: GoogleFonts.poppins(
                  //                 color: Colors.grey[300],
                  //                 fontWeight: FontWeight.w600,
                  //                 fontSize: 15),
                  //             contentPadding: EdgeInsets.symmetric(
                  //                 vertical: 15, horizontal: 15),
                  //             border: InputBorder.none,
                  //             suffixIcon: !widget.obscuretext &&
                  //                     widget.type == "email"
                  //                 ? Icon(
                  //                     Feather.mail,
                  //                     size: 20,
                  //                   )
                  //                 : !widget.obscuretext &&
                  //                         widget.type == "username"
                  //                     ? Icon(
                  //                         Feather.user,
                  //                         size: 20,
                  //                       )
                  //                     : Icon(
                  //                         Icons.lock,
                  //                         size: 20,
                  //                       ))),
                  //     suggestionsCallback: (pattern) async {
                  //       return await RemoteServices.fetchSuggestions(pattern);
                  //     },
                  //     hideOnEmpty: true,
                  //     hideOnError: true,
                  //     itemBuilder: (context, suggestion) {
                  //       return Container(
                  //         child: ListTile(
                  //           title: Text(suggestion.toString(),
                  //               style: GoogleFonts.poppins(
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.w600,
                  //                   fontSize: 12)),
                  //         ),
                  //       );
                  //     },
                  //     onSuggestionSelected: (suggestion) {},
                  //     suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  //       elevation: 0.0,
                  //       color: Constants.primaryColor,
                  //       borderRadius: BorderRadius.circular(25),
                  //     ),
                  //     keepSuggestionsOnLoading: false,
                  //   ),
                  ),
            ],
          ),
        )
      ],
    );
  }
}

class proceed extends StatelessWidget {
  final bool isFinish;
  const proceed({Key? key, required this.isFinish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.find<SignUpController>();

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
            signUpController.processing.value = true;

            if (!isFinish) {
              if (signUpController.SignUp.currentState!.validate()) {
                if (signUpController.passwordControl.text ==
                    signUpController.confirmControl.text) {
                  if (await signUpController
                          .checkEmail(signUpController.mailControl.text) ==
                      true) {
                    Future.delayed(Duration(seconds: 2), () {
                      signUpController.processing.value = false;

                      // Do something
                      Get.defaultDialog(
                          title: "",
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Feather.mail,
                                  size: 60, color: Constants.primaryColor),
                              Text("Email already exists, use another email",
                                  style: GoogleFonts.poppins(
                                      color: Constants.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12))
                            ],
                          ));
                    });
                  } else if (await signUpController
                          .checkUname(signUpController.unameControl.text) ==
                      true) {
                    Future.delayed(Duration(seconds: 2), () {
                      signUpController.processing.value = false;

                      Get.defaultDialog(
                          title: "",
                          titleStyle: GoogleFonts.poppins(
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Feather.user,
                                  size: 60, color: Constants.primaryColor),
                              Text("Username already exists",
                                  style: GoogleFonts.poppins(
                                      color: Constants.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12)),
                              Container(
                                color: Colors.grey[300],
                                height: 1,
                              ),
                              FutureBuilder(
                                  future: RemoteServices.fetchSuggestions(
                                      signUpController.unameControl.text),
                                  builder: (BuildContext ctx,
                                          AsyncSnapshot<List> snapshot) =>
                                      snapshot.hasData
                                          ? SizedBox(
                                              height: 300,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8.0),
                                                      child: Container(
                                                        height: 50,
                                                        child: ListView.builder(
                                                          itemCount: snapshot
                                                              .data!.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                          context,
                                                                      index) =>
                                                                  Card(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child: ListTile(
                                                              onTap: () {
                                                                signUpController
                                                                        .unameControl
                                                                        .text =
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .toString();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);
                                                              },
                                                              leading: Icon(
                                                                Feather.user,
                                                                size: 12,
                                                                color: Constants
                                                                    .primaryColor,
                                                              ),
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              title: Text(
                                                                snapshot.data![
                                                                        index]
                                                                    .toString(),
                                                                style: GoogleFonts.poppins(
                                                                    color: Constants
                                                                        .primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Container(
                                                height: 20,
                                                width: 20,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        Constants.primaryColor,
                                                    strokeWidth: 10,
                                                  ),
                                                ),
                                              ),
                                            ))
                            ],
                          ));
                    });
                  } else {
                    Future.delayed(Duration(seconds: 3), () {
                      signUpController.processing.value = false;
                      var user_data = User(
                              email: signUpController.mailControl.text,
                              username: signUpController.unameControl.text,
                              password: signUpController.passwordControl.text)
                          .toJson();
                      signUpController.sign_up(user_data);
                      Get.toNamed("/finishsignup");
                    });
                  }
                } else {
                  Future.delayed(Duration(seconds: 1), () {
                    signUpController.processing.value = false;
                    Get.defaultDialog(
                        title: "",
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock,
                                size: 80, color: Constants.primaryColor),
                            Text("passwords don't match",
                                style: GoogleFonts.poppins(
                                    color: Constants.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12))
                          ],
                        ));
                  });
                }
              } else {
                signUpController.processing.value = false;
              }
            } else {
              if (signUpController.Finalize.currentState!.validate()) {
                if (!signUpController.bdChecked.value) {
                  Future.delayed(Duration(seconds: 1), () {
                    signUpController.processing.value = false;
                    Get.defaultDialog(
                        title: "",
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cake,
                                size: 50, color: Constants.primaryColor),
                            SizedBox(
                              height: 15,
                            ),
                            Text("please put your birthdate",
                                style: GoogleFonts.poppins(
                                    color: Constants.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12))
                          ],
                        ));
                  });
                } else if (!signUpController.isM.value &&
                    !signUpController.isF.value) {
                  Future.delayed(Duration(seconds: 1), () {
                    signUpController.processing.value = false;
                    Get.defaultDialog(
                        title: "",
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.male,
                                    size: 50, color: Constants.primaryColor),
                                Icon(Icons.female,
                                    size: 50, color: Constants.primaryColor),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("U didn't choose your gender?",
                                style: GoogleFonts.poppins(
                                    color: Constants.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12))
                          ],
                        ));
                  });
                } else if (signUpController.imagesList.isEmpty) {
                  Future.delayed(Duration(seconds: 1), () {
                    signUpController.processing.value = false;
                    Get.defaultDialog(
                        title: "",
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera,
                                size: 50, color: Colors.grey[500]),
                            SizedBox(
                              height: 15,
                            ),
                            Text("please add a profile picture",
                                style: GoogleFonts.poppins(
                                    color: Constants.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12))
                          ],
                        ));
                  });
                } else {
                  var gender;
                  if (signUpController.isF.value) {
                    gender = "F";
                  } else {
                    gender = "M";
                  }

                  if (signUpController.signupId > 0) {
                    var data = {
                      "user": signUpController.signupId,
                      "name": signUpController.nameControl.text,
                      "phone_number": signUpController.phoneControl.text,
                      "gender": gender,
                      "bod": signUpController.bd
                    };
                    var finalize = await RemoteServices.setUpProfile(
                        signUpController.imagesList[0], data);
                    if (finalize == "200") {
                      signUpController.processing.value = false;
                      Get.delete<SignUpController>();
                      Get.toNamed("/emailverify");
                    }
                  }
                }
              } else {
                signUpController.processing.value = false;
              }
            }
          },
          elevation: 0,
          color: Constants.primaryColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(50)),
          child: Obx(
            () => !signUpController.processing.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(!isFinish ? "Sign Up" : "Finish",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20)),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        !isFinish ? Icons.arrow_forward_ios : Icons.save,
                        color: Colors.white,
                      ),
                    ],
                  )
                : ColorLoader5(),
          ),
        ));
  }

  void socketError() {
    Get.defaultDialog(
        title: "",
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 50, color: Colors.red[700]),
            SizedBox(
              height: 15,
            ),
            Text("Something Went wrong",
                style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                    fontSize: 12))
          ],
        ));
  }
}
