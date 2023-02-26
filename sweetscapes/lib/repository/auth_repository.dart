import 'package:sweetscapes/data/network/BaseApiServices.dart';
import 'package:sweetscapes/data/network/NetworkApiServices.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/res/app_url.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<UserModel> loginUrl(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response = UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signupUrl(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.signupUrl, data);
      return response = UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
