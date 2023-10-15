import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/models/drawer_selection_model.dart';
import '../../../core/models/seller_product_model.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  late SellerProducts _initialProduct;

  List<String> _categories = [
    'No label',
    'Electronics',
    'Clothing',
    'Furniture',
    'Books',
    'Custom',
  ];

  List<XFile> _selectedImages = [];
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _initialProduct = ModalRoute.of(context)!.settings.arguments as Products;
  //   _nameController.text = _initialProduct.name;
  //   _priceController.text = _initialProduct.price.toString();
  //   _descriptionController.text = _initialProduct.description;
  //   _quantityController.text = _initialProduct.quantity.toString();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerSelectionState>(
      builder: (context, drawerSelection, child) {
        final colorScheme = Theme.of(context).colorScheme;
        String categoryValue = _categories.first;
        return Scaffold(
          appBar: buildAppBar(colorScheme),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                    SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.only(right: 0),
                      leading: Icon(
                        Icons.add_shopping_cart_outlined,
                        size: 24,
                      ),
                      title: Column(
                        children: [
                          TextFormField(
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
                        ],
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(right: 0),
                      leading: Icon(
                        Icons.category_outlined,
                        size: 24,
                      ),
                      title: Column(
                        children: [
                          DropdownButtonFormField(
                            value: categoryValue,
                            onChanged: (newValue) {
                              setState(() {
                                categoryValue = newValue!;
                              });
                            },
                            items: _categories.map((category) {
                              return DropdownMenuItem<String>(
                                // alignment: Alignment.center,
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
                            isExpanded: true,
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    buildAddImages(colorScheme),
                    SizedBox(height: 8)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Card buildAddImages(ColorScheme colorScheme) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Recommanded Image Dimensions 1 X 1',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FilledButton.tonalIcon(
                onPressed: () {
                  _pickImages(context, colorScheme);
                },
                icon: Icon(
                  Icons.add_a_photo_outlined,
                  size: 24,
                ),
                label: Text(
                  'Add Images (Max 8)',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: _selectedImages.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/image-viewer-page',
                        arguments: {
                          'imagePath': _selectedImages[index].path,
                          'imageUrl': null,
                        });
                  },
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        Image.file(
                          File(_selectedImages[index].path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme.background.withOpacity(0.7),
                            ),
                            width: 33,
                            height: 33,
                            child: IconButton(
                              iconSize: 18,
                              onPressed: () => _removeImage(index),
                              icon: Icon(
                                Icons.close,
                                grade: 200,
                                weight: 700,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(ColorScheme colorScheme) {
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
              _addProduct(context, colorScheme);
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
              case 'Help & Feedback':
                Navigator.of(context).pushNamed('/Help & Feedback');
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

  Future<void> _pickImages(
      BuildContext context, ColorScheme colorScheme) async {
    if (_selectedImages.length >= 8) {
      Fluttertoast.showToast(
        msg: 'You have reached the maximum limit of 8 images.',
        backgroundColor: colorScheme.errorContainer,
        textColor: colorScheme.onErrorContainer,
      );
      return;
    }

    List<XFile>? pickedImages = await ImagePicker().pickMultiImage();

    if (pickedImages.isNotEmpty) {
      if (_selectedImages.length + pickedImages.length <= 8) {
        setState(() {
          _selectedImages.addAll(pickedImages);
        });
      } else {
        Fluttertoast.showToast(
          msg: 'You can select up to 8 images only.',
          backgroundColor: colorScheme.errorContainer,
          textColor: colorScheme.onErrorContainer,
        );
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _addProduct(context, ColorScheme colorScheme) async {
    // Retrieve the timestamp and format it
    // Timestamp productTimestamp = product['timestamp'];
    // DateTime dateTime = productTimestamp.toDate();
    // String formattedDateTime = DateFormat.yMd().add_Hms().format(dateTime);
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('Users');
      CollectionReference productsCollection =
          FirebaseFirestore.instance.collection('Products Test');
      CollectionReference imagesCollection =
          FirebaseFirestore.instance.collection('ProductImages Test');

      String name = _nameController.text;
      double price = double.parse(_priceController.text);
      String description = _descriptionController.text;
      int quantity = int.parse(_quantityController.text);
      String category = 'test (hard coded)'; //categoryValue;

      Timestamp timestamp = Timestamp.now();
      String userUid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDocRef = usersCollection.doc(userUid);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AlertDialog(
              surfaceTintColor: colorScheme.background.withOpacity(0.8),
              title: Text('Uploading Images'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: CircularProgressIndicator()),
                  SizedBox(height: 16),
                  Text('Uploading images...'),
                ],
              ),
            ),
          );
        },
      );

      DocumentReference productRef = await productsCollection.add({
        'name': name,
        'price': price,
        'description': description,
        'quantity': quantity,
        'category': category,
        'userUid': userUid,
        'timestamp': timestamp,
      });

      // Store the images in Firebase Storage and associate them with the product
      List<String> imageIds = [];
      for (XFile imageFile in _selectedImages) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        String imagePath = 'product_images/$fileName.jpg';
        Reference storageReference =
            FirebaseStorage.instance.ref().child(imagePath);
        UploadTask uploadTask = storageReference.putFile(File(imageFile.path));
        TaskSnapshot taskSnapshot = await uploadTask;
        imagePath = 'gs://test-1-flutter.appspot.com/$imagePath';

        double progress =
            (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes) * 100;
        print('Upload progress: $progress%');

        DocumentReference imageDocRef = await imagesCollection.add({
          'productId': productRef.id,
          'imageUrl': imagePath,
          'userUid': userUid,
          'timestamp': timestamp,
        });

        imageIds.add(imageDocRef.id);

        await userDocRef.update({
          'productIds': FieldValue.arrayUnion([productRef.id]),
        });
      }

      await productRef.update({'imageUrls': imageIds});

      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AlertDialog(
              surfaceTintColor: colorScheme.background.withOpacity(0.8),
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
                    setState(() {
                      _selectedImages.clear();
                    });
                  },
                ),
              ],
            ),
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
