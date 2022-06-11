
import 'package:chat/Themes/Themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Services/Constants.dart';
import '../Services/helperFunctions.dart';


class Google_Signin_button extends StatefulWidget {
  final VoidCallback callback;
   Google_Signin_button({Key? key, required this.callback}) : super(key: key);

  @override
  State<Google_Signin_button> createState() => _Google_Signin_buttonState();
}

class _Google_Signin_buttonState extends State<Google_Signin_button> {
  final gname = FirebaseFirestore.instance.collection('user').doc();
  

   getuserInfo()async{
      // Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
  }
  @override
  void initState() {
    getuserInfo();
    // TODO: implement initState
    super.initState();
  }
   final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.callback,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: themes.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.google,color: Colors.red,size: 30,),
            SizedBox(width: 10,),
            Text('SignIn With Google',style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'LemonMilkRegular'),)
          ],
        ),
      ),
    );
  }
}