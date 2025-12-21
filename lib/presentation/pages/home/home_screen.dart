import 'package:coffee_shop/presentation/pages/cart/cart_screen.dart';
import 'package:coffee_shop/presentation/pages/coffee/coffee_screen.dart';
import 'package:coffee_shop/presentation/pages/favorites/favorites_screen.dart';
import 'package:coffee_shop/presentation/pages/notification/notification_screen.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  void changeTap(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  List<Widget> screens = [
    CoffeePage(),
    FavoritesScreen(),
    CartScreen(),
    NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(
        isActivate: currentIndex,
        pageController: pageController,
      ),
      body: PageView.builder(
        itemBuilder: (context, index) => screens[index],
        itemCount: screens.length,
        controller: pageController,
        onPageChanged: (index) => changeTap(index),
      ),
    );
  }
}
