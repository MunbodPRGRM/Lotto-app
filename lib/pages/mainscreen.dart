import 'package:flutter/material.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/pages/catalog/catalog.dart';
import 'package:lotto_app/pages/home/home.dart';
import 'package:lotto_app/pages/home/home_owner.dart';
import 'package:lotto_app/pages/profile/myticket.dart';
import 'package:lotto_app/pages/profile/profile.dart';
import 'package:lotto_app/pages/other/redeem.dart';

// ===== MainScreenPage =====
// หน้าจอหลักของแอป หลังจาก login
// ใช้ BottomNavigationBar สำหรับสลับหน้า
class MainScreenPage extends StatefulWidget {
  final User user; // ข้อมูลผู้ใช้
  final Wallet wallet; // ข้อมูล wallet ของผู้ใช้

  const MainScreenPage({super.key, required this.user, required this.wallet});

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  int selectedIndex = 0; // index ของแท็บที่ถูกเลือก

  // สร้าง list ของ pages สำหรับ owner และ member
  final List<Widget Function()> ownerPages = [];
  final List<Widget Function()> memberPages = [];

  @override
  void initState() {
    super.initState();

    // =================== Pages สำหรับ owner ===================
    ownerPages.addAll([
      () => HomeOwner(
        user: widget.user,
        wallet: widget.wallet,
        onTabChange: onItemTapped,
        key:
            UniqueKey(), // UniqueKey ทำให้ AnimatedSwitcher รีสร้างหน้าใหม่ทุกครั้ง
      ),
      () => CatalogPage(
        user: widget.user,
        wallet: widget.wallet,
        key: UniqueKey(),
      ),
      () => MyTicketsPage(
        user: widget.user,
        wallet: widget.wallet,
        key: UniqueKey(),
      ),
      () => RedeemPage(
        user: widget.user,
        wallet: widget.wallet,
        key: UniqueKey(),
      ),
      () => ProfilePage(
        user: widget.user,
        wallet: widget.wallet,
        onTabChange: onItemTapped,
        key: UniqueKey(),
      ),
    ]);

    // =================== Pages สำหรับ member ===================
    memberPages.addAll([
      () => HomePage(
        user: widget.user,
        wallet: widget.wallet,
        onTabChange: onItemTapped,
        key: UniqueKey(),
      ),
      () => CatalogPage(
        user: widget.user,
        wallet: widget.wallet,
        key: UniqueKey(),
      ),
      () => MyTicketsPage(
        user: widget.user,
        wallet: widget.wallet,
        key: UniqueKey(),
      ),
      () => RedeemPage(
        user: widget.user,
        wallet: widget.wallet,
        key: UniqueKey(),
      ),
      () => ProfilePage(
        user: widget.user,
        wallet: widget.wallet,
        onTabChange: onItemTapped,
        key: UniqueKey(),
      ),
    ]);
  }

  // ===== เมื่อผู้ใช้กดแท็บด้านล่าง =====
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index; // เปลี่ยน index ของ page ที่เลือก
    });
  }

  @override
  Widget build(BuildContext context) {
    // เลือก list pages ตาม role ของผู้ใช้
    final pages = widget.user.role == "owner" ? ownerPages : memberPages;

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300), // ความเร็ว animation
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation, // ใช้ fade effect
            child: child,
          );
        },
        child: pages[selectedIndex](), // แสดง page ตาม index ที่เลือก
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2), // เงาด้านบน navigation bar
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.pink, // สีแท็บที่เลือก
          unselectedItemColor: Colors.grey, // สีแท็บที่ไม่ได้เลือก
          currentIndex: selectedIndex, // index ของแท็บปัจจุบัน
          onTap: onItemTapped, // ฟังก์ชันเรียกเมื่อกดแท็บ
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: "Catalog",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_num),
              label: "My Tickets",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: "Redeem",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
