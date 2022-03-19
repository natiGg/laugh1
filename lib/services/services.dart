import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:laugh1/api/api.dart';
import 'package:laugh1/screens/signup/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteServices {
  static var res, data, ar_tokens;
  static Future<List> login(data) async {
    try {
      res = await Network().getsmallData(data, "auth/login/");

      var body = json.decode(res.body);
      if (res.statusCode == 200) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        try {
          var tokens = body["tokens"].toString().replaceAll("'", '"');
          print(tokens);
          ar_tokens = json.decode(tokens);
          print(ar_tokens["refresh"]);
        } catch (e) {
          print(e);
        }
        localStorage.setString('access_token', ar_tokens["access"]);
        localStorage.setString('refresh_token', ar_tokens["refresh"]);

        return [res.statusCode];
      } else if (res.statusCode == 401) {
        return [res.statusCode, body["detail"].toString()];
      } else {
        return [res.statusCode, body["detail"].toString()];
      }
    } catch (e) {
      throw Exception('Failed to login user');
    }
  }

  static Future<List> fetchSuggestions(uname) async {
    print("here inside suggestions");
    data = {"username": uname};
    if (uname != "") {
      res = await Network().getsmallData(data, "auth/uname-suggest/");
      var body = json.decode(res.body);
      print(res.statusCode);
      if (res.statusCode == 201) {
        print(body);
        return body["data"];
      } else {
        throw Exception('Failed to load Feed');
      }
    } else {
      return [];
    }
  }

  static Future<bool> checkEmail(email) async {
    data = {"email": email.toString()};
    if (email != "") {
      res = await Network().getsmallData(data, "auth/email-checker/");

      var body = json.decode(res.body);
      print(res.statusCode);
      if (res.statusCode == 200) {
        print(body);
        return false;
      } else if (res.statusCode == 404) {
        print("email can be used");
        return true;
      } else {
        throw Exception('Failed to check email');
      }
    } else {
      throw Exception('Failed to check email');
    }
  }

  static Future<bool> checkUname(uname) async {
    data = {"username": uname};
    if (uname != "") {
      res = await Network().getsmallData(data, "auth/uname-checker/");

      var body = json.decode(res.body);
      print(res.statusCode);
      if (res.statusCode == 200) {
        print(body);
        return false;
      } else if (res.statusCode == 404) {
        return true;
      } else {
        throw Exception('Failed to check uname');
      }
    } else {
      throw Exception('Failed to check uname');
    }
  }

  static Future<int> SignUp(data) async {
    if (data != "") {
      res = await Network().getsmallData(data, "auth/register/");

      var body = json.decode(res.body);
      print(res.statusCode);
      if (res.statusCode == 201) {
        print(body);
        return body["data"]["id"];
      } else {
        print(body);
        throw Exception('Failed to register user');
      }
    } else {
      throw Exception('Failed to register user');
    }
  }

  static Future<String> setUpProfile(var image, var data) async {
    print(data);
    // create multipart request
    res = await Network().signUp("auth/update/", image, data);
    print(res.statusCode.toString());
    if (res.statusCode == 200) {
      res.stream.transform(utf8.decoder).listen((value) {});
      return res.statusCode.toString();
    } else {
      print(jsonDecode(res.body));
      throw Exception("can't signup");
    }
  }
}
