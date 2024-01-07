class UserModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String profile_pic;
  final String practitioner;
  final String check;

  const UserModel(
      {this.id,
      required this.email,
      required this.phone,
      required this.name,
      required this.check,
      required this.practitioner,
      required this.profile_pic});
  toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "profile_pic": profile_pic,
      "practitioner": practitioner,
      "check": check
    };
  }
}
