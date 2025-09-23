import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/lotto_catalog_post_res.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // เพิ่ม import นี้เข้ามา

class CatalogDetail extends StatefulWidget {
  final User user;
  final Wallet wallet;
  final LottoCatalogPostResponse lotto;

  CatalogDetail({
    super.key,
    required this.user,
    required this.wallet,
    required this.lotto,
  });

  @override
  State<CatalogDetail> createState() => _CatalogDetailState();
}

class _CatalogDetailState extends State<CatalogDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. ส่วน AppBar ด้านบน
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Lotto details',
          style: TextStyle(fontSize: 18.sp),
        ), // ปรับขนาด font
        elevation: 0,
      ),

      // 2. ส่วนเนื้อหาหลัก
      body: Padding(
        padding: EdgeInsets.all(16.w), // ปรับขนาด padding
        child: Column(
          children: [
            // Container สำหรับบัตรลอตเตอรี่
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r), // ปรับขนาด radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2.r, // ปรับขนาด radius
                    blurRadius: 5.r, // ปรับขนาด radius
                    offset: Offset(0, 3.h), // ปรับขนาด offset
                  ),
                ],
              ),
              child: Row(
                children: [
                  // ส่วนบัตรด้านซ้าย
                  Expanded(
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
                            blurRadius: 5.r, // ปรับขนาด radius
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
                              color:
                                  widget.lotto.status == "sold"
                                      ? const Color(0xFFD9D9D9)
                                      : const Color(0xFFEDF4D0),
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
                                        "${widget.lotto.price}",
                                        style: TextStyle(
                                          color: Colors.pink,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp, // ปรับ font size
                                          height: 0.5,
                                        ),
                                      ),
                                      Text(
                                        'บาท',
                                        style: TextStyle(
                                          color: Colors.pink,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp, // ปรับ font size
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
                                      "${widget.lotto.number}",
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
                                      maxLines:
                                          1, // จำนวนบรรทัดสูงสุดที่ต้องการ
                                      overflow:
                                          TextOverflow
                                              .ellipsis, // เพิ่มเติมในกรณีที่ข้อความยังล้น
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ปุ่ม "Buy a ticket"
            SizedBox(
              width: double.infinity,
              height: 50.h, // ปรับความสูง
              child: ElevatedButton(
                onPressed: buyTicket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFEECEF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      25.r,
                    ), // ปรับขนาด radius
                  ),
                ),
                child: Text(
                  'Buy a ticket',
                  style: TextStyle(
                    fontSize: 18.sp, // ปรับ font size
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFF06292),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buyTicket() async {
    try {
      final response = await http.post(
        Uri.parse('$API_ENDPOINT/lotto/buy'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'user_id': widget.user.id,
          'lottery_id': widget.lotto.id,
        }),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('ซื้อสำเร็จ'),
                content: const Text('คุณซื้อเลขล็อตโต้เรียบร้อยแล้ว'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด dialog
                      Navigator.of(context).pop();
                    },
                    child: const Text('ตกลง'),
                  ),
                ],
              ),
        );
      } else {
        debugPrint('Failed to buy lotto: ${response.statusCode}');
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('ซื้อไม่สำเร็จ'),
                content: const Text('ยอดเงินไม่เพียงพอ หรือเกิดข้อผิดพลาด'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('ตกลง'),
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      debugPrint('Error buying lotto: $e');
    }
  }
}
