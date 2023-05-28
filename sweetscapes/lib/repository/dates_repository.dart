import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/user_model.dart';
import '../res/app_url.dart';

class DatesRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<UserModel> getAllDates(String token) async {
    try {
      dynamic response = await _apiServices.userGetApiResponse(
          AppUrl.getAllDates, token);
      return response = UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
