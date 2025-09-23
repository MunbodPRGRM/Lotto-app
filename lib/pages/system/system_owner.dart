import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class SystemOwnerPage extends StatefulWidget {
  final User user;

  const SystemOwnerPage({super.key, required this.user});

  @override
  State<SystemOwnerPage> createState() => _SystemOwnerPageState();
}

class _SystemOwnerPageState extends State<SystemOwnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Systems', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFF44336), // สีแดงอมชมพู
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w), // ใช้ .w สำหรับ padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ปุ่ม "Reset Draw"
              SizedBox(
                width: double.infinity,
                height: 50.h, // ใช้ .h สำหรับ height
                child: ElevatedButton(
                  onPressed: () {
                    confirmDelete();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF44336), // สีแดงอมชมพู
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10.r,
                      ), // ใช้ .r สำหรับ borderRadius
                    ),
                  ),
                  child: Text(
                    'Reset Draw',
                    style: TextStyle(
                      fontSize: 18.sp, // ใช้ .sp สำหรับ fontSize
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h), // ใช้ .h สำหรับช่องว่าง
              // ปุ่ม "Reset the WORLD!!!!"
              SizedBox(
                width: double.infinity,
                height: 50.h, // ใช้ .h สำหรับ height
                child: ElevatedButton(
                  onPressed: () {
                    resetSystem();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF44336), // สีแดงอมชมพู
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10.r,
                      ), // ใช้ .r สำหรับ borderRadius
                    ),
                  ),
                  child: Text(
                    'Reset the WORLD!!!!',
                    style: TextStyle(
                      fontSize: 18.sp, // ใช้ .sp สำหรับ fontSize
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> confirmDelete() async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("ยืนยันการลบ"),
            content: const Text("คุณแน่ใจหรือไม่ที่จะลบ Lotto ทั้งหมด?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false), // ไม่ลบ
                child: const Text("ยกเลิก"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true), // ยืนยันลบ
                child: const Text("ลบ", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await deleteAll(); // เรียกฟังก์ชันลบจริง
    }
  }

  Future<void> deleteAll() async {
    final url = Uri.parse('$API_ENDPOINT/lotto/delete-all');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"owner_id": widget.user.id}),
      );

      if (response.statusCode == 200) {
        // ลบเสร็จแล้ว → popup แจ้งเตือน
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("สำเร็จ"),
                content: const Text("ลบข้อมูล Lotto ทั้งหมดแล้ว"),
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

  Future<void> resetSystem() async {
    // ยืนยันก่อนลบ
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("ยืนยัน"),
            content: const Text(
              "คุณแน่ใจหรือไม่ว่าต้องการรีเซ็ตระบบ? ข้อมูลผู้ใช้อื่นและ Lotto ทั้งหมดจะถูกลบ",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("ยกเลิก"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("ยืนยัน"),
              ),
            ],
          ),
    );

    if (confirm != true) return; // ถ้าไม่ยืนยัน ให้หยุด

    try {
      final url = Uri.parse("$API_ENDPOINT/system/reset");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"owner_id": widget.user.id}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("สำเร็จ"),
                content: Text(data["message"]),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
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
