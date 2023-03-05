import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/data/response/api_response.dart';
import 'package:sweetscapes/model/signup_body.dart';
import 'package:sweetscapes/model/signup_otp_model.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/model/verify_otp_body.dart';
import 'package:sweetscapes/repository/auth_repository.dart';
import 'package:sweetscapes/utils/routes/routes_name.dart';
import 'package:sweetscapes/utils/utils.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUploading = false;
  bool get signUploading => _signUploading;

  bool _verifyOtploading = false;
  bool get verifyOtploading => _verifyOtploading;

  ApiResponse<UserModel> userData = ApiResponse.loading();

  ApiResponse<SignUpOTPModel> signUpOTPData = ApiResponse.loading();

  setLoginLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUploading = value;
    notifyListeners();
  }

  setverifyOtpLoading(bool value) {
    _verifyOtploading = value;
    notifyListeners();
  }

  Future<void> loginUrl(dynamic data, BuildContext context) async {
    userData = ApiResponse.loading();
    final userPreference = Provider.of<UserViewModel>(context, listen: false);

    setLoginLoading(true);
    _myrepo
        .loginUrl(data)
        .then((value) => {
              setLoginLoading(false),
              if (value.status.toString() == 'Successful')
                {
                  userPreference
                      .saveUser(UserModel(token: value.token.toString())),
                  userData = ApiResponse.completed(value),
                  Utils.goFlushBar('Login Successful', context),
                  Navigator.pushNamed(context, RoutesName.home),
                }
              else
                {
                  Utils.goErrorFlush('Try Again', context),
                },
              if (kDebugMode)
                {
                  print(value.toString()),
                },
            })
        .onError(
          (error, stackTrace) => {
            setLoginLoading(false),
            userData = ApiResponse.error(error.toString()),
            Utils.goErrorFlush(error.toString(), context),
          },
        );
  }

  SignupBody user = SignupBody();

  Future<void> signUp(dynamic data, BuildContext context) async {
    user = SignupBody.fromJson(data);
    signUpOTPData = ApiResponse.loading();

    setSignUpLoading(true);
    _myrepo
        .signupUrl(data)
        .then((value) => {
              setSignUpLoading(false),
              if (value.message.toString() == 'otp sent')
                {
                  signUpOTPData = ApiResponse.completed(value),
                  Utils.goFlushBar('OTP Sent', context),
                }
              else
                {
                  Utils.goErrorFlush('Try Again', context),
                },
              if (kDebugMode)
                {
                  print(value.toString()),
                },
            })
        .onError(
          (error, stackTrace) => {
            setSignUpLoading(false),
            signUpOTPData = ApiResponse.error(error.toString()),
            Utils.goErrorFlush(error.toString(), context),
          },
        );
  }

  VerifyOtpBody verifyOtpBody = VerifyOtpBody();

  Future<void> verifyOtp(String otp, BuildContext context) async {
    verifyOtpBody.otpEntered = otp;
    verifyOtpBody.otpId = signUpOTPData.data?.otpId.toString().trim();
    verifyOtpBody.user?.name = user.name;
    verifyOtpBody.user?.mobileNumber = user.mobileNumber;
    verifyOtpBody.user?.password = user.password;
    userData = ApiResponse.loading();
    final userPreference = Provider.of<UserViewModel>(context, listen: false);

    dynamic data = verifyOtpBody.toJson();

    setverifyOtpLoading(true);
    _myrepo
        .verifyOtpUrl(data)
        .then((value) => {
              setverifyOtpLoading(false),
              if (value.status.toString() == 'Successful')
                {
                  userPreference
                      .saveUser(UserModel(token: value.token.toString())),
                  userData = ApiResponse.completed(value),
                  Utils.goFlushBar('SignUp Successful', context),
                  Navigator.pushNamed(context, RoutesName.home),
                }
              else
                {
                  Utils.goErrorFlush('Try Again', context),
                },
              if (kDebugMode)
                {
                  print(value.toString()),
                },
            })
        .onError(
          (error, stackTrace) => {
            setverifyOtpLoading(false),
            userData = ApiResponse.error(error.toString()),
            Utils.goErrorFlush(error.toString(), context),
          },
        );
  }
}
