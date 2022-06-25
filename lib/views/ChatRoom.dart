
import 'dart:async';

import 'package:chat/Services/Constants.dart';
import 'package:chat/Services/Database.dart';
import 'package:chat/Themes/Themes.dart';
import 'package:chat/Utils/shimmer.dart';
import 'package:chat/main.dart';
import 'package:chat/models/popupmenuchoice.dart';
import 'package:chat/views/ContactUs.dart';
import 'package:chat/views/Conversation_screen.dart';
import 'package:chat/views/Help.dart';
import 'package:chat/views/Profile.dart';
import 'package:chat/views/signUp.dart';
import 'package:chat/views/userList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/Auth.dart';
import '../Services/helperFunctions.dart';



class ChatRoomSceen extends StatefulWidget {
  ChatRoomSceen({Key? key}) : super(key: key);

  @override
  State<ChatRoomSceen> createState() => _ChatRoomSceenState();
}

class _ChatRoomSceenState extends State<ChatRoomSceen> {
  Stream? ChatRoomStream;
  bool isLoading = true;

  dataLoading()async{
    Timer(Duration(seconds: 5),(){
      setState(() {
        isLoading = false;
      });
    });
  }
 
  @override
  void initState() {
    getuserInfo();
    dataLoading();
    super.initState();
  }

  getuserInfo()async{
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    setState(() {
       database.getChatRoom(Constants.myName).then((value){
      setState(() {
        ChatRoomStream = value;
      });
    });
    });
    print(Constants.myName);
  }

  Widget chatRoomList(){
    return StreamBuilder(
      stream: ChatRoomStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index){
              return isLoading ?  ShimmerList() :  ChatRoomTile(
                userName: snapshot.data.docs[index]['chatroom']
                .toString().replaceAll('_', '').replaceAll(Constants.myName, ''),
                chatroomId: snapshot.data.docs[index]['chatroom'],
                callback: (){
                  FirebaseFirestore.instance.collection('chat_room').doc(snapshot.data.docs[index]['chatroom']).delete();
                },
                );
            },
          );
        }
        else{
          return Text('');
        }
      },
    );
  }

  List<PopUpChoice> choices = <PopUpChoice>[
    PopUpChoice(title: 'Profile', icon: Icons.person),
    PopUpChoice(title: 'Help', icon: Icons.help_outline_rounded),
    PopUpChoice(title: 'Contact Us', icon: Icons.contact_mail),
    PopUpChoice(title: 'Sign Out', icon: Icons.exit_to_app),

  ];



  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
   
   return Scaffold(
     drawer: Drawer(
       child: Center(child: Text(Constants.myName)),
     ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Welcome ${user.displayName}',style: TextStyle(fontFamily: 'LemonMilkRegular',fontSize: 15,color:isWhite ? themes.primaryColor : Colors.purple[100]),),
        backgroundColor: isWhite ? Colors.white : Colors.black,
        leading: IconButton(
          icon: Switch(
            value: isWhite,
            onChanged: (value){
              setState(() {
                isWhite = !isWhite;
               
                print(isWhite);
              });
            },
            activeColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.black45,
            activeTrackColor: Colors.grey,
          ),
          onPressed: ()=>'',
        ),
        actions: [
           buildPopUpMenu(),
        ],
      ),
  
    body: chatRoomList(),
    backgroundColor: isWhite ? Colors.white : Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: themes.primaryColor,
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>userList()));
        },
        child: Icon(Icons.chat),
      ),
    );
  }
  void onItemmenupress(PopUpChoice choice){
    if(choice.title == 'Sign Out'){
      Auth authProvider = context.read<Auth>();
      authProvider.signOut().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>SignUpScreen())));
    }
    else if(choice.title == 'Help'){
       Navigator.push(context, MaterialPageRoute(builder: ((context) => Help())));
    }
    else if(choice.title == 'Contact Us'){
       Navigator.push(context, MaterialPageRoute(builder: ((context) => ContactUs())));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: ((context) => Profile())));
    }
  }
   Widget buildPopUpMenu(){
    return PopupMenuButton<PopUpChoice>
    (
      icon: Icon(Icons.more_vert,color: Colors.grey,),
      onSelected: onItemmenupress,
      itemBuilder: (BuildContext context){
        return choices.map((PopUpChoice choice){
          return PopupMenuItem<PopUpChoice>(
            value: choice,
            child: Row(
              children: [
                Icon(
                  choice.icon,
                  color: themes.primaryColor,
                ),
                Container(
                  width: 10,
                ),
                Text(
                  choice.title,
                  style: TextStyle(color: themes.primaryColor),
                ),

              ],
            )
            );
        }).toList();
      }
      );
}
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final VoidCallback callback;
  final String chatroomId;
  
  const ChatRoomTile({Key? key, required this.userName, required this.chatroomId, required this.callback, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          tileColor: isWhite ? Colors.grey[300] : Colors.grey,
          textColor: isWhite ? Colors.black : Colors.white,
          trailing: IconButton(icon: Icon(Icons.delete,color: isWhite ? Colors.red :Colors.red,), onPressed: (){callback();},),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ConversationScreen(userName: userName, chatRoomId: chatroomId)));
          },
          leading: CircleAvatar(
            child: Text(userName.substring(0,1)),
          ),
          title: Text(userName),
          subtitle: Text('Tap to chat',style: TextStyle(color: isWhite ? Colors.grey :Colors.white54),),
        
      ),
    );
  }
}