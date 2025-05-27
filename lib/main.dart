import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitel_app/Login%20page%20authentication/hospitel%20Login.dart';
import 'package:hospitel_app/Login%20page%20authentication/login%20page.dart';
import 'package:hospitel_app/firebase_options.dart';
import 'package:hospitel_app/screens/Booking_managemennt/show%20all%20bookinngs.dart';
import 'package:hospitel_app/screens/cheking_page.dart';
import 'package:hospitel_app/screens/home_page.dart';

import 'screens/Add_doctor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: hospital_Login(),
    routes: {
      "Myapp": (context) => Myapp(),
      "profile": (context) => login_page()
    },
  ));
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  List screens = [
    home(),
    add_doctor(),
    all_bookings(),
     // complains(),

  ];
  int selact = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black.withOpacity(0.9),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return chekking();
            }));
          },
          child: Icon(
            Icons.person_add_alt,
            color: Colors.white,
          ),
        ),
        // backgroundColor: Colors.green,
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.recent_actors),
                  label: "Recent",
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: "Bookings ",
                  backgroundColor: Colors.black),
            ],
            currentIndex: selact,
            onTap: (value) {
              setState(() {
                selact = value;
              });
            }),
        body: screens[selact]);
  }
}
