import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/lotto_catalog_post_res.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/pages/catalog/catalog_detail.dart';

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
    // TODO: implement initState
    super.initState();

    loadData = getAllLotto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    "Catalog",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          suffixIcon: const Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
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
        padding: const EdgeInsets.all(12),
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
                // ถ้าเป็น owner กดไม่ได้ → จะไม่ทำอะไร หรือจะแสดงแจ้งเตือนก็ได้
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("เจ้าของระบบไม่สามารถซื้อได้"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
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
                          lotto.status == "sold"
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
                                lotto.price.toString(),
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
                            lotto.number,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 25),
                          Text(
                            "วันนี้ เดือนนี้ ปีนี้\nซื้อแล้วรวย ซื้อแล้วรวย",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "จะงวดนี้ หรืองวดหน้าก็รวย",
                            style: TextStyle(fontSize: 12),
                          ),
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
