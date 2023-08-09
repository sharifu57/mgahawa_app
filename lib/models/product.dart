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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['quantity'] = quantity;
    data['category'] = category?.toJson();
    return data;
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, image: $image,quantity: $quantity, category: $category)';
  }
}
