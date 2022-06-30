
import 'package:chat/Themes/Themes.dart';
import 'package:chat/Themes/colors.dart';
import 'package:chat/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactUs extends StatefulWidget {
  ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  Future openBrowserUrl ({required String url,bool inApp = false})async{
    if(await canLaunch(url)){
      await launch(url,enableJavaScript: true,forceSafariVC: inApp,forceWebView: inApp);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isWhite ? lightColorScheme.primary : darkColorScheme.primary,
        foregroundColor: isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary,
        title: Text('Contact Us')
      ),
    body:  Container(
        color: isWhite ? lightColorScheme.background : darkColorScheme.background,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: isWhite ? lightColorScheme.primary : darkColorScheme.primary,
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                    elevation: 0
                  ),
                  onPressed: ()async{
                  }, icon: Icon(Icons.email,color: isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary), label: Text('Email : naimishborad34@gmail.com',style: TextStyle(color: isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary),)),
                  SizedBox(height: 20,),
                   ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: isWhite ? lightColorScheme.primary : darkColorScheme.primary,
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                    elevation: 0
                  ),
                  onPressed: (){
                    launch('https://twitter.com/naimishborad');
                  }, icon: Icon(FontAwesomeIcons.twitter,color: isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary), label: Text('Twitter',style: TextStyle(color: isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary))),
                   SizedBox(height: 20,),
                   ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: isWhite ? lightColorScheme.primary : darkColorScheme.primary,
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                    elevation: 0
                  ),
                  onPressed: (){
                    launch('https://github.com/naimishborad');
                  }, icon: Icon(FontAwesomeIcons.github,color: isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary,), label: Text('Github',style: TextStyle(color: isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary))),
                  SizedBox(height: 20,),
                   ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: isWhite ? lightColorScheme.primary : darkColorScheme.primary,
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                    elevation: 0
                  ),
                  onPressed: (){
                    launch('https://www.linkedin.com/in/naimish-borad-55b757220/');
                  }, icon: Icon(FontAwesomeIcons.linkedin,color: isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary), label: Text('LinkedIn',style: TextStyle(color: isWhite ? lightColorScheme.onPrimary : darkColorScheme.onPrimary))),
                   SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}