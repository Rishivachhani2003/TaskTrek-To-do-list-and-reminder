// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_riverpod/Module/user.dart';
import 'package:to_do_riverpod/consts/constants.dart';
import 'package:to_do_riverpod/services/auth_services.dart';
import 'package:to_do_riverpod/services/database_services.dart';
import 'package:to_do_riverpod/view/splash_screen.dart';
import 'package:to_do_riverpod/widget/dialogs/delete_account_dialog.dart';
import 'package:to_do_riverpod/widget/dialogs/logout_dialog.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  Udata? _userData;

  @override
  void initState() {
    _fetchUserData();
    setDrawerListArray();
    super.initState();
  }

  void _fetchUserData() async {
    String uid = AuthServices().getUid();
    Udata? userData = await DatabaseServices().fetchUserData(uid);
    setState(() {
      _userData = userData;
    });
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Home',
        icon: Icon(Icons.home),
      ),
      // DrawerList(
      //   index: DrawerIndex.Help,
      //   labelName: 'Help',
      //   isAssetsImage: true,
      //   imageName: 'assets/images/supportIcon.png',
      // ),
      // DrawerList(
      //   index: DrawerIndex.FeedBack,
      //   labelName: 'FeedBack',
      //   icon: Icon(Icons.help),
      // ),
      DrawerList(
        index: DrawerIndex.Help,
        labelName: 'Help',
        icon: Icon(Icons.help),
      ),
      // DrawerList(
      //     index: DrawerIndex.Share,
      //     labelName: 'Rate the app',
      //     icon: Icon(Icons.share),
      //   ),
      //   DrawerList(
      //     index: DrawerIndex.About,
      //     labelName: 'About Us',
      //     icon: Icon(Icons.info),
      //   ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final name = _userData == null ? "nirav" : _userData?.name;
    final email = _userData == null ? "loading User data..." : _userData?.email;

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: widget.iconAnimationController!,
                      builder: (BuildContext context, Widget? child) {
                        return ScaleTransition(
                          scale: AlwaysStoppedAnimation<double>(1.0 -
                              (widget.iconAnimationController!.value) * 0.2),
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                        begin: 0.0, end: 24.0)
                                    .animate(CurvedAnimation(
                                        parent: widget.iconAnimationController!,
                                        curve: Curves.fastOutSlowIn))
                                    .value /
                                360),
                            child: SizedBox(
                              width: 115,
                              height: 115,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 60,
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: _userData == null
                                        ? Colors.black
                                        : Colors.white,
                                    child: _userData == null
                                        ? Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 50,
                                          )
                                        : ProfilePicture(
                                            name: name![0],
                                            radius: 60,
                                            fontsize: 50,
                                            random: false,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 4),
                      child: Text(
                        name.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 4),
                      child: Text(
                        email.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Divider(
              height: 1,
              color: AppTheme.grey.withOpacity(0.6),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0.0),
                itemCount: drawerList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return inkwell(drawerList![index]);
                },
              ),
            ),
            Divider(
              height: 1,
              color: AppTheme.grey.withOpacity(0.6),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  trailing: Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
                  ),
                  onTap: () async {
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      await AuthServices().signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (c) => SplashScreen()));
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
                Divider(
                  height: 1,
                  color: AppTheme.grey.withOpacity(0.6),
                ),
                ListTile(
                  title: Text(
                    'Delete Account',
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  trailing: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () async {
                    final shouldDeleteAccount =
                        await showDeleteAccountDialog(context);
                    if (shouldDeleteAccount) {
                      try {
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          AuthServices().deleteUserData();
                          AuthServices().deleteAccount();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => SplashScreen()));

                          Fluttertoast.showToast(
                              msg:
                                  'Your data and account deleted successfully.');
                        } else {
                          Fluttertoast.showToast(
                              msg: 'User not authenticated.');
                        }
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: 'Error deleting user data: $e');
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        // splashColor: Colors.grey.withOpacity(0.1),
        // highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? Colors.blue
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? Colors.blue
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.blue
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  FeedBack,
  Help,
  Share,
  About,
  Invite,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
