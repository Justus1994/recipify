import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  NavigationBar({Key? key, this.onTap, required this.selectedIndex}) : super(key: key);

  final onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded),
          label: 'menu',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insights_rounded),
          label: 'planner',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ramen_dining),
          label: 'recipes',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onTap,
    );
  }
}
