import 'package:sweetscapes/model/date_model.dart';
import 'package:sweetscapes/model/response/getDates_response.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class DatesRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<GetDates> getAllDates(String token) async {
    try {
      dynamic response = await _apiServices.userGetApiResponse(
          AppUrl.getAllDates, token);
      return response = GetDates.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<DateModel> getDateDetails(String id, String token) async {
    try {
      dynamic response = await _apiServices.userGetApiResponse(
          AppUrl.getDateDetails+id, token);
      return response = DateModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}