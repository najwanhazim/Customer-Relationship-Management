import 'package:flutter/material.dart';

import '../utils/app_theme_constant.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      appBar: AppBar(
        backgroundColor: AppTheme.redMaroon,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Center(
            heightFactor: 4,
            child: Padding(
              padding: AppTheme.padding20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your account is set',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  const Text('Please check your email to received your password', ),
                  Padding(
                    padding: AppTheme.padding8,
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end, 
                      children: [
                        FilledButton(
                          onPressed: () {},
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
                              Text('Login'),
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
    );
  }
}
