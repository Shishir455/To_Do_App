class UserModel {
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String? photo;
  final String? fullname;

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    this.photo,
    this.fullname,
  });

  // Add fromJson/toJson methods if not present
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobile: json['mobile'],
      photo: json['photo'],
      fullname: json['fullname'] ?? '${json['firstName']} ${json['lastName']}',
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'mobile': mobile,
    'photo': photo,
    'fullname': fullname,
  };
}