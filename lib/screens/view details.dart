import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospitel_app/Leave Report Calender.dart'; // Assuming you have the CalenderRangePicker widget here

class ViewDetails extends StatefulWidget {
  String? docname;
  String? doctid;
  String? docRaiting;
  String? docfee;
  String? docimg;
  String? description;
  String? Categories;
  String? email;
  String? Gender;
  String? ContactNumber;

  ViewDetails({
    super.key,
    required this.docRaiting,
    required this.description,
    required this.docfee,
    required this.docimg,
    required this.doctid,
    required this.docname,
    required this.Categories,
    required this.email,
    required this.Gender,
    required this.ContactNumber,
  });

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

final CollectionReference doctors = FirebaseFirestore.instance.collection("doctors");

void removeDoctor(String doctorId) async {
  try {
    await doctors.doc(doctorId).delete();
    print("Doctor removed successfully");
  } catch (e) {
    print("Error removing doctor: $e");
  }
}

class _ViewDetailsState extends State<ViewDetails> {
  TextEditingController _timeController = TextEditingController();
  List<String> availableTimes = [];

  @override
  void initState() {
    super.initState();
    _loadAvailableTimes();
  }

  Future<void> _loadAvailableTimes() async {
    try {
      DocumentSnapshot doctorSnapshot = await doctors.doc(widget.doctid).get();

      if (doctorSnapshot.exists) {
        var doctorData = doctorSnapshot.data() as Map<String, dynamic>;
        setState(() {
          availableTimes = List<String>.from(doctorData['availableTimes'] ?? []);
        });
      }
    } catch (e) {
      print("Error loading available times: $e");
    }
  }

  void _addAvailableTime(String newTimeSlot) {
    setState(() {
      availableTimes.add(newTimeSlot);
    });
    _timeController.clear();
  }

  Future<void> _saveAvailableTimes() async {
    try {
      await doctors.doc(widget.doctid).update({
        'availableTimes': availableTimes,
      });
      print("Updated available times saved to Firestore");
    } catch (e) {
      print("Error saving available times: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back)),
                      MaterialButton(
                        height: 30,
                        color: Colors.redAccent.withOpacity(0.5),
                        minWidth: MediaQuery.of(context).size.width / 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onPressed: () {
                          removeDoctor(widget.doctid!);
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Remove',
                              style:
                              TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.cancel,
                              color: Colors.white,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.docimg.toString()),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text("Name:", style: TextStyle(fontSize: 20)),
                      SizedBox(width: 10),
                      Text(
                        widget.docname.toString(),
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Email:", style: TextStyle(fontSize: 20)),
                      SizedBox(width: 10),
                      Text(
                        widget.email.toString(),
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Contact Number:", style: TextStyle(fontSize: 20)),
                      SizedBox(width: 10),
                      Text(
                        widget.ContactNumber.toString(),
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Gender:", style: TextStyle(fontSize: 20)),
                      SizedBox(width: 10),
                      Text(
                        widget.Gender.toString(),
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Department:", style: TextStyle(fontSize: 20)),
                      SizedBox(width: 10),
                      Text(
                        widget.Categories.toString(),
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 20),

                  // Display list of available times dynamically
                  Row(
                    children: [
                      Text(
                        "Available Times:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: availableTimes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          availableTimes[index],
                          style: TextStyle(fontSize: 17),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Add New Time Slot:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _timeController,
                    decoration: InputDecoration(
                      hintText: "Enter time slot (e.g. 9:00 AM - 12:00 PM)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_timeController.text.isNotEmpty) {
                        _addAvailableTime(_timeController.text);
                      }
                    },
                    child: Text("Add Time Slot"),
                  ),

                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Leave Report Now",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: CalenderRangePicker(doctorId: widget.doctid!),
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    color: Colors.blue.shade300,
                    height: 36,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _saveAvailableTimes();
                    },
                    child: Text(
                      'Save Available Times',
                      style: TextStyle(
                          color: Colors.white, fontSize: 16),
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
