import 'package:intl/intl.dart';

DateFormat dayFormat = DateFormat("MMM dd yyyy");
DateFormat timeFormat = DateFormat("HH:mm");

class User {
  String id;
  String? name;
  String? phoneNumber;
  String? status;
  String? email;
  String? password;

  String getFirstLetter (){
    return email==null || email == "" ?"":email!.substring(0, 1);
  }

  User(
      {required this.id,
      this.name,
      this.phoneNumber,
      this.status,
      this.email,
      this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['user_name'],
      phoneNumber: json['phone_number'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_name': name,
        'phone_number': phoneNumber,
      };

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_name': name,
      'phone_number': phoneNumber,
    };
  }

  factory User.fromMap(Map<String, dynamic> map, String docID) {
    return User(
      id: docID,
      name: map['user_name'],
      phoneNumber: map['phone_number'],
      status: map['status'],
    );
  }
  factory User.fromDbMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['user_name'],
      phoneNumber: map['phone_number'],
      status: map['status'],
    );
  }

  @override
  bool operator ==(Object other) => other is User && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User{id:$id, name: $name, phoneNumber: $phoneNumber,status:$status}';
  }
}
