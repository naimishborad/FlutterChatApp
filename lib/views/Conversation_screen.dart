
import 'dart:ffi';
import 'package:chat/Services/Constants.dart';
import 'package:chat/Services/Database.dart';
import 'package:chat/Themes/Themes.dart';
import 'package:chat/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ConversationScreen extends StatefulWidget {
  final String userName;
  final String chatRoomId;
   ConversationScreen({Key? key, required this.userName, required this.chatRoomId}) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  Stream? chatMessageStream;
  TextEditingController messageController = TextEditingController();


 @override
  void initState() {
    // TODO: implement initState
    database.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  Widget ChatMessageList(){
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context,index){
            return MessageTile(
              message: snapshot.data.docs[index]['message'],
              time: snapshot.data.docs[index]['time'],
              isSendByMe: snapshot.data.docs[index]['sendBy'] == Constants.myName
              );
          }
          );
        }
        else{
          return Center(child: Text('Say Hii....'));
        }
      },
    );
  }

   final String format = DateFormat('hh:mm a').format(DateTime.now());

  sendMessages(){
    Map<String,dynamic> messageMap = {
      'message': messageController.text,
      'sendBy': Constants.myName,
      'time': format,
      'reciveBy' : widget.userName,
      'ordertime':DateTime.now().microsecondsSinceEpoch
    };
    database.addConversationMessages(widget.chatRoomId,messageMap);
    messageController.text = '';
  }
 


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: isWhite ? Colors.white : Colors.black,
      appBar: AppBar(
        foregroundColor: isWhite ? Colors.black : Colors.white,
        centerTitle: true,
        backgroundColor: isWhite ? Colors.white : Colors.black,
        elevation: 0,
        title: Text(widget.userName,style: TextStyle(fontFamily: 'LemonMilkRegular',color: isWhite ? themes.primaryColor : Colors.purple[100]),),
      ),
      body:  Stack(
            children: [
            Container(
              decoration: isWhite ?  BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:  [Colors.white,themes.primaryColor] 
                )
              ) : 
              BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:  [Colors.black,themes.primaryColor] 
                )
              ) ,
              ),
            ChatMessageList(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                height: 40,
                color: Color.fromARGB(124, 108, 95, 110),
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                          hintText: 'Type message here...'
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        sendMessages();
                      },
                      child: Container(
                        child: Icon(Icons.send,color: Colors.white,)),
                    ),
                       SizedBox(width: 15,),
                  ],
                ),
                        ),
              ),
            ],
          ),
        
      
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final String time;
  final bool isSendByMe;
  const MessageTile({Key? key, required this.message, required this.time, required this.isSendByMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left:isSendByMe ? 0 : 24,
          right: isSendByMe ? 24 : 0),
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: isSendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: isSendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
        topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomRight: Radius.circular(23)),
            color: isSendByMe ? themes.primaryColor : Colors.grey
        ),
        child: Column(
          children: [
            Container(
              alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
              width: 150,
              child: Row(
                mainAxisAlignment: isSendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment:CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                        message,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                    Text(
                  time,
                  style:TextStyle(color: Colors.white38,fontSize: 10) ,
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}