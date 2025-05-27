import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgot_password extends StatefulWidget {
  const forgot_password({super.key});

  @override
  State<forgot_password> createState() => _forgot_passwordState();
}

class _forgot_passwordState extends State<forgot_password> {
  TextEditingController email=TextEditingController();
  Future Forgot()async{
    final forgot=email.text;
    if(forgot.contains('@')){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("send password and rest email$forgot"),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("check your email$forgot"),
        backgroundColor: Colors.redAccent,
      ));
    }

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);


  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
               controller:email ,
              obscureText: false,
              autofocus: true,
              decoration: InputDecoration(
                  hintText: "Email",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400)
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true
              ),

            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Forgot();
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                  },
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child: Text(
                        "Send Request",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          // fontSize: 16
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
