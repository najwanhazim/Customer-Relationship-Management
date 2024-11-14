import 'package:flutter/material.dart';

import '../utils/app_theme_constant.dart';
import '../utils/app_widget_constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      appBar: AppBar(
        backgroundColor: AppTheme.redMaroon,
        elevation: 0.0,
      ),
      body: Padding(
        padding: AppTheme.padding10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Back',
                style: TextStyle(color: AppTheme.redMaroon, fontSize: 20),
              ),
            ),
            Center(
              heightFactor: 1.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: AppTheme.paddingTepi,
                    child: Text(
                      'Let’s set you up',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  ),
                  const Padding(
                    padding: AppTheme.paddingTepi,
                    child: Text(
                      'Please fill in the following information',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  inputField('First Name'),
                  inputField('Last Name'),
                  inputField('Nickname'),
                  inputField('Email Address'),
                  Padding(
                    padding: AppTheme.padding10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .end, 
                      children: [
                        FilledButton(
                          onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
