
import 'dart:math';
import 'package:chat/New/AuthProvider.dart';
import 'package:chat/Services/helperFunctions.dart';
import 'package:chat/Themes/Themes.dart';
import 'package:chat/Utils/Google_signIn_button.dart';
import 'package:chat/views/ChatRoom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/Constants.dart';



class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final key = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _PassController = TextEditingController();
  

 

    getuserInfo()async{
      Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
     setState((){
        
     });
  }
  @override
  void initState() {
    getuserInfo();
    // TODO: implement initState
    super.initState();
  }
   @override
    void dispose(){
      _emailController.dispose();
      _PassController.dispose();
      super.dispose();
    }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text('Flutter Chat App',style: TextStyle(fontFamily: 'LemonMilkRegular',fontSize: 30,color: themes.primaryColor),),
        ),
      ),
      body: Container(
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/5208996.jpg'),
                Google_Signin_button(
                  
                  callback: (){
                    AuthProvider authProvider = context.read<AuthProvider>();
                   authProvider.handleSignIn().then((value) {
                      final user = FirebaseAuth.instance.currentUser;
                        Map<String,String> users ={
                      'name': user!.displayName.toString(),
                      'email':user.email.toString(),
                      };
                      HelperFunctions.saveUserEmailSharedPreference(user.email.toString());
                      HelperFunctions.saveUserNameSharedPreference(user.displayName.toString());
                      FirebaseFirestore.instance.collection('user').doc(user.displayName.toString()).set(users);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoomSceen()));
                    });
                    
                  },
               ),
                // SizedBox(height: 10,),
                // Alreadytext()
              ],
            ),
          ),
        )
      ),
    );
  }
}


