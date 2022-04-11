class UserModel {
  final String firstName;
  final String lastName;

  UserModel({
    required this.firstName,
    required this.lastName,
  });

  static fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
