import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_app/config/internal_config.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/model/response/user_lotto_get_res.dart';

class MyTicketsPage extends StatefulWidget {
  final User user;
  final Wallet wallet;

  const MyTicketsPage({super.key, required this.user, required this.wallet});

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> {
  List<UserLottoGetResponse> userLottoList = [];
  List<UserLottoGetResponse> filteredUserLotto = [];

  late Future<void> loadData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData = getAllUserLotto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tickets"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  filteredUserLotto =
                      userLottoList
                          .where((lotto) => lotto.number.contains(value))
                          .toList();
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredUserLotto.length,
              itemBuilder: (context, index) {
                final lotto = filteredUserLotto[index];
                return Container(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getAllUserLotto() async {
    try {
      var res = await http.get(
        Uri.parse('$API_ENDPOINT/lotto/${widget.user.id}'),
      );
      if (res.statusCode == 200) {
        setState(() {
          userLottoList = userLottoGetResponseFromJson(res.body);
          filteredUserLotto = userLottoList;
        });
      } else {
        debugPrint('Failed to load lotto: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('Error loading lotto: $e');
    }
  }
}
