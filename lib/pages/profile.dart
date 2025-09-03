import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String gender = "Male";
  TextEditingController firstNameCtl = TextEditingController(text: "meepo");
  TextEditingController lastNameCtl = TextEditingController(text: "meepo");
  TextEditingController emailCtl = TextEditingController(
    text: "meepo22@gmail.com",
  );
  TextEditingController dobCtl = TextEditingController(
    text: "10 November 2005",
  );

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
                  child: TextButton(
                    onPressed: () {},
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
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/300",
                      ),
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.pink,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                buildTextField("First Name", firstNameCtl),
                const SizedBox(height: 15),
                buildTextField("Last Name", lastNameCtl),
                const SizedBox(height: 15),
                buildTextField("E-mail", emailCtl),
                const SizedBox(height: 15),
                buildTextField(
                  "Date of Birth",
                  dobCtl,
                  suffix: const Icon(Icons.calendar_today, color: Colors.pink),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Gender",
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    genderButton("Male"),
                    const SizedBox(width: 10),
                    genderButton("Female"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        suffixIcon: suffix,
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

  Widget genderButton(String value) {
    final isSelected = gender == value;
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () {
          setState(() {
            gender = value;
          });
        },
        icon:
            isSelected
                ? const Icon(Icons.check_circle, color: Colors.white)
                : const Icon(Icons.circle_outlined, color: Colors.pink),
        label: Text(value),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: isSelected ? Colors.pink : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.pink,
          side: const BorderSide(color: Colors.pink),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
