import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'OTP_Screen.dart';
import 'Recovery_Password.dart';

class Forget_Screen extends StatefulWidget {

  @override
  State<Forget_Screen> createState() => _Forget_ScreenState();
}

class _Forget_ScreenState extends State<Forget_Screen> {

  bool clrButton = false;

  var EmailController = TextEditingController();
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),

              Align(
                alignment: Alignment.topLeft,
                child: Text("Forget Password",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),
              ),

              SizedBox(height: 60,),

              Text("Please enter your email address. you will resive a link to create or set a new password via email.",
                style: TextStyle(
                    fontSize: 15,
                ),),

              SizedBox(height: 20,),

              TextFormField(
                controller: EmailController,
                onChanged: (val){
                  if(val != "" ){
                    clrButton = true;
                  }
                },
                decoration: InputDecoration(
                  label: Text("Email"),

                  suffixIcon: InkWell(
                      onTap: (){
                        setState(() {
                          EmailController.clear();
                        });
                      },
                      child: Icon(CupertinoIcons.multiply,color: Color(0xff213A50),)),
                  border: OutlineInputBorder()
                ),
              ),


              SizedBox(height: 50,),

              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Recovery_Password(),));
                },
                child: Text("Send Code",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700,color: CupertinoColors.white),),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(45),
                    backgroundColor: Color(0xff213A50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))
                ),
              ),
              SizedBox(height: 20,),

             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("OR",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),

                 TextButton(
                   onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => OTP_Screen(),));

                   },
                   child: Text("Verify Using Number",
                     style: TextStyle(fontSize:17,color: Color(0xff213A50) ),),
                 ),
               ],
             )
            ],
          ),
        ),
      ),
    );
  }
}
