import 'package:mgahawa_app/models/categoryModel.dart';

class FoodItem {
  int? id;
  String? name;
  String? description;
  String? price;
  String? image;
  Category? category;

  FoodItem(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.image,
      this.category});

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
        id: json['id'] as int,
        name: json['name'],
        description: json['description'],
        price: json['price'],
        image: json['image'],
        category: json['category'] != null ? null : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['category'] = category?.toJson();
    return data;
  }

  @override
  String toString() {
    return 'FoodItem(id: $id, name: $name, description: $description, price: $price, image: $image, category: $category)';
  }
}
