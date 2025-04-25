class UserProfileModel {
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String mobile;
  late final String photo;




  UserProfileModel.fromJson(Map<String,dynamic> jsonData){
    firstName=jsonData['firstName'] ?? '';
    lastName=jsonData['lastName'] ?? '';
    email=jsonData['email'] ?? '';
    mobile=jsonData['mobile'] ?? '';
    photo=jsonData['photo'] ?? '';

  }

}
