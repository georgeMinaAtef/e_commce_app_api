
import 'package:e_commerce_app_flutter/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/login_model.dart';
import '../../shared/repo/dio_helper.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  IconData passwordIcon = Icons.visibility;
  bool isPasswordHidden = true;
  LoginModel? loginModel;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  void changePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    isPasswordHidden
        ? passwordIcon = Icons.visibility
        : passwordIcon = Icons.visibility_off;
    emit(ChangePasswordVisibility());
  }

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: 'login',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  void forgotPassword({
    required String email,
  }) async {
    emit(ForgotPasswordLoadingState());
    try {
      var response = await DioHelper.postData(
        url: FORGOT_PASSWORD,
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        emit(ForgotPasswordSuccessState());
      } else {
        // Handle other status codes
        if (response.statusCode == 400) {
          // If status code is 400, assume it's due to invalid email format
          emit(ForgotPasswordInvalidEmailState('Invalid email format. Please enter a valid email.'));
        } else {
          emit(ForgotPasswordErrorState('Failed to reset password. Please try again later.'));
        }
      }
    } catch (error) {
      emit(ForgotPasswordErrorState(error.toString()));
    }
  }

}
