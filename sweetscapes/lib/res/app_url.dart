class AppUrl {
  static var baseUrl = 'http://192.168.125.27:5000';

  static var loginUrl = '$baseUrl/api/v1/user/login';
  static var signupUrl = '$baseUrl/api/v1/user/register';
  static var verifyOtpUrl = '$baseUrl/api/v1/user/otpVerification';
  static var updateUserDetailsUrl = '$baseUrl/api/v1/user/update';
}
