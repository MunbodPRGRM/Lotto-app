import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Add this import

class CreateDrawOwnerPage extends StatefulWidget {
  final User user;

  const CreateDrawOwnerPage({super.key, required this.user});

  @override
  State<CreateDrawOwnerPage> createState() => _CreateDrawOwnerPageState();
}

class _CreateDrawOwnerPageState extends State<CreateDrawOwnerPage> {
  TextEditingController countCtl = TextEditingController();
  // TextEditingController _dateController = TextEditingController();
  // DateTime? _selectedDate;

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
            'Create Tickets',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
            ), // Use sp for font size
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
            SizedBox(height: 25.h), // Use h for height
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
            SizedBox(height: 25.h), // Use h for height
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 2,
            //       child: TextField(
            //         controller: _dateController,
            //         readOnly: true,
            //         onTap: () => _selectDate(),
            //         decoration: InputDecoration(
            //           hintText: 'งวดที่',
            //           suffixIcon: const Icon(Icons.calendar_today),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10.0),
            //             borderSide: BorderSide.none,
            //           ),
            //           filled: true,
            //           fillColor: Colors.grey[200],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 16.h), // Use h for height
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: countCtl,
                    decoration: InputDecoration(
                      hintText: 'จำนวนล็อตโต้',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ), // Use r for radius
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(width: 8.w), // Use w for width
                // Expanded(
                //   flex: 3,
                //   child: SizedBox(
                //     height: 50,
                //     child: ElevatedButton(
                //       onPressed: () {
                //         final count = countCtl.text;
                //         showDialog(
                //           context: context,
                //           builder: (BuildContext context) {
                //             return AlertDialog(
                //               title: const Text("ยืนยันการสร้าง Lotto"),
                //               content: Text(
                //                 "คุณต้องการสร้าง Lotto จำนวน $count ใบใช่หรือไม่?",
                //               ),
                //               actions: [
                //                 TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).pop();
                //                   },
                //                   child: const Text("ตกลง"),
                //                 ),
                //               ],
                //             );
                //           },
                //         );
                //       },
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: const Color(0xFFF44336),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10.0),
                //         ),
                //       ),
                //       child: const Text(
                //         'Create',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 40.h), // Use h for height
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
            SizedBox(height: 40.h), // Use h for height
            Row(
              children: [
                Container(
                  width: 200.w, // Use w for width
                  height: 180.h, // Use h for height
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF4D0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r), // Use r for radius
                      bottomLeft: Radius.circular(12.r), // Use r for radius
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/lotto_icon.png',
                        width: 150.w, // Use w for width
                        height: 150.h, // Use h for height
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10.w, // Use w for left position
                        child: Column(
                          children: [
                            Text(
                              "80",
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp, // Use sp for font size
                                height: 0.5,
                              ),
                            ),
                            Text(
                              'บาท',
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp, // Use sp for font size
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 200.w,
                    height: 180.h,
                    padding: EdgeInsets.all(12.w), // Use w for padding
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.r), // Use r for radius
                        bottomRight: Radius.circular(12.r), // Use r for radius
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: AutoSizeText(
                            "123456",
                            style: TextStyle(
                              fontSize: 30.sp, // 12. ปรับ font size
                              fontWeight: FontWeight.bold,
                            ),
                            minFontSize: 15,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 12.h), // Use h for height
                        Flexible(
                          child: AutoSizeText(
                            "ซื้อเบาๆ รวยหนักๆ\nซื้อหนักๆ รวยเบาๆ",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ), // Use sp for font size
                            minFontSize: 6,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 15.h), // Use h for height
                        Flexible(
                          child: AutoSizeText(
                            "โชคดีมีชัย",
                            style: TextStyle(fontSize: 12.sp),
                            minFontSize: 6,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ), // Use sp for font size
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70.h), // Use h for height
            SizedBox(
              width: double.infinity,
              height: 50.h, // Use h for height
              child: ElevatedButton(
                onPressed: () {
                  createLotto();
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

  // Future<void> _selectDate() async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate ?? DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );
  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //       _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
  //     });
  //   }
  // }

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
