import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';
import 'package:test_1/pages/add_product/components/add_multiple_images.dart';

import '../../core/models/drawer_selection_model.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  List<String> _categories = [
    'No label',
    'Electronics',
    'Clothing',
    'Furniture',
    'Books',
    'Custom',
  ];

  XFile? _selectedImage;

  Future<void> _getImage() async {
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
    return Consumer<DrawerSelectionState>(
      builder: (context, drawerSelection, child) {
        final colorScheme = Theme.of(context).colorScheme;
        String categoryValue = _categories.first;
        return Scaffold(
          appBar: buildAppBar(),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Material(
                        color: colorScheme.secondaryContainer,
                        shape: CircleBorder(),
                        child: InkWell(
                          onTap: _getImage,
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
                    ),
                    TextButton(
                        onPressed: _getImage, child: Text('Add Picture')),
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
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Product Name',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a name';
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
                          Icons.currency_rupee_outlined,
                          size: 24,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _priceController,
                            decoration: InputDecoration(
                              labelText: 'Price',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
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
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          Icons.description_outlined,
                          size: 24,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              labelText: 'Product Description',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter product description';
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
                          Icons.add_shopping_cart_outlined,
                          size: 24,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _quantityController,
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
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
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 24,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: categoryValue,
                            onChanged: (newValue) {
                              setState(() {
                                categoryValue = newValue!;
                              });
                            },
                            items: _categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Category',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please choose a category';
                              }
                              return null;
                            },
                            dropdownColor: colorScheme.onSecondary,
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0),
                    ListTile(
                      trailing: Icon(Icons.close),
                      dense: true,
                      leading: Icon(Icons.add_shopping_cart_outlined),
                      title: Expanded(
                        child: TextFormField(
                          controller: _quantityController,
                          decoration: InputDecoration(
                            labelText: 'Quantity 2',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
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
                    )
                    // AddMultipleImages()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Add Product'),
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
          onPressed: () {
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
                // Implement Option 2 functionality
                break;
              // Add more options as needed
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'Delete',
                child: Text('Delete'),
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
      String name = _nameController.text;
      double price = double.parse(_priceController.text);
      String description = _descriptionController.text;
      int quantity = int.parse(_quantityController.text);
      // String category = _selectedCategory;

      String imageUrl = '';
      // if (_image != null) {
      //   final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      //   final firebaseStorageReference =
      //       firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      //   await firebaseStorageReference.putFile(_image);
      //   imageUrl = await firebaseStorageReference.getDownloadURL();
      // }

      await _productsCollection.add({
        'name': name,
        'price': price,
        'description': description,
        'quantity': quantity,
        // 'category': category,
        'imageUrl': imageUrl,
      });

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
                  // _categoryController.clear();
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
