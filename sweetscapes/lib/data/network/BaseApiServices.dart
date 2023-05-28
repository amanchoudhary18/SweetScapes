abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> userPostApiResponse(String url, dynamic data, String token);
  Future<dynamic> userPutApiResponse(String url, dynamic data, String token);
  Future<dynamic> userGetApiResponse(String url, String token);
}
