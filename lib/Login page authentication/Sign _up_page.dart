import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Sign_Up_page extends StatefulWidget {
  const Sign_Up_page({super.key});

  @override
  State<Sign_Up_page> createState() => _Sign_Up_pageState();
}

class _Sign_Up_pageState extends State<Sign_Up_page> {
  final _formkey=GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController Pass = TextEditingController();

  Future SignUp() async {
    if(_formkey.currentState!.validate()){
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: Pass.text.trim());

      // String id=randomString(10);
      // await SharedPreferenceHelper().saveUserEmail(email.text);
      // await SharedPreferenceHelper().saveUserPassword(Pass.text);
      // await SharedPreferenceHelper().saveUserId(id);


      // Map<String,dynamic> userIntoMap={
      //   "password":Pass.text,
      //   "email":email.text,
      //   "id":id,
      // };
      // await DatabaseMethods().addDetails(userIntoMap, id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("SignUp SuccessFull"),
        backgroundColor: Colors.green,
      ));
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.setBool("islogged", true);
      Navigator.pushNamed(context, "Myapp");
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "SignUp Failed$e",
          style: TextStyle(),
        ),
        backgroundColor: Colors.red,
      ));
    }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Text("Welocome ",
                  //   style: TextStyle(
                  //       fontSize: 26
                  //   ),
                  // ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextFormField(
                     validator: (value){
                       if(value==null|| value.isEmpty){
                         return "Enter Your Email";
                       }
                       if(!RegExp(r'^[\w-\.]+@email\.com$').hasMatch(value)){
                         return 'Please enter a valid gmail address';
                       }
                       return null;
                     },
                      controller: email,
                      decoration: InputDecoration(
                          hintText: "Email",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400)),
                          fillColor: Colors.grey.shade200,
                          filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      validator: (value){

                        if(value==null||value.isEmpty){
                          return 'Enter your password';
                        }
                        if(value.length<6){
                          return'Password must be at least 6 characters';
                        }
                      },


                      controller: Pass,
                      obscureText: true,
                      maxLength: 10,
                      autofocus: true,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.remove_red_eye_sharp),
                          hintText: "Password",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400)),
                          fillColor: Colors.grey.shade200,
                          filled: true),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: TextButton(
                            onPressed: () {
                              SignUp();
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Or Continue with",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey.shade400,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
