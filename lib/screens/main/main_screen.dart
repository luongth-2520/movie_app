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
  static const int homeTabIndex = 0;
  static const int searchTabIndex = 1;
  static const int favoriteTabIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _bottomNavigationBar,
      body: IndexedStack(
        children: const [
          HomeScreen(),
          SearchScreen(),
          FavoriteScreen(),
        ],
        index: _selectedIndex,
      ),
    );
  }

  Widget get _bottomNavigationBar {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.size_8),
          topRight: Radius.circular(AppSize.size_8),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: AppSize.size_8),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSize.size_8),
          topRight: Radius.circular(AppSize.size_8),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.red,
          elevation: AppSize.size_8,
          items: [
            BottomNavigationBarItem(
              icon: _getIcon(_selectedIndex, homeTabIndex),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: _getIcon(_selectedIndex, searchTabIndex),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: _getIcon(_selectedIndex, favoriteTabIndex),
              label: "Favorites",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _getIcon(index, tabIndex) {
    String icon;
    switch (tabIndex) {
      case searchTabIndex:
        icon = AppImages.iconSearch;
        break;
      case favoriteTabIndex:
        icon = AppImages.iconFavorite;
        break;
      default:
        icon = AppImages.iconHome;
        break;
    }
    return SvgPicture.asset(
      icon,
      color: index == tabIndex ? Colors.red : Colors.black,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
