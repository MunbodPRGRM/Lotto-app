import 'package:flutter/material.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/pages/catalog/catalog.dart';
import 'package:lotto_app/pages/home/home.dart';
import 'package:lotto_app/pages/home/home_owner.dart';
import 'package:lotto_app/pages/profile/myticket.dart';
import 'package:lotto_app/pages/profile/profile.dart';
import 'package:lotto_app/pages/other/redeem.dart';

class MainScreenPage extends StatefulWidget {
  final User user;
  final Wallet wallet;

  const MainScreenPage({super.key, required this.user, required this.wallet});

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  int selectedIndex = 0;

  final List<Widget Function()> ownerPages = [];
  final List<Widget Function()> memberPages = [];

  @override
  void initState() {
    super.initState();

    ownerPages.addAll([
      () => HomeOwner(
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

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = widget.user.role == "owner" ? ownerPages : memberPages;

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300), // ⏱ ความเร็วแอนิเมชัน
        transitionBuilder: (child, animation) {
          return FadeTransition(
            // 🔥 เปลี่ยนได้เป็น SlideTransition ถ้าอยากเลื่อน
            opacity: animation,
            child: child,
          );
        },
        child: pages[selectedIndex](),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: onItemTapped,
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
