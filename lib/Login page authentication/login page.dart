
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hospitel_app/Login%20page%20authentication/Foregot_Password.dart';
import 'package:hospitel_app/Login%20page%20authentication/Sign%20_up_page.dart';
import 'package:hospitel_app/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {
    if(_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login SaccessFull'),
          backgroundColor: Colors.green,
        ));
        final SharedPreferences preferences =
        await SharedPreferences.getInstance();
        preferences.setBool("islogged", true);
        Navigator.pushNamed(context, "Myapp");
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Login faile$e"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
  Future googleSignin()async{
    final google=GoogleSignIn();
    final user= await google.signIn().catchError((onError){});
    if(user==null){
      return;
    }else{
      final auth=await user.authentication;
      final cridential= await GoogleAuthProvider.credential(
          idToken: auth.idToken,
          accessToken: auth.accessToken
      );
      await FirebaseAuth.instance.signInWithCredential(cridential);
      final SharedPreferences preferences = await SharedPreferences
          .getInstance();
      preferences.setBool('isLogged', true);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Sign_Up_page()));
                          },
                          child: Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 16
                                ),
                              ),
                            ),),),],),),

                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Welocome back you've been missed",
                    style: TextStyle(fontSize: 19),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextFormField(
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@email\.com$').hasMatch(value)) {
                          return 'Please enter a valid Gmail address';
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
                        if(value==null || value.isEmpty){
                          return 'Enter your password';
                        } if(value.length < 6){
                          return 'Password must be at least 6 characters';
                        }
                      },
                      controller: password,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => forgot_password()));
                          },
                        )
                      ],
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
                          login();
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          googleSignin();
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black,
                              border: Border.all(color: Colors.white)),
                          child: Icon(
                            Icons.g_mobiledata,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black,
                              border: Border.all(color: Colors.white)),
                          child: Icon(
                            Icons.facebook_outlined,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//
//
// class Usersignup extends StatefulWidget {
//   const Usersignup({super.key});
//
//   @override
//   State<Usersignup> createState() => _UsersignupState();
// }
//
// class _UsersignupState extends State<Usersignup> {
//
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController semail=TextEditingController();
//   TextEditingController spassword=TextEditingController();
//   TextEditingController sname=TextEditingController();
//   String? name= '';
//   Future signup()async{
//     if (_formKey.currentState!.validate()) {
//       try{
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: semail.text.trim(),
//           password: spassword.text.trim(),
//
//         );
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Sign up successfull'),backgroundColor: Colors.green,),
//
//         );
//         final SharedPreferences preferences = await SharedPreferences.getInstance();
//         preferences.setBool('isLogged', true);
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(name:name)));
//       }catch(e){
//         print(e);
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Something went wrong!'),backgroundColor: Colors.redAccent,));
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             decoration: BoxDecoration(
//                 color: Colors.grey.shade100
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: MediaQuery.of(context).size.height*1/5,),
//                   Center(
//                     child: Material(
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height*3/5,
//                         width: 320,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.white,width: 2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(top: 30),
//                               child: Text('Sign Up',style: TextStyle(color: Colors.black,
//                                   fontWeight: FontWeight.bold,fontSize: 35),),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
//                               child: TextField(
//                                 controller: sname,
//                                 cursorColor: Colors.green.shade900,
//                                 style: TextStyle(color: Colors.black),
//                                 decoration: InputDecoration(
//                                   label:Text('Name',style: TextStyle(color: Colors.grey),),
//                                   filled: true,
//                                   fillColor: Colors.white12,
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide: BorderSide(width: 1,color: Colors.grey.shade700)
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide: BorderSide(width: 1,color: Colors.grey.shade700)
//                                   ),
//                                 ),
//                               ),
//                             ), Padding(
//                               padding: const EdgeInsets.only(top: 25,left: 20,right: 20),
//                               child: TextFormField(
//                                 validator: (value){
//                                   if(value==null || value.isEmpty){
//                                     return 'Enter your email';
//                                   }
//                                   if (!RegExp(r'^[\w-\.]+@gmail\.com$').hasMatch(value)) {
//                                     return 'Please enter a valid Gmail address';
//                                   }
//                                   return null;
//                                 },
//                                 controller: semail,
//                                 cursorColor: Colors.green.shade900,
//                                 style: TextStyle(color: Colors.black),
//                                 decoration: InputDecoration(
//                                   label:Text('Email',style: TextStyle(color: Colors.grey),),
//                                   filled: true,
//                                   fillColor: Colors.white12,
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(width: 1),
//                                       borderRadius: BorderRadius.circular(15)
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
//                               child: TextFormField(
//                                 validator: (value){
//                                   if(value==null || value.isEmpty){
//                                     return 'Enter your password';
//                                   } if(value.length < 6){
//                                     return 'Password must be at least 6 characters';
//                                   }
//                                 },
//                                 controller: spassword,
//                                 cursorColor: Colors.green.shade900,
//                                 style: TextStyle(color: Colors.black),
//                                 decoration: InputDecoration(
//                                   label:Text('Password',style:TextStyle(color: Colors.grey),),
//                                   filled: true,
//                                   fillColor: Colors.white12,
//                                   //suffixIcon: Icon(CupertinoIcons.eye,color: Colors.black54,),
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(width: 1),
//                                       borderRadius: BorderRadius.circular(15)
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 30,),
//                             MaterialButton(onPressed: (){
//                               setState(() {
//                                 signup();
//                                 name=sname.text;
//                               });
//                             }, child: Text('Sign Up',style: TextStyle(color: Colors.white)),
//                               color: Colors.green.shade700,
//                               minWidth: 285,
//                               height: 45,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height:MediaQuery.of(context).size.height*1/4,)
//                 ],
//               ),
//             ),
//           ),
//         )
//     );
//   }
// }
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// //
// // class Usersignup extends StatefulWidget {
// //   @override
// //   _UsersignupState createState() => _UsersignupState();
// // }
// //
// // class _UsersignupState extends State<Usersignup> {
// //
// //
// //   // Firebase login function
// //   Future<void> _login() async {
// //     if (_formKey.currentState!.validate()) {
// //
// //       try {
// //         await FirebaseAuth.instance.signInWithEmailAndPassword(
// //           email: _emailController.text.trim(),
// //           password: _passwordController.text.trim(),
// //         );
// //         // Navigate to the next screen (e.g. Home screen)
// //         Navigator.pushReplacementNamed(context, '/home');
// //       } catch (e) {
// //         // Show error message
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Login failed: ${e.toString()}')),
// //         );
// //       }
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Login')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               TextFormField(
// //                 controller: _emailController,
// //                 decoration: InputDecoration(
// //                   labelText: 'Email',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter your email';
// //                   }
// //                   // Check if the email format is valid
// //                   final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
// //                   if (!emailRegex.hasMatch(value)) {
// //                     return 'Please enter a valid email';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               SizedBox(height: 16.0),
// //               TextFormField(
// //                 controller: _passwordController,
// //                 obscureText: true,
// //                 decoration: InputDecoration(
// //                   labelText: 'Password',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter your password';
// //                   }
// //                   if (value.length < 6) {
// //                     return 'Password must be at least 6 characters';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               SizedBox(height: 20.0),
// //                ElevatedButton(
// //                 onPressed: _login,
// //                 child: Text('Login'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }