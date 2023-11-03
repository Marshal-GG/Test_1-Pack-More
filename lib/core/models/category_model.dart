import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  static Category fromDocument(DocumentSnapshot data) {
    Category category = Category(
      id: data['id'],
      name: data['name'],
      image: data['img'],
    );
    return category;
  }

  @override
  List<Object?> get props => [id, name, image];
}
