import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Add_New_doctor.dart';
import 'cheking_page.dart';

class add_doctor extends StatefulWidget {

  const add_doctor({super.key, });

  @override
  State<add_doctor> createState() => _add_doctorState();
}

class _add_doctorState extends State<add_doctor> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Doctor Registration",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "recent joining",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 0.9),
                  ),
                ],
              ),
              Divider(),
              FutureBuilder(
                  future: FirebaseFirestore.instance.collection("doctors").get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final doctor=snapshot.data!.docs[index];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Card(
                                color: Color(0xFFf2edf7),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                child: Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  // height: 100,
                                  child: Stack(
                                    children: [
                                      // Positioned(
                                      //     top: 30,
                                      //     right: 3,
                                      //     child: Padding(
                                      //       padding:
                                      //       const EdgeInsets.all(
                                      //           10.0),
                                      //       child: Container(
                                      //         width: 85,
                                      //         height: 30,
                                      //         decoration: BoxDecoration(
                                      //             borderRadius:
                                      //             BorderRadius
                                      //                 .circular(10),
                                      //             gradient:
                                      //             LinearGradient(
                                      //               colors: [
                                      //                 Color(
                                      //                     0xFF4c00ff),
                                      //                 Colors.primaries
                                      //                     .first
                                      //               ],
                                      //               // begin: Alignment(5, 5)
                                      //             )),
                                      //         child: Center(
                                      //             child: TextButton(
                                      //                 onPressed: () {
                                      //                 },
                                      //                 child: Text(
                                      //                   "View",
                                      //                   style: TextStyle(
                                      //                       color: Colors
                                      //                           .white,
                                      //                       fontWeight:
                                      //                       FontWeight
                                      //                           .w500,
                                      //                       fontSize:
                                      //                       10),
                                      //                 ))),
                                      //       ),
                                      //     )),
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          doctor["docimg"]),
                                                      fit: BoxFit.cover),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      20)),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  (doctor[
                                                  "name"]),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      fontSize: 19),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 150,
                                                      child: Text(
                                                        " ${doctor["categories"]}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color:
                                                      Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color:
                                                      Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color:
                                                      Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color:
                                                      Colors.grey,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color:
                                                      Colors.grey,
                                                    ),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    Text(doctor
                                                    ["raiting"],
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );});
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
