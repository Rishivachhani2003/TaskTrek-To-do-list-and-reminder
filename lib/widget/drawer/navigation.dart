import 'package:flutter/material.dart';
import 'package:to_do_riverpod/view/home_page.dart';
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
    screenView = MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        backgroundColor: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
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
            screenView = MyHomePage();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = MyHomePage();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = MyHomePage();
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
            screenView = MyHomePage();
          });
          break;
        default:
          break;
      }
    }
  }
}
