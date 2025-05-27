import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QRCodeDetailsPage extends StatefulWidget {
  final String barcodeType;
  final String barcodeData;

  const QRCodeDetailsPage({
    Key? key,
    required this.barcodeType,
    required this.barcodeData,
  }) : super(key: key);

  @override
  State<QRCodeDetailsPage> createState() => _QRCodeDetailsPageState();
}

class _QRCodeDetailsPageState extends State<QRCodeDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            //   future: FirebaseFirestore.instance
            //       .collection("Users")
            //       .where("Patient Email", isEqualTo: widget.barcodeData) // Correct query here
            //       .get(),
            //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            //     // Check if the snapshot has data
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text('Error: ${snapshot.error}'));
            //     } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            //       return Center(child: Text('User not found'));
            //     } else {
            //       // Fetch the image URL from the document
            //       final userDoc = snapshot.data!.docs[0];
            //       final userImgUrl = userDoc['userImg'] ?? ''; // Handle missing image URL
            //
            //       return Container(
            //         height: 200,
            //         width: 200,
            //         decoration: BoxDecoration(
            //           image: userImgUrl.isNotEmpty
            //               ? DecorationImage(image: NetworkImage(userImgUrl), fit: BoxFit.cover)
            //               : null, // Placeholder if no image
            //           color: Colors.red,
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         child: userImgUrl.isEmpty
            //             ? Center(child: Icon(Icons.person, size: 80, color: Colors.white)) // Placeholder icon
            //             : null,
            //       );
            //     }
            //   },
            // ),
            SizedBox(height: 10),
            // Display barcode data
            SizedBox(height: 10),
            Text('Barcode Data: \n${widget.barcodeData}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
