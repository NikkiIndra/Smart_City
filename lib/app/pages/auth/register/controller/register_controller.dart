import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final isLoading = false.obs;
  final isTrue = true.obs;
  final box = GetStorage();

  List<Map<String, String>> get users {
    final storedUsers = box.read('users') ?? [];
    return List<Map<String, String>>.from(
      storedUsers.map((user) => Map<String, String>.from(user)),
    );
  }

  bool isEmailUsed(String email) {
    return users.any((user) => user['email'] == email.trim());
  }

  void addUser(String email, String password) {
    final newUser = {'email': email.trim(), 'password': password};
    final updatedUsers = [...users, newUser];
    box.write('users', updatedUsers);
    saveUsersToJson(updatedUsers);
  }

  Future<void> saveUsersToJson(List<Map<String, String>> data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/users.json');
    await file.writeAsString(jsonEncode(data), flush: true);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.onClose();
  }
}
