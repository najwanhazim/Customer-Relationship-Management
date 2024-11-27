import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
                    Padding(
                      padding: AppTheme.padding10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilledButton(
                            onPressed: () {
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
}
