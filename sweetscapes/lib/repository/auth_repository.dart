import 'package:sweetscapes/data/network/BaseApiServices.dart';
import 'package:sweetscapes/data/network/NetworkApiServices.dart';
import 'package:sweetscapes/model/signup_otp_model.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/res/app_url.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<UserModel> gAuthUrl(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.gAuthUrl, data);
      return response = UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> loginUrl(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response = UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<SignUpOTPModel> signupUrl(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.signupUrl, data);
      return response = SignUpOTPModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> verifyOTPUrl(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.verifyOtpUrl, data);
      return response = UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
