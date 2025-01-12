import 'dart:math';

import 'package:flutter/material.dart';
import 'Recovery_Password.dart';
import 'TextFieldPin .dart';

class OTP_verify_Screen extends StatefulWidget {

  @override
  State<OTP_verify_Screen> createState() => _OTP_verify_ScreenState();
}

class _OTP_verify_ScreenState extends State<OTP_verify_Screen> {
  var textEditingController = TextEditingController();
  late int randomNumber;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
  int generateFourDigitNumber() {
    Random random = Random();
    return 1000 + random.nextInt(9000);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomNumber = generateFourDigitNumber();
  }

  void _verifyOTP() {
    if (textEditingController.text == randomNumber.toString()) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Recovery_Password()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Verified Successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text("Enter OTP",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),),
              ),

              SizedBox(height: 150,),

              Text("Please enter the OTP we have sent to you to your Number, please check your number and enter here OTP to verify.",
                style: TextStyle(
                  fontSize: 15,
                ),),

              SizedBox(height: 50,),

              TextFieldPin(
                  textController: textEditingController,
                  autoFocus: false,
                  codeLength: 4,
                  alignment: MainAxisAlignment.center,
                  defaultBoxSize: 55.0,
                  margin: 10,
                  selectedBoxSize: 46.0,
                  textStyle: TextStyle(fontSize: 16),
                  defaultDecoration: _pinPutDecoration.copyWith(
                      border: Border.all(color: Colors.grey)),
                  selectedDecoration: _pinPutDecoration,
                  onChange: (code) {
                    setState(() {

                    });
                  }
                  ),

              SizedBox(height: 30,),

              ElevatedButton(
                onPressed: _verifyOTP,
                child: Text(
                  "Verify",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(45),
                  backgroundColor: Color(0xff213A50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),


              SizedBox(height: 50,),

              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reset Code",
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold,color: Colors.green),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "$randomNumber",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blueGrey.shade500),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),

    );
  }
}
