import 'package:sweetscapes/model/response/getMyData_response.dart';
import 'package:sweetscapes/model/response/update_initial_response.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';

class UserRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<UserModel> updateUserDetailsUrl(dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.userPutApiResponse(
          AppUrl.updateUserDetailsUrl, data, token);
      return response = UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<UpdateInitial_Response> updateInitialDetails(dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.userPutApiResponse(
          AppUrl.updateInitialUrl, data, token);
      return response = UpdateInitial_Response.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> setInitialPreferences(dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.userPutApiResponse(
          AppUrl.setInitialPreferences, data, token);
      return response = UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<GetMyDataResponse> getMyData(String token) async {
    try {
      dynamic response = await _apiServices.userGetApiResponse(
          AppUrl.getMyData, token);
      return response = GetMyDataResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
