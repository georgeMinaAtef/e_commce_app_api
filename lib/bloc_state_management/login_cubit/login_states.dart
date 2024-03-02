
import '../../models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class ChangePasswordVisibility extends LoginStates {}

class ForgotPasswordLoadingState extends LoginStates {}

class ForgotPasswordInvalidEmailState extends LoginStates
{
String message;
ForgotPasswordInvalidEmailState(this.message);
}

class ForgotPasswordSuccessState extends LoginStates {}

class ForgotPasswordErrorState extends LoginStates
{
  String error;
  ForgotPasswordErrorState(this.error);
}


class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}
