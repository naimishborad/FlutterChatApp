
import 'package:chat/Themes/Themes.dart';
import 'package:chat/views/signUp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro extends StatefulWidget {

  Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  bool isLastpage = false;
  final controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index){
            setState(() {
              isLastpage  = index == 2;
            });
          },
          controller: controller,
          children: [
            Container(
              color: Colors.white,
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Image.asset('assets/intropage1.png',height: 350,width: 350),
                 SizedBox(height: 30,),
                 Text('Chat with your friends.',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'LemonMilkRegular',color: themes.primaryColor),),
                 SizedBox(height: 30,),
                 Text('Now you can chat with all the users available on the app.',style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),)
              ],
             ),
            ),
           Container(
              color: Colors.white,
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [            
                   Image.asset('assets/intropage2.png',height: 300,width: 300,),
                 SizedBox(height: 30,),
                 Text('Search and make new friends',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'LemonMilkRegular',color: themes.primaryColor),),
                 SizedBox(height: 30,),
                 Text('Search for users available on app and start convertation.',style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),)
              ],
             ),
            ),
             Container(
              color: Colors.white,
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [            
                Image.asset('assets/google.png',height: 250,width: 250,),
                 SizedBox(height: 40,),
                 Text('Google Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontFamily: 'LemonMilkRegular',color: themes.primaryColor),),
                 SizedBox(height: 30,),
                 Text('You can now login with your google account very easily.',style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),)
              ],
             ),
            ),
          ],
        ),
      ),
      bottomSheet: isLastpage ? TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: themes.primaryColor,
          minimumSize: Size.fromHeight(60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        ),
        onPressed: ()async{
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>SignUpScreen()));
        }, 
        child: Text('Get Started')) 
      : Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: ()=>controller.jumpToPage(2), 
              child: Text('Skip')
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: WormEffect(
                    spacing: 16,
                    dotColor: Colors.black26,
                    activeDotColor: themes.primaryColor
                  ),
                  onDotClicked: (index)=> controller.animateToPage(
                    index, 
                    duration: Duration(milliseconds: 300), 
                    curve: Curves.easeIn
                    ),
                ),
              ),
              TextButton(
              onPressed: ()=>controller.nextPage(duration: Duration(microseconds: 500), curve: Curves.easeInOut), 
              child: Text('Next')
              ),
          ],
        ),
      ),
    );
  }
}