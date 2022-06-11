import 'package:flutter/material.dart';


class UserNameFeild extends StatelessWidget {
  const UserNameFeild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        hintText: 'Enter Username',
        label: Text('Username'),
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        )
      ),
    );
  }
}