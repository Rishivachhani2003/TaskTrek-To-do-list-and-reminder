import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/consts/constants.dart';
import 'package:to_do_riverpod/services/auth_services.dart';
import 'package:to_do_riverpod/screens/forget_pass_screen.dart';
import 'package:to_do_riverpod/screens/home_screen.dart';
import 'package:to_do_riverpod/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
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
                  "Welcome to the TaskTrek",
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 25,
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
                const SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  enableSuggestions: false,
                  autocorrect: false,
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
                    label: const Text("Password"),
                    labelStyle: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                    hintText: "Enter your Password",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.lock,
                        color: Colors.grey), // Add prefix icon
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    filled: true,
                    fillColor: Get.isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: TextButton(
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => ForgetPassScreen()));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                            String password = _passwordController.text;

                            if (email.isEmpty) {
                              toast("Please Enter Email", Get.isDarkMode);
                            } else if (password.isEmpty) {
                              toast("Please Enter Password", Get.isDarkMode);
                            } else if (password.length < 6) {
                              toast("Password length is greater than 6",
                                  Get.isDarkMode);
                            } else {
                              setState(() {
                                _isLoading = true;
                              });
                              Future<String> res =
                                  AuthServices().login(email, password);

                              res.then((result) {
                                if (result == 'Success') {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  toast("Login Successful", Get.isDarkMode);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => HomeScreen()));
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
                            padding: EdgeInsets.all(
                              0.0,
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (c) => RegisterView()));
                  },
                  child: Text(
                    'Not registered yet? Register Here!',
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
