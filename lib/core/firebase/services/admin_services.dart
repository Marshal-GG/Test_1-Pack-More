import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/help_feedback_model.dart';

class AdminService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}

class HelpFeedbackServices extends AdminService {
  Future<List<HelpFeedback>> fetchNewHelpFeedbackData() async {
    final CollectionReference imagesCollection =
        firestore.collection('help_feedback Images');

    QuerySnapshot<Map<String, dynamic>> helpFeedbackSnapshot = await firestore
        .collectionGroup('help_feedback')
        .where('status', isEqualTo: 'Under Review')
        .get();

    List<HelpFeedback> helpFeedbackData = [];

    for (var doc in helpFeedbackSnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      List<String> imageIds = List.from(data['imageUrls']);
      List<String> imageUrls = [];

      for (String imageId in imageIds) {
        DocumentSnapshot imageDocSnapshot =
            await imagesCollection.doc(imageId).get();
        String imageUrl = imageDocSnapshot['imageUrl'];
        imageUrls.add(imageUrl);
      }

      HelpFeedback helpFeedback = HelpFeedback(
        id: doc.id,
        status: data['status'],
        message: data['message'],
        userUid: data['userUid'],
        timestamp: data['timestamp'],
        type: data['type'],
        imageUrls: imageUrls,
      );

      helpFeedbackData.add(helpFeedback);
    }
    return helpFeedbackData;
  }

  Future<List<HelpFeedback>> fetchOnHoldHelpFeedbackData() async {
    final CollectionReference imagesCollection =
        firestore.collection('help_feedback Images');
    QuerySnapshot<Map<String, dynamic>> onHoldFeedbackSnapshot = await firestore
        .collectionGroup('help_feedback')
        .where('status', isEqualTo: 'On Hold')
        .get();

    List<HelpFeedback> onHoldFeedbackData = [];

    for (var doc in onHoldFeedbackSnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      List<String> imageIds = List.from(data['imageUrls']);
      List<String> imageUrls = [];

      for (String imageId in imageIds) {
        DocumentSnapshot imageDocSnapshot =
            await imagesCollection.doc(imageId).get();
        String imageUrl = imageDocSnapshot['imageUrl'];
        imageUrls.add(imageUrl);
      }

      HelpFeedback onHoldFeedback = HelpFeedback(
        id: doc.id,
        status: data['status'],
        message: data['message'],
        userUid: data['userUid'],
        timestamp: data['timestamp'],
        type: data['type'],
        imageUrls: imageUrls,
      );

      onHoldFeedbackData.add(onHoldFeedback);
    }

    return onHoldFeedbackData;
  }

  Future<List<HelpFeedback>> fetchSolvedFeedbackData() async {
    final CollectionReference imagesCollection =
        firestore.collection('help_feedback Images');
    QuerySnapshot<Map<String, dynamic>> solvedFeedbackSnapshot = await firestore
        .collectionGroup('help_feedback')
        .where('status', isEqualTo: 'Solved')
        .get();

    List<HelpFeedback> solvedFeedbackData = [];

    for (var doc in solvedFeedbackSnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      List<String> imageIds = List.from(data['imageUrls']);
      List<String> imageUrls = [];

      for (String imageId in imageIds) {
        DocumentSnapshot imageDocSnapshot =
            await imagesCollection.doc(imageId).get();
        String imageUrl = imageDocSnapshot['imageUrl'];
        imageUrls.add(imageUrl);
      }

      HelpFeedback solvedFeedback = HelpFeedback(
        id: doc.id,
        status: data['status'],
        message: data['message'],
        userUid: data['userUid'],
        timestamp: data['timestamp'],
        type: data['type'],
        imageUrls: imageUrls,
      );

      solvedFeedbackData.add(solvedFeedback);
    }

    return solvedFeedbackData;
  }

  Future<List<HelpFeedback>> fetchRejectedFeedbackData() async {
    final CollectionReference imagesCollection =
        firestore.collection('help_feedback Images');
    QuerySnapshot<Map<String, dynamic>> rejectedFeedbackSnapshot =
        await firestore
            .collectionGroup('help_feedback')
            .where('status', isEqualTo: 'Rejected')
            .get();

    List<HelpFeedback> rejectedFeedbackData = [];

    for (var doc in rejectedFeedbackSnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      List<String> imageIds = List.from(data['imageUrls']);
      List<String> imageUrls = [];

      for (String imageId in imageIds) {
        DocumentSnapshot imageDocSnapshot =
            await imagesCollection.doc(imageId).get();
        String imageUrl = imageDocSnapshot['imageUrl'];
        imageUrls.add(imageUrl);
      }

      HelpFeedback rejectedFeedback = HelpFeedback(
        id: doc.id,
        status: data['status'],
        message: data['message'],
        userUid: data['userUid'],
        timestamp: data['timestamp'],
        type: data['type'],
        imageUrls: imageUrls,
      );

      rejectedFeedbackData.add(rejectedFeedback);
    }

    return rejectedFeedbackData;
  }
}
