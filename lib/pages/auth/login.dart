import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/request/user_login_post_req.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/pages/auth/forgetpassword.dart';
import 'package:lotto_app/pages/mainscreen.dart';
import 'package:lotto_app/pages/auth/register.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  width: 276.w,
                  height: 276.h,
                ),
                const Text(
                  'Lotto Application',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36, // This can remain fixed as it is a title
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Righteous',
                  ),
                ),
                SizedBox(height: 64.h),
                SizedBox(
                  width: 354.w,
                  height: 50.h,
                  child: TextField(
                    controller: usernameCtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontFamily: 'Roboto',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 9.w),
                        child: Image.asset(
                          'assets/images/person_icon.png',
                          width: 24.w,
                          height: 27.h,
                        ),
                      ),
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: Colors.white, width: 2.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: Colors.white, width: 3.w),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 15.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 36.h),
                SizedBox(
                  width: 354.w,
                  height: 50.h,
                  child: TextField(
                    controller: passwordCtl,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontFamily: 'Roboto',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 15.w, right: 9.w),
                        child: Image.asset(
                          'assets/images/password_key.png',
                          width: 35.w,
                          height: 35.h,
                          color: Colors.white,
                        ),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: Colors.white, width: 2.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: Colors.white, width: 3.w),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 15.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 45.h),
                SizedBox(
                  width: 354.w,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: const Color(0xFFFF1843),
                        fontSize: 18.sp,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: forgotpassword,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextButton(
                      onPressed: register,
                      child: Text(
                        'Sign Up Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
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

  void login() async {
    UserLoginPostRequest req = UserLoginPostRequest(
      username: usernameCtl.text,
      password: passwordCtl.text,
    );

    try {
      final response = await http.post(
        Uri.parse('$API_ENDPOINT/users/login'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: userLoginPostRequestToJson(req),
      );
      if (response.statusCode == 200) {
        final data = userLoginPostResponseFromJson(response.body);

        if (data.user.role == "member" || data.user.role == "owner") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      MainScreenPage(user: data.user, wallet: data.wallet),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Unexpected user role.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        }
      } else {
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
    } catch (error) {
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
    }
  }

  void forgotpassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgetPassword()),
    );
  }

  void register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }
}
