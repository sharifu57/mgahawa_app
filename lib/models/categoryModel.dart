class Category {
  int? id;
  String? name;
  String? code;

  Category({required this.id, required this.name, required this.code});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    return data;
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, code: $code)';
  }
}
