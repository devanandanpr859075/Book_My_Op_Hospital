// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hospitel_app/screens/home_page.dart';
// import 'package:hospitel_app/screens/leave%20report%20page.dart';
// import 'package:sign_in_button/sign_in_button.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Future googlesignin()async{
//     final google=GoogleSignIn();
//     final user =await google.signIn().catchError((onError){});
//     if(user==null){
//       return;
//     }else{
//       final auth= await user.authentication;
//       final credential= await GoogleAuthProvider.credential(
//         idToken: auth.idToken,
//         accessToken: auth.accessToken,
//       );
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  Center(
//         child: SizedBox(
//           height: 50,
//           child: SignInButton(Buttons.google,
//               text: 'Sign up with google',
//               onPressed: (){
//                 googlesignin();
//               }),
//         ),
//       ),
//     );
//   }
//
// }