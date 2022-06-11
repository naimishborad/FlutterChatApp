import 'package:chat/Themes/Themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SignInButton extends StatelessWidget {
  final VoidCallback callback;
  const SignInButton({Key? key, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: themes.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'LemonMilkRegular'),),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  final VoidCallback callback;
  const SignUpButton({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: themes.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'LemonMilkRegular'),),
      ),
    );
  }
}
