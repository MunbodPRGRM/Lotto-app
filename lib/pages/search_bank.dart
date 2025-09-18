import 'package:flutter/material.dart';

class SearchBankPage extends StatefulWidget {
  const SearchBankPage({super.key});

  @override
  State<SearchBankPage> createState() => _SearchBankPageState();
}

class _SearchBankPageState extends State<SearchBankPage> {
  final List<Map<String, dynamic>> banks = const [
    {'name': 'ธนาคารออมสิน(GSB)', 'logo': Icons.account_balance_outlined},
    {'name': 'ธนาคารกรุงเทพ(BBL)', 'logo': Icons.account_balance_outlined},
    {
      'name': 'ธนาคารกรุงไทย(Krungthai)',
      'logo': Icons.account_balance_outlined,
    },
    {'name': 'ธนาคารกสิกรไทย(KBank)', 'logo': Icons.account_balance_outlined},
    {'name': 'ธนาคารไทยพาณิชย์(SCB)', 'logo': Icons.account_balance_outlined},
    {
      'name': 'ธนาคารกรุงศรีอยุธยา(Krungsri)',
      'logo': Icons.account_balance_outlined,
    },
    {'name': 'ทหารไทยธนชาต(TTB)', 'logo': Icons.account_balance_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Select Bank'),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ช่องค้นหาและปุ่ม Filter
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
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
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list_outlined),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Choose Bank',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // รายการธนาคาร
          Expanded(
            child: ListView.builder(
              itemCount: banks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    // ใช้ CircleAvatar แทนไอคอนโลโก้ธนาคารจริง
                    backgroundColor: Color(0xFFE0E0E0),
                    child: Icon(
                      Icons.account_balance_outlined,
                      color: Colors.black54,
                    ),
                  ),
                  title: Text(banks[index]['name'] as String),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // ปุ่ม "ยืนยัน"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // สามารถเพิ่มโค้ดสำหรับปุ่มยืนยันได้ที่นี่
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF06292),
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
          ),
        ],
      ),
    );
  }
}
