import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prefs/prefs.dart';

import 'Login.dart';

class Recovery_Password extends StatefulWidget {
  const Recovery_Password({super.key});

  @override
  State<Recovery_Password> createState() => _Recovery_PasswordState();
}

class _Recovery_PasswordState extends State<Recovery_Password> {
  var ResetController = TextEditingController();
  var PasswordController = TextEditingController();
  var Confirm_Controller = TextEditingController();
  bool isHide = true;
  final _formKey = GlobalKey<FormState>();
  late int randomNumber;

  int generateSixDigitNumber() {
    Random random = Random();
    return 100000 + random.nextInt(900000);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomNumber = generateSixDigitNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Recovery Password",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  controller: ResetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text("Reset Code"),
                      prefixIcon: Icon(Icons.numbers),
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "can't be empty";
                    } else if (int.tryParse(value.trim()) != randomNumber) {
                      return "Please enter correct Reset code";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: PasswordController,
                  decoration: InputDecoration(
                      label: Text("New Password"),
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm password can't be empty";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: Confirm_Controller,
                  obscureText: isHide,
                  decoration: InputDecoration(
                      label: Text("Confirm Password"),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isHide = !isHide;
                          });
                        },
                        icon: isHide
                            ? Icon(
                                Icons.visibility_off,
                              )
                            : Icon(
                                Icons.visibility,
                              ),
                      ),
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm password can't be empty";
                    } else if (PasswordController.text.trim() != value.trim()) {
                      return "Password and confirm password do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final prifs = await SharedPreferences.getInstance();
                      final storeCpassword =
                          await prifs.getString('c_password');
                      String? storepassword = await prifs.getString('password');

                      if (storepassword == PasswordController.text.toString()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "Your Password already exists Please enter new password ")),
                        );
                      } else if (PasswordController.text.trim() ==
                          Confirm_Controller.text.trim()) {
                        await prifs.setString(
                            'password', Confirm_Controller.text.toString());

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Password Change Successfully")),
                        );
                      } else {
                        return;
                      }
                    }
                  },
                  child: Text(
                    "Reset Password",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(45),
                      backgroundColor: Color(0xff213A50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Reset Code",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "$randomNumber",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade500),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
