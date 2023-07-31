import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/screens/user_info.dart';
import '../home/home_screen.dart';
import 'bottem_bar_provider.dart';

class BottomBar extends StatelessWidget {
  final List<Widget> _tabs = [
    const HomeScreen(), // Replace with your own tab widgets
    const UserInfo(),

  ];

  @override
  Widget build(BuildContext context) {
    final tabProvider = Provider.of<BottomBarProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume App'),
      ),
      body: _tabs[tabProvider.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabProvider.selectedIndex,
        onTap: (index) => tabProvider.setTabIndex(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User Info',
          ),

        ],
      ),
    );
  }
}
