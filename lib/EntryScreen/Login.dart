import 'dart:js';
import 'package:flutter/material.dart';
import 'package:recipe/home.dart';
import 'Forget_Screen.dart';
import 'SignUp_Screen.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var _EmailController = TextEditingController();
    var _PasswordController = TextEditingController();
    return Material(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 105,),

                Image.asset("assets/recipe.png", width: 400, height: 200,),

                SizedBox(height: 35,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _EmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Enter Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 15,),

                      TextFormField(
                        controller: _PasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Enter Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.remove_red_eye)
                        ),
                      ),

                      SizedBox(height: 10,),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Forget_Screen(),));
                          },
                          child: Text("Forget Password?",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff071938)),),
                        ),
                      ),

                      SizedBox(height: 25,),
                      ElevatedButton(
                        onPressed: () {
                          if (_PasswordController == "" && _EmailController =="") {
                            // showErrorMessage("All field is required");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter both fields correct data")));
                          }
                          else
                            {
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => Home_Page(),));
                            }
                        },
                        child: Text("Log in", style: TextStyle(fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(45),
                            backgroundColor: Color(0xff213A50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))
                        ),
                      ),

                      SizedBox(height: 15,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't Have an Account? ",
                            style: TextStyle(
                                fontSize: 15, color: Colors.black54),),

                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SignUp_Screen(),));
                            },
                            child: Text("Sign up",
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xff071938)),),
                          ),
                        ],
                      )

                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  // void showErrorMessage(String message) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: Text(message),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 // Close the dialog box
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       }
  //   );
  // }
}
