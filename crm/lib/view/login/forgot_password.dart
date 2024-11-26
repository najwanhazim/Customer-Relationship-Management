import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/view/login/login_notification.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final FormGroup loginForm = FormGroup({'email': FormControl<String>()});

  final List<String> loginLabel = ['Email Address'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.grey,
      appBar: AppBar(
        backgroundColor: AppTheme.redMaroon,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: AppTheme.padding10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(context),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: AppTheme.paddingTepi,
                      child: Text(
                        "Let's find your account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                    ),
                    const Padding(
                      padding: AppTheme.paddingTepi,
                      child: Text(
                        'Enter the email associated with your account to received new password',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Form(
                        key: _formState,
                        child: Column(
                          children: [
                            reactiveForm(context, loginForm, loginLabel),
                          ],
                        )),
                    Padding(
                      padding: AppTheme.padding10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilledButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginNotification(title: AppString.newPassTitle, subtitle: AppString.newPassSubtitle,)));
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
                                Text('Next'),
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
          ],
        ),
      ),
    );
  }
}
