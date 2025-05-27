import 'package:flutter/material.dart';
import 'package:hospitel_app/Login%20page%20authentication/google_signin.dart';
import 'package:hospitel_app/screens/Add_doctor.dart';
import 'package:hospitel_app/screens/home_page.dart';
import 'Add_New_doctor.dart';
class chekking extends StatefulWidget {
  const chekking({super.key});

  @override
  State<chekking> createState() => _chekkingState();
}

class _chekkingState extends State<chekking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF75afb3),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_rounded)),
            ],
          ),
         SizedBox(height: 320,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("Please Fill the details in this doctor \nregistration form.")),
              ),
              SizedBox(height: 20,),
              Center(
                child: Material(
                  elevation: 10,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return DoctorFormScreen();
                      }));
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Center(
                        child: Text(
                          "Sure",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
