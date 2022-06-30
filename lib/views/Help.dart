import 'package:chat/Themes/colors.dart';
import 'package:chat/main.dart';
import 'package:chat/main.dart';
import 'package:flutter/material.dart';
class Help extends StatefulWidget {
  Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        backgroundColor: isWhite ? lightColorScheme.primary :darkColorScheme.primary,
        foregroundColor:isWhite ? lightColorScheme.onPrimary :darkColorScheme.onPrimary,
        title: Text('Help')
      ),
      body: Container(
        color: isWhite ? lightColorScheme.background :darkColorScheme.background,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text('1.This is basic chat app made with flutter and firebase.',style: TextStyle(fontSize: 15,color: isWhite ?Colors.black :Colors.white),),
                Text('2.User chat with other users available on this app.',style: TextStyle(fontSize: 15,color: isWhite ?Colors.black :Colors.white)),
                Text('3.You can also see all availabe users clicking on chat button situated bottom right in main chat room screen.',style: TextStyle(fontSize: 15,color: isWhite ?Colors.black :Colors.white)),
                Text('4.You can search other user by clicking on search button on appbar in all user screen.',style: TextStyle(fontSize: 15,color: isWhite ?Colors.black :Colors.white)),
                Text('5.You can send message by clicking on tile displayed.',style: TextStyle(fontSize: 15,color: isWhite ?Colors.black :Colors.white)),
                Text('6.All your chat will be show on main chat room screen.',style: TextStyle(fontSize: 15,color: isWhite ?Colors.black :Colors.white)),
                Text('7.User ca switch theme mode by taping on swich given in main page.',style: TextStyle(fontSize: 15,color: isWhite ?Colors.black :Colors.white)),
                Text('8.Every user can see profile details by clicking on profile tab in popupmenu on main chat screen.',style: TextStyle(fontSize: 15,color: isWhite ?Colors.black :Colors.white)),
                Text('9.User can signout by taping sign-out tab in popupmenu.',style: TextStyle(fontSize: 15,color: isWhite ?Colors.black :Colors.white)),
                SizedBox(height: 50,)
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}