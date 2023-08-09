class Category {
  int? id;
  String? name;
  String? code;
  String? icon;

  Category(
      {required this.id,
      required this.name,
      required this.code,
      required this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'] as int,
        name: json['name'],
        code: json['code'],
        icon: json['icon']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['icon'] = icon;
    return data;
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, code: $code, icon: $icon)';
  }
}
