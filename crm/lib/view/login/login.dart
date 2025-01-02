import 'package:crm/function/bloc/login_bloc.dart';
import 'package:crm/function/repository/async_helper.dart';
import 'package:crm/function/repository/user_repository.dart';
import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/utils/app_theme_constant.dart';
import 'package:crm/utils/app_widget_constant.dart';
import 'package:crm/view/dashboard/dashboard_individual.dart';
import 'package:crm/view/drawer/navigation_home_screen.dart';
import 'package:crm/view/login/forgot_password.dart';
import 'package:crm/view/login/sign_up.dart';
import 'package:crm/view/permission_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RoundedLoadingButtonController loginButtonController =
      RoundedLoadingButtonController();

  final List<String> label = ['Email Address', 'Password'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      appBar: AppBar(
        backgroundColor: AppTheme.redMaroon,
        elevation: 0.0,
      ),
      body: Padding(
        padding: AppTheme.padding8,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppString.login,
                      style: AppTheme.titleFont,
                    ),
                    const Text(
                      'Please sign in to continue',
                      style: AppTheme.subtitleFont,
                    ),
                    Form(
                      key: _formState,
                      child: Column(
                        children: [
                          inputField(label[0], controller:emailController),
                          inputField(label[1], controller:passwordController, passInput: true),
                          // reactiveForm(context, loginForm, label)
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassword()));
                              },
                              child: const Text(
                                'Forgotten Password?',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            BlocProvider(
                              create: (context) => LoginBloc(UserRepository()),
                              child: Container(
                                child: BlocConsumer<LoginBloc, LoginState>(
                                  listener: (listenerContext, state) async {
                                    if (state is LoginError) {
                                      loginButtonController.error();
                                      showToastError(context, state.message);
                                    } else if (state is LoginLoaded) {
                                      loginButtonController.success();
                                      showToastSuccess(context, state.message);

                                      Widget goToScreen;
                                      final bool checkPermission =
                                          await checkPermissionList();

                                      goToScreen = checkPermission
                                          ? const NavigationHomeScreen()
                                          : const PermissionPage();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          pageTransitionFadeThrough(goToScreen),
                                          (route) => false);
                                    }

                                    if (state is! LoginLoading &&
                                        state is! LoginLoaded) {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        loginButtonController.reset();
                                      });
                                    }
                                  },
                                  builder: (blocContext, state) {
                                    return buildLoginButton(
                                        context,
                                        blocContext,
                                        emailController,
                                        passwordController);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoginButton(
      BuildContext context,
      BuildContext blocContext,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return FilledButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        final loginBloc = BlocProvider.of<LoginBloc>(blocContext);
        loginBloc.add(VerifyLogin(emailController.text, passwordController.text, context));
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(AppString.login),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}

// FilledButton(
//                               onPressed: () {
//                                 Navigator.pushNamedAndRemoveUntil(
//                                 context,
//                                 '/navigation',
//                                 (Route<dynamic> route) =>
//                                     false, // Remove all previous routes
//                               );
//                               },
//                               style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.all(Colors.black),
//                                 shape: MaterialStateProperty.all(
//                                   RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: const [
//                                   Text(AppString.login),
//                                   SizedBox(width: 8),
//                                   Icon(Icons.arrow_forward),
//                                 ],
//                               ),
//                             ),