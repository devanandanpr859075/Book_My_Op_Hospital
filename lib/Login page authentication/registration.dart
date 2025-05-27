import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class registaration extends StatefulWidget {
  const registaration({super.key});

  @override
  State<registaration> createState() => _registarationState();
}

class _registarationState extends State<registaration> {
  TextEditingController emaile = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future signup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emaile.text.trim(),
          password: pass.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text("Login saccessfull")),
      );
      Navigator.pop(context);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text("login faile$e")));
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Center(
              child: Text(
                "Registration",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: emaile,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: pass,
              decoration: InputDecoration(
                  hintText: 'password',
                  labelText: 'password',
                  suffixIcon: Icon(Icons.remove_red_eye),
                  border: OutlineInputBorder()),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                signup();
              });
            },
            child: Text("Register"),
          )
        ],
      ),
    );
  }
}
