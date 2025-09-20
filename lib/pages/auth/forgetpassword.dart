import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController nameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  TextEditingController confirmPasswordCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF1843), Color(0xFFFF607D)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                SizedBox(
                  width: 354,
                  height: 50,
                  child: TextField(
                    controller: nameCtl,
                    style: const TextStyle(
                      color: Colors.white, // ตัวอักษรสีขาว
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 9),
                        child: Image.asset(
                          'assets/images/person_icon.png',
                          width: 24,
                          height: 27,
                        ),
                      ),
                      hintText: 'Username',
                      hintStyle: const TextStyle(
                        color: Colors.white, // สี hint
                      ),
                      filled: true,
                      fillColor: Colors.transparent, // ทำให้ใส
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ), // ขอบสีขาว
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 3,
                        ), // ขอบหนาขึ้นตอน focus
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 354,
                  height: 50,
                  child: TextField(
                    controller: emailCtl,
                    style: const TextStyle(
                      color: Colors.white, // ตัวอักษรสีขาว
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 9),
                        child: Image.asset(
                          'assets/images/email_icon.png',
                          width: 24,
                          height: 27,
                        ),
                      ),
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                        color: Colors.white, // สี hint
                      ),
                      filled: true,
                      fillColor: Colors.transparent, // ทำให้ใส
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ), // ขอบสีขาว
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 3,
                        ), // ขอบหนาขึ้นตอน focus
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 354,
                  height: 50,
                  child: TextField(
                    controller: passwordCtl,
                    obscureText: true,
                    style: const TextStyle(
                      color: Colors.white, // ตัวอักษรสีขาว
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 9),
                        child: Image.asset(
                          'assets/images/password_key.png',
                          width: 35,
                          height: 35,
                          color: Colors.white,
                        ),
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        color: Colors.white, // สี hint
                      ),
                      filled: true,
                      fillColor: Colors.transparent, // ทำให้ใส
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ), // ขอบสีขาว
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 3,
                        ), // ขอบหนาขึ้นตอน focus
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 354,
                  height: 50,
                  child: TextField(
                    controller: confirmPasswordCtl,
                    obscureText: true,
                    style: const TextStyle(
                      color: Colors.white, // ตัวอักษรสีขาว
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 9),
                        child: Image.asset(
                          'assets/images/password_key.png',
                          width: 35,
                          height: 35,
                          color: Colors.white,
                        ),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(
                        color: Colors.white, // สี hint
                      ),
                      filled: true,
                      fillColor: Colors.transparent, // ทำให้ใส
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ), // ขอบสีขาว
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 3,
                        ), // ขอบหนาขึ้นตอน focus
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 354,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      resetPassword();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Color(0xFFFF1843),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 300),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Did you have an account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextButton(
                      onPressed: login,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    Navigator.pop(context);
  }

  Future<void> resetPassword() async {
    final name = nameCtl.text.trim();
    final email = emailCtl.text.trim();
    final password = passwordCtl.text.trim();
    final confirmPassword = confirmPasswordCtl.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showAlert("Error", "กรุณากรอกข้อมูลให้ครบทุกช่อง");
      return;
    }

    if (password != confirmPassword) {
      showAlert("Error", "รหัสผ่านไม่ตรงกัน");
      return;
    }

    try {
      final url = Uri.parse("$API_ENDPOINT/users/reset-password");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showAlert("สำเร็จ", data['message']);
        Navigator.pop(context);
      } else {
        showAlert("Error", data['error'] ?? "เกิดข้อผิดพลาด");
      }
    } catch (e) {
      showAlert("Error", e.toString());
    }
  }

  void showAlert(String title, String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }
}
