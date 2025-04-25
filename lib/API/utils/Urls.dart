class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const String registration = '$_baseUrl/Registration';
  static const String login = '$_baseUrl/Login';
  static const String profileUpdate = '$_baseUrl/ProfileUpdate';
  static const String profileDetails = '$_baseUrl/ProfileDetails';
  static const String recoverResetPassword = '$_baseUrl/RecoverResetPassword';
  static const String createTask = '$_baseUrl/createTask';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String deleteTask(String id) => "$_baseUrl/deleteTask/$id";
  static String ProfileDetails = "$_baseUrl/ProfileDetails";

  static String recoverVerifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';

  static String listTaskByStatus(String status) =>
      '$_baseUrl/listTaskByStatus/$status';
  static String recoverVerifyOtp(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOtp/$email/$otp';
  static String updateTaskStatus(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';
}
