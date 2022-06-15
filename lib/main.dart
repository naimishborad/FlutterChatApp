
import 'package:chat/New/allScreens/splashScreen.dart';
import 'package:chat/Services/Auth.dart';
import 'package:chat/Services/helperFunctions.dart';
import 'package:chat/views/ChatRoom.dart';
import 'package:chat/views/Signin.dart';
import 'package:chat/views/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:chat/New/AuthProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';


bool isWhite = true;
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();


  runApp(MyApp(prefs: prefs));
}


class MyApp extends StatefulWidget {
    final SharedPreferences prefs;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({super.key, required this.prefs});
  

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
        ChangeNotifierProvider<AuthProvider>(
          create: (_)=>AuthProvider(
          googleSignIn : GoogleSignIn(),
          firebaseAuth: FirebaseAuth.instance,
          prefs: widget.prefs,
          firebaseFirestore: widget.firebaseFirestore
        )),
        ChangeNotifierProvider<Auth>(create: (context)=>Auth(widget.prefs)),
       
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: SplashScreen(),
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