import 'package:flutter/material.dart';
import 'package:login/loginpage.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(), onWillPop: backpress);
  }
  Future<bool>backpress()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return loginpage();
    },));
    return Future.value();
  }
}
