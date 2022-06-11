
import 'package:chat/New/AuthProvider.dart';
import 'package:chat/views/ChatRoom.dart';
import 'package:chat/views/signUp.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5),(){
      checkSignedIn();
    });
  }
  @override
  void checkSignedIn()async{
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if(isLoggedIn){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoomSceen()));
     
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
  }
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