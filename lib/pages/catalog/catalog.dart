import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/lotto_catalog_post_res.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/pages/catalog/catalog_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import library

class CatalogPage extends StatefulWidget {
  final User user;
  final Wallet wallet;

  const CatalogPage({super.key, required this.user, required this.wallet});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  List<LottoCatalogPostResponse> lottoList = [];
  List<LottoCatalogPostResponse> filteredLotto = [];

  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    loadData = getAllLotto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h), // 1. ปรับความสูง AppBar
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ), // 2. ปรับ padding
              child: Row(
                children: [
                  Text(
                    "Catalog",
                    style: TextStyle(
                      fontSize: 20.sp, // 3. ปรับ font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 16.w), // 4. ปรับ width
                  Expanded(
                    child: Container(
                      height: 40.h, // 5. ปรับความสูง
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(
                          20.r,
                        ), // ใช้ .r สำหรับ radius
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          suffixIcon: const Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            filteredLotto =
                                lottoList
                                    .where(
                                      (lotto) => lotto.number.contains(value),
                                    )
                                    .toList();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12.w), // ปรับ padding
        itemCount: filteredLotto.length,
        itemBuilder: (context, index) {
          final lotto = filteredLotto[index];
          return InkWell(
            onTap: () {
              if (widget.user.role != "owner") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CatalogDetail(
                          user: widget.user,
                          wallet: widget.wallet,
                          lotto: lotto,
                        ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("เจ้าของระบบไม่สามารถซื้อได้"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Container(
              height: 180.h, // 6. ปรับความสูง
              margin: EdgeInsets.only(bottom: 12.h), // ปรับ margin
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5.r,
                    offset: Offset(0, 3.h),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 200.w, // 7. ปรับความกว้าง
                    height: 180.h, // ปรับความสูง
                    decoration: BoxDecoration(
                      color:
                          lotto.status == "sold"
                              ? Color(0xFFD9D9D9)
                              : Color(0xFFEDF4D0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/lotto_icon.png',
                          width: 150.w, // 8. ปรับความกว้าง
                          height: 150.h, // 9. ปรับความสูง
                        ),
                        Positioned(
                          bottom: 0,
                          left: 10.w, // ปรับ left
                          child: Column(
                            children: [
                              Text(
                                lotto.price.toString(),
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp, // 10. ปรับ font size
                                  height: 0.5,
                                ),
                              ),
                              Text(
                                'บาท',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp, // 11. ปรับ font size
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
    );
  }

  Future<void> getAllLotto() async {
    try {
      var res = await http.get(Uri.parse('$API_ENDPOINT/lotto'));
      if (res.statusCode == 200) {
        setState(() {
          lottoList = lottoCatalogPostResponseFromJson(res.body);
          filteredLotto = lottoList;
        });
      } else {
        debugPrint('Failed to load lotto: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('Error loading lotto: $e');
    }
  }
}
