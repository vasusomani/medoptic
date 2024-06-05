import 'package:flutter/material.dart';
import 'package:medoptic/Constants/colors.dart';
import 'package:medoptic/view/screens/home/profile_screen.dart';
import 'package:medoptic/view/screens/home/saved_screen.dart';
import 'package:medoptic/view/screens/home/scanner_screen.dart';
import 'package:medoptic/view/screens/home/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          ScannerScreen(),
          SavedScreen(),
          ProfileScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedIconTheme: const IconThemeData(size: 30),
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: CustomColors.primaryColor,
            icon: Icon(
              Icons.qr_code_scanner,
            ),
            label: 'MedTag',
          ),
          BottomNavigationBarItem(
            backgroundColor: CustomColors.primaryColor,
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            backgroundColor: CustomColors.primaryColor,
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            backgroundColor: CustomColors.primaryColor,
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
