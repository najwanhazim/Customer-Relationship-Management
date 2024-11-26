import 'package:flutter/material.dart';

import '../../utils/app_theme_constant.dart';

class LoginNotification extends StatefulWidget {
  const LoginNotification({Key? key, required this.title, required this.subtitle}) : super(key: key);

  final String title;
  final String subtitle;

  @override
  State<LoginNotification> createState() => _LoginNotificationState();
}

class _LoginNotificationState extends State<LoginNotification> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  
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
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: AppTheme.paddingTepi,
                      child: Text(
                        widget.title ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                    ),
                    Padding(
                      padding: AppTheme.paddingTepi,
                      child: Text(
                        widget.subtitle,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: AppTheme.padding10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
      ),
    );
  }
}
