import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/lotto_check_get_res.dart';
import 'package:lotto_app/model/response/lotto_redeem_post.res.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/model/response/user_lotto_get_res.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // เพิ่ม import นี้

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
    super.initState();
    loadData = getAllUserLotto();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user.role == "owner") {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Tickets",
            style: TextStyle(
              fontSize: 20.sp, // ปรับขนาด font
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: Text(
            "ผู้ดูแลระบบไม่ควรซื้อได้",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ), // ปรับขนาด font
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Tickets",
          style: TextStyle(fontSize: 20.sp),
        ), // ปรับขนาด font
        centerTitle: true,
        automaticallyImplyLeading: false,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(12.w), // ปรับ padding
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r), // ปรับขนาด radius
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
              padding: EdgeInsets.all(12.w), // ปรับ padding
              itemCount: filteredUserLotto.length,
              itemBuilder: (context, index) {
                final lotto = filteredUserLotto[index];

                return InkWell(
                  onTap: () {
                    checkUserLotto(lotto.number);
                  },
                  child: Container(
                    height: 180.h, // ปรับความสูง
                    margin: EdgeInsets.only(bottom: 12.h), // ปรับ margin
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ), // ปรับขนาด radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5.r, // ปรับขนาด blur
                          offset: Offset(0, 3.h), // ปรับขนาด offset
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // โลโก้ + ราคา
                        Container(
                          width: 200.w, // ปรับความกว้าง
                          height: 180.h, // ปรับความสูง
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDF4D0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              bottomLeft: Radius.circular(12.r),
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // รูป
                              Image.asset(
                                'assets/images/lotto_icon.png',
                                width: 150.w, // ปรับความกว้าง
                                height: 150.h, // ปรับความสูง
                              ),

                              // ราคา (ทับบนรูป)
                              Positioned(
                                bottom: 0,
                                left: 10.w, // ปรับระยะห่าง
                                child: Column(
                                  children: [
                                    Text(
                                      lotto.price.toString(),
                                      style: TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp, // ปรับขนาด font
                                        height: 0.5,
                                      ),
                                    ),
                                    Text(
                                      'บาท',
                                      style: TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp, // ปรับขนาด font
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
                            padding: EdgeInsets.all(12.w), // ปรับ padding
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12.r),
                                bottomRight: Radius.circular(12.r),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: AutoSizeText(
                                    lotto.number,
                                    style: TextStyle(
                                      fontSize: 30.sp, // 12. ปรับ font size
                                      fontWeight: FontWeight.bold,
                                    ),
                                    minFontSize: 15,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 12.h), // ปรับ height
                                Flexible(
                                  child: AutoSizeText(
                                    "ซื้อเบาๆ รวยหนักๆ\nซื้อหนักๆ รวยเบาๆ",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                    ), // 13. ปรับ font size
                                    minFontSize: 6,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 15.h), // ปรับ height
                                Flexible(
                                  child: AutoSizeText(
                                    "โชคดีมีชัย",
                                    style: TextStyle(fontSize: 12.sp),
                                    minFontSize:
                                        6, // ขนาดฟอนต์เล็กสุดที่อนุญาตให้ย่อได้
                                    maxLines: 1, // จำนวนบรรทัดสูงสุดที่ต้องการ
                                    overflow:
                                        TextOverflow
                                            .ellipsis, // เพิ่มเติมในกรณีที่ข้อความยังล้น
                                  ),
                                ), // 14. ปรับ font size
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

  Future<void> checkUserLotto(String lottoNumber) async {
    try {
      final res = await http.get(
        Uri.parse('$API_ENDPOINT/lotto/check/${widget.user.id}'),
      );

      if (res.statusCode == 200) {
        final results = lottoCheckGetResponseFromJson(res.body);
        final prize =
            results.where((r) => r.number == lottoNumber).isNotEmpty
                ? results.where((r) => r.number == lottoNumber).first
                : null;

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
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('ปิด'),
                ),
                if (prize != null)
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await redeemLotto(lottoNumber);
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

  Future<void> redeemLotto(String lottoNumber) async {
    try {
      final res = await http.post(
        Uri.parse('$API_ENDPOINT/lotto/redeem/${widget.user.id}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"lotto_number": lottoNumber}),
      );

      if (res.statusCode == 200) {
        final result = LottoRedeemPostResponse.fromJson(json.decode(res.body));
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
                      getAllUserLotto();
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
