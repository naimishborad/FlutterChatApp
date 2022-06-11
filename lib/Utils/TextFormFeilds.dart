
import 'package:flutter/material.dart';

class passFormField extends StatelessWidget {
  const passFormField({
    Key? key,
    required TextEditingController PassController,
  }) : _PassController = PassController, super(key: key);

  final TextEditingController _PassController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      validator: (value){
        if(value!.isEmpty){
          return 'Enter Correct Password';
        }
      },
      decoration: InputDecoration(
        hintText: 'Enter Password',
        label: Text('Password'),
        prefixIcon: Icon(Icons.key),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        )
      ),
      controller: _PassController,
    );
  }
}

class emailformfield extends StatelessWidget {
  const emailformfield({
    Key? key,
    required TextEditingController emailController,
  }) : _emailController = emailController, super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
          return 'Enter Correct Email...';
        }
      },
      decoration: InputDecoration(
        hintText: 'Enter Email',
        label: Text('Email'),
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        )
      ),
      controller: _emailController,
    );
  }
}
