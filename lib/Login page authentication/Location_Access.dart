// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// class LocationAccess extends StatefulWidget {
//   const LocationAccess({super.key});
//
//   @override
//   State<LocationAccess> createState() => _LocationAccessState();
// }
//
// class _LocationAccessState extends State<LocationAccess> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child:
//       MaterialButton(onPressed: ()async{
//         try{
//           Position position=
//               await LocationServises().getCurrentLocation();
//           List placemarks=await
//         }
//       },child: Text("get Location"),)),
//
//     );
//   }
// }
// class LocationServises{
//   Future<Position>getCurrentLocation()async{
//     bool serviceenable;
//     LocationPermission Permition;
//     serviceenable=await Geolocator.isLocationServiceEnabled();
//     if(serviceenable){
//       return Future.error('location service disable');
//     }
//     Permition=await Geolocator.checkPermission();
//     if(Permition==LocationPermission.denied){
//       Permition=await Geolocator.requestPermission();
//       if(Permition==LocationPermission.deniedForever){
//         return Future.error("Location Permition Permetelly denied");
//       }
//       return Geolocator.getCurrentPosition();
//     }
//   }
// }
//
//
// }
