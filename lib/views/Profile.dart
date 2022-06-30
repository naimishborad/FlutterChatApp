import 'package:chat/Themes/colors.dart';
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
        backgroundColor: isWhite ? lightColorScheme.primary : darkColorScheme.primary,
        foregroundColor: isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary,
        title: Text('Profile'),
      ),
      body: Container(
        color: isWhite ? lightColorScheme.background : darkColorScheme.background,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                   CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(user.photoURL.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: GestureDetector(
                    onTap: (){
                      
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isWhite ? lightColorScheme.primary :darkColorScheme.primary
                      ),
                      child: Text('+',style: TextStyle(color: isWhite ? lightColorScheme.onSecondary: darkColorScheme.onSecondary,fontSize: 20),)),
                  ),
                )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name : ',style: TextStyle(color: isWhite ? lightColorScheme.onBackground : darkColorScheme.onBackground,fontSize: 20,fontFamily: 'LemonMilkRegular')),
                  Text(user.displayName.toString(),style: TextStyle(color: isWhite ? lightColorScheme.onBackground : darkColorScheme.onBackground,fontSize: 20,fontFamily: 'LemonMilkRegular'),),
                  
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Email : ',style: TextStyle(color: isWhite ? lightColorScheme.onBackground : darkColorScheme.onBackground,fontSize: 15,)),
                  Text(user.email.toString(),style: TextStyle(color: isWhite ? lightColorScheme.onBackground : darkColorScheme.onBackground,fontSize: 15),),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}