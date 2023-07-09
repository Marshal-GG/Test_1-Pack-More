import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:test_1/core/color_schemes.g.dart';

import '../product-review/product-review.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController =
      TextEditingController(text: '0');
  final TextEditingController _categoryController = TextEditingController();
  // late File _image;
  final ImagePicker _picker = ImagePicker();

  CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('test-products');

  Future<void> _getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    // if (pickedFile != null) {
    //   setState(() {
    //     _image = File(pickedFile.path);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // GestureDetector(
              //   onTap: () {
              //     _getImage();
              //   },
              //   child: _image != null
              //       ? Image.file(
              //           _image,
              //           height: 200,
              //           fit: BoxFit.cover,
              //         )
              //       : Container(
              //           height: 200,
              //           color: Colors.grey[300],
              //           child: Icon(Icons.image, size: 50),
              //         ),
              // ),
              SizedBox(height: 14.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.0),
                  color: darkColorScheme.onTertiary,
                ),
                padding: EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 14.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.0),
                  color: darkColorScheme.onTertiary,
                ),
                padding: EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 14.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.0),
                  color: darkColorScheme.onTertiary,
                ),
                padding: EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: InputBorder.none,
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 14.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.0),
                        color: darkColorScheme.onTertiary,
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a quantity';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          int currentValue =
                              int.parse(_quantityController.text);
                          if (currentValue > 0) {
                            setState(() {
                              _quantityController.text =
                                  (currentValue - 1).toString();
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          int currentValue =
                              int.parse(_quantityController.text);
                          setState(() {
                            _quantityController.text =
                                (currentValue + 1).toString();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.0),
                  color: darkColorScheme.onTertiary,
                ),
                padding: EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 14.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addProduct();
                  }
                },
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addProduct() async {
    try {
      // Retrieve the product details from the text controllers
      String name = _nameController.text;
      double price = double.parse(_priceController.text);
      String description = _descriptionController.text;
      int quantity = int.parse(_quantityController.text);
      String category = _categoryController.text;

      // String imageUrl = '';
      // if (_image != null) {
      //   final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      //   final firebaseStorageReference =
      //       firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      //   await firebaseStorageReference.putFile(_image);
      //   imageUrl = await firebaseStorageReference.getDownloadURL();
      // }

      // Add the product to Firestore
      await _productsCollection.add({
        'Name': name,
        'Price': price,
        'Description': description,
        'Quantity': quantity,
        'Category': category,
      });

      // Show a success dialog
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Product added successfully'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _nameController.clear();
                  _priceController.clear();
                  _descriptionController.clear();
                  _quantityController.clear();
                  _categoryController.clear();

                  // Navigate to the ProductReviewPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductReviewPage(
                        name: name,
                        price: price,
                        description: description,
                        quantity: quantity,
                        category: category,
                      ),
                    ),
                  );
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
            content: Text('Failed to add product'),
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
