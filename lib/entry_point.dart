import 'package:advanced_icon/advanced_icon.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:musify/home_page.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const <Widget>[
    HomePage(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems =
      <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(IconlyBold.home),
      activeIcon: AdvancedIcon(
        icon: IconlyBold.home,
        color: Colors.red, //color will have no effect
        gradient: LinearGradient(
          //change gradient as per your requirement
          colors: <Color>[Colors.pink, Colors.deepPurple],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.2, 0.8],
        ),
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconlyBold.folder),
      activeIcon: AdvancedIcon(
        icon: IconlyBold.folder,
        color: Colors.red, //color will have no effect
        gradient: LinearGradient(
          //change gradient as per your requirement
          colors: <Color>[Colors.pink, Colors.deepPurple],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.2, 0.8],
        ),
      ),
      label: 'Downloads',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconlyBold.heart),
      activeIcon: AdvancedIcon(
        icon: IconlyBold.heart,
        color: Colors.red, //color will have no effect
        gradient: LinearGradient(
          //change gradient as per your requirement
          colors: <Color>[Colors.pink, Colors.deepPurple],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.2, 0.8],
        ),
      ),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconlyBold.profile),
      activeIcon: AdvancedIcon(
        icon: IconlyBold.profile,
        color: Colors.red, //color will have no effect
        gradient: LinearGradient(
          //change gradient as per your requirement
          colors: <Color>[Colors.pink, Colors.deepPurple],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.2, 0.8],
        ),
      ),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _handleNavBarTap,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: const IconThemeData(size: 40),
        unselectedIconTheme: const IconThemeData(size: 40),
        currentIndex: _selectedIndex,
        items: _bottomNavBarItems,
      ),
    );
  }

  _handleNavBarTap(int index) => setState(() => _selectedIndex = index);
}
