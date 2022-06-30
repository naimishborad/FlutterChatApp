
import 'package:chat/views/Intro.dart';
import 'package:chat/views/splashScreen.dart';
import 'package:chat/Services/Auth.dart';
import 'package:chat/Services/helperFunctions.dart';
import 'package:chat/views/ChatRoom.dart';

import 'package:chat/views/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';



bool isWhite = true;
bool theme = true;
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
 final showHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(prefs: prefs,showHome: showHome,));
}


class MyApp extends StatefulWidget {
  
    final bool showHome;
    final SharedPreferences prefs;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({super.key, required this.prefs, required this.showHome});
  

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   bool userIsLoggedIn = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    getLoggedInState()async{
      await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
        setState(() {
          userIsLoggedIn = value!;
        });
      });
    }
     @override
    void initState() {
      getLoggedInState();
      super.initState();
    }
    
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (_)=>Auth(widget.prefs)
          ),
        ChangeNotifierProvider<Auth>(create: (context)=>Auth(widget.prefs)),
       
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',

          home: widget.showHome ?  SplashScreen() : Intro()
      ),
    );
  }
}


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return ChatRoomSceen();
        }
        else{
          return SignUpScreen();
        }
      },
    );
  }
}