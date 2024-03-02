
import 'package:e_commerce_app_flutter/bloc_state_management/login_cubit/login_cubit.dart';
import 'package:e_commerce_app_flutter/bloc_state_management/login_cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../shared/components/custom_elevated_button.dart';
import '../../shared/components/custom_text_field.dart';
import '../../shared/constants.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state)
        {
          if (state is ForgotPasswordSuccessState) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset email sent successfully.'),
                backgroundColor: Colors.green,
              ),
            );

          }

          else if(state is ForgotPasswordErrorState)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error when sent Email.'),
                  backgroundColor: Colors.green,
                ),
              );
            }

          else
            {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 8.h,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reset Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28.sp,
                          color: KdefaultColor[800],
                        ),
                      ),

                      SizedBox(
                        height: 70.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: CustomTextFormField(
                          controller: LoginCubit.get(context).emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'E-mail',
                          prefix: const Icon(Icons.mail_outline),
                          validationMode: AutovalidateMode.onUserInteraction,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'e-mail must not be empty';
                            } else if ((RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) ==
                                false) {
                              return 'Please! enter valid e-mail. EX: john@gmail.com';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      SizedBox(
                        height: 15.h,
                      ),
                      state is! LoginLoadingState
                          ? CustomElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).forgotPassword(
                              email: LoginCubit.get(context)
                                  .emailController
                                  .text,
                            );
                          }
                        },
                        color: KdefaultColor,
                        height: 58.h,
                        borderRadius: 15.r,
                        child: Text(
                          'Reset ',
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.white,
                            letterSpacing: 3,
                          ),
                        ),
                      )
                          : const Center(
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
