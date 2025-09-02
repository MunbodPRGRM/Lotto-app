import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                const SizedBox(height: 30),
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
                      // Add your onPressed code here!
                    },
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
                const SizedBox(height: 35),
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
                const SizedBox(height: 10),
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
}
