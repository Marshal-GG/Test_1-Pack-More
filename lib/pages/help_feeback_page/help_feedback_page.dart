import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'bloc/help_feedback_page_bloc.dart';

enum FeedbackType {
  help,
  feedback,
}

class HelpFeedbackPage extends StatefulWidget {
  const HelpFeedbackPage({super.key});

  @override
  State<HelpFeedbackPage> createState() => _HelpFeedbackPageState();
}

class _HelpFeedbackPageState extends State<HelpFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  String _message = '';
  List<XFile> _selectedImages = [];
  bool isSelected = true;
  FeedbackType _selectedType = FeedbackType.help;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<HelpFeedbackPageBloc, HelpFeedbackPageState>(
      builder: (context, state) {
        return buildBody(context, colorScheme, state);
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

  AppBar buildAppBar(
    BuildContext context,
    ColorScheme colorScheme,
    HelpFeedbackPageState state,
  ) {
    return AppBar(
      title: Text('Help & Feedback'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: FilledButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                _showDialog(context, colorScheme);
                BlocProvider.of<HelpFeedbackPageBloc>(context).add(
                  HelpFeedbackSubmitEvent(
                    type: _selectedType.toShortString(),
                    message: _message,
                    selectedImages: _selectedImages,
                  ),
                );
                _formKey.currentState!.reset();
                setState(() {
                  _selectedImages.clear();
                });
              }
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
    );
  }

  Scaffold buildBody(BuildContext context, ColorScheme colorScheme,
      HelpFeedbackPageState state) {
    return Scaffold(
      appBar: buildAppBar(context, colorScheme, state),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SegmentedButton<FeedbackType>(
                      segments: const <ButtonSegment<FeedbackType>>[
                        ButtonSegment<FeedbackType>(
                          value: FeedbackType.help,
                          label: Text('Help'),
                          icon: Icon(Icons.help_outline),
                        ),
                        ButtonSegment<FeedbackType>(
                          value: FeedbackType.feedback,
                          label: Text('Feedback'),
                          icon: Icon(Icons.feedback_outlined),
                        ),
                      ],
                      selected: <FeedbackType>{_selectedType},
                      onSelectionChanged: (Set<FeedbackType> newSelection) {
                        setState(() {
                          _selectedType = newSelection.first;
                        });
                      },
                    ),
                  ],
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

  void _showDialog(BuildContext context, ColorScheme colorScheme) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: BlocBuilder<HelpFeedbackPageBloc, HelpFeedbackPageState>(
              builder: (context, state) {
                return AlertDialog(
                  backgroundColor: colorScheme.background.withOpacity(0.8),
                  title: Center(
                      child: state is HelpFeedbackPageLoadingStatusState &&
                              state.isError
                          ? Text('Error')
                          : Text('Status')),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state is HelpFeedbackPageLoadingStatusState &&
                              state.isUploading ||
                          state is HelpFeedbackSubmitted) ...[
                        Center(child: CircularProgressIndicator()),
                        SizedBox(height: 16),
                        Text('Please wait...')
                      ] else if (state is HelpFeedbackPageLoadingStatusState &&
                          !state.isUploading &&
                          !state.isError) ...[
                        Text('Thank you for your submission.'),
                      ] else if (state is HelpFeedbackPageLoadingStatusState &&
                          state.isError &&
                          !state.isUploading) ...[
                        Text(
                            'Failed to submit your Feedback. Please try again later.'),
                      ]
                    ],
                  ),
                  actions: [
                    Center(
                      child: TextButton(
                        onPressed:
                            state is HelpFeedbackPageLoadingStatusState &&
                                    state.isUploading
                                ? null
                                : () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                        child: Text('OK'),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    });
  }
}

extension FeedbackTypeExtension on FeedbackType {
  String toShortString() {
    return toString().split('.').last.toLowerCase();
  }
}
