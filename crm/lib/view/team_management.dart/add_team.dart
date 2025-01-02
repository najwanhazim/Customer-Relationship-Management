import 'package:crm/function/repository/team_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../db/user.dart';
import '../../function/bloc/team_bloc.dart';
import '../../utils/app_string_constant.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class AddTeam extends StatefulWidget {
  const AddTeam({Key? key, required this.userList}) : super(key: key);

  final List<User> userList;

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TeamRepository teamRepository = TeamRepository();

  BuildContext? _blocContext;

  String search = '';
  final Set<int> _selectedIndices = {};

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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cancelButton(context),
                        pageTitle(AppString.newMember),
                        BlocProvider(
                          create: (context) => TeamBloc(teamRepository),
                          child: BlocConsumer<TeamBloc, TeamState>(
                            listener: (listenerContext, state) {
                              if (state is TeamError) {
                                showToastError(context, state.message);
                              } else if (state is TeamLoaded) {
                                showToastError(context, state.message);
                              }
                            },
                            builder: (blocContext, state) {
                              _blocContext = blocContext;
                              return saveButton(context, sendFunction: onSave);
                            },
                          ),
                        ),
                      ],
                    ),
                    searchBar(search)
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    margin: AppTheme.padding8,
                    child: Form(
                      key: _formState,
                      child: Column(
                        children: [Expanded(child: generateMember())],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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

  Widget generateMember() {
    return ListView.separated(
      itemCount: widget.userList.length,
      itemBuilder: (context, index) {
        final user = widget.userList[index];
        final isSelected = _selectedIndices.contains(index);

        return ListTile(
          leading: CircleAvatar(
            radius: AppTheme.radius15,
            backgroundImage: const NetworkImage(
              'https://static.vecteezy.com/system/resources/previews/003/715/527/non_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg',
            ),
            child: isSelected
                ? const Icon(Icons.check,
                    color: Colors.white) // Check icon for selected
                : null,
          ),
          title: Text(user.login_id, style: AppTheme.profileFont),
          tileColor: isSelected
              ? Colors.blue.withOpacity(0.2)
              : null, // Highlight selection
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedIndices.remove(index);
              } else {
                _selectedIndices.add(index);
              }

              // Update userController with selected IDs
              userController.text = _selectedIndices
                  .map((i) => widget.userList[i].id.toString())
                  .join(',');
            });
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  Future<void> onSave() async {
    if (_formState.currentState != null &&
        _formState.currentState!.validate()) {
      _formState.currentState!.save();
      await sendTeam();
    } else {
      showToastError(context, 'Form is not valid!');
    }
  }

  Future<void> sendTeam() async {
    if (_blocContext == null) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final actionBloc = BlocProvider.of<TeamBloc>(_blocContext!);
    actionBloc.add(CreateTeam(
        buildContext: context, participantIds: userController.text.split(',')));
  }
}
