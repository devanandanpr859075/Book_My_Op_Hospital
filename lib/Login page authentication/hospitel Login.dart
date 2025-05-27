import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospitel_app/Login%20page%20authentication/splash_screen.dart';
import 'package:hospitel_app/main.dart';
import 'package:hospitel_app/screens/home_page.dart';

class hospital_Login extends StatefulWidget {
  const hospital_Login({super.key});

  @override
  State<hospital_Login> createState() => _hospital_LoginState();
}

class _hospital_LoginState extends State<hospital_Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    height: 400,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.redAccent.withOpacity(0.9),
                          // Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.9)
                        ])
                    ),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Hospital",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                            ),),
                            Text("Panel",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                            ),),

                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Container(
                      child: Container(
                        height: MediaQuery.of(context).size.height/1.3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Text("Hospital id",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w500),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: TextField(
                                controller: email,
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey.shade400)),
                                    // fillColor: Colors.black,
                                    filled: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Text("Password",style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.w500),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: TextField(
                                controller: password,
                                obscureText: true,
                                maxLength: 10,
                                autofocus: true,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.password),
                                    hintText: "Password",
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black)),
                                    // fillColor: Colors.,
                                    filled: true),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                loginAdmin();
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(25),
                                  margin: const EdgeInsets.symmetric(horizontal: 25),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.red,
                                        Colors.black
                                      ]),
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      "Sign in",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 25),
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //         child: Divider(
                            //           thickness: 0.5,
                            //           color: Colors.grey.shade400,
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding: const EdgeInsets.all(10.0),
                            //         child: Text(
                            //           "Or Continue with",
                            //           style: TextStyle(
                            //               color: Colors.grey.shade700,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: Divider(
                            //           thickness: 0.5,
                            //           color: Colors.grey.shade400,
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("hospital").get().then((snapshot) {
      return snapshot.docs.forEach((result) {
        if (result.data()["hospitalId"] != email.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                        "Your id is not correct",
                        style: TextStyle(color: Colors.red),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.warning_outlined,
                    color: Colors.amber.withOpacity(0.8),
                  )
                ],
              )));
        } else if (result.data()["password"] != password.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                        "Your password is not correct",
                        style: TextStyle(color: Colors.red),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.warning_outlined,
                    color: Colors.amber.withOpacity(0.8),
                  )
                ],
              )));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Myapp();
          }));
        }
      });
    });
  }
}
