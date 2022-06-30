
import 'package:chat/Services/Constants.dart';
import 'package:chat/Services/Database.dart';
import 'package:chat/Themes/Themes.dart';
import 'package:chat/views/Conversation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Services/Auth.dart';
import '../main.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
  
 QuerySnapshot? searchSnapshot;
 Stream? userStream;

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
   getUser(){
    database.getuser().then((value){
    setState(() {
        userStream = value;
    });
    });
  }


  initialSearch(){
    database.getUserbyUsername(_searchController.text)
    .then((value){
      setState(() {
        searchSnapshot = value; 
      });
    });
  }

   createChatroomandStartConversation({required String userName}){
   if(userName != Constants.myName){
     String chatRoomId = getChatRoomId(userName,Constants.myName);
    List<String> users = [userName,Constants.myName];
    Map<String,dynamic> chatRoomMap = {
      'users':users,
      'chatroom':chatRoomId,
      'Time': DateTime.now().isUtc
    };
    database.createChatromm(chatRoomId,chatRoomMap);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationScreen(userName: userName,chatRoomId:chatRoomId)));
   }
   else{
     Fluttertoast.showToast(msg: 'You can not send message to yourself');
   }
  }

  @override
  void initState() {
    // TODO: implement initState
    initialSearch();
    getUser();
    super.initState();
    
  }

  
  
getChatRoomId(String a,String  b){
  if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }
  else{
     return "$a\_$b";
  }
}

   
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
      elevation: 0,
      foregroundColor: isWhite ? Colors.black : Colors.white,
      backgroundColor: isWhite ? Colors.white : Colors.black,
     
      title: Text('Search Users',style: TextStyle(fontFamily: 'LemonMilkRegular',fontSize: 20,color:isWhite ? themes.primaryColor : Colors.purple[100]),),
    ),
   
    body: Container(
      color: isWhite ? Colors.white : Colors.black,
      child: Column(
        children: [
          Container(
            height: 60,
            color: Color.fromARGB(255, 108, 95, 110),
            child: Row(
              children: [
                SizedBox(width: 15,),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      hintText: 'Search Username...'
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    initialSearch();
                  },
                  child: Container(
                    child: Icon(Icons.search,color: Colors.white,)),
                ),
                   SizedBox(width: 15,),
              ],
            ),
          ),
          Container(
            child: searchList(),
          )
        ],
      ),
    ),
    );
  }
  
  Widget searchTile({required String userName, required String email}){
    return Container(
      child: ListTile(
        textColor: isWhite ? Colors.black : Colors.white,
        title: Text(userName),
        subtitle: Text(email),
        trailing: IconButton(onPressed: (){
         createChatroomandStartConversation(
           userName: userName
           );
        }, icon: Icon(Icons.message,color:isWhite ? themes.primaryColor: Colors.purple[100],)),
      )
    );
  }

 

  Widget searchList(){
    return searchSnapshot!= null ?ListView.builder(
      itemCount: searchSnapshot!.docs.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        return searchTile(
          userName: searchSnapshot!.docs[index]['name'],
           email: searchSnapshot!.docs[index]['email']
        );
      }
    ) :Container();
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



}
