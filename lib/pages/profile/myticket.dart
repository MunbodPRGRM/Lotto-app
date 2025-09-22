import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/lotto_check_get_res.dart';
import 'package:lotto_app/model/response/lotto_redeem_post.res.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/model/response/user_lotto_get_res.dart';

class MyTicketsPage extends StatefulWidget {
  final User user;
  final Wallet wallet;

  const MyTicketsPage({super.key, required this.user, required this.wallet});

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> {
  List<UserLottoGetResponse> userLottoList = [];
  List<UserLottoGetResponse> filteredUserLotto = [];

  late Future<void> loadData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData = getAllUserLotto();
  }

  @override
  Widget build(BuildContext context) {
    // ถ้าเป็น owner → ไม่เห็น lotto
    if (widget.user.role == "owner") {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Tickets",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          foregroundColor: Colors.black,
        ),
        body: const Center(
          child: Text(
            "ผู้ดูแลระบบไม่ควรซื้อได้",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tickets"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  filteredUserLotto =
                      userLottoList
                          .where((lotto) => lotto.number.contains(value))
                          .toList();
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredUserLotto.length,
              itemBuilder: (context, index) {
                final lotto = filteredUserLotto[index];

                return InkWell(
                  onTap: () {
                    checkUserLotto(lotto.number);
                  },
                  child: Container(
                    height: 180,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // โลโก้ + ราคา
                        Container(
                          width: 200,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Color(0xFFEDF4D0),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // รูป
                              Image.asset(
                                'assets/images/lotto_icon.png',
                                width: 150,
                                height: 150,
                              ),

                              // ราคา (ทับบนรูป)
                              Positioned(
                                bottom: 0,
                                left: 10,
                                child: Column(
                                  children: [
                                    Text(
                                      lotto.price.toString(),
                                      style: TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        height: 0.5,
                                      ),
                                    ),
                                    Text(
                                      'บาท',
                                      style: TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ข้อมูลลอตเตอรี่
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  lotto.number,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 25),
                                Text(
                                  "ซื้อเบาๆ รวยหนักๆ\nซื้อหนักๆ รวยเบาๆ",
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(height: 30),
                                Text(
                                  "โชคดีมีชัย",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getAllUserLotto() async {
    try {
      var res = await http.get(
        Uri.parse('$API_ENDPOINT/lotto/${widget.user.id}'),
      );
      if (res.statusCode == 200) {
        setState(() {
          userLottoList = userLottoGetResponseFromJson(res.body);
          filteredUserLotto = userLottoList;
        });
      } else {
        debugPrint('Failed to load lotto: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('Error loading lotto: $e');
    }
  }

  // ===== ส่วน checkUserLotto ปรับใหม่ =====
  Future<void> checkUserLotto(String lottoNumber) async {
    try {
      final res = await http.get(
        Uri.parse('$API_ENDPOINT/lotto/check/${widget.user.id}'),
      );

      if (res.statusCode == 200) {
        // แปลง JSON เป็น List<LottoCheckGetResponse>
        final results = lottoCheckGetResponseFromJson(res.body);

        // ตรวจว่าเลขนี้ถูกรางวัลหรือไม่
        final prize =
            results.where((r) => r.number == lottoNumber).isNotEmpty
                ? results.where((r) => r.number == lottoNumber).first
                : null;

        // แสดง Dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(prize != null ? 'ถูกรางวัล!' : 'ไม่ถูกรางวัล'),
              content:
                  prize != null
                      ? Text(
                        'รางวัลอันดับ: ${prize.prizeRank}\nจำนวนเงิน: ${prize.prizeAmount} บาท',
                      )
                      : const Text('เลขนี้ไม่ได้รางวัล'),
              actions: [
                // ปุ่มปิด
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('ปิด'),
                ),

                // ปุ่มขึ้นเงิน (ถ้าได้รางวัล)
                if (prize != null)
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context); // ปิด dialog เดิม
                      await redeemLotto(lottoNumber); // เรียกฟังก์ชันขึ้นเงิน
                    },
                    child: const Text(
                      'แลกรางวัล',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
              ],
            );
          },
        );
      } else {
        debugPrint('Failed to check lotto: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('Error checking lotto: $e');
    }
  }

  // ===== ฟังก์ชันขึ้นเงินใหม่ =====
  Future<void> redeemLotto(String lottoNumber) async {
    try {
      final res = await http.post(
        Uri.parse('$API_ENDPOINT/lotto/redeem/${widget.user.id}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"lotto_number": lottoNumber}),
      );

      if (res.statusCode == 200) {
        final result = LottoRedeemPostResponse.fromJson(json.decode(res.body));

        // แสดงผลลัพธ์หลังขึ้นเงินเสร็จ
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("ผลการแลกรางวัล"),
                content: Text("คุณได้รับเงินรางวัล ${result.amount} บาท"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getAllUserLotto(); // รีโหลดลอตเตอรี่ใหม่
                    },
                    child: const Text("ปิด"),
                  ),
                ],
              ),
        );
      } else {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("ข้อผิดพลาด"),
                content: Text(
                  "ไม่สามารถแลกรางวัลได้: ${res.statusCode}\n${res.body}",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("ปิด"),
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("ข้อผิดพลาด"),
              content: Text("เกิดข้อผิดพลาด: $e"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("ปิด"),
                ),
              ],
            ),
      );
    }
  }
}
