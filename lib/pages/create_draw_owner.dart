import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';

class CreateDrawOwnerPage extends StatefulWidget {
  final User user;

  const CreateDrawOwnerPage({super.key, required this.user});

  @override
  State<CreateDrawOwnerPage> createState() => _CreateDrawOwnerPageState();
}

class _CreateDrawOwnerPageState extends State<CreateDrawOwnerPage> {
  TextEditingController countCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Create Tickets',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFF44336), // สีแดงอมชมพู
          elevation: 0,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            // ส่วนตั้งค่าการสร้าง
            const Center(
              child: Text(
                'Create Settings',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'งวดที่',
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: countCtl,
                    decoration: InputDecoration(
                      hintText: 'จำนวนล็อตโต้',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        final count = countCtl.text; // ค่าที่กรอกใน TextField

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("ยืนยันการสร้าง Lotto"),
                              content: Text(
                                "คุณต้องการสร้าง Lotto จำนวน $count ใบใช่หรือไม่?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // ปิด popup
                                  },
                                  child: const Text("ตกลง"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF44336), // สีแดงอมชมพู
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Create',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // ส่วนตัวอย่างล็อตโต้
            const Center(
              child: Text(
                'ตัวอย่างล็อตโต้',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 40),

            Row(
              children: [
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
                              "80",
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
                          "123456",
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

            const SizedBox(height: 70),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  createLotto();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF44336), // สีแดงอมชมพู
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: const Text(
                  'Submit',
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

  Future<void> createLotto() async {
    final url = Uri.parse('$API_ENDPOINT/lotto/create');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "owner_id": widget.user.id,
          "count": countCtl.text,
          "price": 80,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("สำเร็จ"),
                content: Text(
                  "สร้าง Lotto จำนวน ${data['count']} ใบเรียบร้อยแล้ว",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              ),
        );
      } else {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("ผิดพลาด"),
                content: Text("Error: ${response.body}"),
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
      debugPrint("Error: $e");
    }
  }
}
