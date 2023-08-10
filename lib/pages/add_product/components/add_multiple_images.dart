import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_1/core/widgets/custom_drawer.dart';

class AddMultipleImages extends StatefulWidget {
  const AddMultipleImages({super.key});

  @override
  State<AddMultipleImages> createState() => _AddMultipleImagesState();
}

class _AddMultipleImagesState extends State<AddMultipleImages> {
  List<XFile> _selectedImages = [];

  Future<void> _getImages() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;
    if (_selectedImages.length < 8) {
      setState(() {
        _selectedImages.add(pickedImage);
      });
    } else {
      print("Maximum number of images reached");
    }
  }

  Future<void> _pickImages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage();

    if (pickedImages.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(pickedImages);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      drawer: CustomDrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'Recommanded Image Dimensions 1 X 1',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 24,
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Flexible(
              child: FilledButton.tonalIcon(
                onPressed: _pickImages,
                icon: Icon(Icons.add_a_photo_outlined),
                label: Text('Add Images'),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return Card(
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
                        top: 1,
                        right: 1,
                        child: IconButton.filled(
                          style: IconButton.styleFrom(),
                          icon: Icon(Icons.close),
                          onPressed: () => _removeImage(index),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
