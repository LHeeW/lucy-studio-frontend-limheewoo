import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/viewmodels/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final viewmodel = context.watch<MainViewModel>();

    return Scaffold(
      body: SafeArea(
        child: viewmodel.widgetOptions.elementAt(viewmodel.selectIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined),
            activeIcon: Icon(Icons.star),
            label: '관심',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: '검색',
          ),
        ],
        currentIndex: viewmodel.selectIndex,
        selectedItemColor: colors.navActive,
        unselectedItemColor: colors.navInactive,
        onTap: viewmodel.onItemTapped,
      ),
    );
  }
}
