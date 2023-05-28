import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sweetscapes/app/routes/router.gr.dart';
import 'package:sweetscapes/data/response/api_response.dart';
import 'package:sweetscapes/model/body/gauth_body.dart';
import 'package:sweetscapes/model/body/signup_body.dart';
import 'package:sweetscapes/model/signup_otp_model.dart';
import 'package:sweetscapes/model/user_model.dart';
import 'package:sweetscapes/model/body/verify_otp_body.dart';
import 'package:sweetscapes/repository/auth_repository.dart';
import 'package:sweetscapes/utils/utils.dart';
import 'package:sweetscapes/view/onboarding/updateTags_view.dart';
import 'package:sweetscapes/view_model/services/splash_services.dart';
import 'package:sweetscapes/view_model/user_view_model.dart';

import '../../model/body/verify_otp_body.dart';

class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRepository();

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
                          AutoRouter.of(context).push(UpdateTagsViewRoute()),
                        }
                      else
                        {
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

  void googleAuthLogIn(BuildContext context) {
    setLoginLoading(true);
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
                  setLoginLoading(false),
                  if (value.status.toString() == 'Successful')
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
                      print('Reached here'),
                      if (value.user!.isNew! == true)
                        {
                          AutoRouter.of(context).push(UpdateTagsViewRoute()),
                        }
                      else
                        {
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
                setLoginLoading(false),
                userData = ApiResponse.error(error.toString()),
                Utils.goErrorFlush(error.toString(), context),
              },
            );
      },
    );
    setLoginLoading(false);
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
                  userPreference.saveUser(
                    UserModel(
                      token: value.token.toString(),
                      user: User(
                        isNew: value.user!.isNew!,
                      ),
                    ),
                  ),
                  userData = ApiResponse.completed(value),
                  Utils.goFlushBar('Login Successful', context),
                  if (value.user!.isNew! == true)
                    {
                      AutoRouter.of(context).push(UpdateTagsViewRoute()),
                    }
                  else
                    {
                      AutoRouter.of(context).push(HomeScreenRoute()),
                    }
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

  // otp.User user = otp.User();
  SignupBody signupBody = SignupBody();

  Future<void> signUp(String email, BuildContext context) async {
    signupBody.email = email;

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

    userData = ApiResponse.loading();
    if (kDebugMode) {
      print("${verifyOtpBody.otpEntered} Here");
      print("${signUpOTPData.data?.otpId.toString()} Here");
    }

    dynamic otpData = verifyOtpBody.toJson();
    final userPreference = Provider.of<UserViewModel>(context, listen: false);

    setverifyOtpLoading(true);
    _myrepo
        .verifyOTPUrl(otpData)
        .then((value) => {
              setverifyOtpLoading(false),
              if (value.status.toString() == 'Successful')
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
                  AutoRouter.of(context).push(SetupPasswordViewRoute()),
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
    _myrepo
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
