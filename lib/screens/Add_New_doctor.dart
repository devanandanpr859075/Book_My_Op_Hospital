import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DoctorFormScreen extends StatefulWidget {
  @override
  _DoctorFormScreenState createState() => _DoctorFormScreenState();
}

class _DoctorFormScreenState extends State<DoctorFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _feesController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  Future<void> _addDoctor() async {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text;
      final phone = _phoneController.text;
      final description = _descriptionController.text;
      final email = _emailController.text;
      final experience = _experienceController.text;
      final fees = _feesController.text;
      final rating = _ratingController.text;
      final gender = _genderController.text;

      try {
        String imageUrl = '';
        if (_image != null) {
          imageUrl = await _uploadImageToFirebase();
        }

        final docRef = await FirebaseFirestore.instance.collection('doctors').add({
          'name': name,
          'categories': selectedCategoryName,
          'Contact Number': phone,
          'email': email,
          'description': description,
          'experience': experience,
          'fees': fees,
          'raiting': rating,
          'Gender': gender,
          "docimg": imageUrl,
        });

        await docRef.update({'doctid': docRef.id});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green,
              content: Text('Doctor added successfully',style: TextStyle(color: Colors.white),)),
        );

        _nameController.clear();
        _descriptionController.clear();
        _phoneController.clear();
        _emailController.clear();
        _feesController.clear();
        _experienceController.clear();
        _ratingController.clear();
        _genderController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add doctor: $e')),
        );
      }
    }
  }


  String? selectedCategoryId;
  String? selectedCategoryName;
  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('Categories').get();
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          categories = snapshot.docs.map((doc) {
            return {
              'catid': doc['catid'],
              'catname': doc['catname'],
            };
          }).toList();
        });
      } else {
        setState(() {
          categories = [];
        });
      }
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  final ImagePicker _picker = ImagePicker();
  File? _image;

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> _uploadImageToFirebase() async {
    if (_image == null) {
      throw 'No image selected';
    }

    try {
      // Generate a unique filename
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
      Reference storageRef = _storage.ref().child('category_images/$fileName');

      // Upload the image to Firebase Storage
      UploadTask uploadTask = storageRef.putFile(_image!);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL of the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw 'Error uploading image: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Doctor')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Center(
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.grey[200],
                            child: _image == null
                                ? Icon(
                              Icons.add_a_photo_rounded,
                              size: 40,
                              color: Colors.blue,
                            )
                                : ClipOval(
                              child: Image.file(
                                _image!,
                                width: 140,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Tap to pick an image from the gallery"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the doctor\'s name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()
                  ),
                  child: TextFormField(
                    controller: _feesController,
                    decoration: InputDecoration(labelText: 'Charge'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the doctor\'s fee';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the doctor\'s description';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()
                  ),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the doctor\'s phone number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()
                  ),
                  child: TextFormField(
                    controller: _genderController,
                    decoration: InputDecoration(labelText: 'Gender'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the doctor\'s gender';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()
                  ),
                  child: TextFormField(
                    controller: _ratingController,
                    decoration: InputDecoration(labelText: 'Rating'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the doctor\'s rating';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()
                  ),
                  child: TextFormField(
                    controller: _experienceController,
                    decoration: InputDecoration(labelText: 'Experience'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the doctor\'s experience';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                categories.isEmpty
                    ? CupertinoActivityIndicator() // Show loading spinner if no categories
                    : Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white)),
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Select Category'),
                      value: selectedCategoryId,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategoryId = newValue;
                          selectedCategoryName = categories.firstWhere(
                                  (category) =>
                              category['catid'] ==
                                  newValue)['catname'];
                        });
                      },
                      items: categories
                          .map<DropdownMenuItem<String>>((category) {
                        return DropdownMenuItem<String>(
                          value: category['catid'],
                          child: Text(category['catname']),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the doctor\'s email address';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Material(
                    elevation: 10,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                       _addDoctor();
                       Navigator.pop(context);
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Center(
                          child: Text(
                            "Submit",
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
          ),
        ),
      ),
    );
  }
}
