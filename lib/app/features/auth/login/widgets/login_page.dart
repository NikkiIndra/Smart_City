import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iofes_android_apps_smart_city/app/features/auth/register/screens/register_screen.dart';
import 'package:iofes_android_apps_smart_city/app/features/main/screens/main_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Positioned(
            top: 25,
            left: 0,
            child: Text(
              "Let's Goooo",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Text("Lihat berita terbaru dan terupdate"),
          SizedBox(height: 20),
          Center(child: Image.asset("img/logo.jpeg", width: 100, height: 100)),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Get.to(()=> MainScreen());
            },
            child: Text("Login"),
          ),
          SizedBox(height: height * 0.1,),
          Row(
            children: [
              Text(
                "Belum punya akun?",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 10),  
              TextButton(
                onPressed: () {
                  Get.to(() => RegisterScreen());
                },
                child: Text(
                  "Daftar",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
