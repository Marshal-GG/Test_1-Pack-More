class Products {
  final int id;
  final String image;
  final String imageUrl;
  final String name;
  final String category;
  final String description;
  final int quantity;
  final int price;

  Products({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.image,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}
