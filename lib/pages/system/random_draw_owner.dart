import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';

class RandomDrawOwnerPage extends StatefulWidget {
  const RandomDrawOwnerPage({super.key});

  @override
  State<RandomDrawOwnerPage> createState() => _RandomDrawOwnerPageState();
}

class _RandomDrawOwnerPageState extends State<RandomDrawOwnerPage> {
  Map<String, String> previewResults = {};

  String? selectedMode;

  final Map<String, String> drawModes = {
    "ลอตโต้ทั้งหมด": "all_numbers",
    "ลอตโต้ที่ขายไปแล้ว": "sold_only",
  };

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
          title: const Text('Draw', style: TextStyle(color: Colors.white)),
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
            // ส่วนตั้งค่าการจับสลาก
            const Center(
              child: Text(
                'Draw Settings',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown สำหรับประเภทการสุ่ม
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'ประเภทการสุ่ม',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              value: selectedMode,
              items:
                  drawModes.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.value, // ส่งค่าไป API
                      child: Text(entry.key), // แสดงชื่อภาษาไทย
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMode = value;
                });
              },
            ),

            const SizedBox(height: 16),

            // ปุ่ม Draw
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedMode != null) {
                    previewDraw(
                      selectedMode!,
                    ); // ใส่ ! เพื่อบอกว่ามั่นใจว่าไม่ null
                  } else {
                    // ถ้า null อาจแจ้งผู้ใช้เลือกก่อน
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: Text("แจ้งเตือน"),
                            content: Text("กรุณาเลือกประเภทการสุ่มก่อน"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"),
                              ),
                            ],
                          ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF44336), // สีแดงอมชมพู
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Draw',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // ส่วนแสดงผลการจับสลาก
            const Center(
              child: Text(
                'ผลการจับฉลาก',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            _buildPrizeRow("รางวัลที่ 1", 6, value: previewResults["1"]),
            _buildPrizeRow("รางวัลที่ 2", 6, value: previewResults["2"]),
            _buildPrizeRow("รางวัลที่ 3", 6, value: previewResults["3"]),
            _buildPrizeRow("เลขท้าย 3 ตัว", 3, value: previewResults["4"]),
            _buildPrizeRow("เลขท้าย 2 ตัว", 2, value: previewResults["5"]),

            const SizedBox(height: 32),

            // ปุ่ม Submit
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedMode != null) {
                    confirmDraw(
                      selectedMode!,
                    ); // ใส่ ! เพื่อบอกว่ามั่นใจว่าไม่ null
                  } else {
                    // ถ้า null อาจแจ้งผู้ใช้เลือกก่อน
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: Text("แจ้งเตือน"),
                            content: Text("กรุณาเลือกประเภทการสุ่มก่อน"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"),
                              ),
                            ],
                          ),
                    );
                  }
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

  Widget _buildPrizeRow(String title, int numberOfBoxes, {String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(title, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                numberOfBoxes,
                (index) => Container(
                  width: 35,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child:
                      value != null && index < value.length
                          ? Text(
                            value[index],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                          : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> previewDraw(String mode) async {
    final url = Uri.parse("$API_ENDPOINT/draw/preview");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mode": mode}), // "sold_only" หรือ "all_numbers"
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        previewResults = Map<String, String>.from(data["preview"]);
      });
    } else {
      debugPrint("Error: ${response.body}");
    }
  }

  Future<void> confirmDraw(String mode) async {
    if (previewResults.isEmpty) {
      // ถ้าไม่มีผล preview -> แจ้งเตือน
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("ผิดพลาด"),
              content: const Text("กรุณากด Draw ก่อนที่จะยืนยันผลรางวัล"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
      );
      return; // หยุดฟังก์ชัน
    }

    final url = Uri.parse("$API_ENDPOINT/draw/confirm");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mode": mode, "results": previewResults}),
    );

    if (response.statusCode == 200) {
      // final data = jsonDecode(response.body);
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("บันทึกสำเร็จ"),
              content: Text("ยืนยันสร้างผลรางวัลเรียบร้อย"),
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
                  child: const Text("OK"),
                ),
              ],
            ),
      );
      debugPrint("Error: ${response.body}");
    }
  }
}
