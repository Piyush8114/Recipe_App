import 'package:flutter/material.dart';

import 'otp_verify_screen.dart';

class OTP_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text("OTP Verification",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),),
              ),

              SizedBox(height: 60,),

              Text("Please enter your number. you will resive a link to create or set a new password via number.",
                style: TextStyle(
                  fontSize: 15,
                ),),

              SizedBox(height: 20,),

              TextFormField(
                decoration: InputDecoration(
                    label: Text("Enter Number"),
                    border: OutlineInputBorder()
                ),
              ),

              SizedBox(height: 20,),

              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OTP_verify_Screen(),));

                },
                child: Text("Send Code",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700,color: Colors.white),),
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
    );
  }
}
