import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/lotto_check_get_res.dart';
import 'package:lotto_app/model/response/lotto_redeem_post.res.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';

class RedeemPage extends StatefulWidget {
  final User user;
  final Wallet wallet;

  const RedeemPage({super.key, required this.user, required this.wallet});

  @override
  State<RedeemPage> createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  List prizes = [];
  List<LottoCheckGetResponse> lottoList = [];
  String? selectedNumber;
  final items = ['Item1', 'Item2', 'Item3'];
  String? value;

  @override
  void initState() {
    super.initState();
    fetchPrizes();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final data = await userLotto();
      setState(() {
        lottoList = data;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  String getPrizeName(int rank) {
    switch (rank) {
      case 1:
        return "รางวัลที่ 1";
      case 2:
        return "รางวัลที่ 2";
      case 3:
        return "รางวัลที่ 3";
      case 4:
        return "เลขท้าย 3 ตัว";
      case 5:
        return "เลขท้าย 2 ตัว";
      default:
        return "อื่น ๆ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child:
            prizes.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // แถบค้นหา
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'โปรดป้อนหมายเลขของคุณ',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // ตารางผลรางวัล
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1.5), // หมวดหมู่
                        1: FlexColumnWidth(1.5), // เลขที่ออก
                        2: FlexColumnWidth(2.0), // รางวัล
                      },
                      children: [
                        // หัวข้อตาราง
                        TableRow(
                          children: [
                            _buildTableCell(
                              'หมวดหมู่',
                              isHeader: true,
                              alignment: TextAlign.start,
                            ),
                            _buildTableCell(
                              'เลขที่ออก',
                              isHeader: true,
                              alignment: TextAlign.center,
                            ),
                            _buildTableCell(
                              'รางวัล',
                              isHeader: true,
                              alignment: TextAlign.end,
                            ),
                          ],
                        ),

                        // แสดงรางวัลทั้งหมด
                        for (var prize in prizes)
                          _buildTableRow(
                            getPrizeName(prize["prize_rank"]),
                            prize["prize_number"].toString(),
                            "${prize["prize_amount"]} บาท",
                          ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 0, // ลดความสูงแนวตั้งลง
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Row(
                          children: [
                            // Prefix Icon ที่ต้องการ
                            const Icon(
                              Icons.confirmation_num_outlined,
                              color: Colors.pink,
                            ),
                            const SizedBox(
                              width: 12,
                            ), // เพิ่มระยะห่างระหว่าง Icon กับ Dropdown
                            Expanded(
                              child: DropdownButton<String>(
                                value: selectedNumber,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                ), // ไอคอนลูกศรปกติ
                                isExpanded: true,
                                hint: const Text(
                                  'โปรดเลือกหมายเลขของท่าน',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                items:
                                    lottoList.map<DropdownMenuItem<String>>((
                                      LottoCheckGetResponse item,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: item.number,
                                        child: Text(item.number),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() => selectedNumber = newValue);
                                },
                                // กำหนด padding ให้เป็น 0 เพื่อลดพื้นที่ว่าง
                                padding: EdgeInsets.zero,
                                // กำหนด style ให้ลดขนาด font ลง
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ปุ่มยืนยัน
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: EnterRedeem,
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

  Future<void> EnterRedeem() async {
    if (selectedNumber == null) {
      // แจ้งผู้ใช้ถ้ายังไม่เลือกเลข
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("ข้อผิดพลาด"),
              content: const Text("กรุณาเลือกหมายเลขล็อตเตอรี่ก่อนแลกรางวัล"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("ปิด"),
                ),
              ],
            ),
      );
      return;
    }

    try {
      final res = await http.post(
        Uri.parse('$API_ENDPOINT/lotto/redeem/${widget.user.id}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"lotto_number": selectedNumber}),
      );

      if (res.statusCode == 200) {
        final result = LottoRedeemPostResponse.fromJson(json.decode(res.body));

        selectedNumber = null;

        // แสดง Dialog แจ้งผลรางวัล
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("แลกรางวัลสำเร็จ"),
                content: Text("คุณได้รับเงินรางวัล ${result.amount} บาท"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("ปิด"),
                  ),
                ],
              ),
        );

        // รีโหลดข้อมูลล็อตเตอรี่ใหม่
        loadData();
      } else {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("ข้อผิดพลาด"),
                content: Text(
                  'ไม่สามารถแลกรางวัลได้: ${res.statusCode}\n${res.body}',
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

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));

  Future<List<LottoCheckGetResponse>> userLotto() async {
    final response = await http.get(
      Uri.parse("$API_ENDPOINT/lotto/check/${widget.user.id}"),
    );

    if (response.statusCode == 200) {
      return lottoCheckGetResponseFromJson(response.body);
    } else {
      throw Exception("Failed to load lotto numbers");
    }
  }

  Future<void> fetchPrizes() async {
    final url = Uri.parse("$API_ENDPOINT/draw/latest");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        prizes = json.decode(response.body);
      });
    }
  }

  // ฟังก์ชันช่วยสร้าง TableRow สำหรับตาราง
  TableRow _buildTableRow(String category, String number, String prize) {
    return TableRow(
      children: [
        _buildTableCell(category, alignment: TextAlign.start),
        _buildTableCell(number, alignment: TextAlign.center),
        _buildTableCell(prize, alignment: TextAlign.end),
      ],
    );
  }

  // ฟังก์ชันช่วยสร้าง Cell สำหรับตาราง
  Widget _buildTableCell(
    String text, {
    bool isHeader = false,
    TextAlign alignment = TextAlign.start,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        textAlign: alignment,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
          color: isHeader ? Colors.black : Colors.black87,
        ),
      ),
    );
  }
}
