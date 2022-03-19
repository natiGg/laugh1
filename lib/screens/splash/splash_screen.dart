import 'package:flutter/material.dart';
import 'package:laugh1/screens/home/home.dart';
import 'package:laugh1/screens/login/login_screen.dart';
import 'package:laugh1/screens/sign_login/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAuth = false;

  @override
  void initState() {
    var d = const Duration(seconds: 3);
    // delayed 3 seconds to next page
    Future.delayed(d, () {
      // to next page and close this page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: isAuth ? HomePage() : const Login(),
          ),
        ),
        (route) => false,
      );
    });
    _checkIfLoggedIn();

    super.initState();
  }

  void _checkIfLoggedIn() async {
    print("object");
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('access_token');

    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        child: Center(
          child: Image.network(
            'https://img.icons8.com/external-bearicons-flat-bearicons/2x/external-login-call-to-action-bearicons-flat-bearicons-1.png',
            height: 160,
            width: 160,
          ),
        ),
      ),
    );
  }
}
