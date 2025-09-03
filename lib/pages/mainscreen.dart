import 'package:flutter/material.dart';
import 'package:lotto_app/model/response/user_login_post_res.dart';
import 'package:lotto_app/pages/catalog.dart';
import 'package:lotto_app/pages/home.dart';
import 'package:lotto_app/pages/home_owner.dart';
import 'package:lotto_app/pages/myticket.dart';
import 'package:lotto_app/pages/profile.dart';
import 'package:lotto_app/pages/redeem.dart';

class MainScreenPage extends StatefulWidget {
  final User user;
  final Wallet wallet;

  const MainScreenPage({super.key, required this.user, required this.wallet});

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  int selectedIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.user.role == "owner") {
      pages = [
        HomeOwner(user: widget.user, wallet: widget.wallet),
        CatalogPage(),
        MyTicketsPage(),
        RedeemPage(),
        ProfilePage(),
      ];
    } else {
      pages = [
        HomePage(user: widget.user, wallet: widget.wallet),
        CatalogPage(),
        MyTicketsPage(),
        RedeemPage(),
        ProfilePage(),
      ];
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
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
          items:
              widget.user.role == "owner"
                  ? const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Home",
                    ),
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
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: "Profile",
                    ),
                  ]
                  : const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Home",
                    ),
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
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: "Profile",
                    ),
                  ],
        ),
      ),
    );
  }
}
