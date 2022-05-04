import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/constants/constanst.dart';
import 'package:movie_app/screens/favorite/favorite_screen.dart';
import 'package:movie_app/screens/home/home_screen.dart';
import 'package:movie_app/screens/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const int home = 0;
  static const int search = 1;
  static const int favorite = 2;
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _bottomNavigationBar,
      body: _screens[_selectedIndex],
    );
  }

  Widget get _bottomNavigationBar {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppSize.size_8),
        topRight: Radius.circular(AppSize.size_8),
      ),
      child: BottomNavigationBar(
        selectedItemColor: Colors.red,
        elevation: AppSize.size_8,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.iconHome,
              color: _selectedIndex == home ? Colors.red : Colors.black,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.iconSearch, color: _selectedIndex == search ? Colors.red : Colors.black),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon:
                SvgPicture.asset(AppImages.iconFavorite, color: _selectedIndex == favorite ? Colors.red : Colors.black),
            label: "Favorites",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
