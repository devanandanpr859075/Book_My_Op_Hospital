import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';

class all_bookings extends StatefulWidget {
  const all_bookings({super.key});

  @override
  State<all_bookings> createState() => _all_bookingsState();
}

class _all_bookingsState extends State<all_bookings> {
  List<DocumentSnapshot> _pendingBookinds = [];

  void _fatchBookings() async {
    FirebaseFirestore.instance
        .collection("Booking")
        .where("status", isEqualTo: 'pending')
        .get()
        .then((QuerySnapshot qureySnapshot) {
      setState(() {
        _pendingBookinds = qureySnapshot.docs;
      });
    }).catchError((Error) {
      print(" fetching Bookings faild $Error");
    });
  }

  @override
  void initState() {
    _fatchBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("All Bookings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("Booking")
                  .where("status", isEqualTo: 'pending')
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _pendingBookinds.length,
                        itemBuilder: (context, index) {
                          // Fetch data for each booking
                          var booking = _pendingBookinds[index];
                          var bookingId = booking.id; // Get the document ID
                          var doctorName = booking['docname'];
                          var patientName = booking['Categories'];
                          var appointmentTime = booking['Time'].toString();
                          var imageUrl = booking['dp'];
                          var currentStatus =
                              booking['status']; // Get the current status

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 10,
                              color: Colors.white,
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        leading: Container(
                                          width: 60,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(imageUrl),
                                              fit: BoxFit.cover,
                                            ),
                                            color: Color(0xFFf2edf7),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        title: Text(
                                          doctorName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          patientName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: Text(
                                          currentStatus,
                                          style: TextStyle(
                                            color: Colors.pink.shade200
                                                .withOpacity(0.8),
                                            fontSize: 12,
                                          ),
                                        ),
                                        onTap: () {
                                          // Open status update dialog
                                          _showStutasDialog(
                                              bookingId, currentStatus);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Divider(),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: MediaQuery.of(context).size.width,
                                      height: 70,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Mdi.clock,
                                            size: 30,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFf2edf7),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Icon(
                                              Icons.notifications,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : Container();
              },
            )
          ],
        ),
      ),
    );
  }

  void _showStutasDialog(String bookingId, String currentStatus) {
    List<String> statuses = [
      'complete',
    ];
    String? selectedStatus = currentStatus;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(
                "Update Status",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Please select a status:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15), // Space between text and options
                    // Radio buttons for status selection
                    Column(
                      children: List.generate(statuses.length, (index) {
                        return RadioListTile<String>(
                          title: Text(statuses[index],
                              style: TextStyle(fontSize: 16)),
                          value: statuses[index],
                          groupValue: selectedStatus,
                          onChanged: (String? value) {
                            setState(() {
                              selectedStatus = value;
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
              actions: [
                // Cancel button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
                // Update button
                TextButton(
                  onPressed: () async {
                    if (selectedStatus != null) {
                      await _updateBookingStutas(bookingId, selectedStatus!);
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _updateBookingStutas(String bookingId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection("Booking")
          .doc(bookingId)
          .update({
        "status": status,
      });

      _fatchBookings();
      print("Booking status updated to $status");
    } catch (e) {
      print("Error updating booking status: $e");
    }
  }
}
