import 'package:cloud_firestore/cloud_firestore.dart';
class database{

 static getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("user")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }
 
 static getUserbyUsername(String username)async{
  return await FirebaseFirestore.instance.collection('user')
   .where('name',isEqualTo: username ).limit(1).get();
 }
 static getUserbyUseremail(String useremail)async{
  return await FirebaseFirestore.instance.collection('user')
   .where('email',isEqualTo: useremail ).get();
 }

 static uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection('user')
    .add(userMap);
  }

  static createChatromm(String ChatroomId,chatRoomMap){
    FirebaseFirestore.instance.collection('chat_room').doc(ChatroomId).set(chatRoomMap).catchError((e){
      print(e);
    });
  }

  static addConversationMessages(String chatroomId,messageMap){
    FirebaseFirestore.instance.collection('chat_room').
    doc(chatroomId).collection('Chats').add(messageMap);
  }

  static getConversationMessages(String chatroomId)async{
   return FirebaseFirestore.instance.collection('chat_room').
    doc(chatroomId).collection('Chats').orderBy('ordertime',descending: false).snapshots();
  }

  static getChatRoom(String userName)async{
    return await FirebaseFirestore.instance.collection('chat_room')
    .where('users',arrayContains: userName).snapshots();
  }

  static getuser()async{
    return await FirebaseFirestore.instance.collection('user').snapshots();
  }

  
  
}