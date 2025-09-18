import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ปุ่ม "Reset Draw"
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    confirmDelete();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF44336), // สีแดงอมชมพู
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Reset Draw',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ปุ่ม "Reset the WORLD!!!!"
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF44336), // สีแดงอมชมพู
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Reset the WORLD!!!!',
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
        body: '{"owner_id": ${widget.user.id}}',
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
}
