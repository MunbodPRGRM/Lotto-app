import 'package:flutter/material.dart';
import 'package:lotto_app/pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      hintText: 'Name',
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
                    onPressed: () {
                      // Handle login action
                    },
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
                      onPressed: () {},
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
                const SizedBox(height: 97),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 35,
                  children: [
                    Image.asset(
                      'assets/images/facebook_icon.png',
                      width: 14.1,
                      height: 29,
                    ),
                    Image.asset(
                      'assets/images/twitter_icon.png',
                      width: 35.67,
                      height: 29,
                    ),
                    Image.asset(
                      'assets/images/google_icon.png',
                      width: 29.59,
                      height: 29,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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

  void register() {
    // Navigate to the registration page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }
}
