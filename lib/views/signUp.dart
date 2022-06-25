
import 'package:chat/Services/helperFunctions.dart';
import 'package:chat/Themes/Themes.dart';
import 'package:chat/Utils/Google_signIn_button.dart';
import 'package:chat/views/ChatRoom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/Auth.dart';
import '../Services/Constants.dart';



class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final key = GlobalKey<FormState>();
  
    getuserInfo()async{
      Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
     setState((){
        
     });
  }
  @override
  void initState() {
    getuserInfo();
    super.initState();
  }
   @override
    void dispose(){
    
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
                Image.asset('assets/Intropage3.jpg'),
                SizedBox(height: 50,),
                Google_Signin_button(  
                  callback: (){
                    Auth authProvider = context.read<Auth>();
                   authProvider.signInWithGoogle().then((value) {
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
                
              ],
            ),
          ),
        )
      ),
    );
  }
}


