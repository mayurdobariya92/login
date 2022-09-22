import 'package:flutter/material.dart';
import 'package:login/register.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController temail = TextEditingController();
  TextEditingController tpassword = TextEditingController();
bool firstvalue =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xffC9F2C9),
            Color(0xffCCF2C9),
            Color(0xffBFF2C9),
            Color(0xffB3F2C9),
          ], end: Alignment.bottomLeft, begin: Alignment.topRight)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 150,
                alignment: Alignment.center,
                child: Text("!Wellcome!",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 25)),
                decoration: BoxDecoration(color: Colors.transparent),
              ),
              SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: temail,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "EMAIL",
                      filled: true,
                      prefixIcon: Icon(Icons.mail)),
                ),
              ),
              SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tpassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "ENTER PASSWORD",
                    filled: true,
                    prefixIcon: Icon(Icons.visibility),
                  ),
                ),
              ),
              SizedBox(height: 3),
              ElevatedButton(onPressed: () {

              }, child: Text("Login")),
              SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                 Checkbox(value: firstvalue, onChanged: (value) {
                   setState(() {
                     firstvalue=value!;
                   });
                 },),Text("Remember me"),

                 TextButton(onPressed: () {

                 }, child: Text("Forget Password?",style: TextStyle(fontWeight: FontWeight.bold),))
                ],),
              ),
              SizedBox(height: 3),
              Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                Text("Don't have an account?"),
                TextButton(onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return register();
                  },));
                }, child: Text("Register",style: TextStyle(fontWeight: FontWeight.bold),))
              ],),
            ],
          ),
        ),
      ),
    );
  }
}
