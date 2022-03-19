import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class Network {
  final String _url = 'http://192.168.1.7:8000/';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  // ignore: prefer_typing_uninitialized_variables
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    token = localStorage.getString('token');
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);
    return await http.post(uri, body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);

    await _getToken();
    // ignore: avoid_print

    return await http.get(uri, headers: _setHeaders());
  }

  uploadFile(apiUrl, file, stream, length) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);
    await _getToken();
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(_setFileHeaders());
    request.fields["_method"] = "put";
    var multipartFile = http.MultipartFile('profile_picture', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    return await request.send();
  }

  postFile(apiUrl, files, data) async {
    var fullUrl = _url + apiUrl;
    // ignore: prefer_typing_uninitialized_variables
    var uri = Uri.parse(fullUrl);

    await _getToken();
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(_setFileHeaders());
    request.fields["location"] = data["location"].toString();
    request.fields["caption"] = data["caption"].toString();
    request.fields["post_type"] = data["post_type"].toString();
    request.fields["tags"] = data["tags"].toString();
    request.fields["is_image"] = data["is_image"].toString();

    for (var file in files) {
      // ignore: deprecated_member_use
      var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var multipartFile = http.MultipartFile('post_attachment', stream, length,
          filename: basename(file.path));
      request.files.add(multipartFile);
    }

    return await request.send();
  }

  signUp(apiUrl, file, data) async {
    var fullUrl = _url + apiUrl;
    // ignore: prefer_typing_uninitialized_variables
    var uri = Uri.parse(fullUrl);

    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(_setSignUpHeaders());
    request.fields["user"] = data["user"].toString();
    request.fields["name"] = data["name"].toString();
    request.fields["gender"] = data["gender"].toString();
    request.fields["phone_number"] = data["phone_number"].toString();
    request.fields["bod"] = convertDateTimeDisplay(data["bod"]);
    // ignore: deprecated_member_use
    var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    var multipartFile = http.MultipartFile("profile_pic", stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    return await request.send();
  }

  String convertDateTimeDisplay(date) {
    var dateTime = DateTime.parse(date.toString());
    var formatted = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    print(formatted);
    return formatted;
  }

  getpassedData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);

    await _getToken();
    return await http.post(uri, body: jsonEncode(data), headers: _setHeaders());
  }

  getsmallData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);
    print(jsonEncode(data));
    await _getToken();
    return await http.post(uri,
        body: jsonEncode(data), headers: _setsmallHeaders());
  }

  getdeleteData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);

    await _getToken();
    return await http.delete(uri, headers: _setHeaders());
  }

  _setsmallHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
  _setFileHeaders() => {
        'Content-type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
  _setSignUpHeaders() => {
        'Content-type': 'multipart/form-data',
        'Accept': 'application/json',
      };
}
