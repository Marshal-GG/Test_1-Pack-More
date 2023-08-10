import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('usertest');
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  XFile? _selectedImage;

  Future<void> _getProfileImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;
    XFile? croppedImage = await _cropImage(imageFile: image);
    if (croppedImage == null) return;
    setState(() {
      _selectedImage = croppedImage;
    });
  }

  Future<XFile?> _cropImage({required XFile imageFile}) async {
    try {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 50,
        // uiSettings: [
        //   AndroidUiSettings(
        //       backgroundColor: Colors.grey,
        //       // hideBottomControls: true,
        //       toolbarColor: Colors.black54)
        // ],
        // IOS config is not done
      );

      if (croppedImage != null) {
        return XFile(croppedImage.path);
      } else {
        return null; // Handle the case where cropping was canceled or failed.
      }
    } catch (e) {
      // Handle any exception that occurred during cropping.
      print("Error while cropping image: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  buildProfilePicture(colorScheme),
                  TextButton(
                    onPressed: _getProfileImage,
                    child: Text('Add Picture'),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 24,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _fullNameController,
                          decoration: InputDecoration(
                            labelText: 'Full name',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.mail_outline,
                        size: 24,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(top: 8, right: 0),
                    leading: Icon(
                      Icons.phone_outlined,
                      size: 24,
                    ),
                    title: Column(
                      children: [
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(right: 0),
                    leading: Icon(
                      Icons.location_on_outlined,
                      size: 24,
                    ),
                    title: Column(
                      children: [
                        TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 40, right: 0),
                    // leading: Icon(Icons.add_shopping_cart_outlined),
                    title: Column(
                      children: [
                        TextFormField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            labelText: 'City',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your city';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 40, right: 0),
                    title: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _stateController,
                            decoration: InputDecoration(
                              labelText: 'State',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.streetAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your state';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _pincodeController,
                            decoration: InputDecoration(
                              labelText: 'Pincode',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your pincode';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildProfilePicture(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: Material(
        color: colorScheme.secondaryContainer,
        shape: CircleBorder(),
        child: InkWell(
          onTap: _getProfileImage,
          customBorder: CircleBorder(),
          child: Ink(
            decoration: BoxDecoration(shape: BoxShape.circle),
            height: 128,
            width: 128,
            child: _selectedImage != null
                ? ClipOval(
                    child: Image.file(
                      File(_selectedImage!.path),
                    ),
                  )
                : Icon(
                    Icons.add_a_photo_outlined,
                    size: 42,
                    color: colorScheme.onSecondaryContainer,
                  ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Edit Profile'),
      elevation: 0,
      scrolledUnderElevation: 2,
      backgroundColor: Colors.transparent,
      leading: InkResponse(
        // radius: 16,
        child: Icon(Icons.close),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        FilledButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _addProduct();
            }
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Save'),
        ),
        PopupMenuButton(
          onSelected: (String choice) {
            // Add the functionality for each menu item here
            // For example, you can have switch cases to handle different choices.
            switch (choice) {
              case 'Option 1':
                // Implement Option 1 functionality
                break;
              case 'Option 2':
                {
                  Navigator.of(context).pushNamed('/Help & Feedback');
                }
                break;
              // Add more options as needed
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'Discard',
                child: Text('Discard'),
              ),
              PopupMenuItem<String>(
                value: 'Help & Feedback',
                child: Text('Help & Feedback'),
              ),
              // Add more PopupMenuItems as needed
            ];
          },
        )
      ],
    );
  }

  Future<void> _addProduct() async {
    try {
      String fullName = _fullNameController.text;
      String email = _emailController.text;
      int phone = int.parse(_phoneController.text);
      String address = _addressController.text;
      String city = _cityController.text;
      String state = _stateController.text;
      int pincode = int.parse(_pincodeController.text);

      String imageUrl = '';
      // if (_image != null) {
      //   final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      //   final firebaseStorageReference =
      //       firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      //   await firebaseStorageReference.putFile(_image);
      //   imageUrl = await firebaseStorageReference.getDownloadURL();
      // }

      await _productsCollection.add({
        'name': fullName,
        'price': email,
        'phone': phone,
        'imageUrl': imageUrl,
        'addresses': {
          'address': address,
          'city': city,
          'state': state,
          'pincode': pincode,
        }
      });

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User added successfully'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _fullNameController.clear();
                  _emailController.clear();
                  _phoneController.clear();
                  _addressController.clear();
                  _cityController.clear();
                  _stateController.clear();
                  _pincodeController.clear();
                  setState(() {
                    // _image = Null;
                  });
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add user'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
