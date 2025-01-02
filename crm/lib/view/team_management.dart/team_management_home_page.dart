import 'package:crm/db/user.dart';
import 'package:crm/function/repository/user_repository.dart';
import 'package:crm/utils/app_string_constant.dart';
import 'package:flutter/material.dart';

import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class TeamManagementHomePage extends StatefulWidget {
  const TeamManagementHomePage({Key? key, required this.userId})
      : super(key: key);

  final String userId;

  @override
  State<TeamManagementHomePage> createState() => _TeamManagementHomePageState();
}

class _TeamManagementHomePageState extends State<TeamManagementHomePage> {
  String search = '';
  UserRepository userRepository = UserRepository();
  List<User> userTeamList = [];
  List<User> userList = [];

  @override
  void initState() {
    super.initState();
    getAllUser();
    getTeamUser();
  }

  Future<void> getTeamUser() async {
    try {
      userTeamList = await userRepository.getUserByTeam();
    } catch (e) {
      print(e);
    } finally {
      setState(() {});
    }
  }

  Future<void> getAllUser() async {
    try {
      userList = await userRepository.getAllUser();
    } catch (e) {
      print(e);
    } finally {
      setState(() {});
    }
  }

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
              addTeam(context, userList);
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
      itemCount: (userTeamList.length / 2).ceil(),
      itemBuilder: (context, index) {
        final firstData = userTeamList[index * 2];
        final secondIndex = index * 2 + 1; // Calculate the second index
        final secondData =
            secondIndex < userTeamList.length ? userTeamList[secondIndex] : null;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                showAppDialog(
                  context,
                  alertDialog(context, removeProfile, AppString.removetext,
                      AppString.removeDesc),
                );
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
                      firstData.login_id,
                      style: AppTheme.profileFont,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            if (secondData != null) 
              GestureDetector(
                onTap: () {
                  showAppDialog(
                    context,
                    alertDialog(context, removeProfile, AppString.removetext,
                        AppString.removeDesc),
                  );
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
                        secondData.login_id,
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

  void removeProfile() {
    
  }
}
