// ignore_for_file: await_only_futures, prefer_const_constructors

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/screens/home_screen.dart';
import 'package:to_do_riverpod/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, navigate);
  }

  void navigate() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return _getScreenBasedOnAuthStatus(FirebaseAuth.instance.currentUser);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Widget _getScreenBasedOnAuthStatus(User? user) {
    if (user != null) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<User?>(
    //   stream: FirebaseAuth.instance.authStateChanges(),
    //   builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.1),
                  child: Container(
                    height: constraints.maxHeight * 0.4,
                    width: constraints.maxWidth * 0.8,
                    decoration: BoxDecoration(),
                    child: Image.asset("assets/images/launcher_icon.png"),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.03,
                ),
                Text(
                  "Hello, Welcome to TaskTrek",
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.03,
                ),
                CircularProgressIndicator(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ],
            ),
          );
        },
      ),
    );
    // } else {
    //   return _getScreenBasedOnAuthStatus(snapshot.data);
    // }
    // },
    // );
  }
}
