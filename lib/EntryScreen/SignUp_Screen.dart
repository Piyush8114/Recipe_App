// import 'package:ecomerceapp/Navegated/Navation_Screen.dart';
// import 'package:ecomerceapp/Screen/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:recipe/home.dart';

// import '../Navegated/Home_Screen.dart';
import 'Login.dart';

class SignUp_Screen extends StatelessWidget {
  const SignUp_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30,),

                Image.asset("assets/recipe.png",width: 300,height: 200,),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter Name",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 15,),

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Enter Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: 15,),

                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Enter Number",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                      SizedBox(height: 15,),

                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Enter Password",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),
                      SizedBox(height: 15,),

                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Enter Conform Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.remove_red_eye)
                        ),
                      ),


                      SizedBox(height: 30,),

                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                        },
                        child: Text("Create Account",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700,color: Colors.white),),
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
                          Text("Already Have an Account? ",
                            style: TextStyle(fontSize:15,color: Colors.black54 ),),

                          TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                            },
                            child: Text("Log in",
                              style: TextStyle(fontSize:17,color: Color(0xff213A50) ),),
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
}
