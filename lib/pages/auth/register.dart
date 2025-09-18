import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/request/user_register_post_req.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameCtl = TextEditingController();
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
                Image.asset(
                  'assets/images/profile1.png',
                  width: 291,
                  height: 291,
                ),
                const SizedBox(height: 44),
                SizedBox(
                  width: 354,
                  height: 50,
                  child: TextField(
                    controller: usernameCtl,
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
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Color(0xFFFF1843),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
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

  void register() async {
    if (passwordCtl.text == confirmPasswordCtl.text) {
      UserRegisterPostRequest req = UserRegisterPostRequest(
        email: emailCtl.text,
        password: passwordCtl.text,
        username: usernameCtl.text,
      );

      http
          .post(
            Uri.parse("$API_ENDPOINT/users/register"),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: userRegisterPostRequestToJson(req),
          )
          .then((value) {
            if (value.statusCode == 200) {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Registration Successful'),
                      content: const Text(
                        'Your account has been created successfully.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // ปิด dialog
                            Navigator.pop(context); // กลับไปหน้า login
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            } else {
              // print("Register Failed");
              // print(response.body);
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Registration Failed'),
                      content: const Text(
                        'Please check your information and try again.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            }
          })
          .catchError((error) {
            // print("Error: $error");
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                      'An error occurred. Please try again later.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          });
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Password Mismatch'),
              content: const Text(
                'The passwords you entered do not match. Please try again.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  void login() {
    Navigator.pop(context);
  }
}
