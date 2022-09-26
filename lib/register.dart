import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/loginpage.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController temail = TextEditingController();
  TextEditingController tpassword = TextEditingController();
  TextEditingController tcontact = TextEditingController();
  TextEditingController tname = TextEditingController();

  ImagePicker _picker = ImagePicker();

  String imagepath = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xffC9F2C9),
                Color(0xffCCF2C9),
                Color(0xffBFF2C9),
                Color(0xffB3F2C9),
              ], end: Alignment.bottomLeft, begin: Alignment.topRight)),
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ListView(
                  children: [
                    Container(
                      height: 150,
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title: Text("Choose Image"),
                                children: [
                                  ListTile(
                                    title: Text("Camera"),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      XFile? image = await _picker.pickImage(
                                          source: ImageSource.camera);
                                      if (image != null) {
                                        setState(() {
                                          imagepath = image.path;
                                        });
                                      }
                                    },
                                  ),
                                  ListTile(
                                    title: Text("Gallery"),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      XFile? image = await _picker.pickImage(
                                          source: ImageSource.gallery);
                                      if (image != null) {
                                        setState(() {
                                          imagepath = image.path;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          child: imagepath.isEmpty
                              ? Image.asset("myimages/user.png")
                              : Image.file(File(imagepath)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: tname,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Name",
                            filled: true,
                            prefixIcon: Icon(Icons.account_box_rounded)),
                      ),
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
                            labelText: "Email",
                            filled: true,
                            prefixIcon: Icon(Icons.mail)),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: tcontact,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Contact",
                            filled: true,
                            prefixIcon: Icon(Icons.call)),
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
                          labelText: "Password",
                          filled: true,
                          prefixIcon: Icon(Icons.visibility),
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            String name = tname.text;
                            String email = temail.text;
                            String contact = tcontact.text;
                            String password = tpassword.text;

                            DateTime dt = DateTime.now();

                            String filename =
                                "$name${dt.year}${dt.month}${dt.day}${dt.hour}${dt.minute}${dt.second}.jpg";

                            var formData = FormData.fromMap({
                              'name': name,
                              'email': email,
                              'contact': contact,
                              'password': password,
                              'file': await MultipartFile.fromFile(imagepath,
                                  filename: filename),
                            });
                            var response = await Dio().post(
                                'https://mayurnda.000webhostapp.com/ecom/ecom_insert.php',
                                data: formData);
                            print(response.data);

                            Map map = jsonDecode(response.data);

                            int status = map['status'];

                            if (status == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Sorry! Try again")));
                            } else if (status == 1) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return loginpage();
                                },
                              ));
                            }
                            if (status == 2) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("User already exists")));
                            }
                          },
                          child: Text("Register")),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: backPress);
  }

  Future<bool> backPress() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return loginpage();
      },
    ));
    return Future.value();
  }
}
