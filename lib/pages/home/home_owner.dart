import 'package:flutter/material.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/pages/system/create_draw_owner.dart';
import 'package:lotto_app/pages/system/random_draw_owner.dart';
import 'package:lotto_app/pages/system/system_owner.dart';

class HomeOwner extends StatefulWidget {
  final User user;
  final Wallet wallet;

  const HomeOwner({super.key, required this.user, required this.wallet});

  @override
  State<HomeOwner> createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello ${widget.user.username}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Good morning, remember to save today 💰",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.redAccent, // สีพื้นหลังวงกลม
                    child: Icon(
                      Icons.person, // ไอคอนที่ต้องการ
                      color: Colors.white, // สีของไอคอน
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Total Money
              Center(
                child: Container(
                  width: 392,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF607D),
                    borderRadius: BorderRadius.circular(20), // มุมโค้งมน
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // สีเงา
                        blurRadius: 10, // ความฟุ้งของเงา
                        offset: const Offset(0, 5), // ตำแหน่งเงา (x, y)
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // จัดกลางแนวตั้ง
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // จัดกลางแนวนอน
                    children: [
                      Text(
                        "Total Money",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "${widget.wallet.balance}.00 Bath",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 43),

              /// Subtitle
              const Text(
                "Get your money working for you",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              /// Menu Buttons (รวมใน GridView เลย)
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TextButton(
                    onPressed: () => print("Lotto clicked"),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.list_alt, size: 40, color: Colors.black),
                        SizedBox(height: 6),
                        Text(
                          "Lotto",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => print("Wallet clicked"),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.account_balance_wallet,
                          size: 40,
                          color: Colors.blue,
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Wallet",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => print("My Tickets clicked"),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.confirmation_num,
                          size: 40,
                          color: Colors.pink,
                        ),
                        SizedBox(height: 6),
                        Text(
                          "My Tickets",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => print("Redeem clicked"),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.card_giftcard,
                          size: 40,
                          color: Colors.amber,
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Redeem",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => print("Profile clicked"),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.person, size: 40, color: Colors.blueAccent),
                        SizedBox(height: 6),
                        Text(
                          "Profile",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  CreateDrawOwnerPage(user: widget.user),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add_circle,
                          size: 40,
                          color: Colors.greenAccent,
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Create Draw",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RandomDrawOwnerPage(),));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.casino,
                          size: 40,
                          color: Colors.purpleAccent,
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Draw Random",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => SystemOwnerPage(user: widget.user),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.settings, size: 40, color: Colors.grey),
                        SizedBox(height: 6),
                        Text(
                          "System",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
