import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/model/response/wallet_balance_get_res.dart';

class WalletPage extends StatefulWidget {
  final User user;
  final Wallet wallet;

  const WalletPage({super.key, required this.user, required this.wallet});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int _balance = 0;
  int _selectedAmount = 50;

  @override
  void initState() {
    super.initState();
    loadBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Wallet'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Center(
              child: const Text(
                'Total Money',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Text(
                '${_balance.toString()} บาท',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAmountButton(20),
                _buildAmountButton(50),
                _buildAmountButton(100),
                _buildAmountButton(200),
                _buildAmountButton(500),
                _buildAmountButton(1000),
              ],
            ),
            SizedBox(height: 32.h),
            Center(
              child: const Text(
                'จำนวนเงิน',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Text(
                '$_selectedAmount บาท',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  topUp(_selectedAmount);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF06292),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                child: Text(
                  'ยืนยัน',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountButton(int amount) {
    bool isSelected = (_selectedAmount == amount);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAmount = amount;
        });
      },
      child: Container(
        width: 50.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5C6BC0) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20.r),
          border:
              isSelected
                  ? Border.all(color: Colors.blue.shade200, width: 2.w)
                  : null,
        ),
        child: Center(
          child: Text(
            '$amount',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black87,
            ),
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
        debugPrint("Failed to load balance: ${res.body}");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> topUp(int amount) async {
    try {
      final response = await http.post(
        Uri.parse("$API_ENDPOINT/wallet/topup"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"user_id": widget.user.id, "amount": amount}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _balance = data["balance"];
        });
        loadBalance();

        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("สำเร็จ"),
                content: Text(
                  "เติมเงิน ${amount} บาท\nยอดเงินคงเหลือ: ${data["balance"]}",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("ตกลง"),
                  ),
                ],
              ),
        );
      } else {
        debugPrint("Top-up failed: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      debugPrint("Error in topUp: $e");
    }
  }
}
