import 'package:get/get.dart';
import 'package:laugh1/controllers/auth_controllers/logincontroller.dart';
import 'package:laugh1/controllers/auth_controllers/signupcontroller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
    Get.put(LoginController());
    // TODO: implement dependencies
  }
}
