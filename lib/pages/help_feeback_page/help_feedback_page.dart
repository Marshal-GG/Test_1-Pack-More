import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class HelpFeedbackPage extends StatefulWidget {
  const HelpFeedbackPage({super.key});

  @override
  State<HelpFeedbackPage> createState() => _HelpFeedbackPageState();
}

class _HelpFeedbackPageState extends State<HelpFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedType = 'Help';
  String _message = '';
  List<XFile> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Feedback'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FilledButton(
              onPressed: () {
                _submitForm(context, colorScheme);
              },
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Submit'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  dropdownColor: colorScheme.onSecondary,
                  value: _selectedType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  },
                  items: ['Help', 'Feedback']
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  decoration: InputDecoration(
                    labelText: 'Type',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  onSaved: (newValue) {
                    _message = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                buildAddImages(colorScheme),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
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
              'Add Screenshot (Optional)',
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
                  'Add Images (Max 4)',
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

  Future<void> _pickImages(
      BuildContext context, ColorScheme colorScheme) async {
    if (_selectedImages.length >= 4) {
      Fluttertoast.showToast(
        msg: 'You have reached the maximum limit of 4 images.',
        backgroundColor: colorScheme.errorContainer,
        textColor: colorScheme.onErrorContainer,
      );
      return;
    }

    List<XFile>? pickedImages = await ImagePicker().pickMultiImage();

    if (pickedImages.isNotEmpty) {
      if (_selectedImages.length + pickedImages.length <= 4) {
        setState(() {
          _selectedImages.addAll(pickedImages);
        });
      } else {
        Fluttertoast.showToast(
          msg: 'You can select up to 4 images only.',
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

  Future<void> _submitForm(context, ColorScheme colorScheme) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('Users');
        CollectionReference helpFeedbackCollection =
            FirebaseFirestore.instance.collection('help_feedback');
        CollectionReference imagesCollection =
            FirebaseFirestore.instance.collection('help_feedback Images');

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

        // Add the user's input to the Firestore collection
        DocumentReference helpFeedbackRef = await helpFeedbackCollection.add({
          'type': _selectedType,
          'message': _message,
          'userUid': userUid,
          'timestamp': timestamp,
        });

        List<String> imageIds = [];
        for (XFile imageFile in _selectedImages) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          String imagePath = 'helpFeedback_images/$fileName.jpg';
          Reference storageReference =
              FirebaseStorage.instance.ref().child(imagePath);
          UploadTask uploadTask =
              storageReference.putFile(File(imageFile.path));
          TaskSnapshot taskSnapshot = await uploadTask;
          imagePath = 'gs://test-1-flutter.appspot.com/$imagePath';

          double progress =
              (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes) * 100;
          print('Upload progress: $progress%');

          DocumentReference imageDocRef = await imagesCollection.add({
            'helpFeedbackId': helpFeedbackRef.id,
            'imageUrl': imagePath,
            'userUid': userUid,
            'timestamp': timestamp,
          });

          imageIds.add(imageDocRef.id);

          await userDocRef.update({
            'helpFeedbackIds': FieldValue.arrayUnion([helpFeedbackRef.id]),
          });
        }

        await helpFeedbackRef.update({'imageUrls': imageIds});

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: AlertDialog(
                surfaceTintColor: colorScheme.background.withOpacity(0.8),
                title: Text('Done'),
                content: Text('Thank you for your $_selectedType!'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      _formKey.currentState!.reset();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
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
              content: Text('Failed to submit your Feedback'),
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
}
