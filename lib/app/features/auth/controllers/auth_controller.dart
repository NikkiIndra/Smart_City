import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/loading_widget.dart';
import '../login/models/dataDummy.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKeyRegisterPage = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyRegisterKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  var isFormValid = false.obs;

  bool isPasswordComplex(String password) {
    final regex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return regex.hasMatch(password);
  }

  bool isUserValid(String email, String password) {
    return DataDummy.users.any(
      (user) => user.email == email && user.password == password,
    );
  }
  bool isEmailRegistered(String email) {
    return DataDummy.users.any((user) => user.email == email);
  }
  //  void printAllEmails() {
  //   for (var user in DataDummy.users && DataDummy.email) {
  //     print(user.email);
  //   }
  //   bool login(String email, String password) {
  //   return DataDummy.users.any((user) =>
  //     user.email == email && user.password == password);
  // }

  void validateForm() {
    final isValid1 = formKeyRegisterKey.currentState?.validate() ?? false;
    final isValid2 = formKeyRegisterPage.currentState?.validate() ?? false;
    final isValid3 = formKeyLogin.currentState?.validate() ?? false;
    isFormValid.value = isValid1 || isValid2 || isValid3;
  }

  void submitForm(BuildContext context, String route) {
    final key1State = formKeyRegisterKey.currentState;
    final key2State = formKeyRegisterPage.currentState;
    final key3State = formKeyLogin.currentState;

    final isValid1 = key1State?.validate() ?? false;
    final isValid2 = key2State?.validate() ?? false;
    final isValid3 = key3State?.validate() ?? false;

    if (isValid1 || isValid2 || isValid3) {
      // Simulasi proses pendaftaran
      LoadingWidget.showLoading(
        context,
        message:
            isValid3
                ? "Memproses login..."
                : isValid2
                ? "Memproses verifikasi..."
                : "Memproses pendaftaran...",
      );

      Future.delayed(const Duration(seconds: 3), () {
        LoadingWidget.hideLoading(context);
        Get.offAllNamed(route);
      });
    }
  }
}
