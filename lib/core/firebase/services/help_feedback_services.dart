import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class HelpFeedbackService {
  Future<void> addHelpFeedback({
    required String type,
    required String message,
    required List<XFile> selectedImages,
  }) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference helpFeedbackCollection = FirebaseFirestore
        .instance
        .collection('Users')
        .doc(userUid)
        .collection('help_feedback');
    final CollectionReference imagesCollection =
        FirebaseFirestore.instance.collection('help_feedback Images');

    try {
      Timestamp timestamp = Timestamp.now();

      DocumentReference helpFeedbackRef = await helpFeedbackCollection.add({
        'type': type,
        'message': message,
        'userUid': userUid,
        'timestamp': timestamp,
        'status': 'Under Review',
        'imageUrls': [],
      });

      List<String> imageIds = [];
      for (XFile imageFile in selectedImages) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        String imagePath = 'helpFeedback_images/$fileName.jpg';
        Reference storageReference =
            FirebaseStorage.instance.ref().child(imagePath);
        UploadTask uploadTask = storageReference.putFile(File(imageFile.path));
        TaskSnapshot taskSnapshot = await uploadTask;
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        imagePath = 'gs://test-1-flutter.appspot.com/$imagePath';

        double progress =
            (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes) * 100;
        print('Upload progress: $progress%');

        DocumentReference imageDocRef = await imagesCollection.add({
          'helpFeedbackId': helpFeedbackRef.id,
          'imagePath': imagePath,
          'imageUrl': imageUrl,
          'userUid': userUid,
          'timestamp': timestamp,
        });

        imageIds.add(imageDocRef.id);
      }
      await helpFeedbackRef.update({'imageUrls': imageIds});
    } catch (e) {
      print(e);
    }
  }
}
