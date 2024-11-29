import 'package:crm/utils/app_string_constant.dart';
import 'package:flutter/material.dart';

import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class TeamManagementHomePage extends StatefulWidget {
  const TeamManagementHomePage({super.key});

  @override
  State<TeamManagementHomePage> createState() => _TeamManagementHomePageState();
}

class _TeamManagementHomePageState extends State<TeamManagementHomePage> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      appBar: appBarPage(context),
      body: Padding(
        padding: AppTheme.padding3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            secondAppBar(context, () {
              addTeam(context);
            }),
            const Padding(
              padding: AppTheme.padding3,
              child: Text(
                'Team Management',
                style: AppTheme.titleFont,
              ),
            ),
            searchBar(search),
            Expanded(child: profileGenerator())
          ],
        ),
      ),
    );
  }

  Widget searchBar(String search) {
    return Padding(
      padding: AppTheme.padding10,
      child: SizedBox(
        height: 40,
        child: TextField(
          onChanged: (value) {
            setState(() {
              search = value;
            });
          },
          decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),
        ),
      ),
    );
  }

  Widget profileGenerator() {
    return ListView.builder(
      itemCount: (10 / 2).ceil(),
      itemBuilder: (context, index) {
        final int firstData = index * 2;
        final int secondData = firstData + 1;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (firstData < 10)
              GestureDetector(
                onTap: () {
                  showAppDialog(
                      context,
                      alertDialog(context, removeProfile, AppString.removetext,
                          AppString.removeDesc));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  alignment: Alignment.center,
                  margin: AppTheme.padding8,
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Allow the column to shrink-wrap its content
                    children: [
                      const CircleAvatar(
                        radius: AppTheme
                            .radius80, // Reduced the radius to fit the content better
                        backgroundImage: NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/003/715/527/non_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg',
                        ),
                      ),
                      const SizedBox(
                          height:
                              8), // Added spacing between the avatar and text
                      Text(
                        'Najwan',
                        style: AppTheme.profileFont,
                        overflow:
                            TextOverflow.ellipsis, // Prevent text overflow
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            if (secondData < 10)
              GestureDetector(
                onTap: () {
                  showAppDialog(
                      context,
                      alertDialog(context, removeProfile, AppString.removetext,
                          AppString.removeDesc));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  alignment: Alignment.center,
                  margin: AppTheme.padding8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: AppTheme.radius80,
                        backgroundImage: NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/003/715/527/non_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Najwan',
                        style: AppTheme.profileFont,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void removeProfile() {}
}
