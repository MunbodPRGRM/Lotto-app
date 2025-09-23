import 'package:flutter/material.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Add this import

class ProfilePage extends StatefulWidget {
  final User user;
  final Wallet wallet;
  final Function(int) onTabChange;

  const ProfilePage({
    super.key,
    required this.user,
    required this.wallet,
    required this.onTabChange,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController usernameCtl;
  late TextEditingController emailCtl;

  @override
  void initState() {
    super.initState();
    usernameCtl = TextEditingController(text: widget.user.username);
    emailCtl = TextEditingController(text: widget.user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            20.w,
          ), // Use w for horizontal and vertical padding
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFEECEF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30.r,
                        ), // Use r for radius
                      ),
                    ),
                    onPressed: signout,
                    child: Text(
                      "Sign out",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp, // Use sp for font size
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h), // Use h for vertical spacing
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50.r, // Use r for radius
                      backgroundColor:
                          widget.user.role == "member"
                              ? Colors.blueAccent
                              : Colors.redAccent,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 90.w, // Use w for icon size
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h), // Use h for vertical spacing
                Text(
                  widget.user.role == "member"
                      ? "สถานะ: สมาชิก"
                      : "สถานะ: ผู้ดูแลระบบ",
                  style: TextStyle(
                    fontSize: 16.sp, // Use sp for font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.h), // Use h for vertical spacing
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 8.h,
                      ), // Use w and h for padding
                      child: Text(
                        'Username',
                        style: TextStyle(fontSize: 16.sp),
                      ), // Use sp for font size
                    ),
                    buildTextField(usernameCtl),
                    SizedBox(height: 15.h), // Use h for vertical spacing
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 8.h,
                      ), // Use w and h for padding
                      child: Text(
                        'Email',
                        style: TextStyle(fontSize: 16.sp),
                      ), // Use sp for font size
                    ),
                    buildTextField(emailCtl),
                    SizedBox(height: 15.h), // Use h for vertical spacing
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signout() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Widget buildTextField(TextEditingController textEditingController) {
    return TextField(
      controller: textEditingController,
      readOnly: true,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.sp,
        ), // Use sp for font size
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
            width: 1.w,
          ), // Use w for border width
          borderRadius: BorderRadius.circular(30.r), // Use r for radius
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pink,
            width: 2.w,
          ), // Use w for border width
          borderRadius: BorderRadius.circular(30.r), // Use r for radius
        ),
      ),
    );
  }
}
