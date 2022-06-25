
import 'package:chat/Services/Auth.dart';
import 'package:chat/views/ChatRoom.dart';
import 'package:chat/views/Checking.dart';
import 'package:chat/views/Intro.dart';
import 'package:chat/views/signUp.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key,}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Checking()));
    });
  }
  @override
 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 500,
                width: 500,
                child: Image.asset('assets/5208996.jpg')),
                SizedBox(height: 50,),
              CircularProgressIndicator(),
              SizedBox(height: 20,),
              Text('Welcome to Flutter chat app.')
            ],
          ),
        )
      ),
    );
  }
}