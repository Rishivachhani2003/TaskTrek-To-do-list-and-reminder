import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/screens/home_screen.dart';
import 'package:to_do_riverpod/widget/drawer/drawercontroller.dart';
import 'package:to_do_riverpod/widget/drawer/mydrawer.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
        child: Scaffold(
          backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.85,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            // screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = HomeScreen();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = HomeScreen();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = HomeScreen();
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
            screenView = HomeScreen();
          });
          break;
        default:
          break;
      }
    }
  }
}
