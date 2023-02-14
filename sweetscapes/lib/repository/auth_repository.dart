import 'package:sweetscapes/data/network/BaseApiServices.dart';
import 'package:sweetscapes/data/network/NetworkApiServices.dart';
import 'package:sweetscapes/res/app_url.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginUrl(dynamic data) async {
    try {
      dynamic response = _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signupUrl(dynamic data) async {
    try {
      dynamic response = _apiServices.getPostApiResponse(AppUrl.signupUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
