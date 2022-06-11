
import 'package:chat/Themes/Themes.dart';
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
        backgroundColor: isWhite ?Colors.white :Colors.black,
        foregroundColor: isWhite ?Colors.black :Colors.white,
        title: Text('Contact Us')
      ),
    body:  Container(
        color: isWhite ?Colors.white :Colors.black,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: isWhite ? themes.primaryColor : Colors.purple[100],
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                    elevation: 0
                  ),
                  onPressed: ()async{
                  }, icon: Icon(Icons.email), label: Text('Email : naimishborad34@gmail.com')),
                  SizedBox(height: 20,),
                   ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: isWhite ? themes.primaryColor : Colors.purple[100],
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                    elevation: 0
                  ),
                  onPressed: (){
                    launch('https://twitter.com/naimishborad');
                  }, icon: Icon(FontAwesomeIcons.twitter), label: Text('Twitter')),
                   SizedBox(height: 20,),
                   ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: isWhite ? themes.primaryColor : Colors.purple[100],
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                    elevation: 0
                  ),
                  onPressed: (){
                    launch('https://github.com/naimishborad');
                  }, icon: Icon(FontAwesomeIcons.github), label: Text('Github')),
                  SizedBox(height: 20,),
                   ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: isWhite ? themes.primaryColor : Colors.purple[100],
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                    elevation: 0
                  ),
                  onPressed: (){
                    launch('https://www.linkedin.com/in/naimish-borad-55b757220/');
                  }, icon: Icon(FontAwesomeIcons.linkedin), label: Text('LinkedIn')),
                   SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}