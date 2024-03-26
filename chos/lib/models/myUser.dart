class MyUser{
  String id;
  String email;
  String? password;

  String name;
  DateTime? dob;
  String? gender;
  String? imageUrl;
  MyUser({
    required this.id,
    required this.name,
    this.gender,
    required this.email,
    this.password,
    this.dob});

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
    // print(map);
    // print( map['Password'].toString());
    // print( map['Id'].toString());
    // print('-------------1------------');
    // print( map['Name'].toString());
    // print('-------------2------------');
    // print( map['Gender'].toString());
    // print(  map['Dob']==null?null:DateTime.parse(map['Dob']));
    return MyUser(
      id: map['Id'],
      email: map['Email'],
      password: map['Password'],
      name: map['Name'],
      dob: map['Dob']==null?null:DateTime.parse(map['Dob']),
      gender: map['Gender'],
    );
  }
}
