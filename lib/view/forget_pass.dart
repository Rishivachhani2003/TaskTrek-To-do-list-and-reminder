import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_riverpod/services/auth_services.dart';
import 'package:to_do_riverpod/view/login_view.dart';

class ForgetPassView extends StatefulWidget {
  const ForgetPassView({Key? key}) : super(key: key);

  @override
  State<ForgetPassView> createState() => _ForgetPassViewState();
}

class _ForgetPassViewState extends State<ForgetPassView> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const Text(
                  "Reset Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
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
                      borderSide: const BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    border: InputBorder.none,
                    label: const Text("Email"),
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: "Enter your Email",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.white,
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
                          color: Colors.black,
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            String email = _emailController.text;
                            if (email.isEmpty) {
                              Fluttertoast.showToast(msg: "Please Enter Email");
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
                                  Fluttertoast.showToast(
                                      msg:
                                          "Password reset email sent successfully.");
                                  await Future.delayed(Duration(seconds: 3))
                                      .then((value) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "You Can Login After Change Password");
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => LoginView()),
                                    );
                                  });
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: result.toString());
                                }
                              }).catchError((error) {
                                setState(() {
                                  _isLoading = false;
                                });
                                Fluttertoast.showToast(msg: error.toString());
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
                              Colors.black,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                0.0), // Add some padding for better visibility
                            child: Text(
                              'Send Email', // Add the text "Login"
                              style: TextStyle(
                                color: Colors.white,
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
