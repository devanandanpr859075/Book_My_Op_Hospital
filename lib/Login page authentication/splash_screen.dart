import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hospitel_app/Login%20page%20authentication/hospitel%20Login.dart';
import 'package:hospitel_app/Login%20page%20authentication/login%20page.dart';
import 'package:hospitel_app/main.dart';
import 'package:hospitel_app/screens/home_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';


class splaShscrren extends StatefulWidget {
  const splaShscrren({super.key});

  @override
  State<splaShscrren> createState() => _splaShscrrenState();
}

class _splaShscrrenState extends State<splaShscrren> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlogdata().whenComplete(() {
      if (finaldata == true) {
        Future.delayed(Duration(seconds: 5), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Myapp()));
        });
         } else {
        Future.delayed(Duration(seconds: 5), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => hospital_Login()));
        });
      }
    });
  }

  bool? finaldata;

  Future getlogdata() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var getdata = preferences.getBool("islogged");
    setState(() {
      finaldata = getdata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("lib/Asset_Images/Animation - 1733308096048.json",width: 200,height: 200,fit: BoxFit.fill),
      ),
    );
  }
}
