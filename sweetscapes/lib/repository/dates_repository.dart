import 'package:sweetscapes/model/response/componentsByTag_response.dart';
import 'package:sweetscapes/model/response/createPlan_response.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/model/response/getRecentPlans_response.dart';
import 'package:sweetscapes/model/response/getUpcomingPlans_response.dart';
import 'package:sweetscapes/model/response/saveUserCreatedPlan_response.dart';

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
      print(e);
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

  Future<CreatePlanResponse> createPlan(String token, dynamic data) async {
    try {
      dynamic response = await _apiServices.userPostApiResponse(
          AppUrl.createPlan, data, token);
      return response = CreatePlanResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<SaveUserCreatedPlanResponse> saveUserCreatedPlan(String token, dynamic data) async {
    try {
      dynamic response = await _apiServices.userPostApiResponse(
          AppUrl.saveUserCreatedPlan, data, token);
      return response = SaveUserCreatedPlanResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<GetRecentPlansResponse> getRecentPlans(String token) async {
    try {
      dynamic response = await _apiServices.userGetApiResponse(
          AppUrl.getRecentSavedUserCreatedPlans, token);
      return response = GetRecentPlansResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<GetUpcomingPlansResponse> getUpcomingPlans(String token) async {
    try {
      dynamic response = await _apiServices.userGetApiResponse(
          AppUrl.getUpcomingSavedUserCreatedPlans, token);
      return response = GetUpcomingPlansResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<SaveUserCreatedPlanResponse> getSavedUserCreatedPlan(String token, String planId) async {
    try {
      dynamic response = await _apiServices.userGetApiResponse(
          AppUrl.getSavedUserCreatedPlan+planId, token);
      return response = SaveUserCreatedPlanResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}