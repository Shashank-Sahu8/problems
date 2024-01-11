import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String profile_pic;
  final bool practitioner;
  final bool check;

  UserModel(
      {this.id,
      required this.email,
      required this.phone,
      required this.name,
      required this.check,
      required this.practitioner,
      required this.profile_pic});
  //a->f
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "profile_pic": profile_pic,
      "practitioner": practitioner,
      "check": check
    };
  }

  //f->a
  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        id: snapshot['id'],
        email: snapshot['email'],
        phone: snapshot['phone'],
        name: snapshot['name'],
        check: snapshot['check'],
        practitioner: snapshot['practitioner'],
        profile_pic: snapshot['profile_pic']);
  }
}
