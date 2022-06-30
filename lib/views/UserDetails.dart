
import 'package:chat/Themes/Themes.dart';
import 'package:chat/views/ChatRoom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Services/Constants.dart';
import '../Services/helperFunctions.dart';


class userDetails extends StatefulWidget {

  userDetails({Key? key,}) : super(key: key);

  @override
  State<userDetails> createState() => _userDetailsState();
}

class _userDetailsState extends State<userDetails> {
  
  @override
  void initState() {
    super.initState();
    getuserInfo();
  }
  getuserInfo()async{
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    setState(() {
      
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter Username...';
                    }
                  },
                  controller: controller,
                  decoration:  InputDecoration(
                    hintText: 'Enter Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10
                    )
                  ),
                )
          
                ),
                SizedBox(height: 20,),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: themes.primaryColor
                  ),
                  onPressed: (){
                    if(key.currentState!.validate()){
                           final user = FirebaseAuth.instance.currentUser;
                           Map<String,String> users ={
                           'name':controller.text,
                           'email':user!.email.toString()
                           };  
                        FirebaseFirestore.instance.collection('user').doc(controller.text).set(users).then((value) {
                           HelperFunctions.saveUserNameSharedPreference(controller.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ChatRoomSceen()));
                        });
                      }
                   
                }, icon: Icon(Icons.edit), label: Text('Continue'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}