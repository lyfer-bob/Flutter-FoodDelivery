import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/service/route/route_page.dart';
import '../../data/repositoryiml/login_repositoryIml.dart';
import '../../models/index.dart';
import '../menu/menu_controller.dart';

class LoginController extends GetxController {
  LoginRepositoryIml? repo;
  LoginController({this.repo});

  var loginModel = Loginmodel().obs;
  var isLoadingLogin = false.obs;
  var errorLoading = false.obs;

  LoginRepositoryIml ctr = LoginRepositoryIml();
  MenuController ctr2 = MenuController();
  final email = TextEditingController().obs;
  final password = TextEditingController().obs;

  var loginbody = Login();
  var obscureText = true.obs;
  var stsLogin = false.obs;

  Future init() async {
    isLoadingLogin.value = false;
    errorLoading.value = false;
    // ctr2.init();
  }

  Future<void> loginAction(BuildContext context) async {
    if (ctr.validateData(email.value.text, password.value.text, context)) {
      loginbody.userNameOrEmailAddress = email.value.text;
      loginbody.password = password.value.text;

      Get.toNamed(SDBRoutes.menuPage);

      try {
        loginModel.value = await ctr.requestLogin(loginbody);
      } catch (e) {
        print('error data');
        // errorLoading = true.obs;
        errorLoading = false.obs; // mock
      }
      isLoadingLogin.value = true;
    }
  }

  void visiblePassword(bool value) {
    obscureText.value = value;
  }

  void changeStsLogin() {
    stsLogin.value = ctr.getStsLogin(email.value.text, password.value.text);
  }
}
