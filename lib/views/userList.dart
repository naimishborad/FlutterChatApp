import 'package:chat/Services/Database.dart';
import 'package:chat/Themes/Themes.dart';
import 'package:chat/Themes/colors.dart';
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
  TextEditingController _searchController = TextEditingController();
  Stream? userStream;
  bool isSearchOn = false;
  @override
  void initState() {
    getUser();
    initialSearch();
    super.initState();
  }

  initialSearch() {
    database.getUserbyUsername(_searchController.text).then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  getUser() {
    database.getuser().then((value) {
      setState(() {
        userStream = value;
      });
    });
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatroomandStartConversation({required String userName}) {
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        'users': users,
        'chatroom': chatRoomId,
        'time': DateTime.now().millisecondsSinceEpoch,
        'isOpned': false
      };
      database.createChatromm(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(
                  userName: userName, chatRoomId: chatRoomId)));
    } else {
      print("You can't send message to yourself");
    }
  }

  Widget userlist() {
    return StreamBuilder(
      stream: userStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            color:  isWhite ? lightColorScheme.background : darkColorScheme.background,
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  textColor: isWhite ? lightColorScheme.secondary : darkColorScheme.secondary,
                  title: Text(snapshot.data.docs[index]['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(snapshot.data.docs[index]['email']),
                  leading: CircleAvatar(
                    child: Text(snapshot.data.docs[index]['name']
                        .toString()
                        .substring(0, 1)),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        createChatroomandStartConversation(
                            userName: snapshot.data.docs[index]['name']);
                      },
                      icon: Icon(
                        Icons.message,
                        color:
                            isWhite ? lightColorScheme.primary : darkColorScheme.primary,
                      )),
                );
              },
            ),
          );
        } else {
          return Text('');
        }
      },
    );
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile(
                  userName: searchSnapshot!.docs[index]['name'],
                  email: searchSnapshot!.docs[index]['email']);
            })
        : Container();
  }

  Widget searchTile({required String userName, required String email}) {
    return ListTile(
      textColor:isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary,
      title: Text(userName,style: TextStyle(fontWeight: FontWeight.bold),),
      subtitle: Text(email),
      trailing: IconButton(
          onPressed: () {
            createChatroomandStartConversation(userName: userName);
          },
          icon: Icon(
            Icons.message,
            color: isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor:
              isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary,
          elevation: 0,
          backgroundColor:
              isWhite ? lightColorScheme.primary : darkColorScheme.primary,
          title: Text('All Users'),
        ),
        body:  Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: isSearchOn ? searchList() : userlist(),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 50,
                  color: isWhite
                      ? darkColorScheme.secondary
                      : lightColorScheme.secondary,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: isWhite
                                      ? darkColorScheme.onPrimary
                                      : lightColorScheme.onPrimary),
                              border: InputBorder.none,
                              hintText: 'Search User...'),
                        ),
                      ),
                      isSearchOn ? cancelhbutton() : Searchbutton(),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }

  Widget Searchbutton() {
    return IconButton(
        onPressed: () {
          initialSearch();
          setState(() {
            isSearchOn = true;
          });
        },
        icon: Icon(Icons.search));
  }

  Widget cancelhbutton() {
    return IconButton(
        onPressed: () {
          initialSearch();
          setState(() {
            isSearchOn = false;
          });
        },
        icon: Icon(Icons.close));
  }
}
