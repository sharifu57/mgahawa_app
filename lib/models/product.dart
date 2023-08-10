import 'package:mgahawa_app/models/categoryModel.dart';

class Product {
  int? id;
  String? name;
  String? description;
  String? price;
  String? image;
  int? quantity;
  Category? category;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.image,
      required this.quantity,
      this.category});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as int,
        name: json['name'],
        description: json['description'],
        price: json['price'],
        image: json['image'],
        quantity: json['quantity'],
        category: json['category'] != null ? null : null);
  }

  Product copyWith({
    int? id,
    String? name,
    String? image,
    int? quantity,
    // ... other fields ...
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      // ... other fields ...
    );
  }

  // Convert Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'quantity': quantity,
      // ... other fields ...
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, image: $image,quantity: $quantity, category: $category)';
  }
}
