import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospitel_app/screens/view%20details.dart';


class doctorsDisplay extends StatelessWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const doctorsDisplay({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    // final provider = FavoriteProvider.of(context);
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         RecipeDetailScreen(documentSnapshot: documentSnapshot),
        //   ),
        // );
      },

      child:Container(
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
                  Positioned(
                      top: 30,
                      right: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.all(
                            10.0),
                        child: Container(
                          width: 85,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(10),
                              gradient:
                              LinearGradient(
                                colors: [
                                  Color(
                                      0xFF4c00ff),
                                  Colors.primaries
                                      .first
                                ],
                                // begin: Alignment(5, 5)
                              )),
                          child: Center(
                              child: TextButton(
                                  onPressed: () {
                                    Navigator
                                        .push(
                                        context,
                                        MaterialPageRoute(
                                            builder:
                                                (
                                                context) {
                                              return ViewDetails(
                                                  docRaiting:
                                                  documentSnapshot[
                                                  "raiting"],
                                                  description:
                                                  documentSnapshot[
                                                  "description"],
                                                  docfee: documentSnapshot[
                                                  "fees"],
                                                  docimg: documentSnapshot[
                                                  "docimg"],
                                                  doctid: documentSnapshot[
                                                  "doctid"],
                                                  docname:
                                                  documentSnapshot[
                                                  'name'],
                                                  Categories:documentSnapshot["categories"],
                                                  email:documentSnapshot["email"],
                                                  Gender:documentSnapshot["Gender"],
                                                  ContactNumber:documentSnapshot["Contact Number"]
                                              );
                                            }));
                                  },
                                  child: Text(
                                    "View",
                                    style: TextStyle(
                                        color: Colors
                                            .white,
                                        fontWeight:
                                        FontWeight
                                            .w500,
                                        fontSize:
                                        10),
                                  ))),
                        ),
                      )),
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
                                      documentSnapshot["docimg"]),
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
                              (documentSnapshot[
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
                                    " ${documentSnapshot["categories"]}",
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
                                Text(documentSnapshot
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
      ),
      // Container(
      //     margin: const EdgeInsets.only(right: 10),
      //     width: 230,
      //     child: Stack(
      //       children: [
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Container(
      //               width: double.infinity,
      //               height: 160,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(15),
      //                 image: DecorationImage(
      //                   fit: BoxFit.cover,
      //                   image: NetworkImage(
      //                     documentSnapshot['docimg'], // image from firestore
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             const SizedBox(height: 10),
      //             Text(
      //               documentSnapshot['name'],
      //               style: const TextStyle(
      //                 fontSize: 17,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //             const SizedBox(height: 5),
      //             Row(
      //               children: [
      //                 const Icon(
      //                   Icons.favorite,
      //                   size: 16,
      //                   color: Colors.grey,
      //                 ),
      //                 Text(
      //                   "${documentSnapshot['fees']} Cal",
      //                   style: const TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 12,
      //                     color: Colors.grey,
      //                   ),
      //                 ),
      //                 const Text(
      //                   " · ",
      //                   style: TextStyle(
      //                     fontWeight: FontWeight.w900,
      //                     color: Colors.grey,
      //                   ),
      //                 ),
      //                 const Icon(
      //                   Icons.calendar_month,
      //                   size: 16,
      //                   color: Colors.grey,
      //                 ),
      //                 const SizedBox(width: 5),
      //                 Text(
      //                   "${documentSnapshot['categories']} Min",
      //                   style: const TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 12,
      //                     color: Colors.grey,
      //                   ),
      //                 ),
      //               ],
      //             )
      //           ],
      //         ),
      //         // for favorite button
      //         // now let's whok on favorite button using provider
      //         // Positioned(
      //         //   top: 5,
      //         //   right: 5,
      //         //   child: CircleAvatar(
      //         //     radius: 18,
      //         //     backgroundColor: Colors.white,
      //         //     child: InkWell(
      //         //       onTap: () {
      //         //         provider.toggleFavorite(documentSnapshot);
      //         //       },
      //         //       child: Icon(
      //         //         provider.isExist(documentSnapshot)
      //         //             ? Icons.add
      //         //             : Icons.add_a_photo_rounded,
      //         //         color: provider.isExist(documentSnapshot)
      //         //             ? Colors.red
      //         //             : Colors.black,
      //         //         size: 20,
      //         //       ),
      //         //     ),
      //         //   ),
      //         // ),
      //         // lets design a favorite screen
      //       ],
      //     ),
      //   ),
    );
  }
}
