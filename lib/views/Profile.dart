import 'package:chat/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isWhite ?Colors.white :Colors.black,
        foregroundColor: isWhite ?Colors.black :Colors.white,
        title: Text('Profile'),
      ),
      body: Container(
        color:  isWhite ?Colors.white :Colors.black,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(user.photoURL.toString()),
              ),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name : ',style: TextStyle(color: isWhite?Colors.black :Colors.white,fontSize: 20,fontFamily: 'LemonMilkRegular')),
                  Text(user.displayName.toString(),style: TextStyle(color: isWhite?Colors.black :Colors.white,fontSize: 20,fontFamily: 'LemonMilkRegular'),),
                  
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Email : ',style: TextStyle(color: isWhite?Colors.black :Colors.white,fontSize: 15,)),
                  Text(user.email.toString(),style: TextStyle(color: isWhite?Colors.black :Colors.white,fontSize: 15),),
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}