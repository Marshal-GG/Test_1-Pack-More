import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerPage extends StatelessWidget {
  const ImageViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String? imagePath = arguments['imagePath'];
    final String? imageUrl = arguments['imageUrl'];

    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Center(
        child: imagePath != null
            ? PhotoView(
                imageProvider: FileImage(File(imagePath)),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2.0,
              )
            : imageUrl != null
                ? PhotoView(
                    imageProvider: CachedNetworkImageProvider(imageUrl),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2.0,
                  )
                : Container(),
      ),
    );
  }
}
