import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:hospitel_app/Login%20page%20authentication/hospitel%20Login.dart';
import 'package:hospitel_app/screens/Doctors%20Display.dart';
import 'package:hospitel_app/screens/view%20details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Leave Report Calender.dart';
import 'Qr_scaner.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Color pcolor = Color(0xFF0C84FF);
  int isSelected = 0;
  int selectedIndex = 0;

  bool isSelact = false;
  double screenWidth = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isSelact = true;
      });
    });
    super.initState();
  }
  List images=[
    "lib/Asset_Images/img_2.png",
    "lib/Asset_Images/img_10.png",
    "lib/Asset_Images/img_1.png",
    "lib/Asset_Images/img_4.png",
    "lib/Asset_Images/img_3.png",
  ];


  String category =
      " General surgery";
  // for category
  final CollectionReference categoriesItems =
  FirebaseFirestore.instance.collection("Categories");
  // for all itesm display
  Query get fileteredRecipes =>
      FirebaseFirestore.instance.collection("doctors").where(
        'categories',
        isEqualTo: category,
      );
  Query get allRecipes =>
      FirebaseFirestore.instance.collection("doctors");
  Query get selectedRecipes =>
      category == "catname" ? allRecipes : fileteredRecipes;

  MaterialColor kBannerColor=Colors.green;



  Future sigout() async {
    try {
      await FirebaseAuth.instance.signOut();
      final SharedPreferences preferences =
      await SharedPreferences.getInstance();
      preferences.setBool("islogged", false);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => hospital_Login()));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
           backgroundColor: Colors.white,
            body:  Column(
              children: [
                Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: pcolor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(
                          40,
                        ),
                        bottomLeft: Radius.circular(40)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          sigout();
                        }, icon: Icon(Icons.logout),color: Colors.red,),
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return QRScanPage();
                          }));
                        }, icon: Icon(Icons.qr_code_scanner,size: 30,),),
                      ],
                    ),
                      Center(
                          child: Text(
                            "My Hospital",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TabBar(
                          indicatorWeight: 5,
                          indicatorColor: Colors.green,
                          tabAlignment: TabAlignment.fill,
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: [
                            Tab(
                              icon: Text(
                                "All Doctors",
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Tab(
                              icon: Text(
                                "leave report",
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Department",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      selectedCategory(),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Specialist Doctors",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      StreamBuilder(
                        stream: selectedRecipes.snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final List<DocumentSnapshot> recipes =
                                snapshot.data?.docs ?? [];
                            return SingleChildScrollView(
                              // scrollDirection: Axis.horizontal,
                              child: Column(
                                children: recipes
                                    .map((e) => doctorsDisplay(documentSnapshot: e))
                                    .toList(),
                              ),
                            );
                          }
                          // it means if snapshot has date then show the date otherwise show the progress bar
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                          ],
                        ),
                ),
                    ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // This will show the doctors who are currently on leave
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('doctors')
                                  .where('isOnLeave', isEqualTo: true) // Filter by doctors on leave
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                }

                                if (snapshot.hasError) {
                                  return Center(child: Text('Something went wrong.'));
                                }

                                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return Center(child: Text('No doctors are on leave.'));
                                }

                                // Extract the data from snapshot
                                final List<DocumentSnapshot> doctorsOnLeave = snapshot.data!.docs;

                                return Column(
                                  children: doctorsOnLeave.map((doc) {
                                    final doctorId = doc.id; // Get the document ID to reference it later
                                    final doctorName = doc['name'] ?? 'Unknown Doctor';
                                    final doctorSpecialty = doc['categories'] ?? 'Unknown Specialty';
                                    final leaveDays = doc['leaveDates'] ?? 0;
                                    final profilePicUrl = doc['docimg'] ?? '';

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        color: Colors.white,
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          height: 220,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 40,
                                                    backgroundImage: profilePicUrl.isNotEmpty
                                                        ? NetworkImage(profilePicUrl)
                                                        : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                                                    backgroundColor: Colors.grey,
                                                  ),
                                                  SizedBox(width: 16),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        doctorName,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        doctorSpecialty,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              SizedBox(height: 8),
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Leave Days: $leaveDays",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              MaterialButton(
                                                color: Colors.blueAccent.withOpacity(0.8),
                                                height: 36,
                                                minWidth: double.infinity,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18),
                                                ),
                                                onPressed: () async {
                                                  try {
                                                    // Update the doctor's 'isOnLeave' field to false
                                                    await FirebaseFirestore.instance
                                                        .collection('doctors')
                                                        .doc(doctorId) // Get the doctor document by ID
                                                        .update({
                                                      'isOnLeave': false, // Set isOnLeave to false
                                                      'leaveDates': FieldValue.delete(), // Remove the leaveDates field
                                                    });

                                                    // Optionally, you can also show a snackbar or some confirmation here
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text('Doctor is no longer on leave')),
                                                    );

                                                  } catch (e) {
                                                    // Handle errors (e.g., network issues)
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text('Error updating doctor status')),
                                                    );
                                                  }
                                                },
                                                child: Text(
                                                  'Rejoin',
                                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ],
        )
        )
    );
  }
  StreamBuilder<QuerySnapshot<Object?>> selectedCategory() {
    return StreamBuilder(
      stream: categoriesItems.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                streamSnapshot.data!.docs.length,
                    (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      category = streamSnapshot.data!.docs[index]['catname'];
                    });
                  },
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: 130,
                        decoration: BoxDecoration(
                            color:
                            category == streamSnapshot.data!.docs[index]['catname']
                                ? Color(0xFF0C84FF)
                                : Colors.white70,
                            borderRadius:
                            BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        color:
                                        category == streamSnapshot.data!.docs[index]['catname']
                                            ? Colors.white70
                                            : Colors.blue.shade600,
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            10)
                                    ),
                                    child: Card(
                                      elevation: 10,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(image: NetworkImage(
                                          streamSnapshot.data!.docs[index]['imageUrl']
                                        ),fit: BoxFit.cover,),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      overflow:
                                      TextOverflow.ellipsis,
                                      (streamSnapshot
                                          .data!.docs[index]
                                      ["catname"]),
                                      style: TextStyle(

                                        color:
                                        category == streamSnapshot.data!.docs[index]['catname']
                                            ? Colors.white
                                            : Colors.grey.shade600,
                                        fontWeight: FontWeight.w600,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

}

