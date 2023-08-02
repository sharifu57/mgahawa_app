class User {
  int? id;
  String? fullName;
  String? email;
  String? location;
  String? phone;
  String? image;

  User(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.location,
      required this.phone,
      required this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        fullName: json['full_name'],
        email: json['email'],
        location: json['location'],
        phone: json['phone'],
        image: json['image']);
  }

  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic>data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['full_name'] = fullName;
  //   data['email'] = email;
  //   data['phone'] = phone;
  //   data['location'] = location;
  //   data['image'] = image;
  // }

  // @override
  // String toString(){
  //   return 'User(id: $id, full_name: $fullName, email: $email, phone: $phone, location: $location, image: $image)';
  // }
}
