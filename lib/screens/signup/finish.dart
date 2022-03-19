import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laugh1/constants/constants.dart';
import 'package:laugh1/controllers/auth_controllers/signupcontroller.dart';
import 'package:laugh1/controllers/bindings/bindings.dart';
import 'package:laugh1/screens/signup/widgets/inputfield.dart';
import 'package:laugh1/screens/signup/widgets/loading.dart';
import 'package:laugh1/services/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class FinishSignUp extends StatefulWidget {
  const FinishSignUp({Key? key}) : super(key: key);

  @override
  _FinishSignUpState createState() => _FinishSignUpState();
}

class _FinishSignUpState extends State<FinishSignUp> {
  bool onMaleTap = true;
  bool onFemaleTap = false;
  @override
  void initState() {
    // TODO: implement initState
    onMaleTap = true;
    onFemaleTap = false;

    super.initState();
  }

  String initialCountry = 'ET';
  PhoneNumber number = PhoneNumber(isoCode: 'ET');

  @override
  Widget build(BuildContext context) {
    final signUpcontroller = Get.find<SignUpController>();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          actions: [
            Obx(() => GestureDetector(
                  onTap: () {
                    signUpcontroller.skip.value = true;
                    Future.delayed(Duration(seconds: 3), () {
                      Get.delete<SignUpController>();
                      Get.toNamed("/emailverify");
                      signUpcontroller.processing.value = false;
                    });
                  },
                  child: !signUpcontroller.skip.value
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[100]),
                            child: Center(
                              child: Text(
                                "Skip",
                                style: GoogleFonts.poppins(
                                    color: Constants.primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ColorLoader5(),
                        ),
                ))
          ],
        ),
        body: Form(
          key: signUpcontroller.Finalize,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(children: [
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 20),
                        child: Text("Set up profile",
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
                          "name",
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
                        padding: const EdgeInsets.only(left: 25.0, right: 50.0),
                        child: makeSignInput(
                          obscuretext: false,
                          type: "name",
                          controller: signUpcontroller.nameControl,
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Text(
                          "Phone",
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
                        padding: const EdgeInsets.only(left: 25.0, right: 50.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        Constants.primaryColor.withOpacity(.15),
                                    blurRadius: 3,
                                    offset: Offset(0, 3))
                              ]),
                          child: InternationalPhoneNumberInput(
                            autoFocus: false,
                            inputDecoration: InputDecoration(
                              errorStyle: GoogleFonts.poppins(
                                  color: Colors.red[500],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10),
                              hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey[300],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              border: InputBorder.none,
                            ),
                            onInputChanged: (PhoneNumber number) {
                              // ignore: avoid_print
                              print(number.phoneNumber);
                            },
                            onInputValidated: (bool value) {
                              // ignore: avoid_print
                              print(value);
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.DROPDOWN,
                            ),
                            ignoreBlank: false,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            initialValue: number,
                            textFieldController: signUpcontroller.phoneControl,
                            formatInput: false,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            onSaved: (PhoneNumber number) {
                              // ignore: avoid_print
                              print('On Saved: $number');
                            },
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 25.0, right: 50.0),
                      //   child: makeSignInput(obscuretext: false, type: ""),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 35.0),
                                child: Text(
                                  "Gender",
                                  style: GoogleFonts.poppins(
                                      color: Constants.primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        signUpcontroller.isM.value =
                                            !signUpcontroller.isM.value;
                                        signUpcontroller.isF.value = false;
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: signUpcontroller.isM.value
                                                ? Constants.primaryColor
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Constants.primaryColor
                                                      .withOpacity(.4),
                                                  blurRadius: 5,
                                                  offset: Offset(0, 5))
                                            ]),
                                        child: Center(
                                          child: Text(
                                            "M",
                                            style: TextStyle(
                                                color: signUpcontroller
                                                        .isM.value
                                                    ? Colors.white
                                                    : Constants.primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        signUpcontroller.isF.value =
                                            !signUpcontroller.isF.value;
                                        signUpcontroller.isM.value = false;
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: signUpcontroller.isF.value ==
                                                    false
                                                ? Colors.white
                                                : Constants.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Constants.primaryColor
                                                      .withOpacity(.4),
                                                  blurRadius: 5,
                                                  offset: Offset(0, 5))
                                            ]),
                                        child: Center(
                                          child: Text(
                                            "F",
                                            style: TextStyle(
                                                color: signUpcontroller
                                                            .isF.value ==
                                                        false
                                                    ? Constants.primaryColor
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      signUpcontroller.isM.value = false;
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 35.0),
                                          child: Text(
                                            "Pick Birthdate",
                                            style: GoogleFonts.poppins(
                                                color: Constants.primaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            signUpcontroller.chooseBd();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 25),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Constants.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.white
                                                            .withOpacity(.4),
                                                        blurRadius: 5,
                                                        offset: Offset(0, 5))
                                                  ]),
                                              child: Center(
                                                  child: Icon(
                                                !signUpcontroller
                                                        .bdChecked.value
                                                    ? Icons.cake
                                                    : Icons.check,
                                                color: Colors.white,
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      signUpcontroller.showPicker(context);
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            "Choose Profile picture",
                                            style: GoogleFonts.poppins(
                                                color: Constants.primaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 25),
                                          child: signUpcontroller
                                                  .imagesList.isEmpty
                                              ? Container(
                                                  width: 150,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    .4),
                                                            blurRadius: 5,
                                                            offset:
                                                                Offset(0, 5))
                                                      ]),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 7.0),
                                                        child: Center(
                                                            child: Icon(
                                                          signUpcontroller
                                                                  .imagesList
                                                                  .isEmpty
                                                              ? Icons.camera
                                                              : Icons.check,
                                                          color:
                                                              Colors.grey[500],
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Constants
                                                                .primaryColor
                                                                .withOpacity(
                                                                    .4),
                                                            blurRadius: 5,
                                                            offset:
                                                                Offset(0, 5))
                                                      ]),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Image.file(
                                                          signUpcontroller
                                                              .imagesList[0],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: Colors.black
                                                              .withOpacity(.3),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Icon(
                                                          Icons.camera,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 30.0),
                          child: proceed(
                            isFinish: true,
                          )),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {}
}
