import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/model/response/wallet_balance_get_res.dart';
import 'package:lotto_app/pages/wallet.dart';

class HomePage extends StatefulWidget {
  final User user;
  final Wallet wallet;

  const HomePage({super.key, required this.user, required this.wallet});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  int _balance = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBalance();
  }

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
                    backgroundColor: Colors.blueAccent, // สีพื้นหลังวงกลม
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
                        "${_balance.toString()}.00 Bath",
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

              /// Menu Buttons
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TextButton(
                    onPressed: () {},
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => WalletPage(
                                user: widget.user,
                                wallet: widget.wallet,
                              ),
                        ),
                      );
                    },
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadBalance() async {
    try {
      final res = await http.get(
        Uri.parse("$API_ENDPOINT/wallet/${widget.user.id}/balance"),
      );

      if (res.statusCode == 200) {
        final data = walletBalanceGetResponseFromJson(res.body);
        setState(() {
          _balance = data.balance;
        });
      } else {
        print("Failed to load balance: ${res.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
