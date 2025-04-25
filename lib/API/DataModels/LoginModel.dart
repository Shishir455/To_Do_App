import 'package:todo_api_app/API/DataModels/UseerModel.dart';

class LoginModel{
  late final String status ;
  late final String token ;
  late UserModel userModel ;
  LoginModel.fromJson(Map<String,dynamic> JsonData){

status=JsonData['status'] ?? '';
token=JsonData['token'] ?? '';
userModel =UserModel.fromJson(JsonData['data'] ?? {});
  }
  Map<String,dynamic> toJson(){
    return {
      'status': status,
      'token': token,


    };
  }


}