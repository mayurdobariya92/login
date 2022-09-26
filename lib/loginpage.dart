import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login/homepage.dart';
import 'package:login/register.dart';
import 'package:login/utils.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController tusername = TextEditingController();
  TextEditingController tpassword = TextEditingController();
bool firstvalue =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
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
                  controller: tusername,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Username",
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
                    labelText: "Enter Password",
                    filled: true,
                    prefixIcon: Icon(Icons.visibility),
                  ),
                ),
              ),
              SizedBox(height: 3),
              ElevatedButton(onPressed: () async {
                String username=tusername.text;
                String password =tpassword.text;

                String api ='https://mayurnda.000webhostapp.com/ecom/veiw.php?username=$username&password=$password';

                Response response = await Dio().get(api);

                print(response.data);

                Map map = jsonDecode(response.data);

                int status= map['status'];

                if(status==0)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Username or Password")));

                  }
                else if(status==1)
                {
                  Map userdata =map['userdata'];

                  User user= User.fromJson(userdata);

                  await Utils.prefs!.setBool('loginstatus', true);

                  await Utils.prefs!.setString('id', user.id!);
                  await Utils.prefs!.setString('name', user.name!);
                  await Utils.prefs!.setString('email', user.email!);
                  await Utils.prefs!.setString('contact', user.contact!);
                  await Utils.prefs!.setString('password', user.password!);
                  await Utils.prefs!.setString('imagepath', user.imagepath!);

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return homepage();
                  },));


                }


              }, child: Text("Login")),
              SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Stack(children: [
                    Container(),
                    Checkbox(value: firstvalue, onChanged: (value) {
                      setState(() {
                        firstvalue=value!;
                      });
                    },),
                  Padding(
                    padding: const EdgeInsets.only(left: 34,top:14),
                    child: Text("Remember me"),
                  ),
                  ],),


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
class User {
  String? id;
  String? name;
  String? email;
  String? contact;
  String? password;
  String? imagepath;

  User(
      {this.id,
        this.name,
        this.email,
        this.contact,
        this.password,
        this.imagepath});

  User.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    password = json['password'];
    imagepath = json['imagepath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['password'] = this.password;
    data['imagepath'] = this.imagepath;
    return data;
  }
}

