import 'package:http/http.dart' as http;
import 'dart:convert';
class API_Connection{
  var BaseUrl = "https://task.teamrabbil.com/api/v1";
  var RequestHeader = {"Content-Type":"application/json"};
 //Login
  Future<bool> LoginPage(FromValues) async{
    var uri = Uri.parse("${BaseUrl}/login");
    var PostBody = json.encode(FromValues);
    var response = await http.post(uri,headers:RequestHeader,body: PostBody);
    var ResultCode = response.statusCode;
    var ResultBody = json.decode(response.body);

    if(ResultCode==200 && ResultBody['status']=="success"){
      print(ResultCode);
      return true;
    }
    else {
      return false;
    }


  }
//Registration
  Future<bool> Registration(FromValues) async{
    var uri = Uri.parse("${BaseUrl}/registration");
    var PostBody = json.encode(FromValues);
    var response = await http.post(uri,headers:RequestHeader,body: PostBody);
    var ResultCode = response.statusCode;
    var ResultBody = json.decode(response.body);

    if(ResultCode==200 && ResultBody['status']=="success"){
      print(ResultCode);
      return true;
    }
    else {
      return false;
    }


  }
 //Email Verification
  Future<bool> EmailVerification(email) async{
    var uri = Uri.parse("${BaseUrl}/RecoverVerifyEmail/$email");
    var response = await http.get(uri,headers: RequestHeader);
    var ResultCode = response.statusCode;
    var ResultBody = json.decode(response.body);
    if(ResultCode==200 && ResultBody['status']=="success"){
      return true;
    }
    else{
      return false;
    }
  }
  //Pin Verification
  Future<bool> PinVerification(email,pin) async{
    var uri = Uri.parse("${BaseUrl}/RecoverVerifyEmail/$email/$pin");
    var response = await http.get(uri,headers: RequestHeader);
    var ResultCode = response.statusCode;
    var ResultBody = json.decode(response.body);
    if(ResultCode==200 && ResultBody['status']=="success"){
      return true;
    }
    else{
      return false;
    }
  }
  // Reset Password
  Future<bool> Forgetpassword(FromValues) async{
    var uri = Uri.parse("${BaseUrl}/RecoverResetPass");
    var PostBody = json.encode(FromValues);
    var response = await http.post(uri,headers:RequestHeader,body: PostBody);
    var ResultCode = response.statusCode;
    var ResultBody = json.decode(response.body);

    if(ResultCode==200 && ResultBody['status']=="success"){
      print(ResultCode);
      return true;
    }
    else {
      return false;
    }


  }



}