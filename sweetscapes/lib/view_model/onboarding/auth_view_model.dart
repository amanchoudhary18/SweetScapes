import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/app/routes/router.gr.dart';
import 'package:sweetscapes/data/response/api_response.dart';
import 'package:sweetscapes/model/body/gauth_body.dart';
import 'package:sweetscapes/model/body/signup_body.dart';
import 'package:sweetscapes/model/body/verify_otp_body.dart' as VOTP;
import 'package:sweetscapes/model/signup_otp_model.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/repository/auth_repository.dart';
import 'package:sweetscapes/repository/user_repository.dart';
import 'package:sweetscapes/utils/utils.dart';
import 'package:sweetscapes/view_model/services/splash_services.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRepository();
  final _myUserRepo = UserRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUploading = false;
  bool get signUploading => _signUploading;

  bool _verifyOtploading = false;
  bool get verifyOtploading => _verifyOtploading;

  bool _passwordloading = false;
  bool get passwordloading => _passwordloading;

  ApiResponse<UserModel> userData = ApiResponse.loading();

  ApiResponse<SignUpOTPModel> signUpOTPData = ApiResponse.loading();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  setPasswordloading(bool value) {
    _passwordloading = value;
    notifyListeners();
  }

  String userEmail = "";

  SignupBody signupBody = SignupBody();

  bool incorrectEmail = false;
  bool isResendVisible = false;
  String errorMessageMail = "";

  void googleAuthSignIn(BuildContext context) {
    setSignUpLoading(true);
    _googleSignIn.signOut();
    _googleSignIn.signIn().then(
      (value) {
        GAuthBody gAuthBody = GAuthBody();
        gAuthBody.email = value!.email;
        gAuthBody.name = value.displayName!;

        userData = ApiResponse.loading();

        dynamic gAuthData = gAuthBody.toJson();
        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);

        _myrepo
            .gAuthUrl(gAuthData)
            .then((value) => {
                  setSignUpLoading(false),
                  if (value.status.toString() == 'Successful')
                    {
                      if (value.user!.isNew! == true)
                        {
                          userPreference.saveUser(
                            UserModel(
                              token: value.token.toString(),
                              user: User(
                                isNew: true,
                              ),
                            ),
                          ),
                          userData = ApiResponse.completed(value),
                          Utils.goFlushBar('SignUp Successful', context),
                          AutoRouter.of(context).push(SetUpDetailsViewRoute()),
                        }
                      else
                        {
                          userPreference.saveUser(
                            UserModel(
                              token: value.token.toString(),
                              user: User(
                                isNew: value.user!.isNew!,
                              ),
                            ),
                          ),
                          userData = ApiResponse.completed(value),
                          Utils.goFlushBar('LogIn Successful', context),
                          AutoRouter.of(context).push(HomeScreenRoute()),
                        }
                    }
                  else
                    {
                      Utils.goErrorFlush('Try Again', context),
                    },
                })
            .onError(
              (error, stackTrace) => {
                setSignUpLoading(false),
                userData = ApiResponse.error(error.toString()),
                Utils.goErrorFlush(error.toString(), context),
              },
            );
      },
    );
    setSignUpLoading(false);
  }

  // otp.User user = otp.User();

  void resetIncorrectEmailMessage() {
    incorrectEmail = false;
    errorMessageMail = "";
    notifyListeners();
  }

  Future<void> signUp(String email, BuildContext context) async {
    isResendVisible = false;
    notifyListeners();
    signupBody.email = email;
    userEmail = email;

    dynamic data = signupBody.toJson();
    signUpOTPData = ApiResponse.loading();

    if (kDebugMode) {
      print("Here after button press");
    }

    setSignUpLoading(true);
    _myrepo
        .signupUrl(data)
        .then((value) => {
              setSignUpLoading(false),
              if (value.message.toString() == 'otp sent')
                {
                  signUpOTPData = ApiResponse.completed(value),
                  if (kDebugMode)
                    {
                      print("Here after SignUp"),
                    },
                  Utils.goFlushBar('OTP Sent', context),
                  incorrectEmail = false,
                  errorMessageMail = "",
                  notifyListeners(),
                  AutoRouter.of(context).push(VerifyOTPViewRoute()),
                  Timer(const Duration(seconds: 60), () {
                    isResendVisible = true;
                    notifyListeners();
                  }),
                }
              else
                {
                  // Utils.goErrorFlush(value.message.toString(), context),
                  incorrectEmail = true,
                  errorMessageMail = value.message.toString(),
                  notifyListeners(),
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

  VOTP.VerifyOtpBody verifyOtpBody = VOTP.VerifyOtpBody();
  VOTP.User verifyOtpUserBody = VOTP.User();

  Future<void> verifyOtp(String otp, BuildContext context) async {
    verifyOtpBody.otpEntered = otp;
    verifyOtpBody.otpId = signUpOTPData.data?.otpId.toString().trim();
    verifyOtpUserBody.email = userEmail;
    verifyOtpBody.user = verifyOtpUserBody;

    userData = ApiResponse.loading();

    dynamic otpData = verifyOtpBody.toJson();
    final userPreference = Provider.of<UserViewModel>(context, listen: false);

    setverifyOtpLoading(true);
    _myrepo
        .verifyOTPUrl(otpData)
        .then((value) => {
              setverifyOtpLoading(false),
              if (value.status.toString() == 'Successful')
                {
                  if (value.user!.isNew! == true)
                    {
                      userPreference.saveUser(
                        UserModel(
                          token: value.token.toString(),
                          user: User(
                            isNew: true,
                          ),
                        ),
                      ),
                      userData = ApiResponse.completed(value),
                      Utils.goFlushBar('SignUp Successful', context),
                      AutoRouter.of(context).push(SetUpDetailsViewRoute()),
                    }
                  else
                    {
                      userPreference.saveUser(
                        UserModel(
                          token: value.token.toString(),
                          user: User(
                            isNew: value.user!.isNew!,
                          ),
                        ),
                      ),
                      userData = ApiResponse.completed(value),
                      Utils.goFlushBar('LogIn Successful', context),
                      AutoRouter.of(context).push(HomeScreenRoute()),
                    }
                }
              else
                {
                  Utils.goErrorFlush('Try Again', context),
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

  SplashServices splashServices = SplashServices();

  Future<void> setNameAndPassword(dynamic data, BuildContext context) async {
    userData = ApiResponse.loading();
    // String token = splashServices.getToken();
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    UserModel setPassUser = await userPreference.getUser();
    String token = setPassUser.token.toString();

    setPasswordloading(true);
    _myUserRepo
        .updateUserDetailsUrl(data, token)
        .then((value) => {
              setPasswordloading(false),
              if (value.status.toString() == 'Successful')
                {
                  userData = ApiResponse.completed(value),
                  Utils.goFlushBar('Name and Password Set', context),
                  AutoRouter.of(context).push(UpdateTagsViewRoute()),
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
            setPasswordloading(false),
            userData = ApiResponse.error(error.toString()),
            Utils.goErrorFlush(error.toString(), context),
          },
        );
  }
}
