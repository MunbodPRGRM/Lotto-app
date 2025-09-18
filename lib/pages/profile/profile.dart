import 'package:flutter/material.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  final Wallet wallet;

  const ProfilePage({super.key, required this.user, required this.wallet});

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
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFEECEF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: signout,
                    child: const Text(
                      "Sign out",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor:
                          widget.user.role == "member"
                              ? Colors.blueAccent
                              : Colors.redAccent, // สีพื้นหลังวงกลม
                      child: Icon(
                        Icons.person, // ไอคอนที่ต้องการ
                        color: Colors.white, // สีของไอคอน
                        size: 90,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  widget.user.role == "member"
                      ? "สถานะ: สมาชิก"
                      : "สถานะ: ผู้ดูแลระบบ",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Username', style: TextStyle(fontSize: 16)),
                    ),
                    buildTextField(usernameCtl),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Email'),
                    ),
                    buildTextField(emailCtl),
                    const SizedBox(height: 15),
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
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.pink),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.pink, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
