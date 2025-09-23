import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Add this import

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
        preferredSize: Size.fromHeight(100.h), // Use h for height
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Draw',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp, // Use sp for font size
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFF44336),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w), // Use w for padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Draw Settings',
                style: TextStyle(
                  fontSize: 16.sp, // Use sp for font size
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.h), // Use h for height

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'ประเภทการสุ่ม',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r), // Use r for radius
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              value: selectedMode,
              items:
                  drawModes.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.value,
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ), // Use sp for font size
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMode = value;
                });
              },
            ),

            SizedBox(height: 16.h), // Use h for height

            SizedBox(
              width: double.infinity,
              height: 50.h, // Use h for height
              child: ElevatedButton(
                onPressed: () {
                  if (selectedMode != null) {
                    previewDraw(selectedMode!);
                  } else {
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: const Text("แจ้งเตือน"),
                            content: const Text("กรุณาเลือกประเภทการสุ่มก่อน"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF44336),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.r,
                    ), // Use r for radius
                  ),
                ),
                child: Text(
                  'Draw',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp, // Use sp for font size
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h), // Use h for height

            Center(
              child: Text(
                'ผลการจับฉลาก',
                style: TextStyle(
                  fontSize: 16.sp, // Use sp for font size
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.h), // Use h for height

            _buildPrizeRow("รางวัลที่ 1", 6, value: previewResults["1"]),
            _buildPrizeRow("รางวัลที่ 2", 6, value: previewResults["2"]),
            _buildPrizeRow("รางวัลที่ 3", 6, value: previewResults["3"]),
            _buildPrizeRow("เลขท้าย 3 ตัว", 3, value: previewResults["4"]),
            _buildPrizeRow("เลขท้าย 2 ตัว", 2, value: previewResults["5"]),

            SizedBox(height: 32.h), // Use h for height

            SizedBox(
              width: double.infinity,
              height: 50.h, // Use h for height
              child: ElevatedButton(
                onPressed: () {
                  if (selectedMode != null) {
                    confirmDraw(selectedMode!);
                  } else {
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: const Text("แจ้งเตือน"),
                            content: const Text("กรุณาเลือกประเภทการสุ่มก่อน"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF44336),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      25.r,
                    ), // Use r for radius
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 18.sp, // Use sp for font size
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
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
      ), // Use h for vertical padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w, // Use w for width
            child: Text(
              title,
              style: TextStyle(fontSize: 16.sp), // Use sp for font size
            ),
          ),
          SizedBox(width: 8.w), // Use w for width
          Expanded(
            child: Wrap(
              spacing: 8.w, // Use w for horizontal spacing
              runSpacing: 8.h, // Use h for vertical spacing
              children: List.generate(
                numberOfBoxes,
                (index) => Container(
                  width: 32.w, // Use w for width
                  height: 32.h, // Use h for height
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      5.r,
                    ), // Use r for radius
                  ),
                  child:
                      value != null && index < value.length
                          ? Text(
                            value[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp, // Use sp for font size
                            ),
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
      body: jsonEncode({"mode": mode}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        previewResults = Map<String, String>.from(data["preview"]);
      });
    } else {
      final data = jsonDecode(response.body);
      String errorMessage = data["error"] ?? "Unexpected error";

      if (mounted) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text("ไม่สามารถสุ่มได้"),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("ตกลง"),
                  ),
                ],
              ),
        );
      }
      debugPrint("Error: ${response.body}");
    }
  }

  Future<void> confirmDraw(String mode) async {
    if (previewResults.isEmpty) {
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
      return;
    }

    final url = Uri.parse("$API_ENDPOINT/draw/confirm");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mode": mode, "results": previewResults}),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("บันทึกสำเร็จ"),
              content: const Text("ยืนยันสร้างผลรางวัลเรียบร้อย"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
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
