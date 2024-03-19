import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:to_do_riverpod/consts/constants.dart';
import 'package:to_do_riverpod/services/auth_services.dart';
// import 'package:to_do_riverpod/services/local_notification.dart';
import 'package:to_do_riverpod/screens/home_screen.dart';
import 'package:to_do_riverpod/screens/login_screen.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  // @override
  // void initState() {
  //   super.initState();
  //   LocalNotification.initialize();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      body: Padding(
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
                "Register to TaskTrek",
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _nameController,
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
                  label: const Text("Name"),
                  labelStyle: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  hintText: "Enter your Name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: Get.isDarkMode ? Colors.black : Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
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
                height: 20,
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
                  label: Text("Password"),
                  labelStyle: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  hintText: "Enter your Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
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
                height: 20,
              ),
              TextField(
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
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
                  label: const Text("Confirm Password"),
                  labelStyle: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  hintText: "Enter your Confirm Password",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.lock,
                      color: Colors.grey), // Add prefix icon
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isConfirmPasswordVisible
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
                height: 30,
              ),
              SizedBox(
                height: _isLoading ? 40 : 50,
                width: _isLoading ? 40 : MediaQuery.of(context).size.width,
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          String name = _nameController.text;
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          String confirmPassword =
                              _confirmPasswordController.text;

                          if (name.isEmpty) {
                            toast("Please Enter name", Get.isDarkMode);
                          } else if (email.isEmpty) {
                            toast("Please Enter Email", Get.isDarkMode);
                          } else if (password.isEmpty) {
                            toast("Please Enter Password", Get.isDarkMode);
                          } else if (password.length < 6) {
                            toast("Password length is greater than 6",
                                Get.isDarkMode);
                          } else if (confirmPassword.isEmpty) {
                            toast("Please Enter Confirmed Password",
                                Get.isDarkMode);
                          } else if (confirmPassword.length < 6) {
                            toast("Password length is greater than 6",
                                Get.isDarkMode);
                          } else if (password != confirmPassword) {
                            toast("Password and confirm password do not match",
                                Get.isDarkMode);
                          } else {
                            setState(() {
                              _isLoading = true;
                            });
                            Future<String> res = AuthServices().signUp(
                              email,
                              _nameController.text,
                              password,
                            );

                            res.then((result) {
                              if (result == 'Success') {
                                setState(() {
                                  _isLoading = false;
                                });

                                // LocalNotification.showNotification(
                                //   title: "Taskify",
                                //   body: "Welcome, in Taskify",
                                // );
                                toast("Account Created", Get.isDarkMode);
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

                            _nameController.clear();
                            _emailController.clear();
                            _passwordController.clear();
                            _confirmPasswordController.clear();
                          }
                        },
                      ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (c) => const LoginScreen()));
                },
                child: Text(
                  'Already registered? Login Here!',
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
