// import 'package:flutter/material.dart';
//
// class ViewDetails extends StatefulWidget {
//   @override
//   _ViewDetailsState createState() => _ViewDetailsState();
// }
//
// class _ViewDetailsState extends State<ViewDetails> {
//   TextEditingController _timeController = TextEditingController();
//   TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0); // Default start time
//   TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0); // Default end time
//   List<String> availableTimes = []; // List to store available time slots
//
//   // Function to pick start time
//   Future<void> _selectStartTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: _startTime,
//     );
//     if (picked != null && picked != _startTime) {
//       setState(() {
//         _startTime = picked;
//       });
//     }
//   }
//
//   // Function to pick end time
//   Future<void> _selectEndTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: _endTime,
//     );
//     if (picked != null && picked != _endTime) {
//       setState(() {
//         _endTime = picked;
//       });
//     }
//   }
//
//   // Function to format time into a string
//   String _formatTime(TimeOfDay time) {
//     final hour = time.hourOfPeriod;
//     final minute = time.minute;
//     final amPm = time.period == DayPeriod.am ? 'AM' : 'PM';
//     return "$hour:${minute.toString().padLeft(2, '0')} $amPm";
//   }
//
//   // Function to add selected time range to available times list
//   void _addAvailableTime() {
//     String formattedTime =
//         "${_formatTime(_startTime)} - ${_formatTime(_endTime)}";
//     setState(() {
//       availableTimes.add(formattedTime);
//     });
//     _timeController.clear(); // Clear the controller after adding time slot
//   }
//
//   // Function to save available times (for example, to Firestore)
//   Future<void> _saveAvailableTimes() async {
//     // Your logic to save availableTimes to Firestore
//     print("Available Times Saved: $availableTimes");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Doctor's Available Times"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Select Available Time Slot",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//             ),
//             SizedBox(height: 20),
//
//             // Start Time Picker
//             Row(
//               children: [
//                 Text("Start Time: ", style: TextStyle(fontSize: 16)),
//                 TextButton(
//                   onPressed: () => _selectStartTime(context),
//                   child: Text(
//                     _formatTime(_startTime),
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//
//             // End Time Picker
//             Row(
//               children: [
//                 Text("End Time: ", style: TextStyle(fontSize: 16)),
//                 TextButton(
//                   onPressed: () => _selectEndTime(context),
//                   child: Text(
//                     _formatTime(_endTime),
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 20),
//
//             // Button to add the selected time range
//             ElevatedButton(
//               onPressed: _addAvailableTime,
//               child: Text("Add Time Slot"),
//             ),
//
//             SizedBox(height: 20),
//
//             // Display available times
//             Text(
//               "Available Times:",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: availableTimes.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(
//                       availableTimes[index],
//                       style: TextStyle(fontSize: 17),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             // Button to save available times
//             ElevatedButton(
//               onPressed: _saveAvailableTimes,
//               child: Text("Save Available Times"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
