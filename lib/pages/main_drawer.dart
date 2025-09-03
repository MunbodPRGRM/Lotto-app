import 'package:flutter/material.dart';

class MainDrawerPage extends StatefulWidget {
  const MainDrawerPage({super.key});

  @override
  State<MainDrawerPage> createState() => _MainDrawerPageState();
}

class _MainDrawerPageState extends State<MainDrawerPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Catalog"),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num),
            label: "My Tickets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: "Redeem",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}
