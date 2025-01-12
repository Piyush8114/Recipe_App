import 'package:flutter/material.dart';
import 'package:prefs/prefs.dart';
import 'package:recipe/home.dart';
import 'Forget_Screen.dart';
import 'SignUp_Screen.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isHide = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home_Page()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void moveToHomePage(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final prefs = await SharedPreferences.getInstance();
      final storedEmail = prefs.getString('email');
      final storedPassword = prefs.getString('password');
      if (_emailController.text.trim() == storedEmail && _passwordController.text.trim() == storedPassword) {
        await prefs.setBool('isLoggedIn', true); // Set login flag
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Successfully Logged In")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_Page()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid email or password")),
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
                  SizedBox(height: 105),
                  Image.asset("assets/recipe.png", width: 400, height: 200),
                  SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          // keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Enter Email",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            // Regex for email validation
                            String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                            RegExp regex = RegExp(pattern);

                            if (value == null || value.isEmpty) {
                              return "Email can't be empty";
                            }
                            else if (!regex.hasMatch(value)) {
                              return "Enter a valid email address";
                            }
                            else{
                            return null;
                            }
                          },
                        ),

                        SizedBox(height: 15),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: isHide,
                          decoration: InputDecoration(
                            labelText: "Enter Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                isHide = !isHide;
                              });
                            }, icon: isHide? Icon(Icons.visibility_off,) : Icon(Icons.visibility,),),
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
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Forget_Screen(),
                                ),
                              );
                            },
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(fontSize: 16, color: Color(0xff071938)),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              moveToHomePage(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Enter valid Details")),
                              );
                            }
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(45),
                            backgroundColor: Color(0xff213A50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have an Account? ",
                              style: TextStyle(fontSize: 15, color: Colors.black54),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp_Screen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(fontSize: 17, color: Color(0xff071938)),
                              ),
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
