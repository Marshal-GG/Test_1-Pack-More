import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class HelpFeedback extends Equatable {
  final String id;
  final String status;
  final String message;
  final String userUid;
  final Timestamp timestamp;
  final List<String> imageUrls;
  final String type;

  HelpFeedback({
    required this.id,
    required this.status,
    required this.message,
    required this.userUid,
    required this.timestamp,
    required this.imageUrls,
    required this.type,
  });

  HelpFeedback copyWith({
    String? id,
    String? status,
    String? message,
    String? type,
  }) {
    return HelpFeedback(
      id: id ?? this.id,
      status: status ?? this.status,
      message: message ?? this.message,
      userUid: userUid,
      timestamp: timestamp,
      imageUrls: imageUrls,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
        id,
        status,
        message,
        userUid,
        timestamp,
        imageUrls,
        type,
      ];
}
