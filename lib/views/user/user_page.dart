import 'package:flutter/material.dart';
class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BottomNavigationBar Sample'),),
      body: Center( child: Text('Index 0: User')),
    );
  }
}