
import 'package:chat/Services/Database.dart';
import 'package:chat/Themes/Themes.dart';
import 'package:chat/main.dart';
import 'package:chat/views/SearchScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Services/Constants.dart';
import 'Conversation_screen.dart';



class userList extends StatefulWidget {
  const userList({Key? key}) : super(key: key);

  @override
  State<userList> createState() => _userListState();
}


class _userListState extends State<userList> {
  Stream? userStream;
  @override
  void initState() {
    getUser();
    super.initState();
    
  }

  getUser(){
    database.getuser().then((value){
    setState(() {
        userStream = value;
    });
    });
  }
  getChatRoomId(String a,String  b){
  if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }
  else{
     return "$a\_$b";
  }
}
  createChatroomandStartConversation({required String userName}){
   if(userName != Constants.myName){
     String chatRoomId = getChatRoomId(userName,Constants.myName);
    List<String> users = [userName,Constants.myName];
    Map<String,dynamic> chatRoomMap = {
      'users':users,
      'chatroom':chatRoomId
    };
    database.createChatromm(chatRoomId,chatRoomMap);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationScreen(userName: userName,chatRoomId:chatRoomId)));
   }
   else{
     print("You can't send message to yourself");
   }
  }

  Widget userlist(){
    return StreamBuilder(
      stream: userStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return Container(
            color:isWhite ? Colors.white : Colors.black ,
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  textColor: isWhite ? Colors.black : Colors.white,
                  title: Text(
                    snapshot.data.docs[index]['name']
                  ),
                  subtitle: Text(snapshot.data.docs[index]['email']),
                  leading: CircleAvatar(
                    child: Text(snapshot.data.docs[index]['name'].toString().substring(0,1)),
                  ),
                    trailing: IconButton(onPressed: (){
                 createChatroomandStartConversation(
                    userName: snapshot.data.docs[index]['name']
                  );
        }, icon: Icon(Icons.message,color: isWhite ? themes.primaryColor : Colors.purple[100],)),
                );
              },
            ),
          );
        }
        else{
          return Text('');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
          }, icon: Icon(Icons.search))
        ],
        foregroundColor: isWhite ? Colors.black : Colors.white,
        elevation: 0,
        backgroundColor: isWhite ? Colors.white : Colors.black,
        title: Text('All Users',style: TextStyle(color: isWhite ? themes.primaryColor : Colors.purple[100]),),
      ),
      body:  userlist()
    );
  }
}