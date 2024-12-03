import 'package:crm/view/profile/update_password.dart';
import 'package:flutter/material.dart';

import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.grey,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: SizedBox(
          height: AppTheme.sheetHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: AppTheme.bottomSheet,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cancelButton(context),
                    pageTitle(AppString.editProfile),
                    saveButton(context)
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor:
                      Colors.transparent, // Fix for background issue
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: Container(
                      margin: AppTheme.padding8,
                      child: SafeArea(
                        child: Form(
                          key: _formState,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: AppTheme.radius50,
                                backgroundColor: Colors.blue,
                              ),
                              // Form sections
                              inputField('Najwan', hintText: true),
                              inputField('Hazim', hintText: true),
                              inputField('Najwan', hintText: true),
                              inputField('najwanhazim@gmail.com',
                                  hintText: true),
                              AppTheme.box30,
                              inputField('Leads', numberInput: true),
                              inputField('Sales-Won', numberInput: true),
                              AppTheme.box30,
                              displayInField(
                                context,
                                'Change Password',
                                function: () {
                                  bottomSheet(context, UpdatePassword());
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
