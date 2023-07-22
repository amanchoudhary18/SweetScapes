class AppUrl {
  // static var baseUrl = 'http://192.168.1.36:5000';
  static var baseUrl = 'https://date-form-prod.onrender.com';

  static var gAuthUrl = '$baseUrl/api/v1/user/googlelogin';
  static var loginUrl = '$baseUrl/api/v1/user/login';
  static var signupUrl = '$baseUrl/api/v1/user/register';
  static var verifyOtpUrl = '$baseUrl/api/v1/user/otpVerification';
  static var updateUserDetailsUrl = '$baseUrl/api/v1/user/update';
  static var updateInitialUrl = '$baseUrl/api/v1/user/updateInitial';
  static var setInitialPreferences = '$baseUrl/api/v1/user/setInitialPreferences';
  static var getAllPlans = '$baseUrl/api/v1/plan/getAllPlans';
  static var getDateDetails = '$baseUrl/api/v1/date/';
}
