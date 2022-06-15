import 'package:chat/views/ChatRoom.dart';
import 'package:chat/views/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Checking extends StatefulWidget {
  Checking({Key? key}) : super(key: key);

  @override
  State<Checking> createState() => _CheckingState();
}

class _CheckingState extends State<Checking> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
          child: CircularProgressIndicator(),
        );
        }
        else if(snapshot.hasData){
          return ChatRoomSceen();
        }
        else if(snapshot.hasError){
          return Center(child: Text("Something Went Wrong"),);
        }
        else{
          return SignUpScreen();
        }
        
      }
    );;
  }
}