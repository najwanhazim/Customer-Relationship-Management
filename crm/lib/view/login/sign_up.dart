import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/user.dart';
import '../../function/bloc/login_bloc.dart';
import '../../function/repository/user_repository.dart';
import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import 'login_notification.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _form = FormGroup({
    'firstName': FormControl<String>(),
    'lastName': FormControl<String>(),
    'username': FormControl<String>(),
    'email': FormControl<String>(),
  });

  final List<String> label = [
    'First Name',
    'Last Name',
    'Username',
    'Email Address'
  ];

  BuildContext? _blocContext;
  UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      appBar: AppBar(
        backgroundColor: AppTheme.redMaroon,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset:
          true, // Allow resizing when the keyboard appears
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed Back Button
          Padding(
            padding: AppTheme.padding10,
            child: backButton(context),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: AppTheme.padding10,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom, // Adjust for keyboard height
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: AppTheme.paddingTepi,
                      child: Text(
                        'Let’s set you up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: AppTheme.paddingTepi,
                      child: Text(
                        'Please fill in the following information',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    reactiveForm(context, _form, label),
                    BlocProvider(
                      create: (context) => LoginBloc(userRepository),
                      child: BlocConsumer<LoginBloc, LoginState>(
                        listener: (listenerContext, state) {
                          if (state is LoginError) {
                            showToastError(context, state.message);
                          } else if (state is LoginLoaded) {
                            showToastSuccess(context, state.message);
                          }
                        },
                        builder: (blocContext, state) {
                          _blocContext = blocContext;
                          return Padding(
                            padding: AppTheme.padding10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FilledButton(
                                  onPressed: () async {
                                    await onSave();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginNotification(
                                          title: AppString.newSignUpTitle,
                                          subtitle: AppString.newPassSubtitle,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text('Sign Up'),
                                      SizedBox(width: 8),
                                      Icon(Icons.arrow_forward),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onSave() async {
    if (_form.valid) {
      final user = createUserFromForms(_form);
      await sendUser(user);
    } else {
      showToastError(context, 'Form is not valid!');
    }
  }

  User createUserFromForms(FormGroup userForms) {
    final firstName = userForms.control('firstName').value as String? ?? '';
    final lastName = userForms.control('lastName').value as String? ?? '';
    final fullName = '$firstName $lastName'.trim();
    final email = userForms.control('email').value as String? ?? '';
    final username = userForms.control('username').value as String? ?? '';

    print("$fullName, $email, $username");

    return User(email: email, full_name: fullName, login_id: username);
  }

  Future<void> sendUser(User userIn) async {
    if (_blocContext == null) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final contactBloc = BlocProvider.of<LoginBloc>(_blocContext!);
    contactBloc.add(CreateSignUp(buildContext: context, user: userIn));
  }
}
