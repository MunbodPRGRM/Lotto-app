import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/model/response/wallet_balance_get_res.dart';
import 'package:lotto_app/pages/profile/wallet.dart';
import 'package:lotto_app/pages/system/create_draw_owner.dart';
import 'package:lotto_app/pages/system/random_draw_owner.dart';
import 'package:lotto_app/pages/system/system_owner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeOwner extends StatefulWidget {
  final User user;
  final Wallet wallet;
  final Function(int) onTabChange;

  const HomeOwner({
    super.key,
    required this.user,
    required this.wallet,
    required this.onTabChange,
  });

  @override
  State<HomeOwner> createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
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
          padding: EdgeInsets.all(16.w),
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
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Good morning, remember to save today 💰",
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.person, color: Colors.white, size: 20.sp),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Center(
                child: Container(
                  width: 392.w,
                  height: 180.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF607D),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10.r,
                        offset: Offset(0, 5.h),
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
                      SizedBox(height: 8.h),
                      Text(
                        "${_balance.toString()}.00 Bath",
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 43.h),
              Text(
                "Get your money working for you",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.h),
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
                        SizedBox(height: 6.h),
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
                      children: [
                        Icon(
                          Icons.add_circle,
                          size: 40.sp,
                          color: Colors.greenAccent,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Create Draw",
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
                          builder: (context) => RandomDrawOwnerPage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.casino,
                          size: 40.sp,
                          color: Colors.purpleAccent,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Draw Random",
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
                              (context) => SystemOwnerPage(user: widget.user),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings, size: 40.sp, color: Colors.grey),
                        SizedBox(height: 6.h),
                        Text(
                          "System",
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
