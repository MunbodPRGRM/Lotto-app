import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/request/user_login_post_req.dart';
import 'package:lotto_app/pages/catalog.dart';
import 'package:lotto_app/pages/forgetpassword.dart';
import 'package:lotto_app/pages/home.dart';
import 'package:lotto_app/pages/loading.dart';
import 'package:lotto_app/pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();

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
                  'assets/images/lotto_icon.png',
                  width: 276,
                  height: 276,
                ),
                const Text(
                  'Lotto Application',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Righteous',
                  ),
                ),
                const SizedBox(height: 64),
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
                const SizedBox(height: 36),
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
                const SizedBox(height: 45),
                SizedBox(
                  width: 354,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFFFF1843),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: forgotpassword,
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Change Password.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextButton(
                      onPressed: register,
                      child: const Text(
                        'Sign Up Now',
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
    UserLoginPostRequest req = UserLoginPostRequest(
      username: usernameCtl.text,
      password: passwordCtl.text,
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoadingPage()),
    );

    http
        .post(
          Uri.parse('$API_ENDPOINT/users/login'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: userLoginPostRequestToJson(req),
        )
        .then((value) {
          if (value.statusCode == 200) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            // แสดงข้อความผิดพลาด
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Login Failed'),
                    content: const Text('Invalid username or password.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
        })
        .catchError((error) {
          // Handle network or other errors
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text('An error occurred: $error'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        });
  }

  void forgotpassword() {
    // Handle forgot password action
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgetPassword()),
    );
  }

  void register() {
    // Navigate to the registration page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }
}
