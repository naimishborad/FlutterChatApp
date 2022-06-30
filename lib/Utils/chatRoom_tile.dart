import 'package:flutter/material.dart';

import '../Themes/colors.dart';
import '../main.dart';
import '../views/Conversation_screen.dart';

class ChatRoomTile extends StatefulWidget {
  final String userName;
  final VoidCallback callback;
  final String chatroomId;
  bool isOpned;
  final String profileImage;
 
  ChatRoomTile({
    Key? key,
    required this.userName,
    required this.callback,
    required this.chatroomId,
    required this.isOpned,
     required this.profileImage,
  }) : super(key: key);

  @override
  State<ChatRoomTile> createState() => _ChatRoomTileState();
}

class _ChatRoomTileState extends State<ChatRoomTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          tileColor: isWhite ? lightColorScheme.secondary: darkColorScheme.secondary,
          textColor: isWhite ? lightColorScheme.onSecondary : darkColorScheme.onSecondary,
          trailing: IconButton(icon: Icon(Icons.delete,color: isWhite ? Colors.red :Colors.red,), onPressed: (){widget.callback();},),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ConversationScreen(userName: widget.userName, chatRoomId: widget.chatroomId)));
            
            //    Map<String,dynamic> changeOpneState = {
            //       'isOpned' : true
            //       };
            //  FirebaseFirestore.instance.collection('chat_room').doc(widget.chatroomId).update(changeOpneState);
  
          },
          leading: CircleAvatar(
            child: Text(widget.userName.substring(0,1))
          ),
          title: Text(widget.userName,),
          subtitle: Text('Tap to chat',style: TextStyle(color: isWhite ? Colors.grey :Colors.black54),),
          
      ),
    );
  }
}