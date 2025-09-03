import 'package:flutter/material.dart';

class HomeOwner extends StatefulWidget {
  const HomeOwner({super.key});

  @override
  State<HomeOwner> createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Catalog"),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num),
            label: "My Tickets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: "Redeem",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header (Hello Joseph)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hello Joseph",
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
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/300",
                    ), // ใช้แทนรูปโปรไฟล์
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
                    color: Colors.pinkAccent,
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
                    children: const [
                      Text(
                        "Total Money",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "120,000.00 Bath",
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
                        Icon(
                          Icons.calendar_view_month,
                          size: 40,
                          color: Colors.black,
                        ),
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
                    onPressed: () => print("Create Draw clicked"),
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
                    onPressed: () => print("Draw Random clicked"),
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
                    onPressed: () => print("System clicked"),
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
