import 'package:flutter/material.dart';

import 'Login.dart';

class Recovery_Password extends StatefulWidget {
  const Recovery_Password({super.key});

  @override
  State<Recovery_Password> createState() => _Recovery_PasswordState();
}

class _Recovery_PasswordState extends State<Recovery_Password> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),

              Text("Recovery Password",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),),

              SizedBox(height: 100,),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    label: Text("Reset Code"),
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder()
                ),
              ),

              SizedBox(height: 20,),

              TextFormField(
                decoration: InputDecoration(
                    label: Text("New Password"),
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder()
                ),
              ),

              SizedBox(height: 20,),

              TextFormField(
                decoration: InputDecoration(
                    label: Text("Confirm Password"),
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder()
                ),
              ),


              SizedBox(height: 50,),

              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));

                },
                child: Text("Reset Password",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700,color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(45),
                    backgroundColor: Color(0xff213A50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))
                ),
              ),

            ],
          ),
        ),
      ),
    );  }
}
