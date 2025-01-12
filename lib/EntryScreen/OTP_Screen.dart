import 'package:flutter/material.dart';
import 'package:prefs/prefs.dart';

import 'Recovery_Password.dart';
import 'otp_verify_screen.dart';

class OTP_Screen extends StatefulWidget {

  @override
  State<OTP_Screen> createState() => _OTP_ScreenState();
}

class _OTP_ScreenState extends State<OTP_Screen> {

  var PhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
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
                  controller: PhoneController,
                  decoration: InputDecoration(
                      label: Text("Enter Phone Number"),
                      border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone nummber";
                    }
                    else if(value?.length != 10){
                      return "Enter valid phone number";
                    }
                    else{
                      return null;
                    }
                  },
                ),

                SizedBox(height: 20,),

                ElevatedButton(
                  onPressed: ()async{
                    if(_formKey.currentState?.validate() ?? false){
                      if (_formKey.currentState?.validate() ?? false) {
                        final prefs = await SharedPreferences.getInstance();
                        final storedPhone = prefs.getString('phone');

                        if (storedPhone == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("No registered Phone Number found.")),
                          );
                          return;
                        }

                        if (PhoneController.text.trim() == storedPhone) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OTP_verify_Screen(),));
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please enter the correct phone number")),
                          );
                        }
                      }
                    }
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
      ),
    );
  }
}
