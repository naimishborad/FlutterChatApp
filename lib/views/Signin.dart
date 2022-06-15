
// import 'dart:math';

// import 'package:chatapp/Services/Auth.dart';
// import 'package:chatapp/Services/Database.dart';
// import 'package:chatapp/Services/helperFunctions.dart';

// import 'package:chatapp/Themes/Themes.dart';
// import 'package:chatapp/Utils/Google_signIn_button.dart';
// import 'package:chatapp/Utils/Usernamefield.dart';
// import 'package:chatapp/Utils/signInbutton.dart';
// import 'package:chatapp/views/ChatRoom.dart';
// import 'package:chatapp/views/ForgotPass.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Services/Constants.dart';
// import '../Utils/ForgotpasswordText.dart';
// import '../Utils/TextFormFeilds.dart';
// import '../Utils/dontaccounttext.dart';


// class SignInScreen extends StatefulWidget {
//   SignInScreen({Key? key}) : super(key: key);

//   @override
//   State<SignInScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignInScreen> {
//   final key = GlobalKey<FormState>();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _PassController = TextEditingController();
  

 

//     getuserInfo()async{
//       Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
     
//   }
//   @override
//   void initState() {
//     getuserInfo();
//     // TODO: implement initState
//     super.initState();
//   }
//    @override
//     void dispose(){
//       _emailController.dispose();
//       _PassController.dispose();
//       super.dispose();
//     }
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         title: Padding(
//           padding: const EdgeInsets.only(top: 15),
//           child: Text('Flutter Chat App',style: TextStyle(fontFamily: 'Mystic',fontSize: 45,color: themes.primaryColor),),
//         ),
//       ),
//       body: Container(
//         child: Form(
//           key: key,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // TextFormField(
//                 //     controller: _usernameController,
//                 //     decoration: InputDecoration(
//                 //     hintText: 'Enter Username',
//                 //     label: Text('Username'),
//                 //     prefixIcon: Icon(Icons.person),
//                 //     border: OutlineInputBorder(
//                 //     borderRadius: BorderRadius.all(Radius.circular(10))
//                 //     )
//                 //     ),
//                 // ),
//                 SizedBox(height: 20,),
//                 emailformfield(emailController: _emailController),
//                 SizedBox(height: 20,),
//                 passFormField(PassController: _PassController),
//                 SizedBox(height: 10,),
//                 GestureDetector(
//                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ForgotPass())),
//                  child: Container(
//                    alignment: Alignment.centerRight,
//                    child: Text('Forgot Password?',style: TextStyle(color: Colors.red),))),
//                 SizedBox(height: 15,),
//                 SignInButton(
//                   callback: (){
//                     if(key.currentState!.validate()){
//                       final provider = Provider.of<Auth>(context,listen: false);
//                       provider.loginUser(_emailController.text, _PassController.text).then((value) async{
//                         if(value!=null){
//                            QuerySnapshot userInfoSnapshot =
//                                await FirebaseFirestore.instance.collection('user').where('email',isEqualTo: _emailController).get();

//                            HelperFunctions.saveUserLoggedInSharedPreference(true);
//                           HelperFunctions.saveUserNameSharedPreference(
//                           userInfoSnapshot.docs[0]["name"]);
//                           HelperFunctions.saveUserEmailSharedPreference(
//                             userInfoSnapshot.docs[0]["email"]);

//                         }
//                       });
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoomSceen()));
//                     }
//                   },
//                   ),
//                 SizedBox(height: 10,),
//                 // Google_Signin_button(),
//                 SizedBox(height: 10,),
//               dontaccount(),
//               SizedBox(height: 30,),
//               Text('Note : Please enter valid username and email which you have entered before....')
//               ],
//             ),
//           ),
//         )
//       ),
//     );
//   }
// }


