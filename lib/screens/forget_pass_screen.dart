import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/consts/constants.dart';
import 'package:to_do_riverpod/services/auth_services.dart';
import 'package:to_do_riverpod/screens/login_screen.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 500,
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: const BoxDecoration(),
                    child: Image.asset(
                      "assets/images/launcher_icon.png",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _emailController,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Get.isDarkMode ? Colors.white : Colors.blueGrey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    border: InputBorder.none,
                    label: const Text("Email"),
                    labelStyle: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                    hintText: "Enter your Email",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Get.isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: _isLoading ? 40 : 50,
                  width: _isLoading ? 40 : MediaQuery.of(context).size.width,
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            String email = _emailController.text;
                            if (email.isEmpty) {
                              toast("Please Enter Email", Get.isDarkMode);
                            } else {
                              setState(() {
                                _isLoading = true;
                              });

                              Future<String> res =
                                  AuthServices().resetPassword(email);
                              res.then((result) async {
                                if (result == 'Success') {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  toast(
                                      "Password reset email sent successfully.",
                                      Get.isDarkMode);
                                  await Future.delayed(Duration(seconds: 3))
                                      .then((value) {
                                    toast("You Can Login After Change Password",
                                        Get.isDarkMode);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => LoginScreen()),
                                    );
                                  });
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  toast(result.toString(), Get.isDarkMode);
                                }
                              }).catchError((error) {
                                setState(() {
                                  _isLoading = false;
                                });
                                toast(error.toString(), Get.isDarkMode);
                              });
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Text(
                              'Send Email',
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
