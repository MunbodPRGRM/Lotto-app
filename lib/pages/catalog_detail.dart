import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/lotto_catalog_post_res.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/pages/catalog.dart';
import 'package:lotto_app/pages/home.dart';
import 'package:lotto_app/pages/home_owner.dart';
import 'package:lotto_app/pages/mainscreen.dart';
import 'package:lotto_app/pages/myticket.dart';
import 'package:lotto_app/pages/profile.dart';
import 'package:lotto_app/pages/redeem.dart';

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
  // เพิ่ม state สำหรับ BottomNavigationBar
  int selectedIndex = 1; // ตั้งค่าให้ Catalog เป็นหน้าที่ถูกเลือกอยู่
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    // สร้างลิสต์ของหน้าเพจเหมือนกับใน MainScreenPage
    if (widget.user.role == "owner") {
      pages = [
        HomeOwner(user: widget.user, wallet: widget.wallet),
        CatalogPage(user: widget.user, wallet: widget.wallet),
        MyTicketsPage(user: widget.user, wallet: widget.wallet),
        RedeemPage(user: widget.user, wallet: widget.wallet),
        ProfilePage(user: widget.user, wallet: widget.wallet),
      ];
    } else {
      pages = [
        HomePage(user: widget.user, wallet: widget.wallet),
        CatalogPage(user: widget.user, wallet: widget.wallet),
        MyTicketsPage(user: widget.user, wallet: widget.wallet),
        RedeemPage(user: widget.user, wallet: widget.wallet),
        ProfilePage(user: widget.user, wallet: widget.wallet),
      ];
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    // ใช้ Navigator เพื่อย้อนกลับไปหน้าหลักที่มี BottomNavigationBar
    // และเปลี่ยน tab ไปตาม index ที่เลือก
    Navigator.pop(context); // pop หน้า CatalogDetail นี้ออก
    // และ push หน้า MainScreenPage กลับเข้าไปใหม่ พร้อมกับ index ที่เลือก
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                MainScreenPage(user: widget.user, wallet: widget.wallet),
      ),
    );
  }

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
        title: const Text('Lotto details'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      // 2. ส่วนเนื้อหาหลัก
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Container สำหรับบัตรลอตเตอรี่
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // ส่วนบัตรสีเขียวด้านซ้าย
                  Expanded(
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
                              color:
                                  widget.lotto.status == "sold"
                                      ? Color(0xFFD9D9D9)
                                      : Color(0xFFEDF4D0),
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
                                        "${widget.lotto.price}",
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
                                    "${widget.lotto.number}",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    "1 พฤศจิกายน 2568\n1 November 2025",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    "งวดที่ 1 ชุดที่ 1",
                                    style: TextStyle(fontSize: 12),
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

            const SizedBox(height: 430),

            // ปุ่ม "Buy a ticket"
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: buyTicket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFEECEF), // สีชมพู
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: const Text(
                  'Buy a ticket',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF06292),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) {
          // ไม่ต้อง setState() เพราะเราจะ pop และ push หน้าใหม่เลย
          Navigator.pop(context);
        },
        type: BottomNavigationBarType.fixed,
        items:
            widget.user.role == "owner"
                ? const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt),
                    label: "Catalog",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.confirmation_num),
                    label: "My Tickets",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.card_giftcard),
                    label: "Redeem",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile",
                  ),
                ]
                : const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt),
                    label: "Catalog",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.confirmation_num),
                    label: "My Tickets",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.card_giftcard),
                    label: "Redeem",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile",
                  ),
                ],
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
