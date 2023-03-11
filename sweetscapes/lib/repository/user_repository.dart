import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';

class UserRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<UserModel> updateUserDetailsUrl(dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          AppUrl.updateUserDetailsUrl, data, token);
      return response = UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
