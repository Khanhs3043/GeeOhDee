class MyUser{
  String id;
  String email;
  String? password;

  String name;
  DateTime? dob;
  String? gender;
  String? imageUrl='';
  MyUser({
    required this.id,
    required this.name,
    this.gender,
    required this.email,
    this.password,
    this.dob,
  this.imageUrl =''});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'dob': dob?.toIso8601String(),
      'gender': gender,
      'image': imageUrl,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['Id'],
      email: map['Email'],
      password: map['Password'],
      name: map['Name'],
      dob: map['Dob']==null?null:DateTime.parse(map['Dob']),
      gender: map['Gender'],
      imageUrl: map['Image']
    );
  }
}
