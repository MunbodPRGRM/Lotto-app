import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/model/response/wallet_balance_get_res.dart';
import 'package:lotto_app/pages/profile/wallet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class HomePage extends StatefulWidget {
  final User user;
  final Wallet wallet;
  final Function(int) onTabChange;

  const HomePage({
    super.key,
    required this.user,
    required this.wallet,
    required this.onTabChange,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  int _balance = 0;

  @override
  void initState() {
    super.initState();
    loadBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w), // ใช้ .w สำหรับ padding
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
                          fontSize: 20.sp, // ใช้ .sp สำหรับ fontSize
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h), // ใช้ .h สำหรับช่องว่าง
                      Text(
                        "Good morning, remember to save today 💰",
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20.r, // ใช้ .r สำหรับ radius
                    backgroundColor: Colors.blueAccent,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20.sp, // ปรับขนาดไอคอน
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h), // ใช้ .h สำหรับช่องว่าง
              /// Total Money
              Center(
                child: Container(
                  width: 392.w, // ใช้ .w สำหรับ width
                  height: 180.h, // ใช้ .h สำหรับ height
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF607D),
                    borderRadius: BorderRadius.circular(
                      20.r,
                    ), // ใช้ .r สำหรับ borderRadius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10.r, // ใช้ .r สำหรับ blurRadius
                        offset: Offset(0, 5.h), // ใช้ .h สำหรับ offset
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total Money",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h), // ใช้ .h สำหรับช่องว่าง
                      Text(
                        "${_balance.toString()}.00 Bath",
                        style: TextStyle(
                          fontSize: 26.sp, // ใช้ .sp สำหรับ fontSize
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 43.h), // ใช้ .h สำหรับช่องว่าง
              /// Subtitle
              Text(
                "Get your money working for you",
                style: TextStyle(
                  fontSize: 14.sp, // ใช้ .sp สำหรับ fontSize
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 20.h), // ใช้ .h สำหรับช่องว่าง
              /// Menu Buttons
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TextButton(
                    onPressed: () {
                      widget.onTabChange(1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.list_alt, size: 40.sp, color: Colors.black),
                        SizedBox(height: 6.h), // ใช้ .h สำหรับช่องว่าง
                        Text(
                          "Lotto",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
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
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          size: 40.sp,
                          color: Colors.blue,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Wallet",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onTabChange(2);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.confirmation_num,
                          size: 40.sp,
                          color: Colors.pink,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "My Tickets",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onTabChange(3);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.card_giftcard,
                          size: 40.sp,
                          color: Colors.amber,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Redeem",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onTabChange(4);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 40.sp,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
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
