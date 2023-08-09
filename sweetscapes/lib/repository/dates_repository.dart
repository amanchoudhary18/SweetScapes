import 'package:sweetscapes/model/response/componentsByTag_response.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class DatesRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<GetAllPlans> getAllPlans(String token) async {
    try {
      dynamic response = await _apiServices.userGetApiResponse(
          AppUrl.getAllPlans, token);
      return response = GetAllPlans.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ComponentsByTagResponse> getComponentsByTag(String token, dynamic data) async {
    try {
      dynamic response = await _apiServices.userPostApiResponse(
          AppUrl.getComponentsByTag, data, token);
      return response = ComponentsByTagResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}