import 'package:flutter/material.dart';
import 'package:login/loginpage.dart';

class splish extends StatefulWidget {
  const splish({Key? key}) : super(key: key);

  @override
  State<splish> createState() => _splishState();
}

class _splishState extends State<splish> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    godata();
  }

  godata() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return loginpage();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffC9F2C9),
            Color(0xffCCF2C9),
            Color(0xffBFF2C9),
            Color(0xffB3F2C9),
      ], end: Alignment.bottomLeft,
              begin: Alignment.topRight)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,children: [
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue)),
            Text("Loading...."),
          ],
        ),

      ),
    ));
  }
}
