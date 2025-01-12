import 'package:flutter/material.dart';
import 'package:recipe/home.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Correct import for SharedPreferences

import 'Login.dart';

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PhoneController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _C_PasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isHide = true;

  void MoveToLoginPage(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final prefs = await SharedPreferences.getInstance();

      // Fetch stored data to check if email or phone already exists
      String? storedEmail = prefs.getString('email');
      String? storedPhone = prefs.getString('phone');

      if (storedEmail == _EmailController.text.trim() ) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account already exists with this email ")),
        );
      }
      else if(storedPhone == _PhoneController.text.trim())
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Account already exists with this phone")),
          );
        }
      else {
        // Store user data if not existing
        await prefs.setString('name', _NameController.text.trim());
        await prefs.setString('email', _EmailController.text.trim());
        await prefs.setString('phone', _PhoneController.text.trim());
        await prefs.setString('password', _PasswordController.text.trim());
        await prefs.setString('c_password', _C_PasswordController.text.trim());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Successfully Created Account")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Image.asset("assets/recipe.png", width: 300, height: 200),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _NameController,
                          decoration: InputDecoration(
                            labelText: "Enter Name",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name can't be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _EmailController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Enter Email",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                            RegExp regex = RegExp(pattern);
                            if (value == null || value.isEmpty) {
                              return "Email can't be empty";
                            } else if (!regex.hasMatch(value)) {
                              return "Enter a valid email address";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _PhoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Enter Phone Number",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone can't be empty";
                            } else if (value.length != 10) {
                              return "Enter valid phone number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _PasswordController,
                          decoration: InputDecoration(
                            labelText: "Enter Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.password),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password can't be empty";
                            } else if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _C_PasswordController,
                          obscureText: isHide,
                          decoration: InputDecoration(
                            labelText: "Enter Confirm Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isHide = !isHide;
                                });
                              },
                              icon: isHide ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Confirm password can't be empty";
                            } else if (_PasswordController.text.trim() != value.trim()) {
                              return "Password and confirm password do not match";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            MoveToLoginPage(context);
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(45),
                            backgroundColor: Color(0xff213A50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already Have an Account? ", style: TextStyle(fontSize: 15, color: Colors.black54)),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                              },
                              child: Text("Log in", style: TextStyle(fontSize: 17, color: Color(0xff213A50))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
