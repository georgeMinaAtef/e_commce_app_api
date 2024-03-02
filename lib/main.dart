
import 'package:e_commerce_app_flutter/shared/constants.dart';
import 'package:e_commerce_app_flutter/shared/network/local/cash_helper.dart';
import 'package:e_commerce_app_flutter/shared/repo/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc_state_management/app_cubit/app_cubit.dart';
import 'bloc_state_management/app_cubit/app_states.dart';
import 'bloc_state_management/bloc_observer.dart';
import 'layouts/home_layout.dart';
import 'modules/log_in/login_screen.dart';
import 'modules/on_boarding/on_boaeding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.int();
  bool? onBoarding = CashHelper.getData(key: 'onBoarding');
  token = CashHelper.getData(key: 'token');
  Widget? startWidget;
  if (onBoarding != null) {
    if (token != null) {
      startWidget = const HomeLayout();
    } else {
      startWidget = const LoginScreen();
    }
  } else {
    startWidget = const OnBoardingScreen();
  }
  runApp(
    MyApp(
      startWidget: startWidget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(392.72727272727275, 825.4545454545455),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context , state) => MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, widget) {
                //add this line
                // ScreenUtil.setContext(context);
                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: widget!,
                );
              },
              title: 'Flutter E-commerce App',
              theme: KlightTheme,
              home: startWidget,
            ),
          );
        },
      ),
    );
  }
}
