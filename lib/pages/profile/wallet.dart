import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/model/response/wallet_balance_get_res.dart';
// import 'package:lotto_app/pages/other/search_bank.dart';

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
    // TODO: implement initState
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Total Money
            Center(
              child: const Text(
                'Total Money',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                '${_balance.toString()} บาท',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // เลือกธนาคาร
            // const Text(
            //   'เลือกธนาคาร',
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.black,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 10),

            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => SearchBankPage()),
            //     );
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 16.0,
            //       vertical: 12.0,
            //     ),

            //     decoration: BoxDecoration(
            //       color: Colors.grey[200],
            //       borderRadius: BorderRadius.circular(15.0),
            //     ),
            //     child: Row(
            //       children: const [
            //         Icon(Icons.account_balance_outlined, color: Colors.grey),
            //         SizedBox(width: 10),
            //         Expanded(
            //           child: Text(
            //             'เลือกธนาคารของคุณ',
            //             style: TextStyle(fontSize: 16, color: Colors.grey),
            //           ),
            //         ),
            //         Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 32),

            // ปุ่มเลือกจำนวนเงิน
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

            const SizedBox(height: 32),

            // จำนวนเงินที่เลือก
            const Center(
              child: Text(
                'จำนวนเงิน',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '$_selectedAmount บาท',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Spacer(), // ใช้ Spacer เพื่อดันปุ่มไปด้านล่าง
            // ปุ่มยืนยัน
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  topUp(_selectedAmount);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF06292), // สีชมพู
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: const Text(
                  'ยืนยัน',
                  style: TextStyle(
                    fontSize: 18,
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

  // ฟังก์ชันช่วยสร้างปุ่มเลือกจำนวนเงิน
  Widget _buildAmountButton(int amount) {
    bool isSelected = (_selectedAmount == amount);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAmount = amount;
        });
      },
      child: Container(
        width: 50,
        height: 40,
        decoration: BoxDecoration(
          color:
              isSelected
                  ? const Color(0xFF5C6BC0)
                  : Colors.grey[200], // สีม่วงเข้ม
          borderRadius: BorderRadius.circular(20.0),
          border:
              isSelected
                  ? Border.all(
                    color: Colors.blue.shade200,
                    width: 2,
                  ) // เพิ่มขอบเมื่อเลือก
                  : null,
        ),
        child: Center(
          child: Text(
            '$amount',
            style: TextStyle(
              fontSize: 16,
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
        print("Failed to load balance: ${res.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> showTopUpDialog() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("เติมเงิน"),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "จำนวนเงิน",
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // ปิด popup
                child: const Text("ยกเลิก"),
              ),
              TextButton(
                onPressed: () async {
                  final text = controller.text;
                  if (text.isEmpty) return;

                  final amount = int.tryParse(text);
                  if (amount == null || amount <= 0) return;

                  Navigator.pop(context); // ปิด popup ก่อน

                  await topUp(amount); // เรียก API เติมเงิน
                },
                child: const Text("ยืนยัน"),
              ),
            ],
          ),
    );
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

        // popup แจ้งผลลัพธ์
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
